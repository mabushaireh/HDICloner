$content = get-content "..\HDICloner\HDICloner.psd1"
$currentVersionString =  $content | Where-Object { $_.Contains("ModuleVersion = ") } | foreach-object {$_ -replace "ModuleVersion = ", ""}
$currentVersion = [version]($currentVersionString -replace "'", "" )
"Current version is $currentVersion"
$newVersion = "{0}.{1}.{2}.{3}" -f $currentVersion.Major, $currentVersion.Minor, $currentVersion.Build, ($currentVersion.Revision + 1)
"New version is $newVersion"
 
$content -replace "ModuleVersion = '$currentVersion'", "ModuleVersion = '$newVersion'" | Set-Content "..\HDICloner\HDICloner.psd1"


$content = get-content "..\HDICloner\HDICloner.psm1"
$content = $content -replace ("ScriptVersion = '" +  $currentVersion + "'"),  ('ScriptVersion = ''' +  $newVersion + "'") | Set-Content "..\HDICloner\HDICloner.psm1"

Publish-Module -Path "..\HDICloner" -NuGetApiKey oy2pqk3b6jh6uhjvc26qjjwahiiheukeljqntxmoyhqjga