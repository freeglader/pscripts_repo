$SourceFolder= "C:\Users\x\Documents\Documentation"
$SourceFileList = Get-ChildItem -Path $SourceFolder

$URLprefix = "http://update.policytech.com/"
$URLsuffix = @()
$URLcomplete = @()

$OutputFile = 'C:\Users\x\Desktop\upgrade_URLs.txt'

foreach ($file in $SourceFileList) {
    if ($file.Name -like "update*") {
        $URLcomplete += $URLprefix + $file.Name
    }
    
}

$URLcomplete | Out-File $OutputFile

