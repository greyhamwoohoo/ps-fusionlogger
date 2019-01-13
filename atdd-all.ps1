#Requires -Version 3
#Requires -RunAsAdministrator
#Requires -PSEdition Desktop

# We want to run every test and collect code coverage; BUT: we want to exclude the .Tests. files themselves from the code coverage metrics
Push-Location
Set-Location FusionLogger
Invoke-Pester -CodeCoverageOutputFileFormat JaCoCo -CodeCoverage (Get-ChildItem *.ps1 -Recurse).Where{ !$_.Name.Contains(".Tests.") } 
Pop-Location
