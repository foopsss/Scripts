:: Evito que los comandos se muestren en pantalla.
@ECHO OFF

:: Defino las propiedades de la ventana.
TITLE Hosts Downloader
MODE 80,10

:: Código
attrib -R C:\Windows\System32\drivers\etc\hosts
powershell -c Invoke-WebRequest -Uri "https://raw.githubusercontent.com/foopsss/hosts/master/hosts-porn" -OutFile "C:\Windows\System32\drivers\etc\hosts"
attrib +R C:\Windows\System32\drivers\etc\hosts