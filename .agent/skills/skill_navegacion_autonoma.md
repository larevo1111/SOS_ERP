# skill_navegacion_autonoma.md

> [!IMPORTANT]
> Este manual es para el **Director (Santi)**. Describe cómo encender el ERP y usarlo sin ayuda de agentes externos.

## Para qué sirve
Garantizar que Santi pueda entrar al sistema, cargar datos y ver resultados de forma independiente en su equipo local (**Windows 11** o **Ubuntu**).

## Reglas que nunca se rompen
1. **El Motor es Primero**: Siempre debe estar encendido Laragon (en Windows) o Apache/MariaDB (en Ubuntu) antes de intentar abrir el ERP.
2. **Entorno de Desarrollo**: Para ver cambios en caliente, se usa el comando de desarrollo de Quasar.

## Cómo "Encender" el ERP (Paso a Paso)

### 0. Instalación Inicial (Solo la primera vez)
Si es la primera vez que usas el ERP en este equipo, abre la terminal en:
`c:/Proyectos_code/SOS_ERP/erp/frontend`
Y ejecuta:
```bash
npm install
```
Este comando descargará todos los componentes necesarios para que el ERP funcione.

### 1. Preparar la Base de Datos
- Abre **Laragon**.
- Dale al botón **"Iniciar todo"**.
- (Opcional) Haz clic en el botón "Database" para verificar que `sos_erp_local` tiene tus tablas.

### 2. Iniciar el Panel de Control (Frontend)
- Abre una terminal (**PowerShell** o **Bash**).
- Navega a la carpeta del proyecto:
  ```bash
  cd c:/Proyectos_code/SOS_ERP/erp/frontend
  ```
- Ejecuta el comando de encendido:
  ```bash
  npm run dev
  ```
- **Resultado**: La terminal te dará una dirección (ejemplo: `http://localhost:9000`). Haz clic ahí y verás tu ERP funcionando.

### 3. Cargar Datos (Uso Manual)
- Una vez dentro del ERP, usa los formularios diseñados (ej: Formulario de Productos).
- El sistema guardará los datos en tu MariaDB local automáticamente.
- Las imágenes que subas se irán directo a **Cloudflare R2** (si tienes internet).

---

## Tips de Poder (Windows 11)
- **Usa CMD**: Si PowerShell te da errores de "scripts deshabilitados", abre la terminal como **Símbolo del Sistema (CMD)**.
- **Si falla el comando**: Si `npm run dev` no funciona, prueba con:
  ```bash
  npx quasar dev
  ```
- **Fidelidad 5S**: Mantén siempre una sola terminal abierta para el proyecto para evitar confusiones de puertos.
