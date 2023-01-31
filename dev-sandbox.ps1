$content = Get-Content -Path "dev-sandbox.wsb"
$tempWsb = "dev-sandbox-temp.wsb" 

if(Test-Path($tempWsb)){
    Remove-Item $tempWsb
}

$downloadsFolder = "$($env:USERPROFILE)\Downloads\dev-sandbox"
if(!(Test-Path($downloadsFolder))){
    $null = mkdir $downloadsFolder
}

foreach($line in $content){
    switch -regex ($line){
        '{userprofile}' { $line = $line.Replace("{userprofile}", $env:USERPROFILE) }
        '{repository_root}' { $line = $line.Replace("{repository_root}", (Get-Location).Path ) }
    }

   $line | Add-Content -Path $tempWsb
}

. ".\$tempWsb"
Start-Sleep -Seconds 5
Remove-Item $tempWsb