# Declaro el intérprete a utilizar

#!/bin/bash

# Defino propiedades de la ventana

resize -s 33 105 > /dev/null

# Defino las opciones a utilizar

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
  echo "En este apartado, usted podra optar por elegir entre una serie de comandos adicionales para ejecutar."
  echo "-------------------------------------------------------------------------------------------------------"
  echo
  echo "1. Administrar las aplicaciones instaladas."
  echo "2. Instalar un archivo .zip utilizando el recovery.   (adb sideload)"
  echo "3. Ejecutar un comando propio."
  echo "4. Volver al menú principal."
  echo
  
  # Creo una entrada para recibir un valor elegido por el usuario
  echo -n "Escriba el numero correspondiente a la operacion que desee realizar y presione ENTER: "
  read selection
  echo

  # Determino la opcion a ejecutar segun el numero elegido por el usuario
  case $selection in
      1) clear; menu_option_one; press_enter;;
      2) clear; menu_option_two; press_enter;;
      3) clear; menu_option_three; press_enter;;
      4) clear; exit;;
      *) clear; incorrect_selection; press_enter;;
  esac
done