$FilesPath = "C:\Program Files (x86)\"
$PTPath = "C:\Program Files (x86)\Policy Technologies\"
$DlPath = "C:\Users\dacole\Downloads\"

$FilesPathFiles = Get-ChildItem $FilesPath -Recurse
$PTPathFiles = Get-ChildItem $PTPath -Recurse
$DlPathFiles = Get-ChildItem $DlPath -Recurse

foreach ($file in $FilesPathFiles) {
    if ($file.Name -like "*session*") {
        Write-Host -ForegroundColor "green" "File name: " -NoNewline
        Write-Host $file.FullName
    }

}