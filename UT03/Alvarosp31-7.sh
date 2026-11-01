#!/bin/bash

# Fichero donde se guardaran los avisos
LOG="/home/alvaro/registro_disco.log"

# Comprobar el espacio ocupado de cada particion
df -P -x iso9660 | awk 'NR > 1 {
    uso = $5
    sub("%", "", uso)

    # Si supera el 80%, guardar un aviso
    if (uso > 80) {
        print $6, uso
    }
}' | while read particion porcentaje
do
    # Guardar fecha, hora, particion y porcentaje
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Particion: $particion - Uso: $porcentaje%" >> "$LOG"
done

