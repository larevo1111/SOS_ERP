---
description: Guía inmutable para el manejo, subida y estructuración de archivos multimedia (Cloudflare R2) en el ERP. LEER COMPLETO antes de tocar cualquier código de subida de archivos.
---

# 📸 Política de Archivos y Multimedia (CDN / R2)

## 0. Principio Fundamental — Analiza la BD ANTES de Codificar

⚠️ **OBLIGATORIO**: Antes de escribir cualquier INSERT, UPDATE o SELECT relacionado con multimedia, ejecuta:
```bash
mysql -u[user] -p[pass] [db] -e "DESCRIBE com_productos_multimedia;"
```
No asumas columnas. El schema real manda. Si el schema en código no coincide con la BD, el código está MAL.

## 1. Filosofía de Almacenamiento (PRINCIPIO INAMOVIBLE)

**El campo `archivo_local` almacena SOLO la ruta relativa dentro del bucket, SIN la URL base del proveedor.**

```
BD guarda:   empresas/ori_sil_2/productos/OS.260302101558/20260302-a1b2.jpg
NO guarda:   https://archivos.oscomunidad.com/empresas/ori_sil_2/...
```

La URL completa se reconstruye dinámicamente en tiempo de ejecución leyendo la configuración de la empresa:
```php
// El middleware JWT inyecta la URL base configurada en `sys_empresa` para el tenant actual
$urlCompleta = rtrim($datos['storage_url_publica'] ?? '', '/') . '/' . $registro['archivo_local'];
```

**¿Por qué? (Nueva Arquitectura Multi-Tenant 2026)**
1. **Portabilidad Total:** Si una empresa cambia de proveedor (AWS S3, R2, GCP), solo cambian los datos en la tabla `sys_empresa`. Los miles de registros de `com_productos_multimedia` quedan intactos, ya que solo guardan la ruta `empresas/ori_sil_2/...`
2. **Seguridad Absoluta:** Las claves maestras S3 (`storage_access_key`, `storage_secret_key`) residen *exclusivamente* en la base de datos `sys_empresa` y solo son llamadas puntualmente por el backend al subir o borrar. **JAMÁS** van en el JWT ni llegan al frontend.
3. **Alto Rendimiento:** Solo el frontend y GETS (`ListarProductos`, `ObtenerProducto`) necesitan la URL base pública (`storage_url_publica`). Esta viaja encriptada en el JWT en el momento del inicio de sesión (evitando miles de consultas a la BD en cada carga de listado).

### 1.1 Configuración de la URL Pública (Lección Crítica)

⚠️ **NUNCA** guardes en la base de datos la URL de la API S3 de Cloudflare (ej. `https://893354e...r2.cloudflarestorage.com/...`). 
Esta URL es un **Endpoint S3** y requiere firmas criptográficas en cada petición. Si la usas como URL pública, **todas las imágenes se verán rotas en el frontend** devolviendo un error HTTP 400 Bad Request.

✅ **FORMA CORRECTA:** Debes guardar **exclusivamente** el Dominio Público configurado en el panel de Cloudflare R2.
- **Opción A (R2.dev):** `https://pub-96a13c5af89340e494b461e0384f879c.r2.dev` (Ideal para desarrollo/pruebas).
- **Opción B (Custom Domain):** `https://archivos.mi-erp.com` (Exigido para Producción).

Esta URL pública real es la que se guarda en la tabla `sys_empresa` en la columna `storage_url_publica`.

## 2. Schema Real de com_productos_multimedia (Verificado 2026-03-02)

> ⚠️ CRÍTICO: Usar SIEMPRE estos nombres. Verificar con DESCRIBE antes de INSERT.

| Columna | Tipo | Qué guarda |
|---|---|---|
| `uid` | VARCHAR(80) | Formato `SIGLAS.YYMMDDHHMMSS` |
| `uid_producto` | VARCHAR(80) | FK → `com_productos.uid` (ON DELETE CASCADE) |
| `tipo_archivo` | ENUM(`imagen,video,documento,html`) | Auto-detectado del MIME type. Soporta PDF, Word, Excel y ZIP. |
| `uso` | ENUM(`Principal,Galeria,Variacion,Galeria secundaria,Otro`) | Definido por sección de la UI |
| `archivo_local` | VARCHAR(500) | **Ruta relativa en el bucket** (sin URL base) |
| `archivo_woocommerce` | VARCHAR(500) | ID de WooCommerce (vacío hasta sincronización) |
| `orden` | INT DEFAULT 0 | Orden de visualización |
| `estado` | ENUM(`Activo,Inactivo`) | Estado |
| + campos de auditoría estándar | | empresa, usuario_creador, etc. |

### Mapa de `uso` según sección de la UI:
| Sección de la UI | Valor de `uso` |
|---|---|
| Pestaña General → foto principal | `Principal` |
| Popup de Variaciones → imagen de variación | `Variacion` |
| Pestaña Galería → sección principal | `Galeria` |
| Pestaña Galería → sección secundaria | `Galeria secundaria` |
| Reservado para uso futuro | `Otro` |

## 3. Relación Padre-Hijo en BD

La tabla `com_productos_multimedia` tiene FK formal con CASCADE:
```sql
FOREIGN KEY (uid_producto) REFERENCES com_productos(uid) ON DELETE CASCADE ON UPDATE CASCADE
```
- Si se borra un producto → sus multimedia se borran automáticamente en BD
- ⚠️ El código PHP que borra un producto DEBE también eliminar los archivos físicos en R2 (la FK limpia la BD, pero no el bucket)

## 4. INSERT Correcto (template)

```php
// ✅ CORRECTO
$stmt->execute([
    ':uid'                      => $uid,                  // SIGLAS.YYMMDDHHMMSS
    ':empresa'                  => $empresa,               // strtolower
    ':uid_producto'             => $uidProducto,           // uid del com_productos padre
    ':tipo_archivo'             => $tipoArchivo,           // 'imagen' | 'video' | etc.
    ':archivo_local'            => $rutaEnBucket,          // ruta relativa en el bucket
    ':archivo_woocommerce'      => '',                     // vacío hasta sincronizar con WC
    ':uso'                      => $datos['uso'] ?? 'Galeria',
    ':orden'                    => $orden,
    ':estado'                   => 'Activo',
    ':usuario_creador'          => $usuario,
    ':usuario_ult_modificacion' => $usuario,
]);
```

## 5. Protocolo de Carga Frontend-Backend

### 5.1 Restricción de "Registro Previo" (Frontend)
**CRÍTICO:** Nunca permitas subir archivos si el registro padre (producto) no ha sido guardado (no tiene `uid`).
```javascript
if (!producto.value.uid) {
  $q.notify({ type: 'warning', message: 'Guarda el producto primero para adjuntar archivos.' })
  return
}
```

### 5.2 Envío `multipart/form-data` con API Service
No usar JSON estándar. Usar `subirArchivo()` de `apiService.js`.

El campo `uso` va dentro de `datos`:
```javascript
await subirArchivo('comercial', 'productos', 'subir_multimedia', archivoFisico, {
  uid_producto: producto.value.uid,
  uso: 'Galeria'  // 'Principal' | 'Galeria' | 'Variacion' | 'Galeria secundaria'
})
```

### 5.3 Construcción de URL para mostrar imágenes en Frontend
```javascript
// El backend devuelve 'archivo_local' (ruta relativa) y 'url_publica_calculada' (URL completa)
const urlImagen = archivo.url_publica_calculada || archivo.archivo_woocommerce || ''
```

## 6. Problemas Conocidos y Soluciones

- **`Data truncated for column 'uso'`**: El frontend envió `'Portada'` que no existe en el ENUM. El valor correcto es `'Principal'`. Revisar `opcionesUso` en los Vue de formularios.
- **`Unknown column 'nombre_archivo' in INSERT INTO`**: Las columnas reales son `archivo_local` y `archivo_woocommerce`. Los nombres `nombre_archivo`, `ruta_archivo`, `url_publica` NO existen en la BD.
- **Archivos huérfanos en R2**: Ocurren cuando el PHP crea el archivo en R2 pero el INSERT falla. Solución: el PHP debe intentar eliminar el archivo de R2 si el INSERT falla (try-catch).
- **Error de FK al insertar multimedia**: Ocurre cuando `uid_producto` no existe en `com_productos`. Verificar que el producto se guardó antes de subir multimedia.

## 7. Configuración de Límite de Tamaño de Archivos (500 MB)

El sistema está configurado actualmente para aceptar archivos (imágenes, PDFs, videos) de hasta **500 MB**.
Si en algún momento el cliente requiere subir archivos más grandes o arroja un error de que el archivo supera el límite permitido, se deben actualizar EXACTAMENTE estos dos lugares:

1. **Configuración del Servidor PHP (`php.ini`)**
   Ruta en producción/local: `/etc/php/8.3/apache2/php.ini` (o la versión correspondiente).
   Cambiar las siguientes directivas y **reiniciar Apache** (`sudo systemctl restart apache2`):
   ```ini
   upload_max_filesize = 500M
   post_max_size = 500M
   ```

2. **Backend PHP (Regla de Negocio)**
   Archivo: `erp/modulos/comercial/casos_de_uso/SubirMultimedia.php`
   Actualizar la constante que valida por seguridad antes de subir a R2:
   ```php
   private const TAMANO_MAXIMO = 500 * 1024 * 1024; // 500 MB
   ```
