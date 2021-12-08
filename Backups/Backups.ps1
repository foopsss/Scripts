<# Defino las variables a utilizar. #>
$wd = Get-Location
$parent = Split-Path -Path $wd -Parent
$github = 'https://github.com/foopsss/hosts/archive/refs/heads/master.zip'
$github1 = 'https://github.com/foopsss/scripts/archive/refs/heads/main.zip' 
$liben = 'C:\Users\liben\OneDrive\Backups\Zips\'
$LUCAS3 = 'G:\Backup\Software\Scripts\'
$minecraft = 'J:\Minecraft\Juego\.minecraft\saves\Lucas3\'
$bo3modtoolsmaps = 'J:\Lanzadores de Juegos\Steam\steamapps\common\Call of Duty Black Ops III\map_source\zm\'
$bo3modtoolsprefabs = 'J:\Lanzadores de Juegos\Steam\steamapps\common\Call of Duty Black Ops III\map_source\_prefabs\Own Prefabs\'
$mafia3 = 'C:\Users\liben\AppData\Local\2K Games\Mafia III\'

<# Defino el menú de opciones. #>
function Show-Menu {
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

<# Defino el diálogo de elección y las opciones. #>
do
 {
    # Diálogo de elección.
    Show-Menu
    $selection =
    Read-Host "Escriba el número que corresponda a la opcion que desee y presione ENTER"
    Write-Host " "

    # Operaciones a realizar con cada comando.
    switch ($selection)
    {
        '1' {
            Clear-Host
            Write-Host "¡Extrayendo contenido de la página y creando archivo zip!" -ForegroundColor Gray
            Invoke-WebRequest -Uri "$github" -OutFile "$parent\Zips\Hosts.zip"
            Copy-Item "$parent\Zips\Hosts.zip" -Destination "$liben\Hosts.zip" -Force

            if ( Test-Path -Path "$parent\Zips\Hosts.zip", "$liben\Hosts.zip" -PathType Leaf ) {
                Write-Host "Operación completada exitosamente." -ForegroundColor Green
            } else {
                Write-Host "La operación no se pudo completar. Intente de nuevo." -ForegroundColor Red
            }
        }

        '2' {
            Clear-Host
            Write-Host "¡Extrayendo contenido de la página y creando archivo zip!" -ForegroundColor Gray
            Invoke-WebRequest -Uri "$github1" -OutFile "$LUCAS3\Scripts.zip"
            Copy-Item "$LUCAS3\Scripts.zip" -Destination "$liben\Scripts.zip" -Force

            if ( Test-Path -Path "$LUCAS3\Scripts.zip", "$liben\Scripts.zip" -PathType Leaf ) {
                Write-Host "Operación completada exitosamente." -ForegroundColor Green
            } else {
                Write-Host "La operación no se pudo completar. Intente de nuevo." -ForegroundColor Red
            }
        }

        '3' {
            Clear-Host
            Write-Host "¡Creando archivo zip!" -ForegroundColor Gray
            Compress-Archive -Path "$minecraft" -DestinationPath "$parent\Zips\Lucas3.zip" -Update -CompressionLevel Optimal
            Copy-Item "$parent\Zips\Lucas3.zip" -Destination "$liben\Lucas3.zip" -Force

            if ( Test-Path -Path "$parent\Zips\Lucas3.zip", "$liben\Lucas3.zip" -PathType Leaf ) {
                Write-Host "Operación completada exitosamente." -ForegroundColor Green
            } else {
                Write-Host "La operación no se pudo completar. Intente de nuevo." -ForegroundColor Red
            }
        }

        '4' {
            Clear-Host
            Write-Host "¡Creando archivo zip!" -ForegroundColor Gray
            Compress-Archive -LiteralPath "$bo3modtoolsmaps", "$bo3modtoolsprefabs" -DestinationPath "$parent\Zips\Black Ops III Mod Tools.zip" -Update -CompressionLevel Optimal
            Copy-Item "$parent\Zips\Black Ops III Mod Tools.zip" -Destination "$liben\Black Ops III Mod Tools.zip" -Force

            if ( Test-Path -Path "$parent\Zips\Black Ops III Mod Tools.zip", "$liben\Black Ops III Mod Tools.zip" -PathType Leaf ) {
                Write-Host "Operación completada exitosamente." -ForegroundColor Green
            } else {
                Write-Host "La operación no se pudo completar. Intente de nuevo." -ForegroundColor Red
            }
        }

        '5' {
            Clear-Host
            Write-Host "¡Creando archivo zip!" -ForegroundColor Gray
            Compress-Archive -LiteralPath "$mafia3" -DestinationPath "$parent\Zips\Mafia III Definitive Edition.zip" -Update -CompressionLevel Optimal
            Copy-Item "$parent\Zips\Mafia III Definitive Edition.zip" -Destination "$liben\Mafia III Definitive Edition.zip" -Force

            if ( Test-Path -Path "$parent\Zips\Mafia III Definitive Edition.zip", "$liben\Mafia III Definitive Edition.zip" -PathType Leaf ) {
                Write-Host "Operación completada exitosamente." -ForegroundColor Green
            } else {
                Write-Host "La operación no se pudo completar. Intente de nuevo." -ForegroundColor Red
            }
        }
    }
    
    # Salgo de la sección actual y limpio la pantalla.
    Write-Host "Presione una tecla para salir." -ForegroundColor Yellow
    [void][System.Console]::ReadKey($FALSE)
    Clear-Host
 }

<# Hasta que la opción elegida sea 7 el script sigue funcionando. #>
until ($selection -eq '6')

<# Credits
•Adam Bertram/adamtheautomator.com - Code to print a menu.
 (https://adamtheautomator.com/powershell-menu/)
•Adam Gordon/blog.itpro.tv - Code to get the time and date.
 (https://blog.itpro.tv/get-date-powershell-cmdlet/)
•SS64.com - Code to pause the script.
 (https://ss64.com/ps/pause.html)
•Michael Pietroforte/4sysops.com - Code to download Internet files.
 (https://4sysops.com/archives/use-powershell-to-download-a-file-with-http-https-and-ftp/)
•Microsoft Docs/PowerShell Community - Code to create a zip file from a directory, copy files, check if a file exists and to create variables.
 (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.archive/compress-archive?view=powershell-7.1)
 (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item?view=powershell-7.1)
 (https://devblogs.microsoft.com/powershell-community/determine-if-a-folder-exists/)
 (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_variables?view=powershell-7.1)
•shelladmin/shellgeek.com - Code to get the current working directory.
 (https://shellgeek.com/how-to-get-current-directory-full-path-in-powershell/)
•www.tutorialspoint.com - Code for if statements and to create or delete a directory.
 (https://www.tutorialspoint.com/powershell/if_else_statement_in_powershell.htm)
•Karim Buzdar/www.faqforge.com - Code to make comments.
 (https://www.faqforge.com/powershell/comment-code-powershell/)
#>
