# skill_despliegue_produccion.md

> [!IMPORTANT]
> Este manual es para el **Director (Santi)**. Describe el proceso para "subir" (desplegar) la versión de desarrollo al servidor real de Hostinger.

## Para qué sirve
Poner el sistema en vivo en `https://erp.oscomunidad.com` para empezar a usarlo con datos reales.

## Procedimiento de Despliegue (Paso a Paso)

### 1. Preparar la Versión Final (Build)
Antes de subir archivos, debemos "empaquetar" el código para que sea rápido y seguro.
- Abre la terminal en: `c:/Proyectos_code/SOS_ERP/erp/frontend`.
- Ejecuta:
  ```bash
  npm run build
  ```
- **Resultado**: Se creará una carpeta llamada `dist/spa`. **Aquí es donde vive tu ERP listo para el mundo.**

### 2. Subir el Código al Servidor
Usaremos el comando `git` que es lo más ordenado (5S):
- En la raíz del proyecto (`SOS_ERP`):
  ```bash
  git add .
  git commit -m "feat: preparar version para despliegue"
  git push origin main
  ```
- Ahora, conéctate a tu servidor:
  ```bash
  ssh hostinger_erp
  ```
- Dentro del servidor, actualiza:
  ```bash
  cd ~/domains/oscomunidad.com/public_html/erp
  git pull origin main
  ```

### 3. Sincronizar la Base de Datos
Sigue los pasos del **[skill_sincronizacion_bd_win11.md](file:///c:/Proyectos_code/SOS_ERP/.agent/skills/skill_sincronizacion_bd_win11.md)** para asegurar que lo que guardaste hoy en local esté en la web.

### 4. Configurar el "Enlace" Final
Si es la primera vez, asegúrate de que el contenido de `erp/frontend/dist/spa` esté accesible desde la URL pública. 
> **Nota técnica**: Normalmente apuntamos el dominio de Hostinger a esa carpeta específica.

---

## Regla de Oro del Despliegue
**NUNCA** despliegues sin antes haber probado en local que todo funciona. El servidor es sagrado.
