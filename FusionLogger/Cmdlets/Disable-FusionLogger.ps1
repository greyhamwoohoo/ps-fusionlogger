<#
.SYNOPSIS
Disable all Fusion Logger options

.DESCRIPTION
Disable all Fusion Logger options

.EXAMPLE
C:\PS> Disable-FusionLogger
LogFailures         : False
LogInExceptionText  : False
LogAll              : False
LogImmersive        : False
LogPath             : 
#>
function Disable-FusionLogger {

    [CmdletBinding()]
    Param(
    )
    PROCESS 
    {
        Remove-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name @("LogFailures", "LogPath", "ForceLog", "EnableLog", "LogImmersive") -Force -ErrorAction SilentlyContinue | Out-Null

        $result = Get-FusionLogger
        Write-Verbose $result
        Write-Output $result
    }
}
