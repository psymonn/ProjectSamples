# Include: Settings
. './ProjectTemplateGenerate3.build.settings.ps1'
# Include: build_utils
. './build_utils.ps1'

#Update-ModuleManifest -Path .\ProjectTemplateGenerate3\ProjectTemplateGenerate3.psd1

# Synopsis: Run/Publish Tests and Fail Build on Error
task Test BeforeTest, RunTests, ConfirmTestsPassed, AfterTest

# Synopsis: Run full Pipleline.
#task . InstallDependencies, Clean, Analyse, Test, Archive, Publish
task . InstallDependencies, Clean, Analyse, Test, Archive

# Synopsis: Install Build Dependencies
task InstallDependencies {
    # Cant run an Invoke-Build Task without Invoke-Build.
    #Install-Module -Name InvokeBuild -Force

    #Install-Module -Name DscResourceTestHelper -Force
    #Install-Module -Name Pester -Force
    #Install-Module -Name PSScriptAnalyzer -Force
    write-host 'Check Module dependencies'
    if (!(Get-Module -Name InvokeBuild -ListAvailable)) { Install-Module -Name InvokeBuild }
    if (!(Get-Module -Name Pester -ListAvailable)) { Install-Module -Name Pester }
    if (!(Get-Module -Name PSScriptAnalyzer -ListAvailable)) { Install-Module -Name PSScriptAnalyzer }
    #if (!(Get-Module -Name PSDeploy -ListAvailable)) { Install-Module -Name PSDeploy }

}

# Synopsis: Clean Artifacts Directory
task Clean BeforeClean, {
    if(Test-Path -Path $Artifacts)
    {
        Remove-Item "$Artifacts/*" -Recurse -Force
    }

    New-Item -ItemType Directory -Path $Artifacts -Force

    # Temp
    #If let it run then error -> fatal: destination path 'ProjectTemplateGenerate3' already exists and is not an empty directory.
	#& git clone https://github.com/meAuthor/ProjectTemplateGenerate3.git

}, AfterClean

# Synopsis: Lint Code with PSScriptAnalyser
task Analyse BeforeAnalyse, {
    $scriptAnalyserParams = @{
        Path = $ModulePath
        Severity = @('Error', 'Warning')
        Recurse = $true
        Verbose = $false
    }

    $saResults = Invoke-ScriptAnalyzer @scriptAnalyserParams

    # Save Analyse Results as JSON
    $saResults | ConvertTo-Json | Set-Content (Join-Path $Artifacts "ScriptAnalysisResults.json")

    if ($saResults) {
        $saResults | Format-Table
        #throw "One or more PSScriptAnalyzer errors/warnings where found."
    }
}, AfterAnalyse

# Synopsis: Test the project with Pester. Publish Test and Coverage Reports
task RunTests {
    $invokePesterParams = @{
        OutputFile =  (Join-Path $Artifacts "TestResults.xml")
        OutputFormat = 'NUnitXml'
        Strict = $true
        PassThru = $true
        Verbose = $false
        EnableExit = $false
        CodeCoverage = (Get-ChildItem -Path "$ModulePath\*.ps1" -Exclude "*.Tests.*","*CallerPreference.*" -Recurse).FullName
    }

    # Publish Test Results as NUnitXml
    $testResults = Invoke-Pester @invokePesterParams;

    # Save Test Results as JSON
    $testresults | ConvertTo-Json -Depth 5 | Set-Content  (Join-Path $Artifacts "PesterResults.json")

    # Old: Publish Code Coverage as HTML
    # $moduleInfo = @{
    #     TestResults = $testResults
    #     BuildNumber = $BuildNumber
    #     Repository = $Settings.Repository
    #     PercentCompliance  = $PercentCompliance
    #     OutputFile =  (Join-Path $Artifacts "Coverage.htm")
    # }
    #
    # Publish-CoverageHTML @moduleInfo

    # Temp: Publish Test Report
    $options = @{
        BuildNumber = $BuildNumber
        GitRepo = $Settings.GitRepo
        GitRepoURL = $Settings.ProjectUrl
        CiURL = $Settings.CiURL
        ShowHitCommands = $true
        Compliance = ($PercentCompliance / 100)
        ScriptAnalyserFile = (Join-Path $Artifacts "ScriptAnalysisResults.json")
        PesterFile =  (Join-Path $Artifacts "PesterResults.json")
        OutputDir = "$Artifacts"
    }

    . ".\PSTestReport\Invoke-PSTestReport.ps1" @options
}

# Synopsis: Throws and error if any tests do not pass for CI usage
task ConfirmTestsPassed {
    # Fail Build after reports are created, this allows CI to publish test results before failing
    [xml] $xml = Get-Content (Join-Path $Artifacts "TestResults.xml")
    $numberFails = $xml."test-results".failures
    assert($numberFails -eq 0) ('Failed "{0}" unit tests.' -f $numberFails)

    # Fail Build if Coverage is under requirement
    $json = Get-Content (Join-Path $Artifacts "PesterResults.json") | ConvertFrom-Json

    # Allow to skip coverage test at first run
    if (!$overallCoverage -eq 0){
        $overallCoverage = [Math]::Floor(($json.CodeCoverage.NumberOfCommandsExecuted / $json.CodeCoverage.NumberOfCommandsAnalyzed) * 100)
        assert($OverallCoverage -gt $PercentCompliance) ('A Code Coverage of "{0}" does not meet the build requirement of "{1}"' -f $overallCoverage, $PercentCompliance)
    }
}

# Synopsis: Creates Archived Zip and Nuget Artifacts
task Archive BeforeArchive, {
    $moduleInfo = @{
        ModuleName = $ModuleName
        BuildNumber = $BuildNumber
    }

    Publish-ArtifactZip @moduleInfo

    $nuspecInfo = @{
        packageName = $ModuleName
        author =  $Settings.Author
        owners = $Settings.Owners
        licenseUrl = $Settings.LicenseUrl
        projectUrl = $Settings.ProjectUrl
        packageDescription = $Settings.PackageDescription
        tags = $Settings.Tags
        destinationPath = $Artifacts
        BuildNumber = $BuildNumber
    }

    Publish-NugetPackage @nuspecInfo
}, AfterArchive

# Synopsis: Publish to SMB File Share
task Publish BeforePublish, {
    $moduleInfo = @{
        RepoName = $Settings.SMBRepoName
        RepoPath = $Settings.SMBRepoPath
        ModuleName = $ModuleName
        ModulePath = "$ModulePath\$ModuleName.psd1"
        BuildNumber = $BuildNumber
    }

    Publish-SMBModule @moduleInfo -Verbose
}, AfterPublish

