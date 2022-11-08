# DocuWare Version 7.5 #
# Writen with PowerShell 5.0 #
# Requires .NET 4.8 to be installed #

#  Enable running of Scripts; run this if scripts are blocked
set-executionpolicy remotesigned -Force



### FILE DOWNLOAD & EXTRACTION ###

# Folder Path to download file into
$DownloadTo = 'C:\Temp\DWDesktopApps'
# Folder Path to unzip download into
$UnzipTo = 'C:\Temp\DWDesktopApps'
# Customers cloud URL ***CASE SENSITIVE***
$CustomerURL = 'tuolumne-county.docuware.cloud'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12

New-Item -ItemType Directory -Force -Path $DownloadTo

Invoke-WebRequest -Uri https://$CustomerURL/DocuWare/Platform/ClientSetup/ClientSetupCmd.zip -OutFile "$DownloadTo\ClientSetupCMD.zip"

get-childitem "$DownloadTo\ClientSetupCMD.zip" | unblock-file

Expand-Archive $DownloadTo\ClientSetupCMD.zip -DestinationPath $UnzipTo -Force

# Folder Path where executable "DocuWare.Setup.Client.Cmd.exe" exists
$UnzipTo = 'C:\Temp\DWDesktopApps'



### CLIENT ACTIONS ###

& $UnzipTo\DocuWare.Setup.Client.Cmd.exe uninstall --all

# Removes desktop icon for DocuWare Desktop Apps
Remove-Item -Path 'C:\users\public\desktop\DocuWare Desktop Apps.lnk' 

# Deletes Download and Unzipped items
Remove-Item -Path $UnzipTo -Recurse -Force