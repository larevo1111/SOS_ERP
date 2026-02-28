# Índice Maestro de Skills: SOS ERP

Este archivo es el catálogo oficial de conocimientos institucionalizados del proyecto. Sirve para que cualquier agente sepa qué manuales existen, cuál es su alcance y cuándo deben usarse.

## Catálogo de Skills

| Skill | Nombre | Alcance / Descripción | Cuándo Usarlo |
|---|---|---|---|
| **[skill_entorno_espejo.md](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/skill_entorno_espejo.md)** | Infraestructura Local | Configuración de MariaDB, PHP, SSH, Puertos y Límites de Memoria. | Antes de preparar una nueva estación o ante errores de conexión/servidor. |
| **[skill_acceso_datos_php.md](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/skill_acceso_datos_php.md)** | Desarrollo de Datos | Uso de la clase `Conexion.php`, manejo de PDO, excepciones y campos de auditoría. | Al desarrollar consultas SQL o lógica que interactúe con la base de datos. |
| **[skill_sincronizacion_bd_win11.md](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/skill_sincronizacion_bd_win11.md)** | Sincronización DB (Win11) | Procedimiento seguro desde Windows 11 para mover bases de datos a Hostinger. | Siempre que se necesite subir cambios a Hostinger desde una estación Windows. |
| **[skill_navegacion_autonoma.md](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/skill_navegacion_autonoma.md)** | Uso Autónomo (Santi) | Manual para encender y cargar datos en el ERP sin ayuda de la IA. | Para el uso diario del sistema en ambiente local. |
| **[skill_despliegue_produccion.md](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/skill_despliegue_produccion.md)** | Despliegue Producción | Pasos para pasar el sistema de desarrollo a la web real. | Cuando se tenga una versión lista para el mundo. |
| **[skill_frontend_quasar.md](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/skill_frontend_quasar.md)** | Desarrollo Frontend con Quasar y Vue 3 | Estándares 5S, Composición, Layouts. | Al desarrollar o modificar la interfaz de usuario. |
| **[skill_comunicacion_santi_ia.md](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/skill_comunicacion_santi_ia.md)** | Comunicación Visual y Estructura (Santi ↔ IA) | Protocolo estricto para definición de UI basada en bocetos, cero asunciones lógicas. | Al definir o revisar requisitos de interfaz de usuario con la IA. |

---

## Protocolo de Mantenimiento
- **Registro**: Cada skill nuevo debe ser añadido a esta tabla.
- **Auditoría**: La Madrina Arquitecta revisa este índice periódicamente basándose en la **Bitácora de Errores**.
- **Acceso**: Todo agente debe consultar este índice antes de iniciar una tarea técnica.
