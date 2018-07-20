$ModulePath=Split-Path $MyInvocation.mycommand.Source -Parent
$TagSharpDLL=Join-Path $ModulePath 'taglib-sharp.dll'
[System.Reflection.Assembly]::LoadFile($TagSharpDLL)>$null
$PhotoFile=Join-Path $ModulePath 'rainbow.jpg'
$PhotoTags= [TagLib.File]::Create($PhotoFile)
$Date = $PhotoTags.Tag.DateTime



