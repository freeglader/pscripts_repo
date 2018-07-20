$ModulePath=Split-Path $MyInvocation.mycommand.Source -Parent
$TagSharpDLL=Join-Path $ModulePath 'taglib-sharp.dll'
[System.Reflection.Assembly]::LoadFile($TagSharpDLL)>$null
$PhotoFile= Join-Path $ModulePath 'Rainbow.jpg'
$PhotoTags= [TagLib.File]::Create($PhotoFile)
$Date = $PhotoTags.Tag.DateTime

Write-Host "Date: " $Date