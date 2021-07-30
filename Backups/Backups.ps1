<# Definimos la función para cambiar el tamaño de la ventana de Powershell #>

    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$False,Position=0)]
         [int]$Height = 18,
         [Parameter(Mandatory=$False,Position=1)]
         [int]$Width = 80
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

<# Definimos el menú que vamos a usar #>

function Show-Menu {
    param (
        [string]$Title = 'Herramienta para crear copias de seguridad'
    )

    Write-Host "............................................................................"
    Write-Host "¡Bienvenido!" -ForegroundColor Green
    Write-Host "Por favor seleccione de que desearía realizar una copia"
    Write-Host "............................................................................"
    Write-Host "Fecha:"
    Get-Date -Format "dd/MM/yyyy"
    Write-Host "Hora:"
    Get-Date -Format "hh:mm"
    Write-Host "............................................................................"
    Write-Host " "
    Write-Host "1: Hacer copia del repositorio 'hosts'"
    Write-Host "2: Hacer copia del repositorio 'scripts'"
    Write-Host "3: Hacer copia del mundo de Minecraft"
    Write-Host "4: Hacer copia de los mapas de Call of Duty: Black Ops III"
    Write-Host "5: SALIR"
    Write-Host " "
}

<# Definimos las variables a utilizar #>

$wd = Get-Location
$github = 'https://github.com/foopsss/hosts/archive/refs/heads/master.zip'
$github1 = 'https://github.com/foopsss/Scripts/archive/refs/heads/main.zip' 
$liben = 'C:\Users\liben\OneDrive\Backups\Zips'
$Lucas = 'C:\Users\Lucas\OneDrive\Backups\Zips'
$minecraft = 'J:\Minecraft\Juego\.minecraft\saves\Lucas3\*'
$bo3modtoolsmaps = 'J:\Lanzadores de Juegos\Steam\steamapps\common\Call of Duty Black Ops III\map_source\zm\'
$bo3modtoolsprefabs = 'J:\Lanzadores de Juegos\Steam\steamapps\common\Call of Duty Black Ops III\map_source\_prefabs\Own Prefabs\'

<# Definimos el diálogo de elección y las opciones #>

do
 {
    # Definimos el diálogo para pedir que el usuario introduzca un número, así como una línea para separar los datos introducidos

    Show-Menu
    $selection =
    Read-Host "Escriba el número que corresponda a la opcion que desee y presione ENTER"
    Write-Host " "
    switch ($selection)
    {

    # Definimos las operaciones a realizar con cada comando

    '1' {

    CLS
    Write-Host "¡Extrayendo contenido de la página y creando archivo .zip!" -ForegroundColor Red
    Invoke-WebRequest -Uri "$github" -OutFile "$wd\Zips\hosts.zip" 

    if (Test-Path -Path $liben) {
      Copy-Item "$wd\Zips\hosts.zip" -Destination "$liben\hosts.zip" -Force
     } elseif (Test-Path -Path $Lucas) {
      Copy-Item "$wd\Zips\hosts.zip" -Destination "$Lucas\hosts.zip" -Force
     }

    if (Test-Path -Path $wd\Zips\hosts.zip -PathType Leaf) {
     Write-Host "¡Archivo creado!" -ForegroundColor Green
    }

    }

    '2' {

    CLS
    Write-Host "¡Extrayendo contenido de la página y creando archivo .zip!" -ForegroundColor Red
    Invoke-WebRequest -Uri "$github1" -OutFile "$wd\Zips\scripts.zip" 

    if (Test-Path -Path $liben) {
      Copy-Item "$wd\Zips\scripts.zip" -Destination "$liben\scripts.zip" -Force
     } elseif (Test-Path -Path $Lucas) {
      Copy-Item "$wd\Zips\scripts.zip" -Destination "$Lucas\scripts.zip" -Force
     }

    if (Test-Path -Path $wd\Zips\scripts.zip -PathType Leaf) {
     Write-Host "¡Archivo creado!" -ForegroundColor Green
    }

    }

    '3' {
    CLS
    Write-Host "¡Creando archivo .zip!"  -ForegroundColor Red
    Compress-Archive -Path "$minecraft" -DestinationPath "$wd\Zips\Lucas3.zip" -Update
    Copy-Item "$wd\Zips\Lucas3.zip" -Destination "$liben\Lucas3.zip" -Force

    if (Test-Path -Path "$wd\Zips\Lucas3.zip", "$liben\Lucas3.zip" -PathType Leaf) {
     Write-Host "¡Archivo creado!" -ForegroundColor Green
    }

    }

    '4' {
    CLS
    Write-Host "¡Creando archivo .zip!"  -ForegroundColor Red
    Compress-Archive -LiteralPath "$bo3modtoolsmaps", "$bo3modtoolsprefabs" -DestinationPath "$wd\Zips\Black Ops III Mod Tools.zip" -Update
    Copy-Item "$wd\Zips\Black Ops III Mod Tools.zip" -Destination "$liben\Black Ops III Mod Tools.zip" -Force

    if (Test-Path -Path "$wd\Zips\Black Ops III Mod Tools.zip", "$liben\Black Ops III Mod Tools.zip" -PathType Leaf) {
     Write-Host "¡Archivo creado!" -ForegroundColor Green
    }

    }

    }

    # Se simula con esto el "Presiona una tecla para continuar"
    # Luego se borra todo el contenido para imprimir el menú otra vez en una pantalla limpia

    Write-Host "Presione una tecla para salir." -ForegroundColor Yellow
    [void][System.Console]::ReadKey($FALSE)
    CLS

    <# Otra función para suspender el script
    "$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")"
    #>

 }

<# Hasta que la opción elegida sea 5 el script sigue funcionando #>

until ($selection -eq '5')

<# Créditos
•Adam Bertram/adamtheautomator.com - Código para el título del script, el menú, las funciones, y para chequear si existe un archivo.
•Adam Gordon/blog.itpro.tv - Código para obtener la fecha y la hora.
•SS64.com - Código para pausar el script y para cambiar el tamaño de la ventana.
•June Castillote/adamtheautomator.com - Código para descargar un archivo de Internet.
•Microsoft Docs - Código para crear un archivo .zip a partir de una carpeta, copiar archivos, chequear si existe una carpeta y declarar variables.
•shelladmin/shellgeek.com - Código para conseguir la ruta del directorio en el que se encuentra el script.
•www.tutorialspoint.com - Código para las declaraciones if/elseif, y para crear o eliminar un directorio.
•Karim Buzdar/www.faqforge.com - Código para realizar comentarios en el código.
#>