---
description: Pipeline de Despliegue a Producción (Santi)
---

Este protocolo realiza el despliegue 100% automático y seguro de la Base de Datos y el Código (Frontend + Backend) a `erp.oscomunidad.com` alojado en Hostinger.

1. **Test Conexión SSH Hostinger**
Verifica de forma rápida que la conexión configurada funcione.
```bash
ssh hostinger_erp "echo 'Conexión a Hostinger Exitosa'"
```

2. **Backup en Hostinger (Mandatorio 5S)**
Protegemos la base de datos de producción antes de sobrescribirla. Al ejecutar esto, puede que te pida la contraseña *de la base de datos de producción*.
```bash
ssh -t hostinger_erp 'source ~/domains/oscomunidad.com/public_html/erp/.env && mkdir -p ~/backups/bd && mariadb-dump --single-transaction -u "$DB_USER" -p"$DB_PASS" -h "${DB_HOST:-localhost}" -P "${DB_PORT:-3306}" "$DB_NAME" > ~/backups/bd/backup_$(date +%Y%m%d_%H%M%S)_pre_deploy.sql && echo "Backup completado"'
```

// turbo
3. **Compilación Profesional del Frontend**
Comprime y optimiza tu código Vue/Quasar que hiciste con Codex en archivos HTML, JS y CSS ultraligeros para producción.
```bash
cd erp/frontend && npm run build
```

// turbo
4. **Exportar tu Base de Datos Local**
Empaqueta la base de tu entorno (Ubuntu) en el archivo `sos_erp_sync.sql`.
```bash
cd erp && ./scripts/db_export.sh
```

// turbo
5. **Subir el Paquete a GitHub (Push)**
Sube tu código fuente, la compilación de producción (forzada para evadir el ignore) y la base de datos sincronizada.
```bash
cd erp && git add -f frontend/dist/spa/ && git add base_datos/sos_erp_sync.sql && git commit -m "deploy: actualizacion de codigo, compilacion front y sync de base de datos" && git push
```

6. **Desplegar Código en Hostinger (Pull)**
Hace que el servidor de Producción baje la actualización.
```bash
ssh hostinger_erp "cd ~/domains/oscomunidad.com/public_html/erp && git pull"
```

7. **Sobrescribir Base de Datos en Producción**
Integra la estructura que bajaste de Git a la base de datos oficial. Al ejecutar, puede pedirte nuevamente la contraseña *de la BD de Producción*.
```bash
ssh -t hostinger_erp 'cd ~/domains/oscomunidad.com/public_html/erp && source .env && mysql -u "$DB_USER" -p"$DB_PASS" -h "${DB_HOST:-localhost}" -P "${DB_PORT:-3306}" "$DB_NAME" < base_datos/sos_erp_sync.sql'
```

🎉 ¡Listo! Si ejecutas estos 7 pasos (que yo puedo auto-ejecutar en cadena para ti), tu sistema en vivo se actualizará idéntico a tu local en menos de 1 minuto.
