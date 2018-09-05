http://duffney.io/GettingStartedWithInvokeBuild
https://kevinmarquette.github.io/2018-03-06-Powershell-Managing-community-modules/

Pre-requisite:

Register-PSRepository -Default
or
Register-PSRepository -Name "PSGallery" -SourceLocation "https://www.powershellgallery.com/api/v2/" -InstallationPolicy Trusted

Register-PSRepository -Name LocalNuGetFeed -SourceLocation http://localhost:8087/nuget -PublishLocation http://localhost:8087/nuget -InstallationPolicy Trusted

get-packagesource
Get-PSRepository | Select *

Find-Module -Repository "LocalNuGetFeed" -IncludeDependencies
Find-Module -Repository "LocalNuGetFeed"


-----------------

function Install-Dependency

{

    [CmdletBinding()]

    Param

    (

        [Parameter(Mandatory=$true)]

        [PSCustomObject] $config

    )

    #$config = Get-Content -Path .\config.json | ConvertFrom-Json

   write-host 'Check Module dependencies'

    try {
        foreach ( $module in $config.Modules ) {

            if ( $null -ne $module.RequiredVersion ) {


                if (!(Get-Module -Name $module.Name -ListAvailable | where-object {$_.version -eq $module.RequiredVersion})){

                    Install-Module -Name $module.Name -requiredVersion $module.RequiredVersion -ErrorAction stop -Verbose
                }

            }else {

                if (!(Get-Module -Name $module.Name -ListAvailable)) { Install-Module -Name $module.Name -ErrorAction stop -Verbose}

            }

            #Import-Module $module.Name -Force
        }
    }

    catch [System.Exception]

    {

        # Write-Error "Install Dependencie Modules Failed"

        throw($_.Exception)

    }



}

----------

$config = Get-Content -Path .\config.json | ConvertFrom-Json
Install-Dependency($config)

