# Defino el intérprete a utilizar.
#!/bin/bash

# Defino los comandos a ejecutar.
comandos () {
    # Defino las funciones locales a utilizar.
    BT() {
        # BT es el acrónimo para Bold Text.
        # Esta función imprime texto en negritas.
        echo -e "\e[1m$1\e[0m"
    }

    GBT() {
        # GBT es el acrónimo para Green Bold Text.
        # Esta función imprime texto blanco, sobre un fondo verde y en negritas.
        echo -e "\e[1;42m$1\e[0m"
    }

    YT() {
        # YT es el acrónimo para Yellow Text.
        # Esta función solo imprime texto amarillo.
        echo -e "\e[1;33m$1\e[0m"
    }
    
    # Imprimo una cabecera.
    YT "--------------------------------------------------------------------------------"
    echo "                          Actualizador de programas                          "
    BT "                          -------------------------                          "
    YT "--------------------------------------------------------------------------------"
    
    # Cancelo cualquier transacción actual que pueda haber en proceso.
    GBT "Cancelando cualquier posible transacción en curso."
    rpm-ostree cancel
    echo
    
    # Chequeo por actualizaciones de la distribución.
    GBT "Actualizando la imagen de la distribución."
    rpm-ostree update
    echo

    # Chequeo por actualizaciones de Flatpak.
    GBT "Actualizando las aplicaciones de Flatpak."
    flatpak update -y
    echo
    
    # Actualizo los paquetes del contenedor.
    GBT "Actualizando los paquetes del contenedor."
    toolbox run -c lucas sudo dnf -y update
    read -n1 -t3
    
    # Limpio la pantalla.
    clear
    
    # Cambio el tamaño de la terminal para poder visualizar correctamente el menú a continuación.
    printf '\e[8;8;89t'
    
    # Pregunto al usuario que le gustaría hacer luego de que se instalen las actualizaciones.
    until [ "$selection" = "0" ];
    do   
        # Imprimo el menú con las opciones.
        YT "----------------------------------------------------------------------------------------"
        echo "¿Qué le gustaría hacer?"
        YT "----------------------------------------------------------------------------------------"
        echo "1. Apagar el dispositivo."
        echo "2. Reiniciar el dispositivo."
        echo "3. SALIR."
        echo ""
        
        # Creo una entrada para recibir un valor elegido por el usuario.
        echo -n "Escriba el número correspondiente a la operación que desee realizar y presione ENTER: "
        read selection
        echo
        
        # Determino la opción a ejecutar según el número elegido por el usuario.
        case $selection in
            1) clear; systemctl poweroff;;
            2) clear; systemctl reboot;;
            3) clear; exit;;
        esac 
    done

    # Mantengo la terminal abierta luego de ejecutar los comandos necesarios.
    # $SHELL
}

# Hago que los comandos sean universalmente utilizables.
export -f comandos

# Comando para ejecutar la función luego de abrir una ventana de la terminal.
gnome-terminal -e "bash -c 'comandos'"

# Créditos
<< 'CREDITS'
* Ask Ubuntu - User 'Radu Rădeanu' - Base idea for the script.
  (https://askubuntu.com/questions/405176/shortcut-to-open-terminal-and-run-some-commands)
* Ask Ubuntu - User 'Seth' - How to execute a script from a .desktop file or a key combo.
  (https://askubuntu.com/questions/398666/execute-sh-script-from-desktop-file)
* Server Fault - User 'ewwhite' - How to automatically answer yes when using yum install.
  (https://serverfault.com/questions/442088/how-do-you-answer-yes-for-yum-install-automatically) 
* ManKier - Man page for flatpak update.
  (https://www.mankier.com/1/flatpak-update)
CREDITS
