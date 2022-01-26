# Declaro el intérprete a utilizar.
#!/bin/bash

# Defino las funciones a utilizar en otros archivos.
resize_window() {
	# Esta función utiliza una secuencia para definir el tamaño de la ventana.
	printf '\e[8;33;105t'
}
export -f resize_window

press_enter() {
	# Cuando se termina de ejecutar una acción, esta función muestra un mensaje para continuar.
    echo
    echo -n "Presione ENTER para continuar."
    read
    clear
}
export -f press_enter

incorrect_selection() {
	# En caso de que la selección realizada no sea la correcta, esta función muestra un mensaje de error.
    RBT "¡Selección incorrecta! Por favor, intente de nuevo."
}
export -f incorrect_selection

read_selection() {
	# Esta función presenta el diálogo para introducir un valor.
    echo -n "Escriba el número correspondiente a la operación que desee realizar y presione ENTER: "
    read selection
    Línea
}
export -f read_selection

Línea() {
	# Esta función imprime una línea de guiones.
    echo "-------------------------------------------------------------------------------------------------------"
}
export -f Línea

GBT() {
	# GBT es el acrónimo para Green Bold Text.
	# Esta función imprime texto blanco, sobre un fondo verde y en negritas.
    echo -e "\e[1;42m$1\e[0m"
}
export -f GBT

RBT() {
	# RBT es el acrónimo para Red Bold Text.
	# Esta función imprime texto blanco, sobre un fondo rojo y en negritas.
    echo -e "\e[1;41m$1\e[0m"
}
export -f RBT

YBT() {
	# YBT es el acrónimo para Yellow Bold Text.
	# Esta función imprime texto blanco, sobre un fondo rojo y en negritas.
    echo -e "\e[1;43m$1\e[0m"
}
export -f YBT

BBT() {
	# BBT es el acrónimo para Blue Bold Text.
	# Esta función imprime texto blanco, sobre un fondo azul y en negritas.
    echo -e "\e[1;44m$1\e[0m"
}
export -f BBT

YT() {
	# YT es el acrónimo para Yellow Text.
	# Esta función solo imprime texto amarillo.
    echo -e "\e[1;33m$1\e[0m"
}
export -f YT

BT() {
	# BT es el acrónimo para Bold Text.
	# Esta función imprime texto en negritas.
    echo -e "\e[1m$1\e[0m"
}
export -f BT

UT() {
	# UT es el acrónimo para Underlined Text.
	# Esta función imprime texto subrayado.
    echo -e "\e[3m$1\e[0m"
}
export -f UT

NV() {
	# NV es el acrónimo para Null Value.
	# Esta función chequea por la posible nulidad de una variable dada, para avisar al usuario de ser necesario.
    if [ -n "$1" ]
    then
        GBT "Se ha introducido un valor."
    else
        BBT "NO se introdujo ningún valor."
    fi
}
export -f NV

OIE() {
	# OIE es el acrónimo para Open If Existing.
	# Esta función chequea por la existencia de un archivo y ofrece abrirlo, de ser posible.
    if [ -e "$1" ]
    then
        GBT "El archivo se ha creado exitosamente en la ubicación actual."
        read -n1 -t1

        # Si el archivo existe, ofrezco para abrirlo directamente.
        Línea
        echo -n "¿Le gustaría abrir el archivo recién generado? [S/N]: "
        read selection

        if [ ${selection} = "S" ]
        then
        	# Si no usas la versión de Flatpak de Gedit, comentá la línea de abajo y luego retirá el numeral de la siguiente.
        	flatpak run org.gnome.gedit $1
        	# gedit $1
        else
            clear
        fi
    else
        RBT "El archivo NO ha podido ser creado de forma exitosa."
    fi
}
export -f OIE
