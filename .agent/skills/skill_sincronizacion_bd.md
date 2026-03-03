# skill_sincronizacion_bd_win11.md

## Para qué sirve
Este skill describe el procedimiento estándar para subir cambios de la base de datos local desde **Windows 11** al servidor de producción Hostinger. 

> [!IMPORTANT]
> Este procedimiento está optimizado para resolver problemas de codificación (UTF-16) específicos de Windows/PowerShell. Para Linux (Ubuntu), el procedimiento es más directo y será documentado por separado.

## Reglas que nunca se rompen
1. **Backup Preventivo**: Siempre ejecutar un backup en Hostinger antes de importar nada nuevo. Se guarda en `~/backups/bd/`.
2. **Exportación Binaria**: En Windows, usar siempre `cmd /c` para el volcado (dump) para evitar que PowerShell cambie la codificación a UTF-16.
3. **Limpieza de DEFINER**: Eliminar siempre las cláusulas `DEFINER` del archivo SQL antes de subirlo para evitar errores de permisos.
4. **Importación Binaria**: Usar el flag `--binary-mode` al importar en el servidor.

## Problemas conocidos y soluciones
- **Error ASCII '\0'**: Causado por redirección de PowerShell. **Solución**: Re-exportar usando `cmd /c` o en bash puro.
- **Error 1449 (Definer)**: El usuario local no coincide con el de producción. **Solución**: Limpiar el SQL con regex `/DEFINER\s*=\s*`[^`]+`@`[^`]+`//`.

## Procedimiento Paso a Paso

### 0. Actualizar Archivo de Inicialización (ANTES DE DESARROLLAR)
Para asegurar que `inicializacion.sql` siempre tenga la foto real de la base de datos, se debe ejecutar un volcado estructural (solo esquema, sin datos) antes de cualquier desarrollo.

**Desde Hostinger (Producción):**
```bash
mariadb-dump -u u768061575_ssierra047 -p \
  --no-data \
  --routines \
  --events \
  --skip-lock-tables \
  --ssl-verify-server-cert=false \
  -h 109.106.250.195 \
  u768061575_os_comunidad \
  > estructura_erp.sql
```

**Desde Local (Desarrollo Ubuntu/WSL):**
```bash
mariadb-dump -u larevo1111 -p \
  --no-data \
  --routines \
  --events \
  --skip-lock-tables \
  -h localhost \
  sos_erp_local \
  > erp/modulos/sistema/base_datos/inicializacion.sql
```

### 1. Exportar en Local (Windows CMD)
```bash
cmd /c "mariadb-dump -u root --skip-lock-tables --hex-blob sos_erp_local > local_to_prod.sql"
```

### 2. Limpiar SQL (Regex o Script PHP)
Remover todos los `DEFINER=...` del archivo.

### 3. Subir al Servidor
```bash
scp -P 65002 local_to_prod.sql u768061575@109.106.250.195:~/backups/bd/import.sql
```

### 4. Importar en Hostinger
```bash
ssh hostinger_erp "mariadb --binary-mode -u [user] -p[pass] [dbname] < ~/backups/bd/import.sql"
```
