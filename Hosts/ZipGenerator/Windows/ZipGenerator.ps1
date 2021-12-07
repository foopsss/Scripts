<# Defino las variables a utilizar. #>
$wd = Get-Location

<# Defino las funciones a utilizar. #>
function ExitScript {
    # Con esta función se simula el "Presiona una tecla para salir".
    # Luego se borra todo el contenido para imprimir el menú otra vez en una pantalla limpia.
    Write-Host "Presione una tecla para salir." -ForegroundColor Yellow
    [void][System.Console]::ReadKey($FALSE)

    # Cierro el programa.
    EXIT
}

<# Código. #>

    # Cambio el directorio de trabajo al actual.
    Set-Location -Path "$wd"

    # Imprimo una cabecera.
    Write-Host "-----------------------------------" -ForegroundColor Yellow
    Write-Host "Generador de archivos para flashear" -ForegroundColor Yellow
    Write-Host "-----------------------------------" -ForegroundColor Yellow

    # Creo las carpetas.
    Write-Host "Creando las carpetas necesarias..." -ForegroundColor Red
    New-Item -Path "META-INF" -ItemType Directory -Force | Out-Null
    New-Item -Path "META-INF\com" -ItemType Directory -Force | Out-Null
    New-Item -Path "META-INF\com\google" -ItemType Directory -Force | Out-Null
    New-Item -Path "META-INF\com\google\android" -ItemType Directory -Force | Out-Null
    New-Item -Path "system" -ItemType Directory -Force | Out-Null
    New-Item -Path "system\etc" -ItemType Directory -Force | Out-Null
    
    # Descargo los archivos necesarios.
    Write-Host "Descargando los archivos más nuevos..." -ForegroundColor Red
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/foopsss/Scripts/main/Hosts/ZipGenerator/files/updater-script" -OutFile "META-INF\com\google\android\updater-script"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/foopsss/Scripts/main/Hosts/ZipGenerator/files/update-binary" -OutFile "META-INF\com\google\android\update-binary"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/foopsss/hosts/master/hosts-porn" -OutFile "$wd\system\etc\hosts"
    Write-Host "¡Archivos descargados!" -ForegroundColor Green
    Write-Host

    # Indico los pasos a seguir a continuación.
    Write-Host "Debido a problemas en el proceso de generación de comprimidos zip de Powershell, estos no se pueden usar para flashear archivos en Android."
    Write-Host
    Write-Host "Por favor, seleccione las carpetas 'META-INF' y 'system' generadas por el script en su ubicación actual, y comprimalas utilizando alguna herramienta como WinRAR o 7-Zip."
    Write-Host
    Write-Host "Gracias, y disculpe las molestias."
    Write-Host

    # Cierro el script.
    ExitScript

<# Créditos
•shelladmin/shellgeek.com - Código para conseguir la ruta del directorio en el que se encuentra el script.
 (https://shellgeek.com/how-to-get-current-directory-full-path-in-powershell/)
•www.tutorialspoint.com - Código para crear y eliminar carpetas.
 (https://www.tutorialspoint.com/powershell/powershell_files_create_folders.htm)
 (https://www.tutorialspoint.com/powershell/powershell_files_delete_folders.htm)
•Stack Overflow - Usuario 'ChiliYago' - Código para esconder el texto retornado por la consola, utilizando Out-Null.
 (https://stackoverflow.com/questions/46586382/hide-powershell-output)
•Michael Pietroforte/4sysops.com - Código para descargar un archivo de Internet.
 (https://4sysops.com/archives/use-powershell-to-download-a-file-with-http-https-and-ftp/)
•Microsoft Docs/PowerShell Community - Código para cambiar el directorio desde el que corre un script y para forzar la creación de un directorio con New-Item.
 (https://docs.microsoft.com/en-us/powershell/scripting/samples/managing-current-location?view=powershell-7.2)
 (https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-7.2)
•SS64.com - Código para pausar el script.
 (https://ss64.com/ps/pause.html)
•Karim Buzdar/www.faqforge.com - Código para realizar comentarios en el código.
 (https://www.faqforge.com/powershell/comment-code-powershell/)
•Dejan Mladenović/www.improvescripting.com - Instrucciones para depurar el código en el ISE de Powershell.
 (https://www.improvescripting.com/how-to-debug-powershell-scripts/)
#>