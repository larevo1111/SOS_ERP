# Manifiesto Operativo: Protocolo de Agentes ERP Origen Silvestre [5S]

## 1. Identidad y Jerarquía
- **Santiago (Santi)**: Director. Prioridad absoluta en comunicación clara, en español y sin tecnicismos innecesarios.
- **Arquitecta (AntiGravity/Madrina)**: Liderazgo estratégico. Única autorizada para crear planes, definir estructuras y tomar decisiones de diseño.
- **Constructor Principal (Claude Code)**: Implementación de lógica pesada y backend.
- **Constructor Secundario (Codex)**: Implementación de UI/UX y fidelidad estética.

---

## 2. Reglas de Oro y Seguridad 5S
1. **Regla de Oro de Claridad (Stop & Ask)**: Si algo no es 100% claro, o detectas incoherencia: **DETENTE Y PREGUNTA A SANTI**. Prohibida la suposición.
2. **Protocolo de Asignación**: Todo plan debe estar en `.agent/planes/` y referenciar la `GUIA_ESTILOS.md` y `Skills` relevantes.
3. **Privacidad de Credenciales**: Passwords y Tokens viven **exclusivamente** en el `.env` local. Nunca en código o planes.
4. **Modo Espejo**: El ambiente local (Windows/Ubuntu) debe reflejar a producción (MariaDB 11.8).

---

## 3. Estándares Técnicos (API y Código)
- **Idioma**: 100% Español (Código, Documentación, Commits).
- **Convención**: `PascalCase` (PHP/Vue), `snake_case` (DB/Endpoints/Campos), `camelCase` (JS).

### 3.1 Protocolo de API (JSON Uniforme)
Toda comunicación Frontend-Backend usa `POST` con esta estructura:

**Petición (Request):**
```json
{
  "token": "VITE_API_TOKEN",
  "accion": "nombre_accion",
  "datos": { ... }
}
```

**Respuesta (Response):**
```json
{
  "exito": true,
  "datos": { ... },
  "mensaje": "Feedback para el usuario",
  "errores": []
}
```

---

## 4. Leyes de Base de Datos
- **Prefijos Mandatorios**: `sys_` (Sistema), `com_` (Comercial), `inv_` (Inventario), `ven_` (Ventas), `din_` (Finanzas).
- **Campos Audit (Obligatorios)**: `id` (PK), `uid` (OS-...), `empresa`, `usuario_creador`, `usuario_ult_modificacion`, `fecha_creacion`, `fecha_ult_modificacion`.

### 4.1 Tablas Protegidas (Inviolables)
Prohibido modificar estructura de tablas AppSheet o Sistema:
- `costos_...`, `prod_...`, `din_...`, `inv_bodegas`, `inv_tipos_pp`.
- `sys_...`, `menu_ppal`.
- **Modificables**: Solo tablas `com_` y tablas nuevas del ERP.

---

## 5. Infraestructura y Despliegue
### 5.1 Protocolo SSH (Hostinger)
Acceso vía aliasing en `~/.ssh/config`:
```text
Host hostinger_erp
    HostName 109.106.250.195
    Port 65002
    User u768061575
    IdentityFile ~/.ssh/sos_erp
```
**Permisos**: `chmod 600 ~/.ssh/sos_erp ~/.ssh/config`.

### 5.2 Backup Estratégico
Backup obligatorio **solo** antes de cambios estructurales en Hostinger.
- **Ubicación**: `~/backups/bd/` en el servidor. **NUNCA en GitHub**.
- **Formato**: `backup_YYYYMMDD_HHMMSS_descripcion.sql`.

---

## 6. Gobernanza Técnica (Memoria 5S)
- **Estética Orígenes**: Fidelidad a `GUIA_ESTILOS.md` (verdes/naranjas tierra, minimalismo premium).
- **Skills (Memoria Técnica)**: Cada aprendizaje se graba en `.agent/skills/skill_tema.md`.
  - **Formato obligatorio**: `Estado` (🚧 En Revisión | ✅ Validada), `Autor`, `Fecha`.
- **Orden Seiton**: Planes terminados se mueven a `.agent/historial/`.
- **Contexto Activo**: Mantener `CONTEXTO_ACTIVO.md` corto, veraz y con la "Madrina a cargo" actualizada.

> **FILOSOFÍA 5S**: Menos ruido, más precisión. Si no está en el Manifiesto, pregúntale a la Madrina.
