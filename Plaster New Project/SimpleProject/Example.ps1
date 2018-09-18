#https://kevinmarquette.github.io/2017-05-14-Powershell-Plaster-GetPlastered-template/?utm_source=blog&utm_medium=blog&utm_content=recent

#one off template creation
Install-Module Plaster

$manifestProperties = @{
    Path = ".\FullModuleTemplate2\PlasterManifest.xml"
    Title = "Full Module Template2"
    TemplateName = 'FullModuleTemplate2'
    TemplateVersion = '0.0.2'
    Author = 'Psymon2'
    Description = "Some description 2"
    #TemplateType = "Item"
}

#New-Item -Path FullModuleTemplate2 -ItemType Directory (not required)
#New-PlasterManifest @manifestProperties (only use this to create a new manifest, otherwise you'll overwrite the existing one)
#New-PlasterManifest -TemplateName NewPowerShellItem -TemplateType Item
#New-PlasterManifest -TemplateName NewPowerShellItem -TemplateType Item -AddContent
#New-PlasterManifest -TemplateName NewPowerShellItem -TemplateType Item -TemplateVersion 0.1.0 -Description "Some
#    description." -Tags Module, Publish,Build

######################
# Once its created, use the template to update the contents and parameters

$plaster = @{
    TemplatePath = (Split-Path $manifestProperties.Path)
    DestinationPath = ".\Temp2\Module"
}

New-Item -ItemType Directory -Path $plaster.DestinationPath
Invoke-Plaster @plaster -Verbose
#----------------------------------------------------------

Remove-Item -Path $plaster.DestinationPath -Recurse
New-Item -ItemType Directory -Path $plaster.DestinationPath

Invoke-Plaster @plaster -Verbose
