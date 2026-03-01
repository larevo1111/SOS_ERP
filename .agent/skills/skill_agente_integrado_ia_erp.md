# Skill: Agente Integrado IA ERP

Esta skill define cómo interactúan los Agentes con el motor de IA (Google Gemini) integrado en el SOS_ERP para tareas de autocompletado, normalización y sugerencias lógicas.

## 1. Arquitectura de IA
- **Backend:** `AsistenteComercialController.php` actúa como proxy hacia Google Gemini.
- **Frontend:** Uso de la función `solicitarAsistenciaIA(campo, contexto)` en componentes Vue/Quasar.
- **Prompts:** Centralizados en el Backend para mantener consistencia.
- **Modelo activo:** `gemini-2.5-flash` (model ID exacto, no usar alias como `gemini-flash-latest`).
- **⚠️ Thinking Models — NO usar `gemini-flash-latest`:** Este alias apunta al modelo experimental `gemini-3-flash-preview`, un "Thinking Model" que consume ~4.000 tokens internos de razonamiento antes de emitir una sola línea JSON. Con `maxOutputTokens` en 200, la respuesta es truncada (MAX_TOKENS). El modelo `gemini-2.5-flash` es equivalente en calidad pero sin razonamiento extravagante, consumiendo apenas ~35 tokens por petición.
- **`maxOutputTokens`:** Mantener en `8192` ya que el límite cubre el caso más amplio sin costo real en tokens de salida efectiva.

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
