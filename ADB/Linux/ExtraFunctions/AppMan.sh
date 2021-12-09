# Declaro el intérprete a utilizar

#!/bin/bash

# Defino propiedades de la ventana

resize -s 33 105 > /dev/null

# Defino las opciones a utilizar

menu_option_one() {
  /bin/bash $(pwd)/ExtraFunctions/AppInstall.sh
}

menu_option_two() {
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "En este apartado, usted podrá optar por "desinstalar" aplicaciones de su dispositivo. Tenga en cuenta"
  echo "que no es posible borrar completamente una aplicación del dispositivo, sino para el usuario actual, por"
  echo "lo que esta puede ser restaurada con un reseteo, o utilizando la siguiente opción de este apartado."
  echo
  echo "Para esto, se requiere el "ID" de la aplicación que quiera desinstalar. Para obtenerlo, puede descargar"
  echo "alguna aplicación de la Play Store o la Web, como "Package Name Viewer 2.0", o utilizar alguna de las"
  echo "opciones del sexto apartado del conjunto de opciones extra."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "ID de la aplicación: "
  read ID
  echo
  adb shell pm uninstall --user 0 $ID
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "¿Necesita desinstalar otra aplicación? [S/N]: "
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
  echo "En este apartado, usted podrá optar por "reinstalar" aquellas aplicaciones que haya removido de su"
  echo "dispositivo utilizando la opción anterior."
  echo
  echo "Se requiere el ID de la aplicación desinstalada."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "ID de la aplicación: "
  read ID
  echo
  adb shell cmd package install-existing $ID
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "¿Necesita reinstalar otra aplicación? [S/N]: "
  read selection

  if [ ${selection} = "S" ]
  then
   menu_option_three
  else
   clear
  fi
}

menu_option_four() {
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "En este apartado, usted podrá optar por desactivar aplicaciones de su dispositivo. Tenga en cuenta que"
  echo "a diferencia de la supresión de aplicaciones mediante el sistema operativo, las que son desactivadas"
  echo "mediante este método solo pueden ser devueltas a la normalidad a través del mismo."
  echo
  echo "Se requiere el ID de la aplicación a desactivar."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "ID de la aplicación: "
  read ID
  echo
  adb shell pm disable-user --user 0 $ID
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "¿Necesita desactivar otra aplicación? [S/N]: "
  read selection

  if [ ${selection} = "S" ]
  then
   menu_option_four
  else
   clear
  fi
}

menu_option_five() {
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "En este apartado, usted podrá optar por reactivar aquellas aplicaciones que haya desactivado utilizando"
  echo "la opción anterior."
  echo
  echo "Se requiere el ID de la aplicación a reactivar."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "ID de la aplicación: "
  read ID
  echo
  adb shell pm enable $ID
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "¿Necesita reactivar otra aplicación? [S/N]: "
  read selection

  if [ ${selection} = "S" ]
  then
   menu_option_five
  else
   clear
  fi
}

menu_option_six() {
 /bin/bash $(pwd)/ExtraFunctions/AppInfo.sh
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
  echo "En este apartado, usted podrá optar por realizar una serie de operaciones para administrar las"
  echo "aplicaciones del dispositivo."
  echo "-------------------------------------------------------------------------------------------------------"
  echo
  echo "1. Instalar una aplicacion."
  echo "2. Desinstalar una aplicacion para el usuario actual.    (adb shell pm uninstall)"
  echo "3. Restaurar una aplicacion desinstalada previamente.    (adb shell cmd package install-existing)"
  echo "4. Deshabilitar una aplicacion.                          (adb shell pm disable-user)"
  echo "5. Habilitar una aplicacion deshabilitada previamente.   (adb shell pm enable)"
  echo "6. Obtener informacion de las aplicaciones instaladas."
  echo "7. Volver al menú principal."
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
      4) clear; menu_option_four; press_enter;;
      5) clear; menu_option_five; press_enter;;
      6) clear; menu_option_six; press_enter;;
      7) clear; exit;;
      *) clear; incorrect_selection; press_enter;;
  esac
done