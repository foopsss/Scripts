# Declaro el intérprete a utilizar.
#!/bin/bash

# Defino una variable para almacenar una ruta.
ruta=~/.local/share/fonts/calibri/

# Defino las funciones a utilizar.
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

# Aquí comienza la operación.
echo "Instalando fuentes..."

# Creo la carpeta y copio los contenidos.
mkdir -p $ruta
{
    find "$(pwd)"/ ! -name Calibri.sh -exec cp -t $ruta {} +
} 2>/dev/null

# Me aseguro de que el proceso haya finalizado exitosamente.
cd $ruta
count=$(ls | wc -l)

if [ ${count} -eq 6 ]
then
 GBT "¡Hecho! Fuentes instaladas en '$ruta'."
else
 RBT "¡Error! Las fuentes no se instalaron correctamente. Por favor intente de nuevo."
fi

# Refresco la cache de las fuentes.
fc-cache -v > /dev/null

# Cŕeditos.
<< 'CREDITS'
•tecadmin.net - Code to make comments.
 (https://tecadmin.net/tutorial/bash-comments)
•Fedora Docs/docs.fedoraproject.org - Code to make a folder and refresh font cache.
 (https://docs.fedoraproject.org/en-US/quick-docs/fonts/#unpackaged)
•Koen Woortman/koenwoortman.com - Code to get the current working directory.
 (https://koenwoortman.com/bash-script-get-current-directory/)
•Stack Overflow - User "John Kugelman" - Code to copy folder contents except one file.
 (https://stackoverflow.com/questions/1313590/bash-copy-all-files-except-one)
•Stack Overflow - User "Andy Lester" - Code to set a variable to the output of a command.
 (https://stackoverflow.com/questions/4651437/how-do-i-set-a-variable-to-the-output-of-a-command-in-bash)
•The Linux Documentation Project/tldp.org - Code to count files in the current directory.
 (https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x700.html)
•Ryan's Tutorials/ryanstutorials.net -  Code to make if statements and some information about operators.
 (https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php)
•Stack Overflow - User "Jeff Bowman" - Code to hide command output.
 (https://stackoverflow.com/questions/18062778/how-to-hide-command-output-in-bash)
CREDITS