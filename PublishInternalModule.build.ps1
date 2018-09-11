# Include: Settings

. './PublishInternalModule.settings.ps1'



# Include: build_utils

. './build_utils.ps1'

$config = Get-Content -Path .\config.json | ConvertFrom-Json

# Synopsis: Run/Publish Tests and Fail Build on Error

task Test BeforeTest, RunTests, AfterTest
task Dependencies SaveDependency, ImportDependency



# Synopsis: Run full Pipleline.

#task . SaveDependency, ImportDependency, Clean, Test, Publish
task . Dependencies, Clean, Test, Publish
#task . InstallDependencies, Clean, Analyse, Test, Archive



# Synopsis: Install Build Dependencies

task SaveDependency {

    write-host 'Save dependencies'
    #script:$config = Get-Content -Path .\config.json | ConvertFrom-Json
    Save-Dependency($config)

}


task ImportDependency {

    write-host 'Import dependencies'
    Import-Dependency

}


# Synopsis: Clean Artifacts Directory

task Clean BeforeClean, {

    if(Test-Path -Path $Artifacts)

    {

        Remove-Item "$Artifacts/*" -Recurse -Force

    }

    New-Item -ItemType Directory -Path $Artifacts -Force

    # Temp

    #If let it run then error -> fatal: destination path 'PSHitchhiker' already exists and is not an empty directory.

    #& git clone https://github.com/psymonn/PSHitchhiker.git

}, AfterClean


# Synopsis: Test the project with Pester. Publish Test and Coverage Reports

task RunTests {
    #$ErrorActionPreference = 'Continue'
    #initPreference
    write-host 'Test dependency'
    Test-Dependency($config)

}

# Synopsis: Publish to SMB File Share

task Publish BeforePublish, {

    Publish-Depedency

}, AfterPublish
