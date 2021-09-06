:: Stopping commands from showing on-screen
@ECHO OFF

:: Defining window properties
TITLE Hosts Downloader
MODE 80,10

attrib -R C:\Windows\System32\drivers\etc\hosts
powershell -c Invoke-WebRequest -Uri "https://raw.githubusercontent.com/foopsss/hosts/master/hosts-porn" -OutFile "C:\Windows\System32\drivers\etc\hosts"
attrib +R C:\Windows\System32\drivers\etc\hosts

:: Credits
:: •www.tutorialspoint.com - Code to make comments (Batch).
:: •Kailash Dhondiyal/mytechnicalnotes.com - Code to turn off echo-ing (Batch).
:: •www.tutorialspoint.com - Code to change window title (Batch).
:: •TechnoCraft/stackoverflow.com - Code to change window size (Batch).
:: •SRINI/www.windows-commandline.com - Code to change file attributes (Batch).
:: •Ryan Bemrose/stackoverflow.com - Code to invoke Powershell from CMD (Powershell).
