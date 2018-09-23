###############################################################################
# Customize these properties and tasks
###############################################################################
param(
    $Artifacts = './artifacts',
	$ModuleName = "PSHitchhiker",
	$ModulePath = './PSHitchhiker',
    $PercentCompliance  = '60',
	#$BuildNumber = $env:BUILD_NUMBER
	$BuildNumber = '10'	
)

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
    LicenseUrl = 'https://github.com/psymonn/PSHitchhiker/LICENSE'
    ProjectUrl = "https://github.com/psymonn/PSHitchhiker"
    PackageDescription = 'descriptiopn'
    Repository = 'https://github.com/psymonn/PSHitchhiker.git'
    # TODO: fix any redudant naming
    GitRepo = "psymonn/PSHitchhiker"
    CIUrl = "http://localhost:8080/job/PSHitchhiker Pineline/"
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

