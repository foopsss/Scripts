:: Evito que los comandos se muestren en pantalla.
@ECHO OFF

:: Defino las propiedades de la ventana.
TITLE Hosts Downloader
MODE 80,10

:: Código
attrib -R C:\Windows\System32\drivers\etc\hosts
powershell -c Invoke-WebRequest -Uri "https://raw.githubusercontent.com/foopsss/hosts/master/hosts-porn" -OutFile "C:\Windows\System32\drivers\etc\hosts"
attrib +R C:\Windows\System32\drivers\etc\hosts

:: Créditos
:: •www.tutorialspoint.com - Code to make comments (Batch).
::  (https://www.tutorialspoint.com/batch_script/batch_script_comments.htm)
:: •ServerFault - User "jftuga" - Code to turn off echo-ing (Batch).
::  (https://serverfault.com/questions/187355/dont-show-batch-file-command-when-execute-it)
:: •www.tutorialspoint.com - Code to change window title (Batch).
::  (https://www.tutorialspoint.com/batch_script/batch_script_title.htm)
:: •TechnoCraft/stackoverflow.com - Code to change window size (Batch).
::  (https://stackoverflow.com/questions/8688846/resize-command-prompt-through-commands)
:: •SRINI/www.windows-commandline.com - Code to change file attributes (Batch).
::  (https://www.windows-commandline.com/set-read-only-attribute-file/)
:: •Ryan Bemrose/stackoverflow.com - Code to invoke Powershell from CMD (Powershell).
::  (https://stackoverflow.com/questions/41862786/how-can-i-download-a-file-from-the-internet-via-command-prompt)
