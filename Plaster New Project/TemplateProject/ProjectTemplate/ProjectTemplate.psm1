function New-ProjectTemplate
{
  <#
    .Synopsis
      Short description
    .DESCRIPTION
      Create new project module
    .EXAMPLE
      New-ProjectTemplate c:\temp\project
  #>
    [CmdletBinding()]
    Param
    (
        [parameter(Mandatory=$true, Position = 0)]
        [String]$Path
    )

    begin {}

    process {

        try {
                if (!$Path) {

                    throw 'Please Provide Project Destination Path!'
                }

                #.\$Path\build.ps1
                if (-not (Test-Path $Path)) {

                   [string]$ModulePath = Split-Path (get-variable myinvocation -scope script).value.Mycommand.Definition -Parent

                   $manifestFile = (Join-Path $ModulePath 'Module')

                   Invoke-Plaster -TemplatePath $manifestFile -DestinationPath $Path -NoLogo

                   Write-Host "Module Created Successfully!"

                   cd $Path

                }else{

                    throw '$Path already exist! Try a different Path instead...'
                }

            } catch {

                Write-Host -ForegroundColor Green 'Create Project Template Failed with the following error:'
                Write-Host $_

            }
    }

    end {}
}

#New-PSProject 'F:\GitHub\Source\ProjectSamples\Plaster New Project\TemplateProject\GoodSample6'

function Test-ProjectTemplate {
    <#
    .Synopsis
      Short description
    .DESCRIPTION
      Verify Project Template is not missing any core files
    .EXAMPLE
      Invoke-Pester .\Tests
     #>

    [string]$ModulePath = Split-Path (get-variable myinvocation -scope script).value.Mycommand.Definition -Parent
    $testPath = (Join-Path $ModulePath 'Tests')

    Invoke-Pester $testPath
}
