# Manifiesto Operativo: Protocolo de Agentes ERP Origen Silvestre [5S]

## 1. Identidad y Jerarquía (Autoridad Operativa)
- **Santiago (Santi)**: **Director y Dueño**. Su aprobación es la ley. Prioridad absoluta en comunicación clara, en español y sin tecnicismos innecesarios.
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
- **Contexto**: `CONTEXTO_ACTIVO.md` corto y real. Planes terminados a `.agent/historial/`.

> **FILOSOFÍA DIAMANTE**: Claridad quirúrgica. Si no es simple, no es 5S.
