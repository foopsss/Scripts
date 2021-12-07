# Scripts
Here I store some scripts[^1] I made thanks to the Internet community that I'd like to share.

* In the **ADB** folder, there's a command-line appliance I made both for Windows (Batch) and GNU/Linux (Shell) that aims to simplify the use of ADB and Fastboot. This tool is currently being reworked for both operating systems to make code more readable and better, where possible.
* In the **Backups** folder, there's a Windows (Powershell) command-line appliance to make backups of some things I regularly use. It's very specific to my computer.
* In the **Calibri** folder, there's a shell script to install the Calibri font family for the local user. However, the font files **are not included**. It can easily be tweaked for other font families.
* In the **Hosts** folder, there are two tools:
  * *HostsDownloader* is a script for Windows (Batch/Powershell) that modifies the hosts file and overwrites it with the latest version of my [hosts-porn](https://github.com/foopsss/hosts/blob/master/hosts-porn) file. It sets the file as read-only at the end, to make manually editing it a bit harder.
  * *ZipGenerator* is a script that pulls some files from my repos ([hosts-porn](https://github.com/foopsss/hosts/blob/master/hosts-porn), [update-binary](https://github.com/foopsss/Scripts/blob/main/Hosts/ZipGenerator/files/update-binary) and [updater-script](https://github.com/foopsss/Scripts/blob/main/Hosts/ZipGenerator/files/updater-script)) to create a flashable zip file to install the hosts-porn file on Android. It's made both for GNU/Linux (Shell) and Windows (Powershell)[^2].

# Credits
Credits for everyone that helped me are included in each script, either in the source code or in a sub-menu. But, I'd also like to add some honorable mentions:
* [osm0sis](https://forum.xda-developers.com/m/osm0sis.4544860/), for his [Shell script replacement](https://forum.xda-developers.com/t/dev-template-complete-shell-script-flashable-zip-replacement-signing-script.2934449/) that allowed me to have a -finally- working update-binary script.

[^1]: Spanish-only at the moment, as they are meant for personal use.
[^2]: The Windows version **does not** automatically create a zip file due to a problem with Powershell-generated zip files in TWRP, even though it does the rest. The user only has to manually package everything (except the script, of course) with a program like [WinRAR](https://www.rarlab.com/download.htm) or [7-Zip](https://www.7-zip.org).
