<# Defino las funciones a utilizar #>

    # Función para cambiar el tamaño de la ventana de Powershell.
    [CmdletBinding()]
    Param(
         [Parameter(Mandatory=$False,Position=0)]
         [int]$Height = 18,
         [Parameter(Mandatory=$False,Position=1)]
         [int]$Width = 77
    )

    $console = $host.ui.rawui
    $ConBuffer  = $console.BufferSize
    $ConSize = $console.WindowSize

    $currWidth = $ConSize.Width
    $currHeight = $ConSize.Height

    # If height is too large, set to max allowed size.
    if ($Height -gt $host.UI.RawUI.MaxPhysicalWindowSize.Height) {
        $Height = $host.UI.RawUI.MaxPhysicalWindowSize.Height
    }

    # If width is too large, set to max allowed size.
    if ($Width -gt $host.UI.RawUI.MaxPhysicalWindowSize.Width) {
     $Width = $host.UI.RawUI.MaxPhysicalWindowSize.Width
    }

    # If the Buffer is wider than the new console setting, first reduce the width.
    If ($ConBuffer.Width -gt $Width ) {
       $currWidth = $Width
    }

    # If the Buffer is higher than the new console setting, first reduce the height.
    If ($ConBuffer.Height -gt $Height ) {
        $currHeight = $Height
    }

    # Initial resizing if needed.
    $host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.size($currWidth,$currHeight)

    # Set the Buffer.
    $host.UI.RawUI.BufferSize = New-Object System.Management.Automation.Host.size($Width,2000)

    # Now set the WindowSize.
    $host.UI.RawUI.WindowSize = New-Object System.Management.Automation.Host.size($Width,$Height)

    # Defino el menú que voy a usar #
    function Show-Menu {
        param (
            [string]$Title = 'Herramienta para crear copias de seguridad'
        )
        Write-Host "----------------------------------------------------------------------------"
        Write-Host "¡Bienvenido!" -ForegroundColor Green
        Write-Host "Por favor, seleccione de que desearía realizar una copia"
        Write-Host "----------------------------------------------------------------------------"
        Write-Host "Fecha:"
        Get-Date -Format "dd/MM/yyyy"
        Write-Host "Hora:"
        Get-Date -Format "hh:mm"
        Write-Host "----------------------------------------------------------------------------"
        Write-Host "1. Hacer copia del repositorio 'hosts'."
        Write-Host "2. Hacer copia del repositorio 'scripts'."
        Write-Host "3. Hacer copia del mundo de Minecraft."
        Write-Host "4. Hacer copia de los mapas de Call of Duty: Black Ops III."
        Write-Host "5. Hacer copia de los datos de partida de Mafia III: Definitive Edition."
        Write-Host "6. SALIR."
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

<# Defino el diálogo de elección y las opciones #>
do
 {
    # Defino el diálogo para pedir que el usuario introduzca un número, así como una lí­nea para separar los datos introducidos.
    Show-Menu
    $selection =
    Read-Host "Escriba el número que corresponda a la opcion que desee y presione ENTER"
    Write-Host " "

    # Defino las operaciones a realizar con cada comando.
    switch ($selection)
    {
        '1' {
            Clear-Host
            Write-Host "¡Extrayendo contenido de la página y creando archivo .zip!" -ForegroundColor Red
            Invoke-WebRequest -Uri "$github" -OutFile "$parent\Zips\Hosts.zip"
            Copy-Item "$parent\Zips\Hosts.zip" -Destination "$liben\Hosts.zip" -Force

            if (Test-Path -Path $parent\Zips\Hosts.zip -PathType Leaf) {
            Write-Host ("¡Archivo creado!") -ForegroundColor Green
            } else {
            Write-Host ("¡El archivo no se pudo crear!") -ForegroundColor Red
            }
        }

        '2' {
            Clear-Host
            Write-Host "¡Extrayendo contenido de la página y creando archivo .zip!" -ForegroundColor Red
            Invoke-WebRequest -Uri "$github1" -OutFile "$LUCAS3\Scripts.zip"
            Copy-Item "$LUCAS3\Scripts.zip" -Destination "$liben\Scripts.zip" -Force

            if (Test-Path -Path "$LUCAS3\Scripts.zip", "$liben\Scripts.zip" -PathType Leaf) {
            Write-Host ("¡Archivo creado!") -ForegroundColor Green
            } else {
            Write-Host ("¡El archivo no se pudo crear!") -ForegroundColor Red
            }
        }

        '3' {
            Clear-Host
            Write-Host "¡Creando archivo .zip!"  -ForegroundColor Red
            Compress-Archive -Path "$minecraft" -DestinationPath "$parent\Zips\Lucas3.zip" -Update -CompressionLevel Optimal
            Copy-Item "$parent\Zips\Lucas3.zip" -Destination "$liben\Lucas3.zip" -Force

            if (Test-Path -Path "$parent\Zips\Lucas3.zip", "$liben\Lucas3.zip" -PathType Leaf) {
            Write-Host ("¡Archivo creado!") -ForegroundColor Green
            } else {
            Write-Host ("¡El archivo no se pudo crear!") -ForegroundColor Red
            }
        }

        '4' {
            Clear-Host
            Write-Host "¡Creando archivo .zip!"  -ForegroundColor Red
            Compress-Archive -LiteralPath "$bo3modtoolsmaps", "$bo3modtoolsprefabs" -DestinationPath "$parent\Zips\Black Ops III Mod Tools.zip" -Update -CompressionLevel Optimal
            Copy-Item "$parent\Zips\Black Ops III Mod Tools.zip" -Destination "$liben\Black Ops III Mod Tools.zip" -Force

            if (Test-Path -Path "$parent\Zips\Black Ops III Mod Tools.zip", "$liben\Black Ops III Mod Tools.zip" -PathType Leaf) {
            Write-Host ("¡Archivo creado!") -ForegroundColor Green
            } else {
            Write-Host ("¡El archivo no se pudo crear!") -ForegroundColor Red
            }
        }

        '5' {
            Clear-Host
            Write-Host "¡Creando archivo .zip!"  -ForegroundColor Red
            Compress-Archive -LiteralPath "$mafia3" -DestinationPath "$parent\Zips\Mafia III Definitive Edition.zip" -Update -CompressionLevel Optimal
            Copy-Item "$parent\Zips\Mafia III Definitive Edition.zip" -Destination "$liben\Mafia III Definitive Edition.zip" -Force

            if (Test-Path -Path "$parent\Zips\Mafia III Definitive Edition.zip", "$liben\Mafia III Definitive Edition.zip" -PathType Leaf) {
            Write-Host ("¡Archivo creado!") -ForegroundColor Green
            } else {
            Write-Host ("¡El archivo no se pudo crear!") -ForegroundColor Red
            }
        }
    }

    # Se simula con esto el "Presiona una tecla para salir".
    # Luego se borra todo el contenido para imprimir el menú otra vez en una pantalla limpia.
    Write-Host "Presione una tecla para salir." -ForegroundColor Yellow
    [void][System.Console]::ReadKey($FALSE)
    Clear-Host
 }

<# Hasta que la opción elegida sea 7 el script sigue funcionando #>
until ($selection -eq '6')

<# Créditos
•Adam Bertram/adamtheautomator.com - Código para el título del script, el menú, las funciones, y para chequear si existe un archivo.
 (https://adamtheautomator.com/powershell-menu/)
•Adam Gordon/blog.itpro.tv - Código para obtener la fecha y la hora.
 (https://blog.itpro.tv/get-date-powershell-cmdlet/)
•SS64.com - Código para pausar el script y para cambiar el tamaño de la ventana.
 (https://ss64.com/ps/syntax-consolesize.html)
 (https://ss64.com/ps/pause.html)
•Michael Pietroforte/4sysops.com - Código para descargar un archivo de Internet.
 (https://4sysops.com/archives/use-powershell-to-download-a-file-with-http-https-and-ftp/)
•Microsoft Docs/PowerShell Community - Código para crear un archivo .zip a partir de una carpeta, copiar archivos, chequear si existe una carpeta y declarar variables.
 (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/compress-archive?view=powershell-7.1)
 (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.1)
 (https://devblogs.microsoft.com/powershell-community/determine-if-a-folder-exists/)
 (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_variables?view=powershell-7.1)
•shelladmin/shellgeek.com - Código para conseguir la ruta del directorio en el que se encuentra el script.
 (https://shellgeek.com/how-to-get-current-directory-full-path-in-powershell/)
•www.tutorialspoint.com - Código para las declaraciones if/elseif, y para crear o eliminar un directorio.
 (https://www.tutorialspoint.com/powershell/if_else_statement_in_powershell.htm)
•Karim Buzdar/www.faqforge.com - Código para realizar comentarios en el código.
 (https://www.faqforge.com/powershell/comment-code-powershell/)
#>