# Declaro el intérprete a utilizar

#!/bin/bash

# Defino propiedades de la ventana

resize -s 33 105 > /dev/null

# Defino las opciones a utilizar

menu_option_one() {
  /bin/bash 
}

menu_option_two() {
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "En este apartado, usted podrá optar por instalar un archivo .zip mediante el modo Recovery."
  echo
  echo "Para ello, por favor, indique su ubicación incluyendo el nombre de este."
  echo "Ejemplo: "/home/Usuario/Documentos/Ejemplo.zip/"."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "Ubicación del archivo: "
  read ubicacion
  echo
  adb sideload $ubicacion
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "¿Necesita instalar otro archivo? [S/N]: "
  read selection

  if [ ${selection} = "S" ]
  then
   menu_option_two
  else
   clear
  fi
}

menu_option_three() {
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "En este apartado, usted podrá optar por ejecutar cualquier otro tipo de comando no incluido en esta"
  echo "herramienta."
  echo
  echo "Para ello, por favor, indique el comando a ejecutar en el campo correspondiente."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "Comando a ejecutar: "
  read comando
  echo
  $comando
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "¿Necesita ejecutar otro comando? [S/N]: "
  read selection

  if [ ${selection} = "S" ]
  then
   menu_option_three
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
  echo "En este apartado, usted podrá optar por elegir entre una serie de comandos adicionales para ejecutar."
  echo "-------------------------------------------------------------------------------------------------------"
  echo
  echo "1. Administrar las aplicaciones instaladas."
  echo "2. Instalar un archivo .zip utilizando el recovery.   (adb sideload)"
  echo "3. Ejecutar un comando propio."
  echo "4. Volver al menú principal."
  echo
  
  # Creo una entrada para recibir un valor elegido por el usuario
  echo -n "Escriba el número correspondiente a la operación que desee realizar y presione ENTER: "
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