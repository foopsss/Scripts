# Defino el intérprete a utilizar.
#!/bin/bash

# Desinstalo algunos programas de Silverblue que no me interesan.
flatpak uninstall org.gnome.Weather -y
flatpak uninstall org.gnome.Maps -y
flatpak uninstall org.gnome.Connections -y
flatpak uninstall org.gnome.Extensions -y

# Instalo Flathub.
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Añado los repositorios externos a utilizar luego.
sudo wget -O /etc/yum.repos.d/jstaf-onedriver.repo https://copr.fedorainfracloud.org/coprs/jstaf/onedriver/repo/fedora-36/jstaf-onedriver-fedora-36.repo
sudo wget -O /etc/yum.repos.d/fedora-uld.repo https://negativo17.org/repos/fedora-uld.repo

# Añado las aplicaciones a instalar con rpm-ostree.
rpm-ostree install onedriver uld elementary-code sway waybar mako light rofi grim

# Remuevo algunas aplicaciones de la imagen base.
rpm-ostree override remove firefox power-profiles-daemon

# Instalo las aplicaciones de Flathub.

	# Internet
	flatpak install flathub org.mozilla.firefox -y
	
	# Comunicación
	flatpak install flathub org.mozilla.Thunderbird -y
	flatpak install flathub com.github.eneshecan.WhatsAppForLinux -y
	flatpak install flathub us.zoom.Zoom -y
	
	# Juegos
	flatpak install flathub org.gnome.Games -y
	
	# Multimedia
	flatpak install flathub com.github.PintaProject.Pinta -y
	flatpak install flathub org.gimp.GIMP -y
	flatpak install flathub org.videolan.VLC -y
	flatpak install flathub com.obsproject.Studio -y
	flatpak install flathub io.github.seadve.Kooha -y
	
	# Oficina
	flatpak install flathub org.libreoffice.LibreOffice -y
	flatpak install flathub org.onlyoffice.desktopeditors -y
	# flatpak install flathub org.texstudio.TeXstudio -y
	
	# Programación
	flatpak install flathub com.visualstudio.code-oss -y
	flatpak install flathub io.github.shiftey.Desktop -y
	
	# Educación
	flatpak install flathub org.geogebra.GeoGebra -y
	
	# Extras
	flatpak install flathub com.github.tchx84.Flatseal -y
	flatpak install flathub ca.desrt.dconf-editor -y
	flatpak install flathub org.qbittorrent.qBittorrent -y
	flatpak install fedora org.gnome.FileRoller -y
	flatpak install flathub org.gnu.emacs -y
	flatpak install flathub com.mattjakeman.ExtensionManager -y
	
	# Códecs #
	flatpak install org.freedesktop.Platform.ffmpeg-full//21.08 -y
	flatpak install org.freedesktop.Platform.ffmpeg_full.i386//21.08 -y

# Descargo las herramientas de plataforma de Android.
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip -O /var/home/$USER/Documentos/platform-tools-latest-linux.zip
unzip -d /var/home/$USER/Documentos /var/home/$USER/Documentos/platform-tools-latest-linux.zip
rm /var/home/$USER/Documentos/platform-tools-latest-linux.zip

# Exporto la ubicación de las herramientas de plataforma de Android.
echo '' >> /var/home/$USER/.bashrc
echo '# Global platform-tools' >> /var/home/$USER/.bashrc
echo 'export PATH=${PATH}:/var/home/$USER/Documentos/platform-tools' >> /var/home/$USER/.bashrc

# Descargo los drivers de HP para la impresora.
wget https://ftp.hp.com/pub/softlib/software13/printers/CLP150/uld-hp_V1.00.39.12_00.15.tar.gz -O /var/home/$USER/Descargas/DriversHP.tar.gz
unzip -d /var/home/$USER/Descargas /var/home/$USER/Descargas/DriversHP.tar.gz

# Descargo mis archivos de configuración para Sway, Waybar y los demás componentes necesarios.

	# Configuración de Sway.
	mkdir /var/home/$USER/.config/sway/
	wget https://raw.githubusercontent.com/foopsss/Dotfiles/main/Sway/config -O /var/home/$USER/.config/sway/config
	
	# Configuración de Waybar.
	mkdir /var/home/$USER/.config/waybar/
	wget https://raw.githubusercontent.com/foopsss/Dotfiles/main/Waybar/config -O /var/home/$USER/.config/waybar/config
	wget https://raw.githubusercontent.com/foopsss/Dotfiles/main/Waybar/style.css -O /var/home/$USER/.config/waybar/style.css

	# Configuración de Rofi.
	# Fuente: https://github.com/davatorium/rofi-themes/tree/master/User%20Themes
	mkdir /var/home/$USER/.config/rofi/
	wget https://raw.githubusercontent.com/davatorium/rofi-themes/master/User%20Themes/flat-orange.rasi -O /var/home/$USER/.config/rofi/config.rasi
	
	# Configuración de Mako.
	mkdir /var/home/$USER/.config/mako/
	wget https://raw.githubusercontent.com/foopsss/Dotfiles/main/Mako/config -O /var/home/$USER/.config/mako/config

# Descargo GeoGebra.
# wget download.geogebra.org/package/linux-port6 -O /var/home/$USER/Descargas/GeoGebra.zip
# unzip -d /var/home/$USER/Descargas /var/home/$USER/Descargas/GeoGebra.zip
# cd /var/home/$USER/Descargas/GeoGebra/GeoGebra-linux-x64
# chmod +x GeoGebra

# Establezco los atajos de teclado a utilizar luego.
/bin/bash Atajos.sh

# Creo el contenedor para utilizar de ser requerido.
/bin/bash Contenedor.sh
    
# Pregunto al usuario que le gustaría hacer luego de que se instalen las actualizaciones.

	# Limpio la terminal.
	clear
	
	# Cambio el tamaño de la terminal para poder visualizar correctamente el menú a continuación.
	printf '\e[8;8;89t'

	# Imprimo por pantalla el menú.
	until [ "$selection" = "0" ];
	do   
		# Imprimo el menú con las opciones.
		echo "----------------------------------------------------------------------------------------"
		echo "¿Qué le gustaría hacer?"
		echo "----------------------------------------------------------------------------------------"
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

# Créditos.
<< 'CREDITS'
* Flatpak Docs - How to uninstall a Flatpak app.
  (https://docs.flatpak.org/en/latest/using-flatpak.html)
CREDITS
