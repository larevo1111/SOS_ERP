# Manifiesto Operativo: Protocolo de Agentes ERP Origen Silvestre [5S]

## 1. Identidad y Jerarquía (Autoridad Operativa)
- **Santi (Santiago)**: **Director y Dueño**. Su aprobación es la ley. Tiene autonomía total para operar el sistema siguiendo el **[Manual de Uso Autónomo](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/skill_navegacion_autonoma.md)** y publicar versiones mediante el **[Manual de Despliegue](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/skill_despliegue_produccion.md)**.
- **Arquitecta (AntiGravity/Madrina)**: **Autoridad de Diseño**. Única autorizada para crear planes, definir estructuras (DB, API, carpetas) y tomar decisiones técnicas. Los constructores no pueden alterar el diseño sin su aval.
- **Constructores (Claude/Codex)**: **Autoridad de Ejecución**. Implementan siguiendo estrictamente los planes locales. Deben reportar bloqueos antes de improvisar.

---

## 2. Reglas de Oro 5S (Blindaje Absoluto)
1. **Regla de Oro de Claridad (Stop & Ask)**: Prohibido suponer o inventar. Si un plan o instrucción no es 100% explícito: **DETENTE Y PREGUNTA A SANTI**.
2. **Protocolo de Comunicación con el Director**: Siempre explicar "Qué se hizo" y "Cómo afecta al negocio" usando analogías o ejemplos, evitando jerga técnica (o explicándola entre paréntesis si es vital).
3. **Protocolo de Asignación**: Todo trabajo se basa en un plan en `.agent/planes/`. Se debe referenciar obligatoriamente la `GUIA_ESTILOS.md` y `Skills` relevantes.
4. **Privacidad y Seguridad**: Credenciales solo en `.env`. Backup estructural solo en Hostinger (nunca en GitHub).

---

## 3. Estándares de Ingeniería (Código y API)
- **Idioma**: 100% Español. **Convenciones**: `PascalCase` (PHP/Vue), `snake_case` (DB/Campos), `camelCase` (JS).
- **Lógica Multiempresa**: Campo `empresa` obligatorio en minúscula (ej: `os`).
- **Limpieza (Seiri)**: Los archivos de prueba (`test_...`, `info.php`) deben eliminarse inmediatamente tras verificar. Prohibido comitear "basura" de depuración.

### 3.1 Almacenamiento y API
- **Cloudflare R2**: Único almacenamiento permanente. Carpetas: `siglas_modulo_desc` (ej: `os_com_fotos`).
- **Protocolo API (JSON)**: 
  - **Request**: `{ "token": "...", "accion": "...", "datos": { ... } }`
  - **Response**: `{ "exito": true, "datos": { ... }, "mensaje": "...", "errores": [] }`

---

## 4. Leyes de Base de Datos (MariaDB 11.8)
- **Prefijos**: `sys_`, `com_`, `inv_`, `ven_`, `din_`.
- **Campos Audit (Obligatorios)**: `id` (PK AI), `uid` (UNIQUE OS-YYYYMMDD-001), `empresa`, `usuario_creador`, `usuario_ult_modificacion`, `fecha_creacion`, `fecha_ult_modificacion`.
- **Tablas Prohibidas**: Estructuras de AppSheet (`costos_`, `prod_`, `din_`, `sys_`) son intocables.

---

## 5. Infraestructura y Despliegue
- **SSH Hostinger**: Alias `hostinger_erp` en `~/.ssh/config`. Permisos `600` en llaves privadas.
- **Backup**: Solo cambios de estructura en Hostinger. Ubicación: `~/backups/bd/`.

---

## 6. Memoria y Gobernanza 5S
- **Estética Orígenes**: Fidelidad total a `GUIA_ESTILOS.md` (Verdes/Naranjas tierra, minimalismo premium).
- **Skills**: Documentar lecciones en `.agent/skills/`. Incluir `Estado`, `Autor` y `Fecha`.
- **Contexto**: `CONTEXTO_ACTIVO.md` corto y real.

## 7. Política de Sincronización de Base de Datos y Accesos

Para garantizar que el ecosistema (Hostinger, Ubuntu Local, Windows 11) se mantenga en sincronía y no existan desfaces estructurales ni de datos de prueba:

1. **La Base de Datos viaja por Git**: Toda alteración a la base de datos (nuevas tablas, migraciones, registros de prueba complejos) debe exportarse al archivo `erp/base_datos/sos_erp_sync.sql` usando el script oficial.
2. **Mandamiento de Exportación**: Si alteras la BD en tu entorno, ejecuta `./erp/scripts/db_export.sh`, haz `git commit` y `git push`.
3. **Mandamiento de Importación**: Al cambiar de equipo (ej. de Hostinger a Ubuntu o de Ubuntu a Windows 11), después de hacer `git pull`, debes ejecutar `./erp/scripts/db_import.sh` para absorber los cambios estructurales.
4. **Acceso Permanente a Desarrollo**: Para visualizar el frontend desde cualquier equipo en la red local, se debe ejecutar siempre `./erp/scripts/iniciar_dev.sh`. Este script imprimirá la URL fija (ej. `http://<ip-ubuntu>:5173`) sin necesidad de configuraciones DNS adicionales.

- MariaDB 11.8 único central. Tanto el servidor de Hostinger como el ambiente local deben usar MariaDB 11.8 para evitar conflictos de collation.
- Todas las tablas incluyen: `empresa`, `usuario_creador`, `usuario_ult_modificacion`, `fecha_creacion`, `fecha_ult_modificacion`.
- Multiempresa lógica por campo, no física.

---

## 7. Protocolo de trabajo por tareas

### Flujo estándar

1. **AntiGravity** crea el plan en un archivo `PLAN_nombre.md` con tareas usando `- [ ]`.
2. **Santi aprueba** el plan en el chat antes de que cualquier constructor ejecute.
3. **Claude Code** lee el plan, revisa el repositorio y construye el código.
4. Al completar cada tarea, Claude Code (o Codex):
   - Marca el checkbox como `- [x]`
   - Actualiza `CONTEXTO_ACTIVO.md` (incluyendo su nombre en el historial y en 'Madrina a cargo')
   - Entrega: archivo principal + SQL si aplica + rutas actualizadas

5. **Regla de Sincronización Estricta (Bloqueo de Falsas Esperanzas)**: Ningún agente (especialmente la Madrina Arquitecta) puede dar instrucciones, "luz verde" o comandos para otros agentes si el código o los planes **no han sido subidos exitosamente al repositorio remoto mediante `git push`**. El agente debe esperar a verificar la salida exitosa del comando push ANTES de decirle a Santi "ya puedes activar al otro agente".

6. **Confianza en la Arquitectura (Regla 5S)**: Si la Madrina Arquitecta ya detalló estructuras de tablas, estados del entorno o variables en el `PLAN_nombre.md` o `CONTEXTO_ACTIVO.md`, el Constructor debe confiar en esa investigación. Está prohibido ejecutar comandos de verificación redundantes que interrumpan al usuario con permisos de Bash innecesarios o consuman tokens repitiendo lo que ya se documentó.

### Estados de tarea

- `- [ ]` → Pendiente, definida por el Arquitecto, esperando aprobación o ejecución.
- `- [x]` → Completada. Solo se marca si el código está implementado y sin errores sintácticos.
- `> BLOQUEO: descripción` → El constructor encontró un impedimento. No marca la tarea. El Arquitecto resuelve en la siguiente iteración.

### Regla de bloqueos

Cuando un constructor encuentra un problema que no puede resolver solo, agrega debajo de la tarea:

```
> BLOQUEO: [explicación clara en español, sin tecnicismos, con ejemplo si aplica]
```

---

## 8. Protocolo de conflictos

Si Claude Code encuentra que lo que AntiGravity diseñó no encaja con lo que existe en el repositorio:

1. **No ejecuta el cambio.**
2. **Reporta el conflicto a Santi** con esta estructura:
   - Qué dice el plan
   - Qué existe en el repo
   - Por qué hay conflicto (explicado sin tecnicismos, con ejemplo si es necesario)
   - Opciones posibles con sus consecuencias simples
3. **Santi decide** cuál camino tomar.
4. Si el tecnicismo es inevitable, debe ir acompañado de su explicación entre paréntesis.

---

## 9. Módulos del sistema

Ventas, Compras, Inventario, Producción, Costos, CRM, Logística, Tareas.
Seguridad y Empresas como módulos transversales en infraestructura.

> **Nota:** Costos y Producción permanecen en AppSheet sin modificaciones.
> El desarrollo activo comienza con la integración WooCommerce, luego el módulo Ventas.

---

## 10. Instrucción de lectura para cualquier agente

Antes de proponer o ejecutar cualquier cosa, leer en este orden:

1. Este archivo (`MANIFESTO.md`)
2. `CONTEXTO_ACTIVO.md`
3. El plan de la tarea asignada (`PLAN_nombre.md`)
4. Los archivos del repositorio relevantes a la tarea
5. `.agent/diseno/GUIA_ESTILOS.md` → obligatorio antes de tocar cualquier archivo del frontend
6. **[.agent/skills/README_SKILLS.md](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/README_SKILLS.md)** → Catálogo Maestro de Skills (Obligatorio)
---

## 6.1 Prefijos de tablas por módulo

Toda tabla debe tener un prefijo que identifique a qué módulo pertenece.
Si hay duda sobre qué prefijo usar, el agente propone y Santi aprueba antes de crear la tabla.

| Prefijo | Módulo |
|---|---|
| `sys_` | Sistema (usuarios, empresas, permisos, roles) |
| `com_` | Comercial (productos, marcas, multimedia) |
| `inv_` | Inventario |
| `ven_` | Ventas |
| `crm_` | CRM |
| `compras_` | Compras |
| `log_` | Logística |
| `tar_` | Tareas |
| `din_` | Dinero / Finanzas |
| `costos_` | Costos (solo AppSheet, no modificar) |
| `prod_` | Producción (solo AppSheet, no modificar) |

> Si un módulo nuevo no tiene prefijo definido aquí, el agente propone uno y espera aprobación de Santi antes de usarlo.

---

## 6.2 Convención de nombres de campos

- Siempre en `snake_case` minúscula. Sin excepción.
- El campo `empresa` siempre en minúscula. Las tablas heredadas de AppSheet pueden tenerlo como `Empresa` (con mayúscula), pero las tablas nuevas del ERP usan siempre `empresa` en minúscula.
- Cuando se vaya a crear una tabla nueva, el agente propone los nombres de los campos y Santi los aprueba o modifica antes de ejecutar el SQL.

---

## 6.3 Tablas protegidas (no modificar estructura)

Estas tablas están enlazadas con AppSheet o son parte del sistema heredado.
**Ningún agente puede modificar su estructura (agregar, quitar o renombrar campos).**
Los registros se pueden leer desde el ERP pero no modificar sin autorización explícita de Santi.

**Módulo Costos (`costos_`)**
costos_categorias, costos_consumibles, costos_encabezados_productos, costos_etiquetas, costos_fases, costos_formulas, costos_grupos_productos, costos_herramientas, costos_mp_insumos, costos_procedimientos, costos_procedimientos_consumibles, costos_procedimientos_herramientas, costos_procedimientos_imag_vid, costos_procedimientos_mp_insumos, costos_procedimientos_pp, costos_procedimientos_servicios_mo, costos_producto_procedimientos, costos_recursos_ambientales, costos_residuos, costos_residuos_destinos, costos_rutas_producto, costos_servicios_mo, costos_tipos_procedimientos, costos_tipos_residuos, costos_unidades, costos_unidades_tipos

**Módulo Producción (`prod_`)**
prod_estados_op, prod_ordenes_consumos, prod_ordenes_detalles, prod_ordenes_encabezados, prod_ordenes_lotes, prod_ordenes_residuos, prod_ordenes_resultantes, prod_ordenes_trazabilidad, prod_tipos_orden

**Módulo Dinero (`din_`)**
din_categorias_egresos, din_categorias_ingresos, din_cuentas, din_egresos, din_filtro_egresos, din_filtro_ingresos, din_ingresos, din_traslados

**Inventario (`inv_`)**
inv_bodegas, inv_tipos_pp

**Sistema (`sys_`)**
sys_acciones, sys_areas, sys_banderas, sys_empresa, sys_permisos, sys_permisos_acciones, sys_permisos_campos, sys_roles, sys_usuarios, sys_usuarios_empresas

**Otras heredadas**
menu_ppal *(estructura intocable, contenido puede actualizarse)*
Ensayoski *(tabla de pruebas, ignorar)*

---

## 6.4 Tablas modificables por el ERP

Solo las tablas `com_` existentes y todas las tablas nuevas que cree el ERP pueden modificarse libremente.

**Módulo Comercial (`com_`)**
com_marcas, com_productos, com_productos_multimedia

---

## 6.5 Campos obligatorios en tablas nuevas

Toda tabla nueva debe incluir estos campos sin excepción:

| Campo | Tipo | Descripción |
|---|---|---|
| `id` | BIGINT UNSIGNED, AUTO_INCREMENT, PRIMARY KEY | Llave interna de MySQL |
| `uid` | VARCHAR(100), UNIQUE NOT NULL | Identificador único. Empieza con las siglas de la empresa (campo `siglas` en `sys_empresa`) seguido de guion y código único. Ejemplo: `OS-20240301-001` |
| `empresa` | VARCHAR(50), NOT NULL | Siglas de la empresa, siempre en minúscula |
| `usuario_creador` | VARCHAR(150), NOT NULL | Email del usuario que creó el registro (referencia a `sys_usuarios.Email`) |
| `usuario_ult_modificacion` | VARCHAR(150), NOT NULL | Email del último usuario que modificó el registro |
| `fecha_creacion` | DATETIME, DEFAULT current_timestamp() | Fecha y hora de creación |
| `fecha_ult_modificacion` | DATETIME, DEFAULT current_timestamp() ON UPDATE current_timestamp() | Fecha y hora de última modificación |

> `fecha_ult_modificacion` es la base para sincronización offline futura. No eliminarlo ni renombrarlo en ninguna tabla nueva.

### 6.5.1 Reglas Generales de Edición (Frontend)
> **Nota:** El Manifiesto solo contiene reglas universales que aplican a todo el ERP. Las reglas específicas de cada módulo viven en su respectivo `PLAN_nombre.md`.

Para mantener la integridad de los datos y el orden (5S):
- **Campos No Editables**: Los campos de auditoría y sistema (`empresa`, `usuario_creador`, `usuario_ult_modificacion`, `fecha_creacion`, `fecha_ult_modificacion`) son de **solo lectura**.
- **Consistencia Visual**: Estos campos deben ser visibles en vistas de detalle o paneles de información, pero nunca habilitados para edición manual por el usuario.

---

## 6.6 Soporte offline futuro

El sistema está diseñado para soportar modo offline en el futuro.
`fecha_ult_modificacion` permite saber qué registro es más reciente al sincronizar entre dispositivo y servidor. Regla de conflicto: el último en modificar gana.

Al diseñar cualquier módulo, no implementar lógicas que dependan de conexión en tiempo real para calcular o validar datos críticos.

---

## 6.7 Backup de base de datos

Los cambios de estructura de BD se desarrollan y prueban primero en local. Solo cuando Santi aprueba, se aplican en Hostinger. El backup es obligatorio únicamente antes de aplicar cambios de estructura en el servidor de Hostinger, nunca en local.

Se requiere backup antes de: crear una tabla nueva, agregar o quitar campos, modificar tipo de datos de un campo.

No se requiere backup para: despliegues de código PHP, cambios de frontend, inserción o modificación de registros normales.

**Ubicación Mandatoria:** El backup es obligatorio únicamente antes de aplicar cambios de estructura en el servidor de Hostinger. El archivo SQL resultante debe guardarse exclusivamente en el servidor Hostinger en `~/backups/bd/`. 

**Formato de nombre:** `backup_YYYYMMDD_HHMMSS_descripcion_corta.sql`
Ejemplo: `backup_20240315_143022_agregar_tabla_clientes.sql`

> [!IMPORTANT]
> Queda terminantemente prohibido subir archivos de volcado de base de datos (`.sql`) al repositorio de GitHub o incluirlos en el historial de Git por razones de seguridad y peso del repositorio.

**Protocolo:** El agente ejecuta el comando del backup en el servidor de Hostinger a través del acceso SSH (`hostinger_erp`) y confirma a Santi el éxito de la operación antes de proceder con el cambio estructural.

---

## 6.8 Conexión a la base de datos

La conexión se maneja mediante un archivo `.env` que **nunca se sube a GitHub**.

**Ubicación:** raíz del proyecto en `/erp/.env`. Debe estar en `.gitignore`.

**Variables requeridas:**
```
DB_HOST=
DB_PORT=3306
DB_NAME=
DB_USER=
DB_PASS=
DB_CHARSET=utf8mb4
```

**Cómo se usa:** El archivo `infraestructura/base_datos/Conexion.php` lee estas variables con `getenv()`. Ningún otro archivo puede contener credenciales directamente.

Los agentes nunca deben pedir ni mostrar los valores reales del `.env`. Si se necesita validar la conexión, pedirle a Santi que ejecute la prueba localmente. Todas las credenciales de conexión (DB, R2, APIs) residen exclusivamente en este archivo.

**Política por Estación:** Cada estación de trabajo (PC) es un ambiente independiente y requiere su propio archivo `.env` local, el cual no debe subirse a GitHub. Las variables deben ajustarse si el nombre o usuario de la base de datos local varía (ej: `sos_erp_local` en Windows vs `sos_erp` en Ubuntu).

---

## 6.9 Refinamiento Continuo y Bitácora
- **Bitácora de Errores:** Todo incidente técnico (bloqueos, incompatibilidades, fallos de entorno) debe registrarse en **[.agent/bitacora_errores.md](file:///c:/Proyectos_code/SOS_ERP/.agent/bitacora_errores.md)** por el agente que lo resuelva.
- **Flujo de Refinamiento:** La Madrina Arquitecta analizará semanalmente la bitácora para elevar soluciones recurrentes a este Manifiesto o a un Skill específico.
- **Actualización Proactiva:** Ante cada nuevo error resuelto, la Madrina preguntará si debe ser documentado permanentemente.

---

## 11. Infraestructura y ambientes

### 11.1 Ambientes de trabajo

El proyecto opera en dos ambientes separados. Nunca se trabaja directo en producción.

**Ambientes locales (Estaciones de Trabajo)**
Cada máquina (PC de Santi en Ubuntu, Windows 11, etc.) se considera un **Ambiente Espejo**.
- **Principio de Espejo:** Todo lo que corre en el servidor debe tener un reflejo funcional en cada estación (Misma versión de MariaDB, mismos módulos PHP, misma estructura de base de datos).
- Cada estación maneja su propio archivo `.env` local (protegido por `.gitignore`) donde residen las credenciales reales de BD y Cloudflare.
- **Prohibición de Credenciales:** Las llaves de acceso (API Keys, Passwords) NUNCA se escriben en el código, planes o walkthroughs. Solo viven en los archivos `.env` respectivos.
- Todos los ambientes acceden al mismo almacenamiento centralizado (Cloudflare R2).

**Ambiente de producción (servidor)**
Solo recibe código probado y aprobado por Santi.
- Servidor: Hostinger Shared Hosting
- Código: `/home/u768061575/domains/oscomunidad.com/public_html/erp/`
- Archivos subidos por usuarios: `/home/u768061575/SOS_ERP_archivos/`
- BD: `u768061575_os_comunidad` en MySQL de Hostinger
- URL: `https://erp.oscomunidad.com`
- `.env` ubicado en: `/home/u768061575/domains/oscomunidad.com/public_html/erp/.env`

> El archivo `.env` existe en cada ambiente por separado. Nunca se sube a GitHub. Está protegido por `.gitignore`. Cada ambiente tiene sus propias credenciales.

---

### 11.2 Acceso SSH al servidor

La conexión al servidor usa llave SSH sin contraseña. Ver protocolo completo en la sección 13.

---

### 11.3 Flujo de despliegue

El despliegue está 100% automatizado mediante el uso de un script oficial de flujo (workflow). Nunca se debe intentar hacer push manuales a Producción sin seguir el protocolo.

**Comando Maestro de Despliegue:**
Simplemente solicita la ejecución del archivo `.agent/workflows/desplegar_produccion.md` dictando el comando `/desplegar_produccion`.

El agente se encargará de ejecutar automáticamente los 7 pasos críticos:
1. Verificar conectividad SSH.
2. Hacer Backup de la BD de Producción.
3. Compilar el Frontend estático optimizado (`npm run build`).
4. Exportar la BD local (`db_export.sh`).
5. Subir a GitHub (Push).
6. Descargar en Hostinger (Pull).
7. Importar la BD actualizada a Producción.

---

### 11.4 Regla de contraseñas

Cuando una tarea requiere ingresar una contraseña (SSH, MySQL, etc.), el agente **nunca la maneja directamente**. En cambio:

1. Le indica a Santi el comando exacto a ejecutar
2. Le avisa que cuando el sistema pida la contraseña, la ingrese él
3. Espera confirmación de Santi para continuar

El agente **nunca bloquea una tarea** diciendo que no puede por falta de contraseña. Siempre encuentra la forma de delegarle ese paso a Santi con instrucciones claras.

Ejemplo correcto:
> "Ejecuta este comando. Cuando te pida la contraseña, ingresa la de tu MySQL local y presiona Enter."

Ejemplo incorrecto:
> "No puedo completar esta tarea porque requiere una contraseña."

---

### 11.5 Archivos del sistema y Almacenamiento Institucional

Los archivos subidos por usuarios (imágenes, documentos, facturas) se guardan fuera de `public_html` para que no sean accesibles directamente por URL. El ERP los sirve a través de PHP con control de permisos.

**Estructura de carpetas de archivos:**
```
SOS_ERP_archivos/
└── empresas/
    └── OS/              → una carpeta por siglas de empresa
        ├── CARPETA NOMBRE 1 (Se les asigna el nombre en cada caso, según el modulo o el contenido, debes preguntar sobre el nombre de estas carpetas)
        ├── CARPETA NOMBRE 2
```

Cuando se agrega una empresa nueva al sistema, se crea automáticamente su carpeta con sus siglas.

**Almacenamiento Centralizado Mandatorio:** Para garantizar el orden (5S) y evitar la redundancia de archivos, se utiliza exclusivamente **Cloudflare R2**. 
- Ninguna estación de trabajo debe guardar archivos permanentes del sistema localmente; todo debe fluir a través de R2.
- Las llaves necesarias para R2 se configuran únicamente en el `.env` de cada ambiente siguiendo el manual de seguridad.

**Política de URLs Dinámicas (Prohibición de URLs Quemadas):**
Por diseño, las rutas de almacenamiento (como dominios de R2 o servidores locales) pueden cambiar en el futuro. Por ello:
- **NUNCA** se debe guardar la URL pública completa (Ej: `https://archivos.oscomunidad.com/empresas/os/...`) directamente en un registro de base de datos.
- Las tablas en base de datos (Ej: `com_productos_multimedia`) solo deben guardar la **Ruta Relativa** en el campo `ruta_archivo` (Ej: `empresas/os/productos/...`).
- Es obligación absoluta de los Casos de Uso del Backend y Controladores de las API formar la URL definitiva al vuelo (`R2_URL_PUBLICA + ruta_archivo`) antes de devovlersela en JSON al Frontend. 
- Al guardar un nuevo archivo, el backend formará la ruta pública pero evitará guardarla dura (harcodearla) si la base de datos no lo exige.

**Ejemplo Técnico Obligatorio (Ensamblaje al vuelo en Controladores):**
```php
// 1. Backend lee la "nube" secreta desde el entorno del servidor actual
$urlBase = getenv('R2_URL_PUBLICA'); // Da: "https://archivos.oscomunidad.com" o "http://localhost:9000"

// 2. Lee la "ruta interna" pre-guardada en la base de datos
$rutaEnBD = $filaBD['ruta_archivo']; // Da: "empresas/os/productos/OS-202/foto.jpg"

// 3. Junta ambas piezas y manda la URL final al Frontend
$producto['enlace_foto'] = rtrim($urlBase, '/') . '/' . $rutaEnBD;
```

---

## 12. Política de Calidad y Orden (5S)

Para que el proyecto crezca de forma limpia y los agentes no se confundan, aplicamos estas reglas:

*   **Selección y Descarte:** Solo los planes `PLAN_nombre.md` que estén en ejecución permanecen en la raíz. Al terminar una tarea o plan, el Constructor lo mueve a la carpeta `.agent/historial/`.
*   **Lugar para cada cosa:** 
    *   **Carpetas de archivos:** Se crean siempre en minúsculas, con guión bajo y sin espacios, siguiendo el formato: `siglas_modulo_descripcion` (ejemplo: `os_ven_fotos`).
    *   **Contexto:** El archivo `CONTEXTO_ACTIVO.md` es sagrado. Al terminar una tarea, se debe limpiar cualquier nota temporal, dejar solo el estado real, el próximo paso claro e identificar al agente responsable tanto en el historial como en el campo 'Madrina a cargo'.
*   **Limpieza de Información:** Prohibido dejar "carreta" o explicaciones técnicas innecesarias. Si algo ya se resolvió o se decidió, se borra del contexto activo para mantenerlo corto.
*   **Estandarización de Aprobación (Niveles):**
    1.  **Requiere "Aprobado" explícito de Santi:** Planes nuevos de módulos, cambios a la estructura de la base de datos, cambios en tablas protegidas y modificaciones a este Manifiesto.
    2.  **Flujo Libre (No requiere aprobación nueva):** Correcciones de errores dentro de una tarea, creación de archivos definidos en un plan ya aprobado y ajustes de código menores dentro del alcance.
*   **Disciplina de Contexto:** El paso cero de todo agente es leer `MANIFESTO.md` y `CONTEXTO_ACTIVO.md`. La Arquitecta auditará el orden antes de proponer nuevos planes.
*   **Archivos Temporales y de Prueba:** Los archivos creados para realizar pruebas puntuales de conexión o depuración (ej: `test_conexion.php`) deben ser eliminados inmediatamente después de cumplir su función. Nunca deben ser comiteados al repositorio.
*   **Autorización de Archivos de Configuración:** Cualquier nuevo archivo de configuración permanente debe ser autorizado explícitamente por Santi y registrado en este Manifiesto como parte de la estructura oficial.

---

## 13. Protocolo de Acceso SSH a Producción (Hostinger)

Para acceder al servidor de producción desde la PC local (usuario `osserver`), se debe seguir este protocolo de llaves:

### 13.1 Precondiciones
*   Ejecutar comandos en la PC local, no dentro del servidor.
*   Llaves existentes: `~/.ssh/sos_erp` (privada) y `~/.ssh/sos_erp.pub` (pública).
*   Alias configurado: `hostinger_erp` en `~/.ssh/config`.

### 13.2 Configuración del Alias (`~/.ssh/config`)
```text
Host hostinger_erp
    HostName 109.106.250.195
    Port 65002
    User u768061575
    IdentityFile ~/.ssh/sos_erp
```

### 13.3 Permisos de seguridad obligatorios
```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/sos_erp ~/.ssh/config
chmod 644 ~/.ssh/sos_erp.pub
```

### 13.4 Comandos de acceso
*   **Acceso directo (con alias):** `ssh hostinger_erp`
*   **Prueba rápida:** `ssh hostinger_erp "echo conectado_ok"`
*   **Conexión manual (respaldo):** `ssh -i ~/.ssh/sos_erp -p 65002 u768061575@109.106.250.195`

### 13.5 Notas de seguridad
*   Si SSH pide contraseña, revisar los permisos de los archivos y el contenido del alias.
*   El agente nunca maneja contraseñas; si se requiere, se pide a Santi que la ingrese en el comando indicado.

---

## 14. Guías de Estilo: "Sistema Orígenes"

El ERP debe transmitir elegancia, modernidad y orden absoluto (5S), alineado con la esencia de Origen Silvestre.

### 14.1 Mantra Visual
*   **Minimalismo Funcional**: Si un elemento no ayuda a la tarea, estorba.
*   **Luz y Aire**: Uso generoso de espacios en blanco y tonos crema suaves para evitar fatiga.
*   **Profesionalismo Orgánico**: Inspiración en el diseño de Stripe y Linear, pero con el alma de Origen Silvestre (verdes y naranjas tierra).

### 14.2 Referencia Técnica Obligatoria
Toda la especificación técnica de colores (hex), tipografías, espaciados y componentes se encuentra en:
👉 **[.agent/diseno/GUIA_ESTILOS.md](file:///c:/Proyectos_code/SOS_ERP/.agent/diseno/GUIA_ESTILOS.md)**

Cualquier duda visual sobre el resultado esperado se debe consultar en el mockup:
👉 **[.agent/diseno/dashboard_ref.html](file:///c:/Proyectos_code/SOS_ERP/.agent/diseno/dashboard_ref.html)**

---

## 15. Política de Skills (Memoria Técnica 5S)

Para institucionalizar el conocimiento y evitar repetir errores, el ERP utiliza un sistema de "Skills".

### 15.1 Ubicación e Índice Maestro
- Los archivos se guardan en `.agent/skills/` con el prefijo `skill_`.
- El punto de entrada obligatorio es el **[README_SKILLS.md](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/README_SKILLS.md)**, que actúa como catálogo y guía de uso de toda la memoria técnica.

### 15.2 Flujo de Creación
- **Constructores (Claude Code/Codex)**: Aportan la materia prima. Al resolver un problema complejo o recurrente, deben anotar al final de su reporte: `SKILL PENDIENTE: [breve descripción del problema y solución]`.
- **Arquitecta (AntiGravity)**: Crea el skill oficial cuando se acumulan **3 o más anotaciones** sobre el mismo tema. Ella analiza los patrones, redacta el skill y asegura que cumpla con el estándar 5S.

### 15.3 Estructura de un Skill
1. `# SKILL_NOMBRE.md`
2. `## Para qué sirve`
3. **Regla de Especificidad (Obligatoria)**: Si el Skill es específico para un equipo (Windows 11, Ubuntu), una terminal (PowerShell, Bash) o un entorno particular, **DEBE** indicarse explícitamente al inicio con una alerta `> [!IMPORTANT]`.
4. `## Reglas que nunca se rompen`
5. `## Problemas conocidos y soluciones`
6. `## Ejemplos de código correcto`

> **Regla de Oro**: Ningún agente debe proponer soluciones técnicas que contradigan un Skill existente.
### 15.4 Refinamiento por Bitácora
- Todo error registrado en la bitácora que implique un cambio en el proceso de trabajo o una configuración de entorno obligatoria debe generar una actualización en el Skill correspondiente o la creación de uno nuevo.

> **FILOSOFÍA DIAMANTE**: Claridad quirúrgica. Si no es simple, no es 5S.
