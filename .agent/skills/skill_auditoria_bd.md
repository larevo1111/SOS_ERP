---
description: Reglas de oro inmutables sobre la inyección forzada de datos de autoría y pertenencia (empresa) en base de datos.
---

# 🛡️ Política de Seguridad y Auditoría de BD (Multi-tenant)

## Para qué sirve
Este skill unifica y blinda la regla más crítica del ERP Origen Silvestre. Garantiza:
1. **Aislamiento multi-empresa** (ningún dato puede verse desde otra empresa).
2. **Trazabilidad perfecta** (quién creó, quién modificó y cuándo).
3. **Identificación correcta de empresa** (usar `uid` de `sys_empresa`, no `siglas`).

## Convención de Empresa (CRÍTICO)
| Campo en `sys_empresa` | Tipo | Uso | Ejemplo |
|---|---|---|---|
| `uid` | PK | Identificador real (se usa en JOINs y en el JWT) | `Ori_Sil_2` |
| `nombre_empresa` | texto | Nombre completo (se muestra al usuario) | `Origen Silvestre` |
| `siglas` | abreviatura | Solo visual (NO se usa como FK en ninguna tabla) | `OS` |

- El JOIN correcto a `sys_empresa` es siempre: `ON e.uid = tabla.empresa`
- El campo `empresa` en tablas transaccionales guarda el `uid` de `sys_empresa`
- El `empresa_activa` del JWT guarda el `uid` de `sys_empresa`

## Reglas que nunca se rompen (Bloqueo en Backend)
1. **Confianza Cero en el Frontend**: JAMÁS se debe confiar en el ID de empresa o el nombre del usuario enviado por el Frontend en el cuerpo de una petición JSON, ya que estos pueden ser manipulados maliciosamente.
2. **Inyección Forzada (La Verdad Absoluta es el JWT)**: 
   - El middleware `ValidarJwt.php` valida el token y extrae el payload (que contiene `empresa_activa` y `email`).
   - El controlador base inyecta y sobrescribe obligatoriamente estas variables en el array de `$datos` ANTES de pasarlo a los Casos de Uso.
3. **Todo Caso de Uso (SELECT, UPDATE, DELETE)**: Debe condicionarse inexcusablemente con `AND empresa = :empresa`.
4. **Campos obligatorios en nuevos registros (INSERT)**:
   - `empresa`
   - `usuario_creador` (el email del usuario)
   - `usuario_ult_modificacion` (mismo al creador en la inserción)
5. **Auditoría de MySQL**:
   - `fecha_creacion`: Debe delegarse a la BD mediante `DEFAULT CURRENT_TIMESTAMP`.
   - `fecha_ult_modificacion`: Debe delegarse mediante `DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP`.

## Problemas conocidos y soluciones
- **Error**: Mostrar o editar datos que no pertenecen a la empresa actual.
  **Solución**: El Caso de Uso omitió la validación. Revisa la cláusula `WHERE uid = :uid AND empresa = :empresa`. **Precaución especial:** Las tablas de solo lectura o tablas maestras (ej: `com_marcas`, `costos_encabezados_productos`) también están sujetas a esta regla inquebrantable; nunca olvides el `WHERE empresa = :empresa` en los SELECTs masivos.
- **Error**: *Vulnerabilidad de suplantación*.
  **Solución**: Un desarrollador intentó leer el `usuario_creador` del `$POST` o de variables Vue. Siempre lee `$usuarioRef->email` en el backend.
- **Error**: `SQLSTATE[42S22]: Column not found: 1054 Unknown column 'url_publica' in SELECT`.
  **Causa**: La consulta de listado (ej: `ListarProductos`) hacía una subquery a una tabla auxiliar cuya estructura no coincidía con lo esperado (columna renombrada o tabla aún no creada en ese entorno).
  **Solución**: En consultas de listado, no uses subqueries a tablas auxiliares a menos que estés 100% seguro de que existen en todos los ambientes. Usa SELECT con columnas explícitas de la tabla principal únicamente. La portada/multimedia se carga en la vista de detalle (obtener_producto), no en el listado.
- **Error**: `Call to undefined method PDO::obtenerPDO()`.
  **Causa**: El singleton `Conexion::obtenerInstancia()` ya devuelve directamente un objeto `PDO`. Si le agregas `->obtenerPDO()` encadenado, PHP falla con Fatal Error.
  **Solución**: Usa siempre `$pdo = Conexion::obtenerInstancia();` — sin encadenamiento adicional.
- **Error**: El catálogo muestra "No hay productos" aunque existan registros en BD. La API regresa timeout o error de conexión.
  **Causa raíz**: Conexiones `Sleep` fantasma dentro del servidor MariaDB. Ocurre cuando un cliente mysql es terminado externamente (Ctrl+C, kill, timeout) pero su sesión TCP permanece abierta dentro del servidor en estado `Sleep`. Si luego se ejecuta un `ALTER TABLE ... FOREIGN KEY` o DDL similar, este espera a que esas conexiones Sleep liberen sus locks → deadlock de espera → toda la BD bloqueada.
  **Síntoma**: `SHOW PROCESSLIST` y `SELECT COUNT(*)` se cuelgan sin responder.
  **Diagnóstico correcto**:
  ```bash
  mysqladmin -u[user] -p[pass] processlist   # muestra conexiones Sleep colgadas
  ```
  **Solución**:
  ```bash
  # 1. Ver los IDs de los procesos colgados:
  mysqladmin -u[user] -p[pass] processlist
  # 2. Matar los procesos Sleep por ID:
  mysqladmin -u[user] -p[pass] kill ID1,ID2,...
  # Alternativa — matar todos los clientes externos (NO el proceso del servidor):
  pkill -f "mysql.*nombre_bd"
  ```
  **Prevención**:
  1. Antes de ejecutar cualquier `ALTER TABLE` o DDL, verificar que no haya conexiones Sleep largas con `mysqladmin processlist`.
  2. Si hay conexiones Sleep con `Time > 30`, matarlas antes del ALTER.
  3. Nunca dejar ventanas de terminal con comandos mysql abiertos en background por más de unos minutos.

- **Error**: *Filtro de Seguridad Bloquea Peticiones de Vue (Cuadros Amarillos de Network Error)*.
  **Solución**: El navegador lanza peticiones `OPTIONS` (CORS preflight) antes de los métodos `POST` que llevan JWT. Si tu middleware JWT intercepta la petición `OPTIONS`, la rechazará con HTTP 401. **Para solucionarlo:** En el enrutador principal, responde a `OPTIONS` con HTTP 204 INMEDIATAMENTE ANTES de despachar o requerir middlewares.

## Ejemplos de código correcto

**El Controlador blinda los datos:**
```php
// Fichero: CualquierController.php
$usuarioRef = ValidarJwt::$usuarioActual;

// Inyección forzosa para auditoría y filtro:
$datos['empresa']                  = $usuarioRef->empresa_activa ?? '';
$datos['usuario_creador']          = $usuarioRef->email ?? '';
$datos['usuario_ult_modificacion'] = $usuarioRef->email ?? '';
```

**El UPDATE blindado:**
```php
$sql = 'UPDATE com_productos SET 
            nombre = :nombre,
            usuario_ult_modificacion = :usuario_ult_modificacion
        WHERE uid = :uid AND empresa = :empresa'; // <--- Vital

$stmt = $pdo->prepare($sql);
$stmt->execute([
    'nombre' => $datos['nombre'],
    'usuario_ult_modificacion' => $datos['usuario_ult_modificacion'], // Inyectado por PHP
    'uid' => $uid,
    'empresa' => $datos['empresa'] // Inyectado por PHP
]);
```
