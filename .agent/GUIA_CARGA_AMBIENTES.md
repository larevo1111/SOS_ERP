# GUÍA RÁPIDA: CÓMO CARGAR MI ERP 🚀

Santi, aquí tienes el "Mapa de Mandos" para tu terminal de Windows 11. Guarda esto o tenlo a mano.

---

## 🏗️ AMBIENTE 1: DESARROLLO (Para trabajar y ver cambios)
Usa este modo cuando quieras que yo (o tú) hagamos cambios y se vean **al instante**.

1.  Abre Laragon y dale a **"Iniciar todo"**.
2.  Abre tu terminal y escribe:
    ```bash
    cd c:/Proyectos_code/SOS_ERP/erp/frontend
    npm run dev
    ```
3.  **Resultado**: Se abrirá una dirección como `http://localhost:9000`. 
    > **Nota**: Si cierras la terminal, el ERP se apaga.

---

## 📦 AMBIENTE 2: PRODUCCIÓN LOCAL (Para ver la versión final)
Usa este modo para ver cómo quedará el ERP "congelado" antes de subirlo a la web.

1.  Abre Laragon y dale a **"Iniciar todo"**.
2.  En la terminal escribe:
    ```bash
    cd c:/Proyectos_code/SOS_ERP/erp/frontend
    npm run build
    ```
3.  Abre Laragon y haz clic en el botón **"Web"** o entra a `http://sos_erp.test/erp`.
    > **Dato**: Aquí no necesitas tener la terminal abierta todo el tiempo. Laragon lo sirve como una web real.

---

## 🌐 POR QUÉ VES LA BICI DE HOSTINGER (Producción Real)
Si entras a `erp.oscomunidad.com` y ves la imagen de Hostinger, es porque:
- El servidor está buscando archivos en la carpeta raíz, pero tu ERP está "guardado" en `erp/frontend/dist/spa`.

### ¿Cómo lo arreglamos? (Elegir una opción)
- **Opción A (Recomendada)**: Yo configuro un archivo para decirle a Hostinger: "Oye, la web está en la carpeta `dist/spa`".
- **Opción B**: Movemos los archivos de la carpeta `dist/spa` a la raíz cada vez que subamos a Git.

---

**¿Cuál prefieres que configuremos para que `erp.oscomunidad.com` deje de mostrar la bici y muestre tu ERP?** 🖖🔥
