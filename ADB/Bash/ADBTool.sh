# Declaro el intérprete a utilizar

#!/bin/bash

# Defino propiedades de la ventana

resize -s 33 105 > /dev/null

# Defino las opciones a utilizar

menu_option_one() {
  adb devices
}

menu_option_two() {
  echo "¡Reiniciando!"
  adb reboot
}

menu_option_three() {
  echo "¡Reiniciando!"
  adb reboot recovery
}

menu_option_four() {
  echo "¡Reiniciando!"  
  adb reboot bootloader
}

menu_option_five() {
  /bin/bash Archivos.sh
}

menu_option_six() {
  fastboot devices
}

menu_option_seven() {
  fastboot reboot 
}

menu_option_eight() {
  fastboot reboot recovery
}

menu_option_nine() {
  /bin/bash Format.sh
}

menu_option_ten() {
  /bin/bash Extra.sh
}

menu_option_eleven() {
  /bin/bash Créditos.sh
}

menu_option_twelve() {
  adb kill-server
  clear
  exit
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

# Defino el menú de opciones a utilizar

until [ "$selection" = "0" ];
do   
  clear
  echo "-------------------------------------------------------------------------------------------------------"
  echo "Bienvenido a mi herramienta para usar ADB y Fastboot."
  echo "Espero que encuentres esta herramienta de utilidad y te haga el uso de ADB más fácil."
  echo "-------------------------------------------------------------------------------------------------------"
  echo "Bienvenido $(whoami), hoy es $(date)"
  echo "-------------------------------------------------------------------------------------------------------"
  echo
  echo "ADB"
  echo "---"
  echo
  echo "1. Comprobar si el ordenador reconoce el dispositivo.    (adb devices)"
  echo "2. Reiniciar el dispositivo.                             (adb reboot)"
  echo "3. Reiniciar el dispositivo en modo Recovery.            (adb reboot recovery)"
  echo "4. Reiniciar el dispositivo en modo Fastboot/Descarga.   (adb reboot bootloader)"
  echo "5. Realizar operaciones con archivos."
  echo
  echo "FASTBOOT"
  echo "--------"
  echo
  echo "6. Comprobar si el ordenador reconoce el dispositivo.    (fastboot devices)"
  echo "7. Reiniciar el dispositivo.                             (fastboot reboot)"
  echo "8. Reiniciar el dispositivo en modo Recovery.            (fastboot reboot recovery)"
  echo "9. Formatear particiones del dispositivo.                (fastboot format)"
  echo
  echo "MISCELANEO"
  echo "----------"
  echo
  echo "10. Elegir más opciones."
  echo "11. Créditos."
  echo "12. SALIR."
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
      7) clear; menu_option_seven; press_enter;;
      8) clear; menu_option_eight; press_enter;;
      9) clear; menu_option_nine; press_enter;;
      10) clear; menu_option_ten; press_enter;;
      11) clear; menu_option_eleven; press_enter;;
      12) menu_option_twelve;;
      *) clear; incorrect_selection; press_enter;;
  esac
done