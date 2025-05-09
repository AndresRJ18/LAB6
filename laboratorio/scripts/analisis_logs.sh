#!/bin/bash
OUTPUT=~/laboratorio/datos/salida/informe_logs.md
mkdir -p ~/laboratorio/datos/salida
echo "# Informe de Análisis de Logs" > $OUTPUT
echo "Fecha y hora: $(date)" >> $OUTPUT
echo "" >> $OUTPUT
echo "| Archivo | Tamaño | # Errores |" >> $OUTPUT
echo "|---------|--------|-----------|" >> $OUTPUT

LOGS=$(find /var/log -type f -name "*.log" -exec du -h {} + | sort -rh | head -5 | awk '{print $2}')

MAYOR_ERROR=""

MAX_ERRORES=0

for FILE in $LOGS; do
  SIZE=$(du -h "$FILE" | cut -f1)
  COUNT=$(grep -i "error" "$FILE" | wc -l)
  echo "| $FILE | $SIZE | $COUNT |" >> $OUTPUT
  if [ $COUNT -gt $MAX_ERRORES ]; then
    MAX_ERRORES=$COUNT
    MAYOR_ERROR=$FILE
  fi
done

echo "" >> $OUTPUT
echo "## Últimos 3 errores en: $MAYOR_ERROR" >> $OUTPUT
grep -i "error" "$MAYOR_ERROR" | tail -n 3 >> $OUTPUT
cat $OUTPUT
