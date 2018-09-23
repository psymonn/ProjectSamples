function publicFunction
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
