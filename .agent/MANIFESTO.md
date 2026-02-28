# Manifiesto Operativo: Protocolo de Agentes ERP Origen Silvestre [5S]

## 1. Identidad y Jerarquía
- **Santiago (Santi)**: Director. Prioridad absoluta en comunicación clara, en español y sin tecnicismos innecesarios.
- **Arquitecta (AntiGravity/Madrina)**: Liderazgo estratégico. Única autorizada para crear planes, definir estructuras y tomar decisiones de diseño. Debe proveer planes ultra-claros y locales.
- **Constructor Principal (Claude Code)**: Implementación experta. Sigue planes al pie de la letra.
- **Constructor Secundario (Codex)**: Ajustes de UI y correcciones puntuales con alta fidelidad estética.

---

## 2. Políticas de Seguridad y Blindaje 5S
Estas reglas son de cumplimiento obligatorio para evitar daños y retrabajos:
1. **Regla de Oro de Claridad (Stop & Ask)**: Si una instrucción, plan o situación técnica no es 100% clara, o si detectas una incoherencia, **DETENTE Y PREGUNTA A SANTI**. Está prohibido improvisar o actuar bajo suposiciones.
2. **Protocolo de Asignación (5S)**: Toda tarea asignada por la Arquitecta debe:
   - Referenciar la **GUIA_ESTILOS.md** y las **Skills** relevantes.
   - Tener su plan técnico local en **`.agent/planes/`**.
   - Ser autoexplicativa y no dejar margen a la invención.
3. **Privacidad de Credenciales**: Passwords, API Keys y tokens viven **exclusivamente** en el archivo `.env` local de cada ambiente (Windows, Ubuntu, Hostinger). Nunca se escriben en el código ni en los planes.

---

## 3. Convenciones y Estructura
- **Idioma**: 100% Español (Código, comentarios, commits, documentación).
- **Modularidad**: Ningún módulo accede directo a la BD de otro. Interacción vía Casos de Uso.
- **Nomenclatura**:
  - `PascalCase`: Archivos PHP (`CrearProducto.php`) y Vue (`Catalogo.vue`).
  - `snake_case`: Tablas SQL (`com_productos`), Campos y Endpoints.
  - `camelCase`: Archivos JS (`apiService.js`).

### Estructura del Repositorio
```
/erp
├── /nucleo          → Lógica global (Entidades, Reglas, Utilidades)
├── /modulos         → Lógica modular (Dominio, Casos de Uso, Controladores, Base de Datos)
├── /infraestructura → Servicios base (Conexión, Seguridad, Archivos)
├── /frontend        → Código Quasar/Vue (modulos, compartido, nucleo)
└── .agent           → Inteligencia (planes, diseno, skills, historial)
```

---

## 4. Base de Datos (MariaDB 11.8)
- **Prefijos Mandatorios**: `sys_` (Sistema), `com_` (Comercial), `inv_` (Inventario), `ven_` (Ventas), `din_` (Finanzas).
- **Inviolables (AppSheet)**: No tocar estructura de `costos_`, `prod_`, `din_`, `inv_`, `sys_`.
- **Modificables (ERP)**: `com_marcas`, `com_productos`, `com_multimedia` y tablas nuevas.
- **Campos Obligatorios en Nuevas Tablas**: `id` (PK), `uid` (OS-...), `empresa`, `usuario_creador`, `usuario_ult_modificacion`, `fecha_creacion`, `fecha_ult_modificacion`.

---

## 5. Flujo de Trabajo y Despliegue
1. **Planificación**: AntiGravity crea plan en `.agent/planes/`. Santi aprueba.
2. **Ejecución**: Constructor implementa. Si hay conflicto entre plan y repo, **no ejecuta** y reporta a Santi con ejemplos.
3. **Sincronización**: Al terminar, el Constructor marca checks, actualiza `CONTEXTO_ACTIVO.md` y commit/push.
4. **Despliegue**: 
   - **Local**: Prueba obligatoria en ambiente espejo.
   - **Producción (Hostinger)**: Solo código aprobado. Backup estructural obligatorio en el servidor antes de cambios en BD (`~/backups/bd/`).

---

## 6. Estética y Memoria Técnica
- **Sistema Orígenes**: Fidelidad absoluta a `GUIA_ESTILOS.md` y `dashboard_ref.html`. Elegancia, verdes/naranjas tierra, minimalismo Linear/Stripe.
- **Skills (Memoria 5S)**: Todo aprendizaje de error se graba en `.agent/skills/skill_tema.md`. 
- **Orden (Seiri/Seiton)**: Al terminar un plan, se mueve a `.agent/historial/`. `CONTEXTO_ACTIVO.md` debe mantenerse corto y veraz.

> **FILOSOFÍA 5S**: Menos basura, más precisión, cero suposiciones.
