<#
.SYNOPSIS
Enable Fusion Logging

.DESCRIPTION
Enable Fusion Logging

.PARAMETER LogPath
Fully qualified path to a folder that will contain the logs. The folder will be created automatically if it does not exist. 

.PARAMETER LogImmersive
The same as the 'Enable Immersive Logging' option from Fuslogvw

.EXAMPLE
C:\PS> Enable-FusionLogger
#>
function Enable-FusionLogger {

    [CmdletBinding()]
    Param(
        [Parameter(Mandatory,HelpMessage="Folder path to log to")]
        [ValidateNotNullOrEmpty()]
        [string] $LogPath,
        [Parameter(Mandatory=$false,HelpMessage="Fuslogvw: Enable Immersive Logging")]
        [Switch] $LogImmersive,
        [Parameter(Mandatory=$false,HelpMessage="Fuslogvw: Log all binds to disk; Fuslogvw: Log in exception text; Fuslogvw: Log failures")]
        [ValidateSet('All','ExceptionText','Failures')]
        [string] $Log = "Failures"
    )
    PROCESS 
    {
        Disable-FusionLogger | Out-Null

        if(-NOT (Test-Path $LogPath)) {
            New-Item -ItemType Directory -Path $LogPath | Out-Null
        }

        $actualLogPath = $LogPath
        if(-NOT $actualLogPath.EndsWith("\")) {
            $actualLogPath += "\"
        }

        New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name "LogPath" -Value $actualLogPath -PropertyType "String" -Force | Out-Null

        if($Log -eq "Failures") {
            New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name "LogFailures" -Value 1 -PropertyType "DWord" -Force | Out-Null
        }
        if($Log -eq "All") {
            New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name "ForceLog" -Value 1 -PropertyType "DWord" -Force | Out-Null
        }        
        if($Log -eq "ExceptionText") {
            New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name "EnableLog" -Value 1 -PropertyType "DWord" -Force | Out-Null
        }                

        if($LogImmersive) {
            New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name "LogImmersive" -Value 1 -PropertyType "DWord" | Out-Null
        }

        $result = Get-FusionLogger
        Write-Verbose $result
        Write-Output $result
    }
}
