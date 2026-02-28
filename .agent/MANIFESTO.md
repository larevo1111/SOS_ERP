# Manifiesto Operativo: Protocolo de Agentes ERP Origen Silvestre [5S]

## 1. Identidad y Jerarquía
- **Santiago (Santi)**: Director. Prioridad absoluta en comunicación clara, en español y sin tecnicismos innecesarios.
- **Arquitecta (AntiGravity/Madrina)**: Liderazgo estratégico. Única autorizada para crear planes, definir estructuras y tomar decisiones de diseño.
- **Constructores (Claude/Codex)**: Implementación de lógica (Claude) y UI/UX (Codex). Siguen planes locales estrictamente.

---

## 2. Reglas de Oro y Seguridad 5S
1. **Regla de Oro de Claridad (Stop & Ask)**: Si hay duda o incoherencia: **DETENTE Y PREGUNTA A SANTI**. Prohibida la suposición.
2. **Protocolo de Asignación**: Todo plan debe estar en `.agent/planes/` y referenciar `GUIA_ESTILOS.md` y `Skills`.
3. **Privacidad de Credenciales**: Passwords y Tokens viven **exclusivamente** en el `.env` local. Nunca en código o planes.
4. **Modo Espejo**: Ambiente local debe reflejar a producción (MariaDB 11.8).

---

## 3. Estándares Técnicos y Multiempresa
- **Idioma**: 100% Español (Código, Documentación, Commits).
- **Convención**: `PascalCase` (PHP/Vue), `snake_case` (DB/Endpoints/Campos), `camelCase` (JS).
- **Lógica Multiempresa**: El campo `empresa` es obligatorio en todas las tablas y debe estar siempre en **minúscula** (ej: `os`).

### 3.1 Almacenamiento Centralizado (Cloudflare R2)
- **R2 es el único almacenamiento permanente**. Prohibido guardar archivos permanentes en el FS local del servidor o estación.
- Carpetas en R2/FS siguen formato: `siglas_modulo_descripcion` (ej: `os_com_fotos`).

### 3.2 Protocolo de API (JSON Uniforme)
Toda comunicación usa `POST` con esta estructura:

**Petición (Request):** `{ "token": "...", "accion": "...", "datos": { ... } }`
**Respuesta (Response):** `{ "exito": true, "datos": { ... }, "mensaje": "...", "errores": [] }`

---

## 4. Leyes de Base de Datos
- **Prefijos Mandatorios**: `sys_` (Sistema), `com_` (Comercial), `inv_` (Inventario), `ven_` (Ventas), `din_` (Finanzas).
- **Campos Audit (Obligatorios)**: 
  - `id`: BIGINT UNSIGNED PK AI.
  - `uid`: VARCHAR(100) UNIQUE (Formato: `SIGLAS-YYYYMMDD-CORRELATIVO`).
  - `empresa`: VARCHAR(50) (Siempre en minúscula).
  - `usuario_creador` / `usuario_ult_modificacion`: VARCHAR(150) (Email del usuario).
  - `fecha_creacion` / `fecha_ult_modificacion`: DATETIME.

### 4.1 Tablas Protegidas (No Modificar Estructura)
- `costos_...`, `prod_...`, `din_...`, `inv_bodegas`, `inv_tipos_pp`.
- `sys_...`, `menu_ppal`.
- **Modificables**: Solo tablas `com_` y tablas nuevas del ERP.

---

## 5. Infraestructura y Despliegue
- **SSH (Hostinger)**: Acceso vía alias `hostinger_erp` configurado en `~/.ssh/config`. Permisos `600` mandatorios.
- **Backup**: Obligatorio **solo** antes de cambios estructurales en Hostinger. Guardar en `~/backups/bd/` del servidor.

---

## 6. Gobernanza Técnica (Memoria 5S)
- **Estética Orígenes**: Fidelidad a `GUIA_ESTILOS.md` (Minimalismo premium, verdes/naranjas tierra).
- **Skills**: Documentar aprendizajes en `.agent/skills/`. Debe incluir: `Estado` (🚧 o ✅), `Autor` y `Fecha`.
- **Orden Seiton**: Planes terminados se mueven a `.agent/historial/`. `CONTEXTO_ACTIVO.md` siempre corto y veraz.

> **FILOSOFÍA 5S**: Menos ruido, más precisión. Si no está aquí, pregúntale a la Madrina.
