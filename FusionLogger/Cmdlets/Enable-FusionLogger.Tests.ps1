. .\Cmdlets\Get-FusionLogger.ps1
. .\Cmdlets\Disable-FusionLogger.ps1
. .\Cmdlets\Enable-FusionLogger.ps1
. .\TestHelpers\Mutations.ps1

Describe "Enable-FusionLogger" {

    Context "When Logging Path is required" {

        MutationRemoveAllFusionLoggerSettings
        Remove-Item "C:\ts\tsss" -Force -ErrorAction SilentlyContinue -Recurse        

        It "will create the LogPath" {
            $result = Enable-FusionLogger -LogPath "C:\ts\tsss\"

            $result.LogPath | Should Be "C:\ts\tsss\"
            Test-Path "C:\ts\tsss" | Should Be $true
        }

        It "will create the LogPath and append the trailing \ as required by the fusion logger" {
            $result = Enable-FusionLogger -LogPath "C:\ts\tsss"

            $result.LogPath | Should Be "C:\ts\tsss\"
            Test-Path "C:\ts\tsss" | Should Be $true
        }        

        It "will fail if LogPath is passed as null" {
            { Enable-FusionLogger -LogPath $null } | Should -Throw
        }        
    }

    Context "Whenever Fusion Logger is configured" {
        
        Mock Disable-FusionLogger { return $null }

        It "Will disable (and clear up) any previous Fusion Logging settings" {
            MutationRemoveAllFusionLoggerSettings
            
            Enable-FusionLogger -LogPath "C:\ts\fuslog\" | Out-Null
            
            Assert-MockCalled Disable-FusionLogger -Times 1
        }
    }

    Context "When just the LogPath is specified" {
        
        MutationRemoveAllFusionLoggerSettings

        It "Will revert to logging binding failures only" {
            $result = Enable-FusionLogger -LogPath "C:\ts\fuslog\"

            $result.LogAll | Should Be $false
            $result.LogFailures | Should Be $true
            $result.LogPath | Should Be "C:\ts\fuslog\"
            $result.LogInExceptionText | Should Be $false
            $result.LogImmersive | Should be $false    
        }

    }
    
    Context "When ImmersiveLogging is specified" {

        MutationRemoveAllFusionLoggerSettings

        It "Will enable Immersive Logging" {
            $result = Enable-FusionLogger -LogPath "C:\ts\fuslog\" -LogImmersive

            $result.LogPath | Should Be "C:\ts\fuslog\"
            $result.LogImmersive | Should Be $true
        }

    }

    Context "When different logging levels are specified" {

        MutationRemoveAllFusionLoggerSettings

        It "can enable just binding failures" {
            $result = Enable-FusionLogger -LogPath "C:\ts\fuslog\" -Log 'Failures'

            $result.LogAll | Should Be $false
            $result.LogFailures | Should Be $true
            $result.LogPath | Should Be "C:\ts\fuslog\"
            $result.LogInExceptionText | Should Be $false
            $result.LogImmersive | Should be $false               
        }

        It "can enable all bindings" {
            $result = Enable-FusionLogger -LogPath "C:\ts\fuslog\" -Log 'All'

            $result.LogAll | Should Be $true
            $result.LogFailures | Should Be $false
            $result.LogPath | Should Be "C:\ts\fuslog\"
            $result.LogInExceptionText | Should Be $false
            $result.LogImmersive | Should be $false               
        }    
        
        It "can enable just exception in text" {
            $result = Enable-FusionLogger -LogPath "C:\ts\fuslog\" -Log 'ExceptionText'

            $result.LogAll | Should Be $false
            $result.LogFailures | Should Be $false
            $result.LogPath | Should Be "C:\ts\fuslog\"
            $result.LogInExceptionText | Should Be $true
            $result.LogImmersive | Should be $false               
        }                

    }
}
