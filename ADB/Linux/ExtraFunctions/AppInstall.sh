# Declaro el intérprete a utilizar.
#!/bin/bash

# Defino propiedades de la ventana.
resize -s 33 105 > /dev/null

# Importo funciones de otro archivo.
source Functions.sh

# Defino las opciones a utilizar.
menu_option_one() {
  echo "Introduzca en el campo correspondiente la ubicación del archivo APK a instalar."
  echo
  echo "Ejemplo: '/home/Usuario/Documentos/Aplicación.apk'."
  echo
  echo -n "Ubicación del archivo: "
  read ubicacion
  echo
  adb install $ubicacion
}

menu_option_two() {
  echo "Introduzca en los campos correspondientes las ubicaciones de los archivos APK correspondientes a la"
  echo "aplicación a instalar. Se pueden instalar 3 partes al mismo tiempo."
  echo
  echo -n "Ubicación del primer archivo: "
  read ubicacion1
  echo -n "Ubicación del segundo archivo: "
  read ubicacion2
  echo -n "Ubicación del tercer archivo: "
  read ubicacion3
  echo
  adb install-multiple $ubicacion1 $ubicacion2 $ubicacion3
}

menu_option_three() {
  echo "Introduzca en los campos correspondientes las ubicaciones de los archivos APK correspondientes a las"
  echo "aplicaciones a instalar. Se pueden instalar hasta 5 aplicaciones al mismo tiempo."
  echo
  echo -n "Ubicación del primer archivo: "
  read ubicacion1
  echo -n "Ubicación del segundo archivo: "
  read ubicacion2
  echo -n "Ubicación del tercer archivo: "
  read ubicacion3
  echo -n "Ubicación del cuarto archivo: "
  read ubicacion4
  echo -n "Ubicación del quinto archivo: "
  read ubicacion5
  echo
  adb install-multi-package $ubicacion1 $ubicacion2 $ubicacion3 $ubicacion4 $ubicacion5
}

# Defino el menú de selección de opciones.
until [ "$selection" = "0" ];
do   
  # Borro el contenido de la terminal. 
  clear

  # Imprimo el menú.
  Línea
  echo "En este apartado, usted podrá optar por elegir entre distintas opciones para instalar aplicaciones en"
  echo "su dispositivo mediante archivos APK."
  Línea
  echo
  echo "1. Instalar una aplicación.                           (adb install)"
  echo "2. Instalar una aplicación por partes (split APKs).   (adb install-multiple)"
  echo "3. Instalar múltiples aplicaciones.                   (adb install-multi-package)"
  echo "4. Volver al menú de manejo de aplicaciones."
  echo
  
  # Creo una entrada para recibir un valor elegido por el usuario.
  echo -n "Escriba el número correspondiente a la operación que desee realizar y presione ENTER: "
  read selection
  Línea
  
  # Determino la opción a ejecutar según el número elegido por el usuario.
  case $selection in
    # Las funciones "press_enter" e "incorrect_selection" se explican en Functions.sh.
    1) menu_option_one; press_enter;;
    2) menu_option_two; press_enter;;
    3) menu_option_three; press_enter;;
    4) clear; exit;;
    *) clear; incorrect_selection; press_enter;;
  esac
done