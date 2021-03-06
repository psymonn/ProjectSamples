function newFunction2
{
  <#
    .Synopsis
      Short description
    .DESCRIPTION
      Long description
    .EXAMPLE
      Example of how to use this cmdlet
  #>
    [CmdletBinding()]
    Param
    (
        [Parameter(
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true, 
            Position=0)]
        [string[]]
        $ComputerName
    )
    begin
    {
		
		write-host "not loadedA get-calledPreference - $ErrorActionPreference"
		
		$script:ErrorActionPreference = 'changed2'
		write-host "not loadedB get-calledPreference - $ErrorActionPreference"
		
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState -Name 'ErrorActionPreference'
		
		write-host "loaded2C get-calledPreference - $ErrorActionPreference"
    }
    process
    {
        forEach ($computer in $ComputerName)
        {

        }
    }
    end
    {

    }
}
