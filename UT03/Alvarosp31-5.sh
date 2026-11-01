#!/bin/bash

# Mostrar el inicio del analisis
echo "BUSQUEDA DE ERRORES EN /var/log"
echo "--------------------------------"

# Recorrer los archivos de la carpeta /var/log
find /var/log -type f 2>/dev/null | while read archivo
do
    # Buscar las palabras error o fail
    resultado=$(grep -inE "error|fail" "$archivo" 2>/dev/null)

    # Mostrar los resultados si existen
    if [ -n "$resultado" ]
    then
        echo ""
        echo "Archivo: $archivo"
        echo "$resultado"
        echo "--------------------------------"
    fi
done

echo "Busqueda terminada."

