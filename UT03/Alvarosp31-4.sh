!/bin/bash

# Obtener la carpeta donde se encuentra el script
carpeta="$(cd "$(dirname "$0")" && pwd)"

# Leer los programas del archivo programas.txt
while read -r programa
do
    # Comprobar si el programa esta instalado
    if dpkg -s "$programa" 2>/dev/null | grep -q "Status: install ok installed"
    then
        echo "Desinstalando $programa..."
        sudo apt remove -y "$programa"
    else
        echo "El programa $programa no esta instalado."
    fi

done < "$carpeta/programas.txt"

echo "Proceso terminado."
