#!/bin/bash
# erp/scripts/db_export.sh
# Exporta la base de datos actual para sincronizarla vía Git.

cd "$(dirname "$0")/.."
# if .env doesn't exist, we can't continue
if [ ! -f .env ]; then
    echo "Error: No se encontró el archivo .env"
    exit 1
fi

source .env

# Crear carpeta de base de datos si no existe
mkdir -p base_datos

echo "Exportando base de datos: $DB_NAME..."
mariadb-dump --single-transaction -u "$DB_USER" -p"$DB_PASS" -h "${DB_HOST:-localhost}" -P "${DB_PORT:-3306}" "$DB_NAME" > base_datos/sos_erp_sync.sql

# Remover las directivas DEFINER para evitar conflictos de privilegios al importar en otros servidores (Hostinger)
sed -i 's/DEFINER=[^*]*\*/\*/g' base_datos/sos_erp_sync.sql || true

echo "¡Base de datos exportada! Ahora puedes hacer 'git add erp/base_datos/sos_erp_sync.sql', luego 'git commit' y 'git push' para que llegue a las otras terminales."
