$ModulePath=Split-Path $MyInvocation.mycommand.Source -Parent
$TagSharpDLL=Join-Path $ModulePath 'taglib-sharp.dll'
[System.Reflection.Assembly]::LoadFile($TagSharpDLL)>$null
$PhotoFile= Join-Path $ModulePath 'F5E350E4-E5FD-4880-974B-2305FF7EFC6F.jpg'
$PhotoTags= [TagLib.File]::Create($PhotoFile)
$Date = $PhotoTags.Tag.DateTime

Write-Host "Date: " $Date