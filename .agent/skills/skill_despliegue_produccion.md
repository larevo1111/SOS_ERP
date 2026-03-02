---
description: Guía para desplegar el ERP a producción (erp.oscomunidad.com en Hostinger) desde el entorno de desarrollo local (Ubuntu).
---

# 🚀 Skill: Despliegue a Producción

> [!IMPORTANT]
> **Entorno de ejecución:** Ubuntu local. Los comandos se ejecutan en bash desde `/home/osserver/.gemini/antigravity/scratch/SOS_ERP`.
> **Workflow oficial**: usar `/desplegar_produccion` que auto-ejecuta los pasos marcados con `// turbo`.

## Flujo Completo (7 pasos)

### Paso 1 — Verificar conexión SSH
```bash
ssh hostinger_erp "echo 'Conexión a Hostinger Exitosa'"
```

### Paso 2 — Backup de producción (MANDATORIO antes de sobrescribir BD)
```bash
ssh -t hostinger_erp 'source ~/domains/oscomunidad.com/public_html/erp/.env && mkdir -p ~/backups/bd && mariadb-dump --single-transaction -u "$DB_USER" -p"$DB_PASS" -h "${DB_HOST:-localhost}" -P "${DB_PORT:-3306}" "$DB_NAME" > ~/backups/bd/backup_$(date +%Y%m%d_%H%M%S)_pre_deploy.sql && echo "Backup completado"'
```

### Paso 3 — Build del frontend
```bash
cd erp/frontend && npm run build
```
Resultado: `erp/frontend/dist/spa/` listo para producción.

### Paso 4 — Exportar BD local
```bash
cd erp && ./scripts/db_export.sh
```

### Paso 5 — Git push (código + build + BD)
```bash
cd erp && git add -f frontend/dist/spa/ && git add base_datos/sos_erp_sync.sql && git add -A && git commit -m "deploy: actualizacion codigo, build front y sync BD" && git push
```

### Paso 6 — Pull en Hostinger
```bash
ssh hostinger_erp "cd ~/domains/oscomunidad.com/public_html/erp && git pull"
```

### Paso 7 — Sobrescribir BD en producción
```bash
ssh -t hostinger_erp 'cd ~/domains/oscomunidad.com/public_html/erp && source .env && mysql -u "$DB_USER" -p"$DB_PASS" -h "${DB_HOST:-localhost}" -P "${DB_PORT:-3306}" "$DB_NAME" < erp/base_datos/sos_erp_sync.sql'
```

---

## ⚠️ Problemas Conocidos y Soluciones

### SSH git pull se queda colgado / timeout
**Causa:** El `git pull` en Hostinger tarda si hay muchos archivos o si la conexión SSH tiene timeout bajo configurado. Si se ejecutó `npm run build` hay decenas de assets JS/CSS nuevos que subir.
**Síntomas:** El comando no devuelve output por 30+ segundos, la terminal queda en estado `running`.
**Soluciones:**
1. Esperar 2-3 minutos: si hay muchos archivos, el git pull puede tardar legítimamente.
2. Si el comando se cancela: volver a ejecutar `ssh hostinger_erp "cd ~/domains/... && git pull"` — git es idempotente, se puede repetir.
3. Si el SSH cae por timeout, revisar `~/.ssh/config` y agregar:
   ```
   Host hostinger_erp
     ServerAliveInterval 30
     ServerAliveCountMax 5
   ```

### Catálogo vacío en producción después del deploy
**Causa frecuente:** La BD de producción no fue sobrescrita (Paso 7 omitido) o tiene estructura diferente a la local.
**Diagnóstico:** Revisar si el error en producción es `SQLSTATE` o simplemente datos vacíos. Si es error SQL, el schema está desactualizado. Si son datos vacíos, la BD de prod no tiene los registros de test local (lo cual es NORMAL en producción).
**Importante:** Los datos de test (CHOCOBEETAL, Miel de Bosque) son datos de **desarrollo local** y NO se deben subir a producción. Solo se despliega estructura SQL, no datos de prueba.

### `.htaccess` con variables rotas (`$1`)
**Causa:** Usar heredoc por SSH desde PowerShell en Windows destroza las variables `$1`.
**Solución:** Crear el `.htaccess` local y subirlo con `scp`:
```bash
scp -P 65002 -i ~/.ssh/sos_erp /tmp/prod.htaccess u768061575@109.106.250.195:~/domains/oscomunidad.com/public_html/erp/.htaccess
```

### Caché del navegador (usuario no ve cambios)
Indicar a Santi que use **Ctrl + Shift + R** o agregar `?v=timestamp` a la URL.

---

## Regla de Oro
**NUNCA despliegues sin haber verificado en local que todo funciona.** El servidor de producción es sagrado.
