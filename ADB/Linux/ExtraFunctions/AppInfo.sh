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

	# Imprimo el texto.
	Línea
	echo "Introduzca en el campo correspondiente la ID de la aplicación cuya ruta quiere averiguar."
	Línea

	# Tomo una ID introducida por el usuario, y la uso para ejecutar el comando y guardar la lista.
	echo -n "ID de la aplicación: "
	read ID
	NV "$ID"
	echo
	{
		# Defino una variable como la salida de un comando.
		IDPATH=$(adb shell pm path $ID)

		# Con la variable definida, la muestro coloreada con una función.
		echo "La ruta de la aplicación indicada es: "
		YBT "${IDPATH}"
	} 2>/dev/null
}

menu_option_two() {
	# Defino las variables locales a utilizar.
	Apps=Apps.txt

	# Borro el contenido de la terminal.
	clear

	# Imprimo el texto.
	Línea
	echo "A continuación, obtendrá una lista de las aplicaciones instaladas en su dispositivo tanto por el"
	echo "fabricante como por usted mismo. Los directorios escaneados son system/app, /priv-app/ y data/app."
	echo
	echo "Una vez que presione cualquier tecla, se imprimirá la lista y se la guardará en un archivo de texto en"
	echo "su carpeta Documentos, ya que será extensa."
	Línea

	# Luego de una pausa, rota por el usuario a voluntad, se ejecuta el comando y se guarda la lista.
	# En caso negativo, se esconde el código de error para imprimir un texto personalizado que lo reemplace.
	read -n1
	{
		adb shell pm list packages -f > $Apps
	} 2>/dev/null

	# Chequeo si existe el archivo, y, si existe, ofrezco la opción de poder abrirlo directamente.
	OIE "$Apps"
}

menu_option_three() {
	# Defino el nombre de las variables locales a utilizar.
	AppsDes=AppsDes.txt

	# Borro el contenido de la terminal.
	clear

	# Imprimo el texto.
	Línea
	echo "A continuación, obtendrá una lista de las aplicaciones de su dispositivo que se encuentran suprimidas."
	echo
	echo "Una vez que presione cualquier tecla, se imprimirá la lista y se la guardara en un archivo de texto en"
	echo "su carpeta Documentos, ya que será extensa."
	Línea

	# Luego de una pausa, rota por el usuario a voluntad, se ejecuta el comando y se guarda la lista.
	# En caso negativo, se esconde el código de error para imprimir un texto personalizado que lo reemplace.
	read -n1
	{
		adb shell pm list packages -d -f > $AppsDes
	} 2>/dev/null

	# Chequeo si existe el archivo, y, si existe, ofrezco la opción de poder abrirlo directamente.
	OIE "$AppsDes"
}

menu_option_four() {
	# Defino las variables locales a utilizar.
	AppsClave=AppsClave.txt

	# Borro el contenido de la terminal.
	clear

	# Imprimo el texto.
	Línea
	echo "Introduzca en el campo correspondiente alguna palabra que quiera utilizar para poder identificar el ID"
	echo "de alguna aplicación, junto con su ruta."
	echo
	echo "Una vez que introduzca la palabra, se imprimirá la lista y se la guardará en su carpeta Documentos. De"
	echo "estar vacío el archivo, es porque no se encontró nada y deberá probar con otra clave."
	Línea

	# Tomo una palabra clave introducida por el usuario, y la uso para ejecutar el comando y guardar la lista.
	# En caso negativo, se esconde el código de error para imprimir un texto personalizado que lo reemplace.
	echo -n "Palabra clave: "
	read clave
	NV "$clave"
	echo
	{
		adb shell pm list packages -f $clave > $AppsClave
	} 2>/dev/null

	# Chequeo si existe el archivo, y, si existe, ofrezco la opción de poder abrirlo directamente.
	OIE "$AppsClave"
}

# Defino el menú de selección de opciones.
until [ "$selection" = "0" ];
do
	# Borro el contenido de la terminal. 
	clear

	# Imprimo el menú.
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
