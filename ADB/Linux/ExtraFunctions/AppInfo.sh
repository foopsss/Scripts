# ACLARACIÓN:
# Las funciones Línea, resize_window, NV, YBT, OIE, read_selection, press_enter e incorrect_selection son funciones importadas del archivo Functions.sh.
# El funcionamiento de estas se encuentra explicado ahí.

# Declaro el intérprete a utilizar.
#!/bin/bash

# Importo las funciones a utilizar de otro archivo.
source Functions.sh

# Defino las propiedades de la ventana.
resize_window

# Defino las opciones a utilizar.
menu_option_one() {
	# Borro el contenido de la terminal.
	clear

	# Imprimo el texto a mostrar por pantalla.
	Línea
	echo "Introduzca en el campo correspondiente la ID de la aplicación cuya ruta quiere averiguar."
	Línea

	# Tomo una ID introducida por el usuario.
	echo -n "ID de la aplicación: "
	read ID
	
	# Chequeo si la variable 'ID' contiene algún valor o no.
	if [ -z $ID ]
	then
		# Si la variable no recibe ningún valor, se utiliza la función NV (Null Value) para informar al usuario y abortar la operación.
		NV "$ID"
	else
		# Si la variable recibe un valor, muestro por pantalla la ruta de la aplicación solicitada.
		echo
		{
			# Defino la variable 'IDPATH' como la salida de un comando.
			IDPATH=$(adb shell pm path $ID)

			# Con la variable 'IDPATH' definida, la muestro coloreada con una función.
			echo "La ruta de la aplicación indicada es: "
			YBT "${IDPATH}"
		} 2>/dev/null
	fi
}

menu_option_two() {
	# Defino las variables locales a utilizar.
	Apps=Apps.txt

	# Borro el contenido de la terminal.
	clear

	# Imprimo el texto a mostrar por pantalla.
	Línea
	echo "A continuación, obtendrá una lista de las aplicaciones instaladas en su dispositivo tanto por el"
	echo "fabricante como por usted mismo. Los directorios escaneados son system/app, /priv-app/ y data/app."
	echo
	echo "Una vez que presione cualquier tecla, se imprimirá la lista y se la guardará en un archivo de texto en"
	echo "su carpeta Documentos, ya que será extensa."
	Línea

	# Luego de una pausa, rota por el usuario a voluntad, se ejecuta el comando y se guarda la lista.
	# De no poder generarse la lista, se esconde el código de error para imprimir un texto personalizado que lo reemplace.
	read -n1
	{
		adb shell pm list packages -f > $Apps
	} 2>/dev/null

	# Chequeo si existe la lista, y, si existe, ofrezco la opción de poder abrirla directamente.
	OIE "$Apps"
}

menu_option_three() {
	# Defino el nombre de las variables locales a utilizar.
	AppsDes=AppsDes.txt

	# Borro el contenido de la terminal.
	clear

	# Imprimo el texto a mostrar por pantalla.
	Línea
	echo "A continuación, obtendrá una lista de las aplicaciones de su dispositivo que se encuentran suprimidas."
	echo
	echo "Una vez que presione cualquier tecla, se imprimirá la lista y se la guardara en un archivo de texto en"
	echo "su carpeta Documentos, ya que será extensa."
	Línea

	# Luego de una pausa, rota por el usuario a voluntad, se ejecuta el comando y se genera la lista.
	# De no poder generarse la lista, se esconde el código de error para imprimir un texto personalizado que lo reemplace.
	read -n1
	{
		adb shell pm list packages -d -f > $AppsDes
	} 2>/dev/null

	# Chequeo si existe la lista, y, si existe, ofrezco la opción de poder abrirla directamente.
	OIE "$AppsDes"
}

menu_option_four() {
	# Defino las variables locales a utilizar.
	AppsClave=AppsClave.txt

	# Borro el contenido de la terminal.
	clear

	# Imprimo el texto a mostrar por pantalla.
	Línea
	echo "Introduzca en el campo correspondiente alguna palabra que quiera utilizar para poder identificar el ID"
	echo "de alguna aplicación, junto con su ruta."
	echo
	echo "Una vez que introduzca la palabra, se imprimirá la lista y se la guardará en su carpeta Documentos. De"
	echo "estar vacío el archivo, es porque no se encontró nada y deberá probar con otra clave."
	Línea

	# Tomo una palabra clave introducida por el usuario.
	echo -n "Palabra clave: "
	read clave
	echo 
	
	# Chequeo si la variable 'clave' contiene algún valor o no.
	if [ -z $clave ]
	then
		# Si la variable no recibe ningún valor, se utiliza la función NV (Null Value) para informar al usuario y abortar la operación.
		NV "$clave"
	else
		# Si la variable recibe un valor, ejecuto el comando y genero la lista.
		# De no poder generarse la lista, se esconde el código de error para imprimir un texto personalizado que lo reemplace.
		{
			adb shell pm list packages -f $clave > $AppsClave
		} 2>/dev/null
		
		# Chequeo si existe la lista, y, si existe, ofrezco la opción de poder abrirla directamente.
		OIE "$AppsClave"
	fi
}

# Defino el menú de selección de opciones.
until [ "$selection" = "0" ];
do
	# Borro el contenido de la terminal. 
	clear

	# Imprimo el menú a mostrar por pantalla.
	Línea
	echo "En este apartado, usted podrá optar por obtener cierta información de las aplicaciones instaladas en su"
	echo "dispositivo."
	Línea
	echo
	echo "1. Obtener la ruta de una aplicacion.                               (adb shell pm path)"
	echo "2. Obtener un listado de aplicaciones y sus rutas.                  (adb shell pm list packages -f)"
	echo "3. Obtener un listado de aplicaciones desactivadas y sus rutas.     (adb shell pm list packages -d -f)"
	echo "4. Obtener un listado de aplicaciones buscando por palabra clave.   (adb shell pm list packages -f)"
	echo "5. Volver al menú de manejo de aplicaciones."
	echo

	# Creo una entrada para recibir un valor elegido por el usuario.
	read_selection

	# Determino la opción a ejecutar según el número elegido por el usuario.
	case $selection in
		1) menu_option_one; press_enter;;
		2) menu_option_two; press_enter;;
		3) menu_option_three; press_enter;;
		4) menu_option_four; press_enter;;
		5) clear; exit;;
		*) clear; incorrect_selection; press_enter;;
	esac
done