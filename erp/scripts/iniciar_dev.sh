#!/bin/bash
# erp/scripts/iniciar_dev.sh
# Comando maestro para iniciar el Frontend en Desarrollo e imprimir la IP fija.

# Obtener la IP local de la máquina (Ubuntu o Windows en WSL)
IP_LOCAL=$(hostname -I | awk '{print $1}')
if [ -z "$IP_LOCAL" ]; then
    IP_LOCAL="localhost"
fi

echo "==========================================================="
echo "   🚀 INICIANDO ENTORNO DE DESARROLLO SOS_ERP (5S) 🚀   "
echo "==========================================================="
echo ""
echo "📱 PARA ABRIR LA APLICACIÓN DESDE CUALQUIER PC DE LA RED:"
echo "👉 Haz click (o copia y pega) aquí: http://$IP_LOCAL:5173"
echo ""
echo "==========================================================="
echo "Levantando Vite (Frontend)..."

cd "$(dirname "$0")/../frontend"
npm run dev -- --host 0.0.0.0 --port 5173
