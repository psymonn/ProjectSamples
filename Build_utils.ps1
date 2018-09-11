#Set Global Scope Preference
function initPreference {

    if (-not $PSBoundParameters.ContainsKey('ErrorAction')) 
    { 
        #$ErrorActionPreference = $PSCmdlet.GetVariableValue('ErrorActionPreference') 
        $ErrorActionPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ErrorActionPreference')
    } 
           
    Write-Host "Module Function: ErrorActionPreference = $ErrorActionPreference" 
}

#download modules from LocalNuGetFeed to a folder
function Save-Dependency {

    [CmdletBinding()]
    Param

    (

        [Parameter(Mandatory = $true)]

        [PSCustomObject] $config

    )
    try {
       
   
        foreach ( $module in $config.Modules ) {

            $saveParam = @{
                Name       = $module.Name
                Path       = '.\artifacts'
                Repository = 'LocalNuGetFeed'
            }

            if ( $null -ne $module.RequiredVersion ) {
                $saveParam.RequiredVersion = $module.RequiredVersion
            }

            Save-Module @saveParam -ErrorAction stop -Verbose
        }
    }
    catch [System.Exception]
    {

        #Write-Error "Save Dependencie Modules Failed: $_.Exception"

        throw($_.Exception)

    }

}

function Import-Dependency {
    #import the downloaded modules ready to use
    foreach ( $module in $config.Modules ) {
        $path = Join-Path .\artifacts $module.Name
        Import-Module $path -Force
    }
}

function Test-Dependency {
    #test all my projects that depend on these modules
    #assuming all modules have a build.ps1
    [CmdletBinding()]
    Param

    (

        [Parameter(Mandatory = $true)]

        [PSCustomObject] $config

    )
   

        foreach($project in $config.TestOrder)
        {
            #$project = 'PSHitchhiker'
            #    $repo = 'https://github.com/psymonn/{0}.git' -f $project
            $buildScript = '{0}.build.ps1' -f $project
            write-host "BuildScript: $buildScript"
            #   git clone $repo
            try {
                #& invoke-build -Task 'InstallDependencies' -f "$project/$buildScript"
                #just need to perform pester test.
                & invoke-build -Task 'Test' -f "$project/$buildScript" 
            }
            catch {
                Write-Host "Skipe error project (non existing project?) : $project"
                Write-Host "Within Catch block: ErrorActionPreference = $ErrorActionPreference" 
            }
            
        }
}

function Publish-Depedency {
    #publish the packages into our Local Nuget Feed
    foreach ($module in $config.Modules) {
        $path = '.\artifacts\{0}\*\{0}.psd1' -f $module.Name
        #$path = '.\artifacts\{0}\{0}.psd1' -f $module.Name

        $publishParam = @{
            Name        = $path
            Repository  = 'LocalNuGetFeed'
            NuGetApiKey = "SECRETKEY"
            Force       = $true
        }
        Publish-Module @publishParam
    }
}
