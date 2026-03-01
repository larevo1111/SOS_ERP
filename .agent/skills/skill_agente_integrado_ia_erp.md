# Skill: Agente Integrado IA ERP

Esta skill define cómo interactúan los Agentes con el motor de IA (Google Gemini) integrado en el SOS_ERP para tareas de autocompletado, normalización y sugerencias lógicas.

## 1. Arquitectura de IA
- **Backend:** `AsistenteComercialController.php` actúa como proxy hacia Google Gemini.
- **Frontend:** Uso de la función `solicitarAsistenciaIA(campo, contexto)` en componentes Vue/Quasar.
- **Prompts:** Centralizados en el Backend para mantener consistencia.
- **Configuración (tokens):** Es mandatario configurar `maxOutputTokens` a valores altos (ej: `8192`) al usar versiones como `gemini-flash-latest`, ya que estos "Thinking Models" consumen miles de tokens de respuesta ocultos ("thought tokens") razonando internamente cómo cumplir el prompt antes de emitir la respuesta en sí. Con un límite bajo (ej: 200), la API se detiene prematuramente devolviendo un error `MAX_TOKENS` que rompe el JSON.

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

> [!IMPORTANT]
> **Contextos Incompletos:** Si el frontend no tiene un producto base seleccionado en el momento en que se solicita la IA, el servidor se encargará de indicarle a Gemini que devuelva una `nota` amigable para el usuario solicitándole que seleccione primero el producto base, previniendo así "alucinaciones" o errores de JSON no estructurado. Además, el backend requiere `responseMimeType: application/json` para asegurar que Gemini responda en formato nativo estricto.

## 4. Estética de Notificaciones
- Usar el tipo `asistente` en Quasar Notify (color `deep-orange-9`, icono `auto_awesome`).
- Mostrar la "nota" devuelta por la IA para dar transparencia al usuario sobre la sugerencia.

## 5. Seguridad
- Durante el desarrollo (Fases 1-7), las peticiones de IA se validan con el `R2_TOKEN`.
- A partir de la Fase 8, se migrará a validación `JWT` obligatoria.

## 6. Troubleshooting: Error 429 (Quota Exceeded)
**Problema:** Al utilizar una API Key nueva o el Tier Gratuito (Free Tier) de Gemini, la respuesta puede ser un HTTP 429 (Quota Exceeded) a pesar de no haberla utilizado nunca.  
**Causa:** Restricciones regionales de Google Cloud. En ciertas regiones (como Colombia), las cuentas nuevas tienen una cuota efectiva de `0` peticiones en la capa gratuita si el proyecto de Google Cloud asociado a la API Key no tiene una cuenta de facturación vinculada activa.  
**Solución:**
1. Ingresar a Google Cloud Console.
2. Afiliar un método de pago/cuenta de facturación al proyecto donde se creó la API Key (el Tier gratuito se seguirá aplicando, pero Google requiere la tarjeta como garantía por medidas anti-abuso).
3. Alternativamente, utilizar los modelos más antiguos, aunque Google restringe agresivamente las cuotas en proyectos sin facturación.
