<# C�digo Extra
"Write-Host "Presione cualquier tecla para salir" -ForegroundColor Red"
"$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")"
#>

<# Defino la funci�n para cambiar el tama�o de la ventana de Powershell #>

    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$False,Position=0)]
         [int]$Height = 20,
         [Parameter(Mandatory=$False,Position=1)]
         [int]$Width = 77
    )

    $console = $host.ui.rawui
    $ConBuffer  = $console.BufferSize
    $ConSize = $console.WindowSize

    $currWidth = $ConSize.Width
    $currHeight = $ConSize.Height

    # If height is too large, set to max allowed size
    if ($Height -gt $host.UI.RawUI.MaxPhysicalWindowSize.Height) {
        $Height = $host.UI.RawUI.MaxPhysicalWindowSize.Height
    }

    # If width is too large, set to max allowed size
    if ($Width -gt $host.UI.RawUI.MaxPhysicalWindowSize.Width) {
     $Width = $host.UI.RawUI.MaxPhysicalWindowSize.Width
    }

    # If the Buffer is wider than the new console setting, first reduce the width
    If ($ConBuffer.Width -gt $Width ) {
       $currWidth = $Width
    }

    # If the Buffer is higher than the new console setting, first reduce the height
    If ($ConBuffer.Height -gt $Height ) {
        $currHeight = $Height
    }

    # Initial resizing if needed
    $host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.size($currWidth,$currHeight)

    # Set the Buffer
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.size($Width,2000)

    # Now set the WindowSize
    $host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.size($Width,$Height)

    # Display result
      ## "Height: " + $host.ui.rawui.WindowSize.Height
      ## "Width:  " + $host.ui.rawui.WindowSize.width

<# Defino el men� que voy a usar #>

function Show-Menu {
    param (
        [string]$Title = 'Herramienta para crear copias de seguridad'
    )

    Write-Host "----------------------------------------------------------------------------"
    Write-Host "�Bienvenido!" -ForegroundColor Green
    Write-Host "Por favor seleccione de que desear�a realizar una copia"
    Write-Host "----------------------------------------------------------------------------"
    Write-Host "Fecha:"
    Get-Date -Format "dd/MM/yyyy"
    Write-Host "Hora:"
    Get-Date -Format "hh:mm"
    Write-Host "----------------------------------------------------------------------------"
    Write-Host " "
    Write-Host "1. Hacer copia del repositorio 'hosts'."
    Write-Host "2. Hacer copia del repositorio 'scripts'."
    Write-Host "3. Hacer copia del mundo de Minecraft."
    Write-Host "4. Hacer copia de los mapas de Call of Duty: Black Ops III."
    Write-Host "5. Hacer copia de los datos de partida de Mafia III: Definitive Edition."
    Write-Host "6. Cr�ditos."
    Write-Host "7. SALIR."
    Write-Host " "
}

<# Defino las variables a utilizar #>

$wd = Get-Location
$parent = Split-Path -Path $wd -Parent
$github = 'https://github.com/foopsss/hosts/archive/refs/heads/master.zip'
$github1 = 'https://github.com/foopsss/scripts/archive/refs/heads/main.zip' 
$liben = 'C:\Users\liben\OneDrive\Backups\Zips'
$LUCAS3 = 'G:\Backup\Software\Scripts\'
$minecraft = 'J:\Minecraft\Juego\.minecraft\saves\Lucas3\'
$bo3modtoolsmaps = 'J:\Lanzadores de Juegos\Steam\steamapps\common\Call of Duty Black Ops III\map_source\zm\'
$bo3modtoolsprefabs = 'J:\Lanzadores de Juegos\Steam\steamapps\common\Call of Duty Black Ops III\map_source\_prefabs\Own Prefabs\'
$mafia3 = 'C:\Users\liben\AppData\Local\2K Games\Mafia III'


<# Defino el di�logo de elecci�n y las opciones #>

do
 {
    # Defino el di�logo para pedir que el usuario introduzca un n�mero, as� como una l�nea para separar los datos introducidos

    Show-Menu
    $selection =
    Read-Host "Escriba el n�mero que corresponda a la opcion que desee y presione ENTER"
    Write-Host " "
    switch ($selection)
    {

    # Defino las operaciones a realizar con cada comando

    '1' {

    Clear-Host
    Write-Host "�Extrayendo contenido de la p�gina y creando archivo .zip!" -ForegroundColor Red
    Invoke-WebRequest -Uri "$github" -OutFile "$parent\Zips\Hosts.zip"
    Copy-Item "$parent\Zips\Hosts.zip" -Destination "$liben\Hosts.zip" -Force

    if (Test-Path -Path $parent\Zips\Hosts.zip -PathType Leaf) {
     Write-Host ("�Archivo creado!") -ForegroundColor Green
    } else {
     Write-Host ("�El archivo no se pudo crear!") -ForegroundColor Red
    }

    }

    '2' {

    Clear-Host
    Write-Host "�Extrayendo contenido de la p�gina y creando archivo .zip!" -ForegroundColor Red
    Invoke-WebRequest -Uri "$github1" -OutFile "$LUCAS3\Scripts.zip"
    Copy-Item "$LUCAS3\Scripts.zip" -Destination "$liben\Scripts.zip" -Force

    if (Test-Path -Path "$LUCAS3\Scripts.zip", "$liben\Scripts.zip" -PathType Leaf) {
     Write-Host ("�Archivo creado!") -ForegroundColor Green
    } else {
     Write-Host ("�El archivo no se pudo crear!") -ForegroundColor Red
    }

    }

    '3' {
    Clear-Host
    Write-Host "�Creando archivo .zip!"  -ForegroundColor Red
    Compress-Archive -Path "$minecraft" -DestinationPath "$parent\Zips\Lucas3.zip" -Update
    Copy-Item "$parent\Zips\Lucas3.zip" -Destination "$liben\Lucas3.zip" -Force

    if (Test-Path -Path "$parent\Zips\Lucas3.zip", "$liben\Lucas3.zip" -PathType Leaf) {
     Write-Host ("�Archivo creado!") -ForegroundColor Green
    } else {
     Write-Host ("�El archivo no se pudo crear!") -ForegroundColor Red
    }

    }

    '4' {
    Clear-Host
    Write-Host "�Creando archivo .zip!"  -ForegroundColor Red
    Compress-Archive -LiteralPath "$bo3modtoolsmaps", "$bo3modtoolsprefabs" -DestinationPath "$parent\Zips\Black Ops III Mod Tools.zip" -Update
    Copy-Item "$parent\Zips\Black Ops III Mod Tools.zip" -Destination "$liben\Black Ops III Mod Tools.zip" -Force

    if (Test-Path -Path "$parent\Zips\Black Ops III Mod Tools.zip", "$liben\Black Ops III Mod Tools.zip" -PathType Leaf) {
     Write-Host ("�Archivo creado!") -ForegroundColor Green
    } else {
     Write-Host ("�El archivo no se pudo crear!") -ForegroundColor Red
    }

    }

    '5' {
    Clear-Host
    Write-Host "�Creando archivo .zip!"  -ForegroundColor Red
    Compress-Archive -LiteralPath "$mafia3" -DestinationPath "$parent\Zips\Mafia III Definitive Edition.zip" -Update
    Copy-Item "$parent\Zips\Mafia III Definitive Edition.zip" -Destination "$liben\Mafia III Definitive Edition.zip" -Force

    if (Test-Path -Path "$parent\Zips\Mafia III Definitive Edition.zip", "$liben\Mafia III Definitive Edition.zip" -PathType Leaf) {
     Write-Host ("�Archivo creado!") -ForegroundColor Green
    } else {
     Write-Host ("�El archivo no se pudo crear!") -ForegroundColor Red
    }

    }

    '6' {
    Clear-Host
    Write-Host "----------------------------------------------------------------------------"
    Write-Host "CR�DITOS"
    Write-Host "----------------------------------------------------------------------------"
    Write-Host ""
    Write-Host "[�] Adam Bertram/adamtheautomator.com - C�digo para el t�tulo del script, el"
    Write-Host "men�, las funciones, y para chequear si existe un archivo."
    Write-Host "    (https://adamtheautomator.com/powershell-menu/)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[�] Adam Gordon/blog.itpro.tv - C�digo para obtener la fecha y la hora."
    Write-Host "    (https://blog.itpro.tv/get-date-powershell-cmdlet/)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[�] SS64.com - C�digo para pausar el script y para cambiar el tama�o de la"
    Write-Host "ventana."
    Write-Host "    (https://ss64.com/ps/syntax-consolesize.html)" -ForegroundColor Yellow
    Write-Host "    (https://ss64.com/ps/pause.html)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[�] Michael Pietroforte/4sysops.com - C�digo para descargar un archivo de"
    Write-Host "Internet."
    Write-Host "    (https://4sysops.com/archives/use-powershell-to-download-a-file-with-http-https-and-ftp/)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[�] Microsoft Docs/PowerShell Community - C�digo para crear un archivo .zip"
    Write-Host "a partir de una carpeta, copiar archivos, chequear si existe una carpeta,"
    Write-Host "y declarar variables."
    Write-Host "    (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/compress-archive?view=powershell-7.1)" -ForegroundColor Yellow
    Write-Host "    (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.1)" -ForegroundColor Yellow
    Write-Host "    (https://devblogs.microsoft.com/powershell-community/determine-if-a-folder-exists/)" -ForegroundColor Yellow
    Write-Host "    (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_variables?view=powershell-7.1)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[�] shelladmin/shellgeek.com - C�digo para conseguir la ruta del directorio"
    Write-Host "en el que se encuentra el script, y para conseguir el directorio que se"
    Write-Host "encuentra antes."
    Write-Host "    (https://shellgeek.com/how-to-get-current-directory-full-path-in-powershell/)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[�] www.tutorialspoint.com - C�digo para las declaraciones if/elseif, y para"
    Write-Host "crear o eliminar un directorio."
    Write-Host "    (https://www.tutorialspoint.com/powershell/if_else_statement_in_powershell.htm)" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "[�] Karim Buzdar/www.faqforge.com - C�digo para realizar comentarios en el c�digo."
    Write-Host "    (https://www.faqforge.com/powershell/comment-code-powershell/)" -ForegroundColor Yellow
    Write-Host ""
    }

    }

    # Se simula con esto el "Presiona una tecla para continuar"
    # Luego se borra todo el contenido para imprimir el men� otra vez en una pantalla limpia

    Write-Host "Presione una tecla para salir." -ForegroundColor Yellow
    [void][System.Console]::ReadKey($FALSE)
    Clear-Host
 }

<# Hasta que la opci�n elegida sea 7 el script sigue funcionando #>

until ($selection -eq '7')