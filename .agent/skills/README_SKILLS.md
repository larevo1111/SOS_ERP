# 🗂️ Índice Maestro de Skills: SOS ERP [5S]

Este archivo es el **Catálogo Oficial de Conocimientos Institucionalizados**. Sirve para que cualquier agente (IA o Humano) sepa qué manuales existen, cuál es su alcance y cuándo deben usarse obligatoriamente para no romper la arquitectura.

---

## 🏛️ Categoría: Arquitectura y Backend (Gobernanza de Datos)

| Skill | Nombre | Alcance / Descripción | Cuándo Usarlo |
|---|---|---|---|
| **[skill_multimedia_r2.md](skill_multimedia_r2.md)** | **Fontanería Multimedia (Back)** | Gestión de buckets R2, rutas relativas en BD, límites de 500MB y seguridad S3. | Al programar subidas, borrados o consultas de archivos en PHP. |
| **[skill_auditoria_bd.md](skill_auditoria_bd.md)** | **Seguridad y Auditoría** | Filtro multi-tenant (`empresa`) e inyección forzada de campos de auditoría. | **OBLIGATORIO** para cualquier Query SQL o Caso de Uso. |
| **[skill_acceso_datos_php.md](skill_acceso_datos_php.md)** | **Acceso a Datos** | Uso de PDO, clase Conexion, manejo de excepciones y limpieza de datos. | Al desarrollar lógica de negocio en el backend. |
| **[skill_acceso_datos_php.md](skill_acceso_datos_php.md)** | **Integración IA** | Cómo la IA del ERP interactúa con las funciones y el contexto. | Al modificar el Asistente o herramientas de IA. |

---

## 🎨 Categoría: Frontend y Experiencia de Usuario (Estética 5S)

| Skill | Nombre | Alcance / Descripción | Cuándo Usarlo |
|---|---|---|---|
| **[skill_diseno_ui_ux.md](skill_diseno_ui_ux.md)** | **Estética y Encuadre (Front)** | **Regla de Oro del Encuadre (`object-fit: cover`)**, colores Orígenes y layouts de popups. | Antes de tocar CSS o estructurar visualmente un componente. |
| **[skill_subregistros_variaciones.md](skill_subregistros_variaciones.md)** | **Patrón de Subregistros** | Edición *In-Situ* dentro de popups, panel lateral con miniaturas y flujos atómicos. | Al manejar Variaciones, Items de combos o cualquier relación Padre-Hijo. |
| **[skill_vista_listado.md](skill_vista_listado.md)** | **Vista Catálogo / Lista** | Estándares para tablas, filtros rápidos y acciones masivas. | Al crear o modificar buscadores de entidades. |
| **[skill_vista_detalle.md](skill_vista_detalle.md)** | **Vista Detalle (Lectura)** | Layout de solo-lectura, pestañas y paneles laterales de información. | Al diseñar la vista profunda de un registro. |
| **[skill_creacion_formularios.md](skill_creacion_formularios.md)** | **Formularios (Edición)** | Validación de campos, manejo de estados y guardado asíncrono. | Al crear o editar registros (Formularios). |
| **[skill_frontend_quasar.md](skill_frontend_quasar.md)** | **Framework Quasar** | Uso de componentes Quasar, composición de Vue 3 y layouts globales. | Guía técnica general de desarrollo frontend. |

---

## 🚀 Categoría: Operaciones e Infraestructura

| Skill | Nombre | Alcance / Descripción | Cuándo Usarlo |
|---|---|---|---|
| **[skill_despliegue_produccion.md](skill_despliegue_produccion.md)** | **Pipeline de Despliegue** | Paso a paso para subir cambios a Hostinger de forma segura. | Al finalizar una fase y querer verla en la web real. |
| **[skill_sincronizacion_bd.md](skill_sincronizacion_bd.md)** | **Sincronización DB** | Movimiento de datos entre Local, Windows y Producción. | Ante desajustes de datos o cambios de estación de trabajo. |
| **[skill_entorno_espejo.md](skill_entorno_espejo.md)** | **Configuración Local** | Setup de MariaDB, PHP y Apache en la estación de trabajo. | Al preparar un equipo nuevo para desarrollar. |
| **[skill_navegacion_autonoma.md](skill_navegacion_autonoma.md)** | **Manual de Uso (Santi)** | Cómo el director opera el ERP sin asistencia técnica. | Referencia para flujo de negocio puro. |

---

## 📜 Protocolo de Mantenimiento Kaizen
1. **Registro Obligatorio**: Todo Skill nuevo o actualizado **debe** reflejarse en este índice.
2. **Separación de Poderes**: Si una Skill toca Back y Front (como Multimedia), se divide en dos: una para la lógica (Back) y otra para el diseño (Front).
3. **Paso Cero**: Todo agente debe consultar este índice antes de iniciar cualquier tarea para leer su "Mantis de Combate" correspondiente.
