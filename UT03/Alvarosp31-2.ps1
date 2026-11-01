# Recibir las fechas
param(
    [datetime]$FechaInicio,
    [datetime]$FechaFin
)

# Buscar los eventos de inicio de sesión
$eventos = Get-WinEvent -FilterHashtable @{
    LogName = "Security"
    Id = 4624
    StartTime = $FechaInicio
    EndTime = $FechaFin
}

# Mostrar el titulo
Write-Host "Eventos de Inicio de Sesión:"

# Recorrer los eventos encontrados
foreach ($evento in $eventos) {

    # Obtener el nombre del usuario
    $usuario = $evento.Properties[5].Value

    # Excluir SYSTEM
    if ($usuario -ne "SYSTEM" -and $usuario -ne "") {

        # Mostrar fecha, hora y usuario
        $fecha = $evento.TimeCreated.ToString("MM/dd/yyyy HH:mm:ss")

        Write-Host "Fecha: $fecha - Usuario: $usuario"
    }
}
