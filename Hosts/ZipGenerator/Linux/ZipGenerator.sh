# Declaro el intérprete a utilizar.
#!/bin/bash

# Defino las propiedades de la ventana.
resize -s 20 85 > /dev/null

# Defino las variables a utilizar.
ZipName=Hosts-Flash.zip

# Defino las funciones a utilizar.
YT() {
# YT es el acrónimo para Yellow Text.
# Esta función solo imprime texto amarillo.
    echo -e "\e[1;33m$1\e[0m"
}

GBT() {
# GBT es el acrónimo para Green Bold Text.
# Esta función imprime texto blanco, sobre un fondo verde y en negritas.
    echo -e "\e[1;42m$1\e[0m"
}

RBT() {
# RBT es el acrónimo para Red Bold Text.
# Esta función imprime texto blanco, sobre un fondo rojo y en negritas.
    echo -e "\e[1;41m$1\e[0m"
}

BBT() {
# BBT es el acrónimo para Blue Bold Text.
# Esta función imprime texto blanco, sobre un fondo azul y en negritas.
    echo -e "\e[1;44m$1\e[0m"
}

ErrorCheck() {
# Esta función chequea el código de salida devuelto por un comando al ejecutarlo, para saber si se ejecutó correctamente o no.
    if [ $? -eq 0 ]
    then
        GBT "Operación completada exitosamente."
    else
        RBT "La operación no se pudo completar. Intente de nuevo."
    fi
}

FileCheck() {
# Esta función chequea si existe un archivo o carpeta, e imprime dos mensajes según el resultado.
    if [ -e "$1" ]
    then
        GBT "Operación completada exitosamente."
        BBT "El archivo zip ha sido creado con éxito. Muévalo a su dispositivo e instálelo usando un recovery personalizado compatible."
    else
        RBT "La operación no se pudo completar. Intente de nuevo."
    fi
}

FileCheckX2() {
# Esta función chequea si dos archivos/carpetas NO existen, e imprime un mensaje según el resultado.
    if [ ! -e "$1" ] && [ ! -e "$2" ]
    then
        GBT "Operación completada exitosamente."
    else
        RBT "La operación no se pudo completar. Intente de nuevo."
    fi
}

ExitScript() {
# Con esta función se simula el "Presiona una tecla para salir".
# Luego se borra todo el contenido para limpiar la terminal al salir.
    YT "Presione una tecla para salir."
    read -n1
    clear
    exit
}

# Limpio la pantalla antes de comenzar.
clear

# Imprimo una cabecera.
YT "-----------------------------------"
echo "Generador de archivos para flashear"
YT "-----------------------------------"

# Creo las carpetas necesarias.
echo "Creando las carpetas necesarias..."
{
    mkdir -p META-INF/com/google/android
    mkdir -p system/etc
} 2>/dev/null
ErrorCheck
echo

# Descargo los archivos requeridos de Internet.
echo "Descargando los archivos necesarios de Internet..."
{
    wget https://raw.githubusercontent.com/foopsss/Scripts/main/Hosts/ZipGenerator/files/update-binary -P META-INF/com/google/android
    wget https://raw.githubusercontent.com/foopsss/Scripts/main/Hosts/ZipGenerator/files/updater-script -P META-INF/com/google/android
    wget https://raw.githubusercontent.com/foopsss/hosts/master/hosts-porn -O system/etc/hosts
} 2>/dev/null
ErrorCheck
echo

# Creo el comprimido zip.
echo "Creando el archivo zip..."
zip -r -q $ZipName META-INF system
FileCheck "$ZipName"
echo

# Borro los archivos residuales.
echo "Borrando los archivos residuales..."
{
    rm -rf META-INF system
} 2>/dev/null
FileCheckX2 "META-INF" "system"
echo

# Cierro el script.
ExitScript

# Cŕeditos.
<< 'CREDITOS'
•Stack Overflow - User 'plhn' - Code to resize a terminal window.
 (https://stackoverflow.com/questions/5243445/bash-command-to-change-size-of-bash-window)
•DevQA - User 'Amir Ghahrai' - Code to create and call functions.
 (https://devqa.io/create-call-bash-functions/)
•ShellHacks - ANSI color codes to colorize text.
 (https://www.shellhacks.com/bash-colors/)
•Ryan's Tutorials/ryanstutorials.net - Code to make if statements and some information about operators.
 (https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php)
•EdXD/bytexd.com - Code to make a folder and additional options.
 (https://bytexd.com/mkdir-command-create-directories/)
•Stack Overflow - User 'Jim' - Code to pause the console using read.
 (https://stackoverflow.com/questions/92802/what-is-the-linux-equivalent-to-dos-pause)
•Unix & Linux Stack Exchange - User 'John' - Code to suppress error messages.
 (https://unix.stackexchange.com/questions/192042/how-do-i-suppress-error-messages-from-cp)
•The sites listed below - Code to use wget and info about its exit status.
 •GeeksforGeeks/www.geeksforgeeks.org.
  (https://www.geeksforgeeks.org/wget-command-in-linux-unix/)
 •Stack Overflow - User 'RPradeep'
  (https://stackoverflow.com/questions/1078524/how-to-specify-the-download-location-with-wget)
 •The GNU Operating System and the Free Software Movement/www.gnu.org.
  (https://www.gnu.org/software/wget/manual/html_node/Exit-Status.html)
•nixCraft - User 'Vivek Gite' - Code to remove a folder using rm.
 (https://www.cyberciti.biz/tips/find-out-if-file-exists-with-conditional-expressions.html)
CREDITOS