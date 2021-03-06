#$script:ErrorActionPreference = 'Stop'
#			Write-Host "ErrorActionPreference: $ErrorActionPreference"
			#$script:NonstandardPreferenceVariable = 'I exist!'
			#Write-Host "NonstandardPreferenceVariable: $NonstandardPreferenceVariable"

function New-AwesomeFunction {
    <#
    .SYNOPSIS
    TBD
    .DESCRIPTION
    TBD
    .LINK
    https://www.github.com/psymon/tempCleanFull2
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
		
			
			. 'F:\GitHub\Source\ProjectSamples\Plaster New Project\TemplateProject\GoodSample7\GoodSample7\Private\Get-CallerPreference.ps1'
			
			#$script: can be define here or from the caller
			$script:ErrorActionPreference = 'SilentlyContinue'
			$script:PsymonPeferenceVariable = 'Who am I?'

			Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState -Name 'ErrorActionPreference', 'PsymonPeferenceVariable'

			Write-Host "Init-PreferenceMultiple Function: ErrorActionPreference = $ErrorActionPreference"
			Write-Host "PsymonPeferenceVariable: $PsymonPeferenceVariable"
			
			
			
            #Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState -Name 'ErrorActionPreference','NonstandardPreferenceVariable'
			#write-host "loaded get-calledPreference - $ErrorActionPreference"
        }
        $FunctionName = $MyInvocation.MyCommand.Name
        Write-Verbose "$($FunctionName): Begin."
		write-host "outside loaded get-calledPreference ErrorActionPreference - $ErrorActionPreference"
		write-host "outside loaded get-calledPreference NonstandardPreferenceVariable - $NonstandardPreferenceVariable"
		
		write-host "###############################"
		newFunction comp
    }
    process {
    }
    end {
        Write-Verbose "$($FunctionName): End."
    }
}
