# DocuWare Version 7.5 #
# Written with PowerShell 5.0 #
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
# Customers Cloud Org ID
$CustomerOrgID = '0fbecc92-6bbe-440f-9129-c1c76514d4f2'
# Items you want installed
$Modules = 'Printer EditSend Update C2Outlook WEC'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12

New-Item -ItemType Directory -Force -Path $DownloadTo

Invoke-WebRequest -Uri https://$CustomerURL/DocuWare/Platform/ClientSetup/ClientSetupCmd.zip -OutFile "$DownloadTo\ClientSetupCMD.zip"

get-childitem "$DownloadTo\ClientSetupCMD.zip" | unblock-file

Expand-Archive $DownloadTo\ClientSetupCMD.zip -DestinationPath $UnzipTo -Force



### CLIENT ACTIONS ###

& $UnzipTo\DocuWare.Setup.Client.Cmd.exe install --modules=$Modules --server=https://$CustomerURL --orgId=$CustomerOrgID

& 'C:\Program Files (x86)\DocuWare\Desktop\DocuWare.Desktop.exe'

$FileName = "C:\users\public\desktop\DocuWare Desktop Apps.lnk"
if (Test-Path $FileName)  {
    Remove-Item $FileName
}

# Deletes Download and Unzipped items
Remove-Item -Path $UnzipTo -Recurse -Force