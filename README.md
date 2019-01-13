# ps-fusionlogger
A PowerShell Module for configuring Assembly Binding Log Viewer (fuslogvw). 

## Why?
Mostly: to learn the lifecycle of simple PowerShell Module development with Pester and Acceptance Test-Driven Development

## Background
The Microsoft Tool 'Fuslogvw.exe' is used for configuring and viewing Fusion logs. The viewer can be used to troubleshoot SxS Configuration / Binding Errors. This Module provides a PowerShell wrapper around those registry entries and manual UI. 

NOTE: Fusion Logger (Fuslogvw.exe - if enabled) will impact performance of your system. Be sure to call Disable-FusionLogger after using it. Consider developing / testing this in a virtual machine.  

## Getting Started
To import the Fusion Logger module:
<br><br><code>
Import-Module FusionLogger\FusionLogger.psm1
</code>

| Description | Action |
| ----------- | ------ |
| To import Fusion-Logger into a PowerShell Session | Import-Module .\FusionLogger\FusionLogger.psm1 |
| To disable Fusion Logger | Disable-FusionLogger |
| To collect all Binding Failures to C:\ts\fuslog | Enable-FusionLogger -LogPath "C:\ts\fuslog" |
| To collect ALL bindings (success/failure) to C:\woo\hoo | Enable-FusionLogger -LogPath "C:\woo\hoo" -Log "All"
| To collect Exception Text to C:\woo\hoo | Enable-FusionLogger -LogPath "C:\woo\hoo" -Log "ExceptionText"
| To include Immerive Logging | Add -LogImmersive to any of the above parameters |

## Testing and Development
This module makes changes to your registry.  

I tend to develop DSC and PowerShell Modules on a virtual machine and use 'nodemon' to watch for changes and execute my tests on every file change. 

From this repository root, execute:
<br><br><code>
npm install nodemon -g<br>
nodemon --watch FusionLogger --exec powershell -File .\atdd-all.ps1
</code>


## References
| Description | Link |
| ----------- | ------ |
| Assembly Binding Logger (fuslogvw.exe) landing page | https://docs.microsoft.com/en-us/dotnet/framework/tools/fuslogvw-exe-assembly-binding-log-viewer | 
| PowerShellGuard will watch for file changes and invoke commands (similar to Nodemon). However, I ran into a few difficulties similar to an (unclosed) issue from January 2018 so I reverted to Nodemon. This is quite a bit slower due to the PowerShell instantiation each time | https://www.powershellgallery.com/packages/PowerShellGuard |
