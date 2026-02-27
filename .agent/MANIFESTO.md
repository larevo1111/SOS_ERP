# Manifiesto Operativo: Protocolo de Agentes ERP Origen Silvestre

## 1. Identidad del Equipo

Este repositorio es un ERP modular desarrollado en PHP, Vue 3 + Quasar y MySQL.
Está alojado en Hostinger Shared Hosting y diseñado para ser vendible a terceros.

El equipo de agentes opera bajo la siguiente jerarquía:

- **Santiago (Santi) es el director:** Tu eres su arquitecta pero el prefiere llamarlas madrinas. La buena comunicacion es lo principal. Siempre que sea explicada bien en español, sin tecnisistmos, pero tambien sin carreta, clara concisa, con ejemplos, buscando que Santi entienda cada cosa. Si no enitenden algo pregunten, la comunicacion debe ser fluida y clara. En lo posible cuando Santi no entienda algo le ponen algun ejemplo. El es malo para palabras tecnicas, pueden usarlas pero explicandolas clara y brevemente.
- **Arquitecto (AntiGravity):** Única entidad autorizada para crear planes, definir estructura y tomar decisiones de diseño. Opera con modelos ligeros para optimizar tokens.
- **Constructor Principal (Claude Code):** Implementa el código completo siguiendo estrictamente los planes del Arquitecto. Analiza el repositorio antes de ejecutar.
- **Constructor Secundario (Codex):** Correcciones puntuales y ajustes específicos de código.
- **Consultor Estratégico (Claude en carpeta del proyecto):** Revisa decisiones, resuelve dudas de arquitectura, genera documentación y contextos para los demás agentes.

---

## 2. Reglas que nunca se rompen

- Todo el código, comentarios, carpetas y documentación van **en español**.
- Ningún módulo accede directamente a la base de datos de otro. Toda interacción pasa por casos de uso.
- Sin sobreingeniería: solo la complejidad que el problema requiere.
- Estructura modular: cada módulo es autosuficiente.

---

## 3. Convenciones obligatorias

| Elemento | Convención | Ejemplo |
|---|---|---|
| Archivos PHP | PascalCase | `CrearVenta.php` |
| Tablas SQL | prefijo_snake_case plural | `ven_ordenes_venta` |
| Endpoints | snake_case | `/api/ventas/crear_cotizacion` |
| Archivos Vue | PascalCase | `PantallaVentas.vue` |
| Archivos JS | camelCase | `useVentas.js` |

> Los prefijos por módulo están definidos en la sección 6.1.

---

## 4. Estructura del repositorio

```
/erp
├── /nucleo
│   ├── /entidades        → clases que definen qué ES algo
│   ├── /reglas           → validaciones de negocio globales
│   ├── /utilidades       → Fechas.php, Numeros.php, Textos.php
│   ├── /validaciones     → ValidarRFC.php, ValidarEmail.php
│   └── /excepciones      → ProductoNoEncontrado.php, DatosInvalidos.php
├── /modulos
│   └── /nombre_modulo
│       ├── /dominio        → entidades y reglas del módulo
│       ├── /casos_de_uso   → una clase = una acción
│       ├── /controladores  → recibe HTTP, llama caso de uso
│       ├── rutas_modulo.php
│       ├── /base_datos     → archivos SQL del módulo
│       └── /documentacion  → reglas y flujos en markdown
├── /infraestructura
│   ├── /autenticacion
│   ├── /base_datos       → Conexion.php, config_bd.php
│   ├── /correo
│   ├── /archivos
│   ├── /seguridad
│   ├── /auditoria
│   └── rutas.php
├── /frontend
│   └── /src
│       ├── /modulos
│       ├── /compartido
│       └── /nucleo
└── /documentacion
```

---

## 5. Estructura de respuesta API (siempre igual)

```json
{
  "exito": true,
  "datos": {},
  "mensaje": "Descripción del resultado",
  "errores": []
}
```

---

## 6. Base de datos

- MariaDB 11.8 único central. Tanto el servidor de Hostinger como el ambiente local deben usar MariaDB 11.8 para evitar conflictos de collation.
- Todas las tablas incluyen: `empresa`, `usuario_creador`, `usuario_ult_modificacion`, `fecha_creacion`, `fecha_ult_modificacion`.
- Multiempresa lógica por campo, no física.

---

## 7. Protocolo de trabajo por tareas

### Flujo estándar

1. **AntiGravity** crea el plan en un archivo `PLAN_nombre.md` con tareas usando `- [ ]`.
2. **Santi aprueba** el plan en el chat antes de que cualquier constructor ejecute.
3. **Claude Code** lee el plan, revisa el repositorio y construye el código.
4. Al completar cada tarea, Claude Code:
   - Marca el checkbox como `- [x]`
   - Actualiza `CONTEXTO_ACTIVO.md` (incluyendo su nombre en el historial y en 'Madrina a cargo')
   - Entrega: archivo principal + SQL si aplica + rutas actualizadas

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

**Nombre del archivo:** `backup_YYYYMMDD_HHMMSS_descripcion_corta.sql`
Ejemplo: `backup_20240315_143022_agregar_tabla_clientes.sql`

**Dónde se guarda:** En el servidor Hostinger en `~/backups/bd/`. Nunca se sube a GitHub. Agregar `/backups/` al `.gitignore`.

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

Los agentes nunca deben pedir ni mostrar los valores reales del `.env`. Si se necesita validar la conexión, pedirle a Santi que ejecute la prueba localmente.

Nota: el motor de base de datos es MariaDB 11.8, no MySQL. Usar MySQL en local causa conflictos de collation con las tablas heredadas de AppSheet.

---

## 11. Infraestructura y ambientes

### 11.1 Ambientes de trabajo

El proyecto opera en dos ambientes separados. Nunca se trabaja directo en producción.

**Ambiente local (desarrollo)**
Donde se construye y prueba todo. Nadie externo lo ve.
- Máquina: PC de Santi (Ubuntu)
- Código: `/home/osserver/.gemini/antigravity/scratch/SOS_ERP/`
- Archivos subidos por usuarios: `/home/osserver/SOS_ERP_archivos/`
- BD: `sos_erp_local` en MySQL local
- URL: `http://localhost/erp`
- `.env` ubicado en: `/home/osserver/.gemini/antigravity/scratch/SOS_ERP/.env`

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

```
Código local → prueba → Santi aprueba → push a GitHub → despliega en Hostinger
```

**Paso a paso:**
1. El agente construye y prueba en local
2. Santi revisa y aprueba
3. Se hace commit y push al repo `SOS_ERP` en GitHub
4. Santi se conecta al servidor por SSH y ejecuta el pull
5. El servidor queda actualizado

El comando para actualizar el servidor desde SSH es:
```bash
cd ~/domains/oscomunidad.com/public_html/erp && git pull
```

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

### 11.5 Archivos del sistema

Los archivos subidos por usuarios (imágenes, documentos, facturas) se guardan fuera de `public_html` para que no sean accesibles directamente por URL. El ERP los sirve a través de PHP con control de permisos.

**Estructura de carpetas de archivos:**
```
SOS_ERP_archivos/
└── empresas/
    └── OS/              → una carpeta por siglas de empresa
        ├── CARPETA NOMBRE 1 (Se les asigna el nombre en cada caso, según el modulo o el contenido, debes preguntar sobre el nombre de estas carpetas)
        ├── CARPETA NOMBRE 2
        ├── CARPETA NOMBRE 3
        └── CARPETA NOMBRE 4
```

Cuando se agrega una empresa nueva al sistema, se crea automáticamente su carpeta con sus siglas.

**Almacenamiento futuro:** cuando el proyecto escale a muchos clientes, los archivos migrarán a Cloudflare R2 (~$15 USD/TB/mes, sin costo de transferencia). El código no cambiará porque todo se lee desde variables del `.env`.

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

---

## 14. Guías de Estilo: "Sistema Orígenes"

El ERP debe transmitir elegancia, modernidad y orden absoluto (5S), alineado con la esencia de Origen Silvestre.

### 14.1 Mantra Visual
*   **Minimalismo Funcional**: Si un elemento no ayuda a la tarea, estorba.
*   **Luz y Aire**: Uso generoso de espacios en blanco/off-white para evitar fatiga.
*   **Profesionalismo Orgánico**: Equilibrio entre tecnología (Stripe/Linear) y naturaleza.

### 14.2 Paleta de Colores Oficial
*   **Fondo Base**: `#FDFDFB` (Off-White/Hueso).
*   **Primario (Éxito/Marca)**: `#2D5A27` (Verde Bosque).
*   **Secundario (Acción/WooCommerce)**: `#D2691E` (Naranja Terracota).
*   **Texto/Sidebar**: `#1A1C19` (Dark Charcoal).
*   **Superficies**: Blanco puro con bordes sutiles o Glassmorphism leve.

### 14.3 Tipografía y UI
*   **Fuente Principal**: `Inter` o `Geist` para interfaces de datos.
*   **Micro-interacciones**: Transiciones suaves de opacidad y `spring` sutil en botones.
*   **Buscador**: Centralizado (estilo Command+K) para acceso rápido.

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
