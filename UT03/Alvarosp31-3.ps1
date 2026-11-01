# Obtener los registros que existen en el sistema
$registros = Get-WinEvent -ListLog * | Where-Object {$_.RecordCount -gt 0}

# Variable para controlar el menu
$salir = $false

# Repetir el menu hasta que el usuario quiera salir
while ($salir -eq $false) {

    Write-Host ""
    Write-Host "MENU DE REGISTROS DE EVENTOS"
    Write-Host "----------------------------"

    # Mostrar los registros numerados
    for ($i = 0; $i -lt $registros.Count; $i++) {
        Write-Host "$($i + 1). $($registros[$i].LogName)"
    }

    Write-Host "0. Salir"
    Write-Host ""

    # Pedir una opcion al usuario
    $opcion = Read-Host "Elige una opcion"

    # Comprobar si quiere salir
    if ($opcion -eq "0") {
        $salir = $true
    }

    # Comprobar si la opcion es correcta
    elseif ($opcion -match '^\d+$' -and [int]$opcion -ge 1 -and [int]$opcion -le $registros.Count) {

        # Obtener el registro seleccionado
        $registro = $registros[[int]$opcion - 1]

        # Mostrar el numero total de eventos
        Write-Host ""
        Write-Host "Total de eventos: $($registro.RecordCount)"

        # Mostrar los 12 ultimos eventos
        Write-Host "Ultimos 12 eventos:"
        Get-WinEvent -LogName $registro.LogName -MaxEvents 12 |
            Format-Table TimeCreated, Id, LevelDisplayName, ProviderName -AutoSize
    }

    # Si la opcion no existe, mostrar un aviso
    else {
        Write-Host "Opcion no valida"
    }
}
