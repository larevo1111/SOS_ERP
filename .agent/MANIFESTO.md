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
| Tablas SQL | snake_case plural | `ordenes_de_venta` |
| Endpoints | snake_case | `/api/ventas/crear_cotizacion` |
| Archivos Vue | PascalCase | `PantallaVentas.vue` |
| Archivos JS | camelCase | `useVentas.js` |

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

- MySQL único central.
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
   - Actualiza `CONTEXTO_ACTIVO.md`
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
