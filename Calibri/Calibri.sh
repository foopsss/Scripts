# Defining script interpreter.

#!/bin/bash

# Process starts here

echo "Installing fonts..."

# Creating the directory and copying folder contents.

mkdir -p ~/.local/share/fonts/calibri
find $(pwd)/ ! -name Calibri.sh -exec cp -t ~/.local/share/fonts/calibri/ {} +

# Making sure the process was successful.

cd ~/.local/share/fonts/calibri/
count=$(ls | wc -l)

if [ ${count} -eq 6 ]
then
 echo Done! Fonts installed in "~/.local/share/fonts/calibri/".
else
 echo The fonts have not been correctly installed. Please run the script again.
fi

# Refreshing font cache.

fc-cache -v > /dev/null

# Credits
<< 'CREDITS'
•tecadmin.net - Code to make comments.
 (https://tecadmin.net/tutorial/bash-comments)
•Fedora Docs/docs.fedoraproject.org - Code to make a folder and refresh font cache.
 (https://docs.fedoraproject.org/en-US/quick-docs/fonts/#unpackaged)
•Koen Woortman/koenwoortman.com - Code to get the current working directory.
 (https://koenwoortman.com/bash-script-get-current-directory/)
•StackOverFlow - User "John Kugelman" - Code to copy folder contents except one file.
 (https://stackoverflow.com/questions/1313590/bash-copy-all-files-except-one)
•StackOverFlow - User "Andy Lester" - Code to set a variable's value as a command output.
 (https://stackoverflow.com/questions/4651437/how-do-i-set-a-variable-to-the-output-of-a-command-in-bash)
•The Linux Documentation Project/tldp.org - Code to count files in the current directory.
 (https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x700.html)
•Ryan's Tutorials/ryanstutorials.net -  Code to make if statements and some information about operators.
 (https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php)
•StackOverFlow - User "Jeff Bowman" - Code to hide command output.
 (https://stackoverflow.com/questions/18062778/how-to-hide-command-output-in-bash)
CREDITS
