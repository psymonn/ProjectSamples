###############################################################################
# Customize these properties and tasks
###############################################################################
param(
    $Artifacts = './artifacts',
	$ModuleName = "ProjectTemplateGenerate2",
	$ModulePath = './ProjectTemplateGenerate2',
    $PercentCompliance  = '60',
	$BuildNumber = $env:BUILD_NUMBER
	#$BuildNumber = '1'
)

if (!$env:BUILD_NUMBER) {
    $BuildNumber = '1'
}

###############################################################################
# Static settings -- no reason to include these in the param block
###############################################################################
$Settings = @{
    #SMBRepoName = 'PsymonCorp'
    #SMBRepoPath = 'F:\Shared Folder\Repo'
    SMBRepoName = 'LocalNuGetFeed'
    SMBRepoPath = 'http://localhost:8087/nuget'
	Tags = ""
    Author = 'meAuthor'
	 Owners = 'A Team'
    LicenseUrl = 'https://github.com/meAuthor/ProjectTemplateGenerate2/LICENSE'
    ProjectUrl = "https://github.com/meAuthor/ProjectTemplateGenerate2"
    PackageDescription = 'dsaf'
    Repository = 'https://github.com/meAuthor/ProjectTemplateGenerate2.git'
    # TODO: fix any redudant naming
    GitRepo = "meAuthor/ProjectTemplateGenerate2"
    CIUrl = "http://localhost:8080/job/ProjectTemplateGenerate2 Pineline/"
}

###############################################################################
# Before/After Hooks for the Core Task: Clean
###############################################################################

# Synopsis: Executes before the Clean task.
task BeforeClean {}

# Synopsis: Executes after the Clean task.
task AfterClean {}

###############################################################################
# Before/After Hooks for the Core Task: Analyze
###############################################################################

# Synopsis: Executes before the Analyze task.
task BeforeAnalyse {}

# Synopsis: Executes after the Analyze task.
task AfterAnalyse {}

###############################################################################
# Before/After Hooks for the Core Task: Archive
###############################################################################

# Synopsis: Executes before the Archive task.
task BeforeArchive {}

# Synopsis: Executes after the Archive task.
task AfterArchive {}

###############################################################################
# Before/After Hooks for the Core Task: Publish
###############################################################################

# Synopsis: Executes before the Publish task.
task BeforePublish {}

# Synopsis: Executes after the Publish task.
task AfterPublish {}

###############################################################################
# Before/After Hooks for the Core Task: Test
###############################################################################

# Synopsis: Executes before the Test Task.
task BeforeTest {}

# Synopsis: Executes after the Test Task.
task AfterTest {}

