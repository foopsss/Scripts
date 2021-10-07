# Declaro el intérprete a utilizar

#!/bin/bash

# Defino propiedades de la ventana

resize -s 33 105 > /dev/null

# Defino las opciones a utilizar

menu_option_one() {
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "Para copiar un archivo hacia el dispositivo, por favor, indique su ubicación incluyendo el nombre de"
  echo "este, y la ubicación en el dispositivo a la cual le gustaría copiarlo."
  echo
  echo "Ejemplo: "adb push /home/Usuario/Documentos/Texto.txt/ /sdcard/Textos/"."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "Ubicación del archivo: "
  read ubicacion1
  echo -n "Ubicación a la cual copiar: "
  read ubicacion2
  echo
  adb push $ubicacion1 $ubicacion2
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "¿Necesita copiar otro archivo? [S/N]: "
  read selection

  if [ ${selection} = "S" ]
  then
   menu_option_one
  else
   clear
  fi
}

menu_option_two() {
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "Para copiar un archivo desde el dispositivo, por favor, indique su ubicación incluyendo el nombre de"
  echo "este, y la ubicación en el ordenador a la cual le gustaría copiarlo."
  echo
  echo "Ejemplo: "adb pull /sdcard/Textos/Texto.txt/ /home/Usuario/Documentos/"."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "Ubicación del archivo: "
  read ubicacion1
  echo -n "Ubicación a la cual copiar: "
  read ubicacion2
  echo
  adb pull $ubicacion1 $ubicacion2
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "¿Necesita copiar otro archivo? [S/N]: "
  read selection

  if [ ${selection} = "S" ]
  then
   menu_option_two
  else
   clear
  fi
}

press_enter() {
  echo ""
  echo -n "Presione ENTER para continuar."
  read
  clear
}

incorrect_selection() {
  echo "¡Selección incorrecta! Por favor, intente de nuevo."
}

# Defino el menú de selección de opciones

until [ "$selection" = "0" ];
do   
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "En este apartado, usted podrá optar por copiar archivos desde o hacia su dispositivo móvil."
  echo "-------------------------------------------------------------------------------------------------------"
  echo
  echo "1. Copiar archivos hacia el dispositivo.                      (adb push)"
  echo "2. Copiar archivos desde el dispositivo hacia el ordenador.   (adb pull)"
  echo "3. Volver al menú principal."
  echo
  
  # Creo una entrada para recibir un valor elegido por el usuario
  echo -n "Escriba el número correspondiente a la operación que desee realizar y presione ENTER: "
  read selection
  echo

  # Determino la opción a ejecutar según el número elegido por el usuario
  case $selection in
      1) clear; menu_option_one; press_enter;;
      2) clear; menu_option_two; press_enter;;
      3) clear; exit;;
      *) clear; incorrect_selection; press_enter;;
  esac
done