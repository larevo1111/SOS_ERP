# Skill: Agente Integrado IA ERP

Esta skill define cómo interactúan los Agentes con el motor de IA (Google Gemini) integrado en el SOS_ERP para tareas de autocompletado, normalización y sugerencias lógicas.

## 1. Arquitectura de IA
- **Backend:** `AsistenteComercialController.php` actúa como proxy hacia Google Gemini.
- **Frontend:** Uso de la función `solicitarAsistenciaIA(campo, contexto)` en componentes Vue/Quasar.
- **Prompts:** Centralizados en el Backend para mantener consistencia.

## 2. Reglas de Sugerencia Lógica
Para mantener la estética 5S y la coherencia de datos, la IA debe seguir estas reglas:

| Campo | Regla de Oro | Ejemplo |
|-------|--------------|---------|
| `nombre` | Producto Base + Atributo | Miel Silvestre 500g |
| `nombre_grupo_catalogo` | Nombre genérico de familia | Miel Silvestre |
| `valor_atributo_variacion` | Normalización de unidades | 500 grs -> 500g |

## 3. Manejo de Contexto
Al solicitar asistencia, siempre se debe enviar el contexto completo disponible:
- `uid_producto_padre_nombre`: El nombre original del producto de costos.
- `nombre_actual`: Lo que el usuario ya escribió.
- `campo_peticion`: Identificador del campo para que la IA sepa qué regla aplicar.

## 4. Estética de Notificaciones
- Usar el tipo `asistente` en Quasar Notify (color `deep-orange-9`, icono `auto_awesome`).
- Mostrar la "nota" devuelta por la IA para dar transparencia al usuario sobre la sugerencia.

## 5. Seguridad
- Durante el desarrollo (Fases 1-7), las peticiones de IA se validan con el `R2_TOKEN`.
- A partir de la Fase 8, se migrará a validación `JWT` obligatoria.
