#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SimpleProject:
#---------------------------------

$plasterDest = 'F:\GitHub\Source\ProjectSamples\Plaster New Project\SimpleProject\TempClean'
$defaultTemplate = Get-PlasterTemplate | 
    Where-Object -FilterScript {$PSItem.Title -eq 'New PowerShell Manifest Module'}

Invoke-Plaster -TemplatePath $defaultTemplate.TemplatePath -DestinationPath $plasterDest\MyFirstPlasterModule  -Verbose 

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
NormalProject:
#---------------------------------

Invoke-Plaster -TemplatePath 'F:\GitHub\Source\ProjectSamples\Plaster New Project\NormalProject\PlasterTemplates\Module' -DestinationPath .\tempClean
Invoke-Plaster -TemplatePath 'F:\GitHub\Source\ProjectSamples\Plaster New Project\NormalProject\PlasterTemplates\Function' -DestinationPath .\tempClean
Invoke-Plaster -TemplatePath 'F:\GitHub\Source\ProjectSamples\Plaster New Project\NormalProject\PlasterTemplates\BlogPost' -DestinationPath .\tempClean

#---------------------------------
Genearate MD and Help files:
#---------------------------------

New-MarkdownHelp -Module platyPS -OutputFolder .\docs
New-MarkdownHelp -Module PSGraph -OutputFolder .\docs
New-MarkdownHelp -Module Mytools -OutputFolder .\docs
New-MarkdownHelp -Module DiskSpaceInfo -OutputFolder .\docs
New-MarkdownHelp -Module tempCleanFull -OutputFolder .\docs

Import-Module .\tempCleanFull.psd1
New-MarkdownHelp -Module tempCleanFull -OutputFolder .\docs

New-ExternalHelp .\docs -OutputPath en-US\

#---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DynamicProject:
#---------------------------------

manual:
Invoke-Plaster -TemplatePath 'F:\GitHub\Source\ProjectSamples\Plaster New Project\DynamicProject\ModuleBuild\plaster\ModuleBuild' -DestinationPath .\tempCleanMin -Verbose
Invoke-Plaster -TemplatePath 'F:\GitHub\Source\ProjectSamples\Plaster New Project\DynamicProject\ModuleBuild\plaster\PlasterModule\Templates\NewPowerShellScriptModule' -DestinationPath .\tempCleanMin

auto:
Initialize-ModuleBuild -Path 'F:\GitHub\Source\ProjectSamples\Plaster New Project\DynamicProject\tempCleanMin'
Initialize-ModuleBuild -Path 'F:\GitHub\Source\DynamicProject\ProjectSamples\Plaster New Project\temp7' -SourceModule 'F:\GitHub\Source\ProjectSamples\Plaster New Project\temp5\temp5\newModule.psd1'


Add-PublicFunction -Name 'New-AwesomeFunction' -TemplateName:PlainPublicFunction

Get-buildenvironment

Import-ModulePrivateFunction -ModulePath 'F:\GitHub\Source\ProjectSamples\Plaster New Project\temp3\newModule\newModule.psd1'
Import-ModulePublicFunction -ModulePath 'F:\GitHub\Source\ProjectSamples\Plaster New Project\temp3\newModule\newModule.psd1'


Set-BuildEnvironment -OptionSensitiveTerms @('myapikey','myname','password')

#---------------------------------
Build script:
#---------------------------------

.\Build.ps1 -BuildModule or .\Build.ps1

.\Build.ps1 -BuildModule -InstallAndTestModule or Invoke-Build -Task BuildInstallAndTestModule

.\Build.ps1 -UploadPSGallery or Invoke-Build -Task BuildInstallTestAndPublishModule 

or

.\Build.ps1 -BuildModule -InstallAndTestModule -UploadPSGallery -ReleaseNotes 'First Upload'

#---------------------------------
Release to Gallery:
#---------------------------------

release to PSGallery (changed to LocalNuGetFeed):
.\Build.ps1 -BuildModule -InstallAndTestModule -UploadPSGallery -ReleaseNotes 'First Upload'

or 

Invoke-Build -Task BuildInstallTestAndPublishModule

Set-BuildEnvironment -NugetAPIKey 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
.\Build.ps1 -UploadPSGallery

#---------------------------------
Start Your Next Release:
#---------------------------------

.\Build.ps1 -NewVersion '0.0.5'
.\Build.ps1

or 

.\Build.ps1 -NewVersion '0.0.5' -BuildModule -InstallAndTestModule -UploadPSGallery -ReleaseNotes '0.0.5 release'


.\Build.ps1 -InsertCBH

https://modulebuild-psy.readthedocs.io/en/latest/Usage/7%20-%20Project%20Documentation/index.html

Pester:
.\Build.ps1 -test