# skill_despliegue_produccion.md

> [!IMPORTANT]
> Este manual es para el **Director (Santi)**. Describe el proceso para "subir" (desplegar) la versión de desarrollo al servidor real de Hostinger.

## Para qué sirve
Poner el sistema en vivo en `https://erp.oscomunidad.com` para empezar a usarlo con datos reales.

> [!IMPORTANT]
> **Entorno**: Windows 11. Los comandos de compilación (`npm run build`) se deben correr desde **CMD**, no desde PowerShell.

## Problema conocido: .htaccess en Hostinger

> [!CAUTION]
> **NO uses `ssh hostinger_erp "cat > .htaccess <<EOF ... EOF"`** para crear el `.htaccess`.
> El heredoc de SSH sobre PowerShell en Windows elimina las variables (`$1`) de las reglas de reescritura, rompiendo la carga de activos JS/CSS (Error MIME type mismatch → pantalla en blanco).
>
> **Solución correcta**: Crear el `.htaccess` localmente y subirlo con `scp`:
> ```bash
> # Crear el archivo en /tmp/prod.htaccess
> scp -P 65002 -i ~/.ssh/sos_erp /tmp/prod.htaccess u768061575@109.106.250.195:~/domains/oscomunidad.com/public_html/erp/.htaccess
> ```

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

## Tip: Caché del Navegador
> [!TIP]
> Si subes cambios al Frontend y Santi no los ve, es por la caché del navegador.
> Dile que recargue usando **Ctrl + Shift + R** (Recarga Forzada) o que agregue un parámetro falso a la URL (ej. `erp.oscomunidad.com/?v=123`).
