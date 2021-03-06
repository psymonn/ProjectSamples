function New-AwesomeFunction {
    <#
    .SYNOPSIS
    TBD
    .DESCRIPTION
    TBD
    .LINK
    https://www.github/Psymon/newCleanModule
    .EXAMPLE
    TBD
    .NOTES
    Author: Psymon
    #>

    [CmdletBinding()]
    param(
    )
    begin {
        if ($script:ThisModuleLoaded -eq $true) {
            Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."
    }
    process {
    }
    end {
        Write-Verbose "$($FunctionName): End."
    }
}
