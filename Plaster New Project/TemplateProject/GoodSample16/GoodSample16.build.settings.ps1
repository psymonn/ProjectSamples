###############################################################################
# Customize these properties and tasks
###############################################################################
param(
    $Artifacts = './artifacts',
	$ModuleName = "GoodSample16",
	$ModulePath = './GoodSample16',
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
    Author = 'psymonn'
	 Owners = 'A Team'
    LicenseUrl = 'https://github.com/psymonn/GoodSample16/LICENSE'
    ProjectUrl = "https://github.com/psymonn/GoodSample16"
    PackageDescription = 'test describ'
    Repository = 'https://github.com/psymonn/GoodSample16.git'
    # TODO: fix any redudant naming
    GitRepo = "psymonn/GoodSample16"
    CIUrl = "http://localhost:8080/job/GoodSample16 Pineline/"
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
task BeforeAnalyze {}

# Synopsis: Executes after the Analyze task.
task AfterAnalyze {}

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

