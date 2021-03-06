function newFunction
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
		
		write-host "not loaded1 get-calledPreference - $ErrorActionPreference"
		
		$script:ErrorActionPreference = 'changed1'
		write-host "not loaded2 get-calledPreference - $ErrorActionPreference"
		
		Get-CallerPreference -Cmdlet $PSCmdlet -SessionState $ExecutionContext.SessionState -Name 'ErrorActionPreference'
		
		write-host "loaded3 get-calledPreference - $ErrorActionPreference"
		
		
    }
    process
    {
		 write-host "###########################3#############"
		 newFunction2 com

        forEach ($computer in $ComputerName)
        {

        }
    }
    end
    {

    }
}
