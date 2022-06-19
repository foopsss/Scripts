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
* Stack Overflow - User 'Jeff Zeitlin' - Ideas and knowledge to develop or rework some of the functions seen in this script.
  (https://stackoverflow.com/questions/56297149/if-test-path-path-detect-2-files-at-once)
#>
