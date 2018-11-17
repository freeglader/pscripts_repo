$sourceDir = "C:\Users\dacole\Desktop\Greenshot"
$sourceFileList = Get-ChildItem $sourceDir -File

# Get the file datetime
foreach ($file in $sourceFileList) {
    
    $today = Get-Date
    $fileDate = $file.CreationTime
    $fileAge = $($today - $fileDate).Days
    
}