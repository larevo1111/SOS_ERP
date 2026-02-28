---
description: Protocolo de Comunicación Visual y Estructura Organizacional (Santi-IA)
---

# SKILL: Comunicación Visual e Interfaz (Santi ↔ IA)

## Para qué sirve
Este skill define el protocolo estricto que rige cómo la inteligencia artificial (arquitecta y constructores) interactúa con Santi (el Director) respecto a la **Estructura Visual y Experiencia de Usuario (UI/UX)** del sistema SOS_ERP. Asegura que ninguna vista compleja se construya basada en suposiciones de la IA, sino en las directrices visuales exactas dictadas por la dirección.

> [!IMPORTANT]
> **Autonomía Limitada en UI:** La IA tiene autonomía técnica (backend, BD, algoritmos), pero **CERO autonomía estructural visual** en vistas clave. La distribución de elementos en la pantalla la dicta exclusivamente el director.

## Reglas que nunca se rompen

1. **La Regla del Boceto Obligatorio (Cero Asunciones Visuales):**
   * Antes de planificar o codificar una vista compleja (formularios principales, dashboards, flujos de creación múltiple), la IA **DEBE** exigir un boceto provisto por Santi.
   * La IA no debe asumir pestañas, modales, o distribuciones espaciales sin este norte claro.

2. **Naturaleza del Boceto (Fondo sobre Forma):**
   * Los bocetos entregados por Santi (ya sean digitales o a mano alzada) son **100% ESTRUCTURALES Y LÓGICOS**, no de diseño gráfico.
   * La IA **NO DEBE** imitar los colores, tipografías, o alineaciones "feas" del boceto.
   * La IA **DEBE** abstraer la lógica (qué campo va dónde, qué botón abre qué modal) y aplicar a esa lógica la estética premium definida en `GUIA_ESTILOS.md` (Sistema Orígenes).

3. **Almacenamiento y Documentación de Bocetos:**
   * Todo boceto clave proporcionado por Santi debe guardarse en el repositorio en la carpeta `.agent/bocetos/`.
   * El plan de implementación (`PLAN_nombre.md`) debe referenciar obligatoriamente la ruta de este boceto para que los Constructores (Claude Code/Codex) lo consulten durante la ejecución.

4. **Proactividad en el Análisis Lógico:**
   * Al recibir un boceto, la IA no solo lo copia, lo **analiza**.
   * Debe leer cada comentario del boceto.
   * Si el boceto sugiere lógicas avanzadas (ej. uso de APIs externas, autocompletado inteligente con IA), la IA debe plantear la viabilidad técnica inmediatamente antes de aprobar el plan.

5. **Anotaciones de Inteligencia Artificial (Prompting UI):**
   * Cuando el boceto de Santi requiera que un campo de la interfaz tenga "sugerencias usando IA" (ej. autocompletar nombres de variaciones), la Arquitecta debe planificar la integración de la **API de Gemini** en el backend para servir esas sugerencias al frontend de Quasar.

## Problemas conocidos y soluciones

**Problema:** El constructor (Codex) hace el formulario de crear productos dividiendo los campos en 5 pestañas porque le pareció "más organizado" según estándares comunes.
* **Solución (Mala):** Santi tiene que entrar, ver que no sirve así, y gastar tiempo corrigiendo.
* **Solución (Diamante):** La Arquitecta detiene el plan antes de empezar, solicita el boceto a Santi. Santi envía un dibujo mostrando todo en una sola vista con un modal. El constructor ejecuta fiel al boceto. Este skill previene el problema original.

## Flujo de Trabajo (Paso a Paso)
> [!WARNING]
> **Limitación Técnica de Guardado:** La IA Arquitecta (AntiGravity) PUEDE VER y analizar a la perfección las imágenes que se suben como adjunto en el chat, pero **NO TIENE HERRAMIENTAS** para agarrar ese binario de la foto del chat y embutirlo como archivo `.png` dentro del repositorio del proyecto.

## Flujo de Trabajo (Paso a Paso Mejorado: Cero Fricción para Santi)
> [!TIP]
> **El Principio del "Inbox" (Bandeja de entrada):** Para que Santi no pierda tiempo renombrando archivos ni lidiando con su disco local, puede usar directamente la interfaz web de GitHub para arrastrar y soltar sus imágenes.

1. **Santi** requiere una nueva interfaz y dibuja un boceto (estructural/lógico).
2. **Santi** sube la imagen cruda directamente a la página web de GitHub, dentro de la carpeta `/erp/.agent/bocetos_inbox/` (no importa el nombre feo que tenga la foto, ej: `IMG-2024-WhatsApp.jpeg`).
3. **Santi** notifica a la IA en el chat diciéndole: *"Te dejé un nuevo boceto en el inbox para el formulario XYZ"*.
4. **IA (Arquitecta)** hace `git pull` para detectar la nueva imagen.
5. **IA (Arquitecta)** toma el mando operativo: Renombra el archivo a algo profesional (ej: `boceto_formulario_xyz.png`), lo mueve a su hogar final `/erp/.agent/bocetos/` y elimina la basura del Inbox.
6. **IA (Arquitecta)** analiza el boceto visual, extrae la lógica, plantea viabilidad técnica y define el plan en `PLAN_xx.md` referenciando la nueva ruta limpia.
7. **Constructores (Claude/Codex)** ejecutan leyendo el Plan y abriendo la imagen física ya organizada.
