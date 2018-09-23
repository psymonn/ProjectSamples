$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

#since we match the srs/tests organization this works
#$here = $here -replace 'tests', 'PSHitchhiker'
$here = $here -replace 'tests', 'GoodSample2'	
write-host "Invoke-PSHitchhiker.tests here: " $here
write-host "Invoke-PSHitchhiker.tests here\sut:"  "$here\Public\$sut"

. "$here\Public\$sut"

# Import our module to use InModuleScope
#Import-Module (Resolve-Path ".\PSHitchhiker\PSHitchhiker.psm1") -Force
Import-Module (Resolve-Path ".\GoodSample2\GoodSample2.psm1") -Force	

#InModuleScope "PSHitchhiker" {
InModuleScope "GoodSample2" {
    Describe "Public/Invoke-ModuleName" {
        Context "Ask" {
            It "Asks a question" {
                {Invoke-ModuleName -Ask "Is the cake a lie?" } | Should Not Throw
            }
            It "specifies a format" {
                {Invoke-ModuleName -Ask "Is the cake a lie?" -Format integer } | Should Not Throw
            }
        }
        Context "Help" {
            It "gets the docs" {
                {Invoke-ModuleName -Help } | Should Not Throw
             }
        }
    }
}
