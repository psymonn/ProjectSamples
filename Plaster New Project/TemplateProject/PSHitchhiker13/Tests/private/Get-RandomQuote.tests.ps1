$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Write-Host "parent: $here"

$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
Write-Host "file: $sut"

#since we match the srs/tests organization this works
$here = $here -replace 'tests', 'PSHitchhiker'
Write-Host "replace: $here"

. "$here\$sut"
write-host "dot-source: $here\$sut"

# Import our module to use InModuleScope
Import-Module (Resolve-Path ".\PSHitchhiker\PSHitchhiker.psm1") -Force

InModuleScope "PSHitchhiker" {
    Describe "Private/Get-RandomQuote" {
        # Intentionally Empty.
    }
}
InModuleScope "PSHitchhiker" {
    Describe "Private/Get-RandomQuote" {
        # Intentionally Empty.
    }
}
