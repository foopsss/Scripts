<# Defino las variables globales a utilizar. #>
$wd = Get-Location
$METAINF = "META-INF\com\google\android"
$system = "system\etc"
$updaterscript = "https://raw.githubusercontent.com/foopsss/Scripts/main/Hosts/ZipGenerator/files/updater-script"
$updatebinary = "https://raw.githubusercontent.com/foopsss/Scripts/main/Hosts/ZipGenerator/files/update-binary"
$hosts = "https://raw.githubusercontent.com/foopsss/hosts/master/hosts-porn"

<# Codigo. #>

# Cambio el directorio de trabajo al actual.
Set-Location -Path "$wd"

# Imprimo una cabecera.
Write-Host "-----------------------------------" -ForegroundColor Yellow
Write-Host "Generador de archivos para flashear" -ForegroundColor Yellow
Write-Host "-----------------------------------" -ForegroundColor Yellow

# Creo las carpetas.
Write-Host "Creando las carpetas necesarias..." -ForegroundColor Cyan
New-Item -Path "$METAINF" -ItemType Directory -Force | Out-Null
New-Item -Path "$system" -ItemType Directory -Force | Out-Null

# Creo la funcion para chequear si las carpetas existen.
function TestExistence {
# Esta funcion chequea la existencia de las carpetas que deberian ser generadas en el directorio.
    if ( (Test-Path -Path $METAINF) -and (Test-Path -Path $system) ) {
        Write-Host "Operacion completada exitosamente." -ForegroundColor Green
    } else {
        Write-Error "La operacion no se pudo completar. Intente de nuevo."
    }
}

# Chequeo si las carpetas existen.
TestExistence
Write-Host ""
    
# Descargo los archivos necesarios.
Write-Host "Descargando los archivos mas nuevos..." -ForegroundColor Cyan
Invoke-WebRequest -Uri "$updaterscript" -OutFile "$METAINF\updater-script"
Invoke-WebRequest -Uri "$updatebinary" -OutFile "$METAINF\update-binary"
Invoke-WebRequest -Uri "$hosts" -OutFile "$system\hosts"

# Creo la funcion para chequear si los archivos existen.
function TestExistenceV2 {
# Esta funcion chequea la existencia de los archivos que deberian ser generados en el directorio.
    if ( ( (Test-Path -Path "$METAINF\updater-script" -PathType Leaf) -and (Test-Path -Path "$METAINF\update-binary" -PathType Leaf) ) -and (Test-Path -Path "$system\hosts" -PathType Leaf) ) {
        Write-Host "Operacion completada exitosamente." -ForegroundColor Green
    } else {
        Write-Error "La operacion no se pudo completar. Intente de nuevo."
    }
}

# Chequeo si los archivos existen.
TestExistenceV2
Write-Host ""

# Indico los pasos a seguir a continuacion.
Write-Host "Debido a problemas en el proceso de generacion de archivos zip de Powershell, estos no se pueden usar para flashear archivos en Android."
Write-Host
Write-Host "Por favor, seleccione las carpetas 'META-INF' y 'system' generadas por el script en su ubicacion actual, y comprimalas utilizando alguna herramienta como WinRAR o 7-Zip."
Write-Host
Write-Host "Gracias, y disculpe las molestias."
Write-Host

# Con esta funcion se simula el "Presiona una tecla para salir" y se cierra el programa.
Write-Host "Presione una tecla para salir." -ForegroundColor Yellow
[void][System.Console]::ReadKey($FALSE)
EXIT

<# Credits
*shelladmin/shellgeek.com - Code to get the current working directory.
 (https://shellgeek.com/how-to-get-current-directory-full-path-in-powershell/)

*www.tutorialspoint.com:
    *Code to create folders.
        (https://www.tutorialspoint.com/powershell/powershell_files_create_folders.htm)
    *Code to delete folders.
        (https://www.tutorialspoint.com/powershell/powershell_files_delete_folders.htm)

*Stack Overflow - User 'ChiliYago' - Code to hide console output using Out-Null and the pipeline.
 (https://stackoverflow.com/questions/46586382/hide-powershell-output)

*Michael Pietroforte/4sysops.com - Code to download Internet files.
 (https://4sysops.com/archives/use-powershell-to-download-a-file-with-http-https-and-ftp/)

*Microsoft Docs/PowerShell Community:
    *Code to change a script working directory.
        (https://docs.microsoft.com/en-us/powershell/scripting/samples/managing-current-location?view=powershell-7.2)
    *Code to force directory creation with New-Item.
        (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.2)
    *Code for if statements.
        (https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-if?view=powershell-7.2)
    *Code to use Test-Path.
        (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/test-path?view=powershell-7.2)

*SS64.com - Code to pause the script.
 (https://ss64.com/ps/pause.html)

*Karim Buzdar/www.faqforge.com - Code to make comments.
 (https://www.faqforge.com/powershell/comment-code-powershell/)

*Dejan Mladenovic/www.improvescripting.com - Instructions to debug code in Powershell ISE.
 (https://www.improvescripting.com/how-to-debug-powershell-scripts/)

*The sites listed below - Ideas and knowledge to develop or rework some of the functions seen in this script:
    *Stack Overflow - User 'Jeff Zeitlin'.
        (https://stackoverflow.com/questions/56297149/if-test-path-path-detect-2-files-at-once)
#>
