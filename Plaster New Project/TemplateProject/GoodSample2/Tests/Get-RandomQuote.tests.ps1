$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host "parent: $here"

$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
Write-Host "file: $sut"

#since we match the srs/tests organization this works
#$here = $here -replace 'tests', 'PSHitchhiker'
$here = $here -replace 'tests', 'GoodSample2'	
Write-Host "replace: $here"

. "$here\Private\$sut"
write-host "dot-source: $here\Private\$sut"

# Import our module to use InModuleScope
#Import-Module (Resolve-Path ".\PSHitchhiker\PSHitchhiker.psm1") -Force
Import-Module (Resolve-Path ".\GoodSample2\GoodSample2.psm1") -Force	

#InModuleScope "PSHitchhiker" {
InModuleScope "GoodSample2" {
    Describe "Private/Get-RandomQuote" {
        # Intentionally Empty.
    }
}

