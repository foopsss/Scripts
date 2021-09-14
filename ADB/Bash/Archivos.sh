# Declaro el intérprete a utilizar

#!/bin/bash

# Defino las opciones a utilizar

menu_option_one() {
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "Para copiar un archivo hacia el dispositivo, por favor, indique su ubicacion incluyendo el nombre de"
  echo "este, y la ubicacion en el dispositivo a la cual le gustaria copiarlo."
  echo
  echo "Ejemplo: "adb push /home/usuario/Documentos/Texto.txt/ /sdcard/Textos/"."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "Ubicacion del archivo: "
  read ruta1
  echo -n "Ubicacion a la cual copiar: "
  read ruta2
  echo
  adb push $ruta1 $ruta2
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "Necesita copiar otro archivo? [S/N]: "
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
  echo "Para copiar un archivo desde el dispositivo, por favor, indique su ubicacion incluyendo el nombre de"
  echo "este, y la ubicacion en el ordenador a la cual le gustaria copiarlo."
  echo
  echo "Ejemplo: "adb pull /sdcard/Textos/Texto.txt/ /home/usuario/Documentos/"."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "Ubicacion del archivo: "
  read ruta1
  echo -n "Ubicacion a la cual copiar: "
  read ruta2
  echo
  adb pull $ruta1 $ruta2
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "Necesita copiar otro archivo? [S/N]: "
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
  echo "3. Volver al menu principal."
  echo
  
  # Creo una entrada para recibir un valor elegido por el usuario
  echo -n "Escriba el numero correspondiente a la operacion que desee realizar y presione ENTER: "
  read selection
  echo

  # Determino la opcion a ejecutar segun el numero elegido por el usuario
  case $selection in
      1) clear; menu_option_one; press_enter;;
      2) clear; menu_option_two; press_enter;;
      3) clear; exit;;
      *) clear; incorrect_selection; press_enter;;
  esac
done