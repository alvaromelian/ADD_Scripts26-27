#!/bin/bash

# Obtener el mes y el año actual
MES=$(date +%B-%Y)

# Crear copia total del directorio /home
if tar -czf "/bacalvaro/CopTot-$MES.tar.gz" /home; then
    # Guardar la fecha de la copia total
    touch /bacalvaro/ultima_copia_total
    echo "Copia total realizada correctamente."
else
    echo "Error al realizar la copia total."
    exit 1
fi
