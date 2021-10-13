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
  echo "En este apartado, usted podrá optar por obtener cierta información de las aplicaciones instaladas en su"
  echo "dispositivo."
  echo "-------------------------------------------------------------------------------------------------------"
  echo
  echo "1. Obtener la ruta de una aplicacion.                               (adb shell pm path)"
  echo "2. Obtener un listado de aplicaciones y sus rutas.                  (adb shell pm list packages -f)"
  echo "3. Obtener un listado de aplicaciones desactivadas y sus rutas.     (adb shell pm list packages -d -f)"
  echo "4. Obtener un listado de aplicaciones buscando por palabra clave.   (adb shell pm list packages -f)"
  echo "5. Volver al menú de manejo de aplicaciones."
  echo
  
  # Creo una entrada para recibir un valor elegido por el usuario
  echo -n "Escriba el número correspondiente a la operación que desee realizar y presione ENTER: "
  read selection
  echo

  # Determino la opción a ejecutar según el número elegido por el usuario
  case $selection in
      1) menu_option_one; press_enter;;
      2) menu_option_two; press_enter;;
      3) menu_option_three; press_enter;;
      4) menu_option_four; press_enter;;
      5) clear; exit;;
      *) clear; incorrect_selection; press_enter;;
  esac
done