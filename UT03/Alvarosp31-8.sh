!/bin/bash

# Obtener el numero de semana del año
SEMANA=$(date +%V)

# Fichero con la fecha de la ultima copia total
MARCA="/bacalvaro/ultima_copia_total"

# Comprobar que existe una copia total anterior
if [ ! -f "$MARCA" ]; then
    echo "Error: no existe una copia total anterior."
    exit 1
fi

# Crear copia diferencial de los archivos modificados
if tar -czf "/bacalvaro/CopDifSem-$SEMANA.tar.gz" \
    --newer-mtime="$MARCA" /home; then
    echo "Copia diferencial semanal realizada correctamente."
else
    echo "Error al realizar la copia diferencial."
    exit 1
fi



