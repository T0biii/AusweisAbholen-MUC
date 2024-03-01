# AusweisAbholen-MUC
Info ob Ausweis zum abholen bereit ist via PowerShell  
Folgende URL wird verwendet: https://www17.muenchen.de/Passverfolgung/ (Verson V 2.3.2 vom 05.06.2019)  
Folgendes Module wird verwendet: https://www.powershellgallery.com/packages/PowerHTML/0.1.7  
```PowerShell
Install-Module -Name PowerHTML
```
Getestet auf PowerShell 7.4.1 


# Usage:

PowerShell mit Paramter starten:
```PowerShell
.\Get-PassInfo.ps1 -passNummer "12345"
```

oder in Zeile 2 im Skript "Get-PassInfo.ps1" die PassNummer anpassen:  
```PowerShell
$passNummer = ""
```
Run:
```PowerShell
.\Get-PassInfo.ps1
```

Ergebnis:
![New text](images/image.png)