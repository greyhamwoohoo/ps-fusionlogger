. .\Cmdlets\Get-FusionLogger.ps1
. .\Cmdlets\Disable-FusionLogger.ps1
. .\TestHelpers\Mutations.ps1

Describe "Disable-FusionLogger" {

    Context "When Fusion Logger is not configured" {

        MutationRemoveAllFusionLoggerSettings     

        It "will clear all Fusion Logger configurations" {

            $result = Disable-FusionLogger 

            $result.LogAll | Should Be $false
            $result.LogFailures | Should Be $false
            $result.LogPath | Should Be $null
            $result.LogInExceptionText | Should Be $false
            $result.LogImmersive | Should be $false            
        }
    }

    Context "When every Fusion Logger parameter is set" {
     
        It "will clear all Fusion Logger configurations" {

            MutationSetAllFusionLoggerOptions

            $result = Disable-FusionLogger 

            $result.LogAll | Should Be $false
            $result.LogFailures | Should Be $false
            $result.LogPath | Should Be $null
            $result.LogInExceptionText | Should Be $false
            $result.LogImmersive | Should be $false            
        } 
    }    
}
