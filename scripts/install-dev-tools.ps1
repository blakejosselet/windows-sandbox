$scripts = "install-winget.ps1", 
    # "install-terminal.ps1", 
    "install-powershell-7.ps1",
    "install-git.ps1",
    "install-win32-openssh.ps1",
    # "install-gpg.ps1",
    "install-vscode.ps1"
$script = $MyInvocation.MyCommand.Path
$folder = $script | Split-Path -Parent

Write-host "Executing install scripts..."
foreach($s in $scripts){
    . "$folder\$s"
}
