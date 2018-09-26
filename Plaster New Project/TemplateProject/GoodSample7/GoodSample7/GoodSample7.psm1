$functionFolders = @('Public', 'Private')
ForEach ($folder in $functionFolders)
{
    $folderPath = Join-Path -Path $PSScriptRoot -ChildPath $folder
    If (Test-Path -Path $folderPath)
    {
        Write-Verbose -Message "Importing from $folder"
        $functions = Get-ChildItem -Path $folderPath -Filter '*.ps1' 
        ForEach ($function in $functions)
        {
            Write-Verbose -Message "  Importing $($function.BaseName)"
            . $($function.FullName)
        }
    }    
}

# Non-function exported public module members might go here.
#Export-ModuleMember -Variable SomeVariable -Function  *
$publicFunctions = (Get-ChildItem -Path "$PSScriptRoot\Public" -Filter '*.ps1').BaseName
Export-ModuleMember -Function $publicFunctions

# Use this in your scripts to check if the function is being called from your module or independantly.
$ThisModuleLoaded = $true
