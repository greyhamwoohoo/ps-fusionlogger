<#
.SYNOPSIS
Get the Fusion Logger configuration options

.DESCRIPTION
Get the Fusion Logger configuration options

.EXAMPLE
C:\PS> Get-FusionLogger
LogFailures         : True
LogInExceptionText  : False
LogAll              : False
LogImmersive        : False
LogPath             : C:\ts\fusionlogs\
#>
function Get-FusionLogger {

    [CmdletBinding()]
    Param(
    )
    PROCESS 
    {
        $logPath = Get-ItemProperty -Path HKLM:\Software\Microsoft\Fusion -Name "LogPath" -ErrorAction SilentlyContinue
        $logImmersive = Get-ItemProperty -Path HKLM:\Software\Microsoft\Fusion -Name "LogImmersive" -ErrorAction SilentlyContinue
        $forceLog = Get-ItemProperty -Path HKLM:\Software\Microsoft\Fusion -Name "ForceLog" -ErrorAction SilentlyContinue
        $enableLog = Get-ItemProperty -Path HKLM:\Software\Microsoft\Fusion -Name "EnableLog" -ErrorAction SilentlyContinue
        $logFailures = Get-ItemProperty -Path HKLM:\Software\Microsoft\Fusion -Name "LogFailures" -ErrorAction SilentlyContinue

        $result = New-Object System.Management.Automation.PSObject
        $result | Add-Member -MemberType NoteProperty -Name "Kind" -Value "GetFusionLoggerResult"
        $result | Add-Member -MemberType NoteProperty -Name "LogFailures" -Value $($logFailures.LogFailures -eq 1)
        $result | Add-Member -MemberType NoteProperty -Name "LogInExceptionText" -Value $($enableLog.EnableLog -eq 1)
        $result | Add-Member -MemberType NoteProperty -Name "LogAll" -Value $($forceLog.ForceLog -eq 1)
        $result | Add-Member -MemberType NoteProperty -Name "LogImmersive" -Value $($logImmersive.LogImmersive -eq 1)
        $result | Add-Member -MemberType NoteProperty -Name "LogPath" -Value $logPath.LogPath

        Write-Output $result
        Write-Verbose $result
    }
}
