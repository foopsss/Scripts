# ACLARACIÓN:
# Las funciones resize_window, Línea, read_selection, press_enter e incorrect_selection son funciones importadas del archivo Functions.sh.
# El funcionamiento de estas se encuentra explicado ahí.

# Declaro el intérprete a utilizar.
#!/bin/bash

# Importo las funciones a utilizar de otro archivo.
source Functions.sh

# Defino las propiedades de la ventana.
resize_window

# Defino las opciones a utilizar.
menu_option_one() {
	# Imprimo el texto a mostrar por pantalla.
	echo "Introduzca en el campo correspondiente la ubicación del archivo APK a instalar."
	echo
	echo "Ejemplo: '/home/Usuario/Documentos/Aplicación.apk'."
	echo
	
	# Tomo una ubicación introducida por el usuario.
	echo -n "Ubicación del archivo: "
	read ubicacion
	echo
	
	# Chequeo si la variable 'ubicacion' contiene algún valor o no.
	if [ -z $ubicacion ]
	then
		# Si la variable no recibe ningún valor, se utiliza la función NV (Null Value) para informar al usuario y abortar la operación.
		NV "$ubicacion"
	else
		# Si la variable recibe un valor, ejecuto el comando con normalidad.
		adb install $ubicacion
	fi
}

menu_option_two() {
	# Imprimo el texto a mostrar por pantalla.
	echo "Introduzca en los campos correspondientes las ubicaciones de los archivos APK correspondientes a la"
	echo "aplicación a instalar. Se pueden instalar 3 partes al mismo tiempo."
	echo
	
	# Tomo las ubicaciones introducidas por el usuario.
	echo -n "Ubicación del primer archivo: "
	read ubicacion
	echo -n "Ubicación del segundo archivo: "
	read ubicacion1
	echo -n "Ubicación del tercer archivo: "
	read ubicacion2
	echo
	
	# Ejecuto el comando.
	adb install-multiple $ubicacion $ubicacion1 $ubicacion2
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
