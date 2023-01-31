# windows-sandbox

Scripts that configure Windows Sandbox environments

## Creating dev environments

By default the script will configure Windows Sandbox with the development tools listed
in [./scripts/install-dev-tools](./scripts/install-dev-tools.ps1)

- winget
- Powershell 7
- Git for Windows
- Powershell Win32 OpenSSH client
- VSCode
- *Terminal (disabled; not working - winget install is failing)*
- *GPG (optional; uncomment to enable)*

```powershell
.\dev-sandbox.ps1
```

If you want to customize the tools being loaded, for instance, adding GPG4Win
edit [scripts/install-dev-tools.ps1](./scripts/install-dev-tools.ps1) and uncomment
the line for GPG.

To load another app, create a script and reference it in
[scripts/install-dev-tools.ps1](./scripts/install-dev-tools.ps1)

## Configuration details

The [dev-sandbox.wsb](./dev-sandbox.wsb)

- Creates a dev-sandbox folder in your Downloads directory if one does not exist.
- Mounts the dev-sandbox in the WDAGUtilityAccount Downloads directory
  - Mount location: C:\Users\WDAGUtilityAccount\Downloads\dev-sandbox
- Mounts the [scripts](./scripts) for execution in Windows Sandbox
  - Mount location: c:\dev\dev-sandbox-scripts
