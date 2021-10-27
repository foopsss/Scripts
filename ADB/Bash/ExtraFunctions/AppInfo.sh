# Declaro el intérprete a utilizar

#!/bin/bash

# Defino propiedades de la ventana

resize -s 33 105 > /dev/null

# Defino las opciones a utilizar

menu_option_one() {
  echo "Introduzca en el campo correspondiente la ID de la aplicación cuya ruta quiere averiguar."
  echo
  echo -n "ID de la aplicación: "
  read ID
  echo
  adb shell pm path ID
}

menu_option_two() {
  echo "A continuación, obtendrá una lista de las aplicaciones instaladas en su dispositivo tanto por el"
  echo "fabricante como por usted mismo. Los directorios escaneados son system/app, /priv-app/ y data/app."
  echo
  echo "Una vez que presione cualquier tecla, se imprimirá la lista y se la guardará en un archivo de texto en"
  echo "su carpeta Documentos, ya que será extensa."
  read -n1
  adb shell pm list packages -f > /home/$(whoami)/Documentos/Apps.txt
  if [ -e /home/$(whoami)/Documentos/Apps.txt ]
  then
   echo "El archivo se encuentra en la carpeta Documentos."
  else
   echo "El archivo NO se encuentra en la carpeta Documentos."
  fi
}

menu_option_three() {
  echo "A continuación, obtendrá una lista de las aplicaciones de su dispositivo que se encuentran suprimidas."
  echo
  echo "Una vez que presione cualquier tecla, se imprimirá la lista y se la guardara en un archivo de texto en"
  echo "su carpeta Documentos, ya que será extensa."
  read -n1
  adb shell pm list packages -d -f > /home/$(whoami)/Documentos/AppsDes.txt
  if [ -e /home/$(whoami)/Documentos/AppsDes.txt ]
  then
   echo "El archivo se encuentra en la carpeta Documentos."
  else
   echo "El archivo NO se encuentra en la carpeta Documentos."
  fi
}

menu_option_four() {
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "Introduzca en el campo correspondiente alguna palabra que quiera utilizar para poder identificar el ID"
  echo "de alguna aplicación, junto con su ruta."
  echo
  echo "Una vez que introduzca la palabra, se imprimirá la lista y se la guardará en su carpeta Documentos. De"
  echo "estar vacío el archivo, es porque no se encontró nada y deberá probar con otra clave."
  echo "-------------------------------------------------------------------------------------------------------"
  echo -n "Palabra clave: "
  read clave
  echo
  adb shell pm list packages -f "$clave" > /home/$(whoami)/Documentos/AppsClave.txt
  if [ -e /home/$(whoami)/Documentos/AppsClave.txt ]
  then
   echo "El archivo se encuentra en la carpeta Documentos."
  else
   echo "El archivo NO se encuentra en la carpeta Documentos."
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
  echo "-------------------------------------------------------------------------------------------------------"

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