[CmdletBinding()]

param (
    [parameter(Position = 0)]
    [String]$BuildModule
)

function PrerequisitesLoaded {
    # Install required modules if missing
    try {
        if ((get-module InvokeBuild -ListAvailable) -eq $null) {
            Write-Output "Attempting to install the InvokeBuild module..."
            $null = Install-Module InvokeBuild -Scope:CurrentUser
        }
        if (get-module InvokeBuild -ListAvailable) {
            Write-Output -NoNewLine "Importing InvokeBuild module"
            Import-Module InvokeBuild -Force
            Write-Output '...Loaded!'
            return $true
        }
        else {
            return $false
        }
    }
    catch {
        return $false
    }
}

if (-not (PrerequisitesLoaded)) {
    throw 'Unable to load InvokeBuild!'
}

# If no parameters were specified or the build action was manually specified then kick off a standard build
if (($psboundparameters.count -eq 0) -or ($BuildModule)) {
    try {
        PrerequisitesLoaded
        Invoke-Build test -verbose
    }
    catch {
        Write-Output 'Build Failed with the following error:'
        Write-Output $_
    }
}

