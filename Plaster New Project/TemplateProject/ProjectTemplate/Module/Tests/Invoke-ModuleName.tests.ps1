$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'

#since we match the srs/tests organization this works
#$here = $here -replace 'tests', 'PSHitchhiker'
<%
"`$here = `$here -replace `'tests`', `'$PLASTER_PARAM_ModuleName`'"
%>	
write-host "Invoke-PSHitchhiker.tests here: " $here
write-host "Invoke-PSHitchhiker.tests here\sut:"  "$here\Public\$sut"

. "$here\Public\$sut"

# Import our module to use InModuleScope
#Import-Module (Resolve-Path ".\PSHitchhiker\PSHitchhiker.psm1") -Force
<%
"Import-Module (Resolve-Path `".\$PLASTER_PARAM_ModuleName\$PLASTER_PARAM_ModuleName.psm1`") -Force"
%>	

#InModuleScope "PSHitchhiker" {
<%
"InModuleScope `"$PLASTER_PARAM_ModuleName`" {"
%>
<%
"    Describe `"Public/Invoke-ModuleName`" {"
"        Context `"Ask`" {"
"            It `"Asks a question`" {"
"                {Invoke-ModuleName -Ask `"Is the cake a lie?`" } | Should Not Throw"
"            }"
"            It `"specifies a format`" {"
"                {Invoke-ModuleName -Ask `"Is the cake a lie?`" -Format integer } | Should Not Throw"
"            }"
"        }"
"        Context `"Help`" {"
"            It `"gets the docs`" {"
"                {Invoke-ModuleName -Help } | Should Not Throw"
"             }"
"        }"
"    }"
"}"
%>