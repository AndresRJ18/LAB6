#!/bin/bash
if [ -z "$1" ]; then
  echo "Uso: $0 <directorio>"
  exit 1
fi
FECHA=$(date +%Y%m%d)
ARCHIVO="backup_${FECHA}.tar.gz"
tar czvf ~/laboratorio/respaldo/$ARCHIVO "$1"
echo "Backup creado: $ARCHIVO"
du -h ~/laboratorio/respaldo/$ARCHIVO
