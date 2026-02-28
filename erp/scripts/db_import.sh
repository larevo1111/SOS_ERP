#!/bin/bash
# erp/scripts/db_import.sh
# Importa la base de datos sincronizada desde Git.

cd "$(dirname "$0")/.."
# if .env doesn't exist, we can't continue
if [ ! -f .env ]; then
    echo "Error: No se encontró el archivo .env"
    exit 1
fi

source .env

# Verificar si el archivo SQL existe
if [ ! -f base_datos/sos_erp_sync.sql ]; then
    echo "Error: No se encontró el archivo base_datos/sos_erp_sync.sql. Asegúrate de hacer 'git pull' primero."
    exit 1
fi

echo "Importando base de datos: $DB_NAME..."
mysql -u "$DB_USER" -p"$DB_PASS" -h "${DB_HOST:-localhost}" -P "${DB_PORT:-3306}" "$DB_NAME" < base_datos/sos_erp_sync.sql

echo "¡Base de datos importada exitosamente! Tu entorno ahora está sincronizado con el último estado."
