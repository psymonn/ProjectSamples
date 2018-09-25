function New-PSProject
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
        [parameter(Position = 0)]
        [String]$Destination
    )
    begin
    {
        if (!$Destination) {
            throw 'Please Provide Project Destination Path!'
        }
        function BuildModule {
            [string]$ModulePath = Split-Path (get-variable myinvocation -scope script).value.Mycommand.Definition -Parent
            $manifestFile = (Join-Path $ModulePath 'Module')
            Invoke-Plaster -TemplatePath $manifestFile -DestinationPath $Destination
        }
    }
    process
    {
        try {
            .\$Destination\build.ps1
            if (-not (Test-Path $Destination)) {
               # BuildModule
                .\$Destination\build.ps1
                Write-Host "Module Build Successful"
            }else{
               # throw 'Destination Path already exist!'
            }
        }
        catch {
            Write-Host 'Build Module Failed with the following error:'
            Write-Host $_
        }
    }
    end
    {
    }
}

New-PSProject 'C:\Data\Git\ProjectTemplateTest\myNewModule2'
