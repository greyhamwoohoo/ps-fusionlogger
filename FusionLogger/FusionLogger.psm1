#Requires -Version 3
#Requires -RunAsAdministrator
#Requires -PSEdition Desktop

# FusionLogger.psm1
# 
# Helper methods for working with Fusion Logger (fuslogvw)
#
# To test with Pester:
# 1. Install-Module -Name Pester -Force -SkipPublisherCheck
# 2. Invoke-Pester
#
# To see Code Coverage:
# Invoke-Pester -CodeCoverageOutputFileFormat JaCoCo -CodeCoverage @(Get-ChildItem *.ps1 -Recurse | ?{ !$_.Name.Contains(".Tests.") })
# 
# Author: GreyhamWooHoo

$here = Split-Path -Parent $MyInvocation.MyCommand.Path

. $here\Cmdlets\Get-FusionLogger.ps1
. $here\Cmdlets\Enable-FusionLogger.ps1
. $here\Cmdlets\Disable-FusionLogger.ps1

Export-ModuleMember -Function "Get-FusionLogger"
Export-ModuleMember -Function "Disable-FusionLogger"
Export-ModuleMember -Function "Enable-FusionLogger"
