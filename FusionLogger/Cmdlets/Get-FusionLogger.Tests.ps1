. .\Cmdlets\Get-FusionLogger.ps1
. .\TestHelpers\Mutations.ps1

Describe "Get-FusionLogger" {

    Context "Smoke: When there is no configuration" {

        MutationRemoveAllFusionLoggerSettings

        It "will indicate there is no configuration" {
            $result = Get-FusionLogger

            $result.LogAll | Should Be $false
            $result.LogFailures | Should Be $false
            $result.LogPath | Should Be $null
            $result.LogInExceptionText | Should Be $false
            $result.LogImmersive | Should be $false            
        }
    }

    Context "Smoke: When every configuration option is set" {

        MutationSetAllFusionLoggerOptions       

        It "will return all configuration settings" {
            $result = Get-FusionLogger

            $result.LogAll | Should Be $true
            $result.LogFailures | Should Be $true
            $result.LogPath | Should Be "C:\ts\fuslog\"
            $result.LogInExceptionText | Should Be $true
            $result.LogImmersive | Should be $true            
        }
    }
}
