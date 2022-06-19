# Defino el intérprete a utilizar.
#!/bin/bash

# Creo el contenedor.
toolbox create lucas

# Actualizo los paquetes del contenedor.
toolbox run -c lucas sudo dnf update

# Instalo los paquetes requeridos.
toolbox run -c lucas sudo dnf install ImageMagick elementary-code gnome-tweaks -y
# toolbox run -c lucas sudo dnf install rpmdevtools rpmlint -y

# Ejecuto comandos varios.
# toolbox run -c lucas rpmdev-setuptree
