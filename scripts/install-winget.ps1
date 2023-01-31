write-host "Installing winget..."
$downloadsFolder = "$($Env:USERPROFILE)\Downloads"
Push-Location $downloadsFolder
$ProgressPreference='Silent'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$WebClient = New-Object System.Net.WebClient

Write-Output 'Installing Winget...'
Write-Host "Installing dependencies..."
Write-Output 'Downloading VCLibs...'
$url = "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
$file = "Microsoft.VCLibs.x64.14.00.Desktop.appx"
$WebClient.DownloadFile($url, "$downloadsFolder\$file")
Write-Output 'Installing VCLibs...'
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx

Write-Output 'Downloading Winget...'
$url = "https://github.com/microsoft/winget-cli/releases/download/v1.3.2691/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$file = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
$WebClient.DownloadFile($url, "$downloadsFolder\$file")
Write-Output 'Installing Winget...'
Add-AppxPackage $file
if(!$?){    
    $url = "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.0"
    $file = "microsoft.ui.xaml.2.7.0.zip"
    $expandedFolder = "microsoft.ui.xaml.2.7.0"
    Write-Output 'Fetching Microsoft.UI.XAML Nuget Package'
    $WebClient.DownloadFile($url, "$downloadsFolder\$file")
    Write-Output 'Extracting Microsoft.UI.XAML Nuget Package'
    Expand-Archive -Path $file -DestinationPath $expandedFolder -Force
    Write-Output 'Installing Microsoft.UI.XAML'
    $file = "$expandedFolder\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx"
    Add-AppxPackage $file

    Write-Output 'Installing Winget...'
    $file = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    Add-AppxPackage $file
}

Write-Output 'Cleaning up VCLibs installer files...'
Remove-Item Microsoft.VCLibs.x64.14.00.Desktop.appx
Write-Output 'Cleaning up Winget installer files...'
Remove-Item Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

if((Test-Path("microsoft.ui.xaml.2.7.0")) -or (Test-Path("microsoft.ui.xaml.2.7.0.zip"))){
    Write-Output 'Cleaning up Microsoft.UI.XAML Nuget Package...'
    if(Test-Path("microsoft.ui.xaml.2.7.0")){
        Remove-Item microsoft.ui.xaml.2.7.0 -Recurse -Force
    }
    if(Test-Path("microsoft.ui.xaml.2.7.0.zip")){
        Remove-Item microsoft.ui.xaml.2.7.0.zip -Recurse -Force
    }
}
Pop-Location