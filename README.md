# AusweisAbholen-MUC
Info ob Ausweis zum abholen bereit ist via PowerShell  
Folgende URL wird verwendet: https://www17.muenchen.de/Passverfolgung/  
Folgendes Module wird verwendet: https://www.powershellgallery.com/packages/PowerHTML/0.1.7
Getestet auf PowerShell 7.1.3


Zeile 1 im Skript Get-PassInfo.ps1 muss angepasst werden auf die PassNummer:  
```PowerShell
$passNummer = ""
```
Run .\Get-PassInfo.ps1  
![image](https://user-images.githubusercontent.com/5702338/127875840-74d45a15-1b55-45f6-8d2b-fac3f59b4c13.png)
