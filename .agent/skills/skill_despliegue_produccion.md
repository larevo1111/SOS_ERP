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

### Git push aparece "colgado" por 30+ minutos (monitoring de background)
**Causa:** El paso 5 incluye `git add -f frontend/dist/spa/` que tiene decenas de archivos JS/CSS compilados. Git debe indexar (hashear) cada archivo antes de hacer el push. Esto puede tardar legitimamente 5-15 minutos. Además, cuando el agente AI ejecuta comandos en background, el monitoring puede no reflejar el progreso real.

**Síntomas:** El agente reporta el comando como `RUNNING` indefinidamente; el usuario no ve output.

**Verificación:** Abrir una terminal nueva y ejecutar:
```bash
cd ~/.gemini/antigravity/scratch/SOS_ERP/erp
git log --oneline -3
git status --short
```
Si el último commit aparece en `origin/main` y el `status` está limpio → **el push SÍ se completó**, el agente simplemente no lo sabía.

**Solución si realmente está colgado:**
```bash
# Cancelar el proceso y hacer push manual:
cd ~/.gemini/antigravity/scratch/SOS_ERP/erp
git add -A -- ':!frontend/dist'   # excluir dist si no se necesita actualizar
git commit -m "docs: ..."
git push
```

**Prevención:** Para el agente AI: siempre agregar `git log --oneline -2` al final del push para verificar que el commit está en origin. Para el workflow de despliegue: reducir lo que entra al dist commit separando el push de código del push del build.

### SSH git pull se queda colgado / timeout
**Causa:** El `git pull` en Hostinger tarda si hay muchos archivos o si la conexión SSH tiene timeout bajo configurado.
**Soluciones:**
1. Esperar 2-3 minutos: si hay muchos archivos, es normal.
2. Si cae por timeout, agregar a `~/.ssh/config`:
   ```
   Host hostinger_erp
     ServerAliveInterval 30
     ServerAliveCountMax 5
   ```
3. Si se cancela: repetir `ssh hostinger_erp "cd ~/domains/... && git pull"` — es idempotente.

### Catálogo vacío en producción después del deploy
**Causa frecuente:** La BD de producción no fue sobrescrita (Paso 7 omitido) o tiene estructura diferente. Los datos de test (CHOCOBEETAL, Miel de Bosque) son datos de desarrollo local y **NO se deben subir a producción**. Solo se despliega estructura SQL.

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
