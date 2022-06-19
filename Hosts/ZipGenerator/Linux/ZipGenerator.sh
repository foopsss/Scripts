# Declaro el intérprete a utilizar.
#!/bin/bash

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
# Si se produce un error al ejecutar el script, este se cierra tras avisar al usuario.
    if [ $? -eq 0 ]
    then
        GBT "Operación completada exitosamente."
    else
        RBT "La operación no se pudo completar. Intente de nuevo."
        echo
        echo "Procediendo a cerrar el script..."
        ExitScript
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

# Chequeo si las carpetas existen.
ErrorCheck
echo

# Descargo los archivos requeridos de Internet.
echo "Descargando los archivos necesarios de Internet..."
{
    wget https://raw.githubusercontent.com/foopsss/Scripts/main/Hosts/ZipGenerator/files/update-binary -P META-INF/com/google/android
    wget https://raw.githubusercontent.com/foopsss/Scripts/main/Hosts/ZipGenerator/files/updater-script -P META-INF/com/google/android
    wget https://raw.githubusercontent.com/foopsss/hosts/master/hosts-porn -O system/etc/hosts
} 2>/dev/null

# Chequeo si los archivos existen.
ErrorCheck
echo

# Creo el comprimido zip.
echo "Creando el archivo zip..."
zip -r -q $ZipName META-INF system

# Chequeo si el comprimido zip existe.
if [ -e "$ZipName" ]
then
    GBT "Operación completada exitosamente."
    BBT "El archivo zip ha sido creado con éxito. Muévalo a su dispositivo e instálelo usando un recovery personalizado compatible."
else
    RBT "La operación no se pudo completar. Intente de nuevo."
    echo
    echo "Procediendo a cerrar el script..."
    ExitScript
fi
echo

# Borro los archivos residuales si el usuario así lo decide.
echo "¿Desea borrar los archivos residuales creados por el script? [S/N]: "
read selection

if [ ${selection} = "S" ]
then
    echo "Borrando los archivos residuales..."
    {
        rm -rf META-INF system
    } 2>/dev/null

    if [ ! -e META-INF ] && [ ! -e system ]
    then
        GBT "Operación completada exitosamente."
    else
        RBT "La operación no se pudo completar. Intente de nuevo."
    fi
else
    ExitScript
fi
echo

# Cierro el script.
ExitScript