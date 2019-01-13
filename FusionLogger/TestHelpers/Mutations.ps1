<#
.SYNOPSIS
Directly disable Fusion Logger; call this before running any tests
#>
function MutationRemoveAllFusionLoggerSettings {
    Remove-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name @("LogFailures", "LogPath", "ForceLog", "EnableLog", "LogImmersive") -Force -ErrorAction SilentlyContinue | Out-Null
    Remove-Item "C:\ts\fuslog" -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
}

<#
.SYNOPSIS
Set every Fusion Logger option. The opposite of MutationRemoveAllFusionLoggerSettings. This brute-force setting of registry settings 
#>
function MutationSetAllFusionLoggerOptions {
    New-Item "C:\ts\fuslog" -Force -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

    New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name "LogPath" -Value "C:\ts\fuslog\" -PropertyType "String" -Force | Out-Null
    New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name "ForceLog" -Value 1 -PropertyType "DWord" -Force | Out-Null
    New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name "EnableLog" -Value 1 -PropertyType "DWord" -Force | Out-Null
    New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name "LogFailures" -Value 1 -PropertyType "DWord" -Force | Out-Null
    New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Fusion -Name "LogImmersive" -Value 1 -PropertyType "DWord" | Out-Null
}
