# Declaro el intérprete a utilizar

#!/bin/bash

# Defino propiedades de la ventana

resize -s 33 105 > /dev/null

# Defino las opciones a utilizar

menu_option_one() {
  fastboot format system
}

menu_option_two() {
  fastboot format userdata
}

menu_option_three() {
  fastboot format cache
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
  echo "En este apartado, usted podra optar por formatear ciertas particiones de su dispositivo utilizando el"
  echo "modo Fastboot."
  echo "-------------------------------------------------------------------------------------------------------"
  echo
  echo "1. Formatear la particion /system.   (fastboot format system)"
  echo "2. Formatear la particion /data.     (fastboot format userdata)"
  echo "3. Formatear la particion /cache.    (fastboot format cache)"
  echo "4. Volver al menu principal."
  echo
  
  # Creo una entrada para recibir un valor elegido por el usuario
  echo -n "Escriba el numero correspondiente a la operacion que desee realizar y presione ENTER: "
  read selection
  echo

  # Determino la opción a ejecutar según el número elegido por el usuario
  case $selection in
      1) clear; menu_option_one; press_enter;;
      2) clear; menu_option_two; press_enter;;
      3) clear; menu_option_three; press_enter;;
      4) clear; exit;;
      *) clear; incorrect_selection; press_enter;;
  esac
done