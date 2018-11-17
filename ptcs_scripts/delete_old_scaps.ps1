<#
    This script will delete old screenshots from the GreenShot folder. Given the number of screenshots I take on a daily basis for clients, I need a way to minimize the amount of junk stored on my system.

    * GOALS
      
      TODO: Move screenshots to folder "pending_deletion" after 1 week
      TODO: Script will delete screenshots after age has surpassed 2 weeks   
      TODO: If screenshot has been renamed to something other than the default naming conventions set in Greenshot, do not delete
        ? To accomplish this, perhaps filter out files that begin with a year? Eg. the naming convention sets document names to ${capturetime:d"yyyy-MM-dd HH_mm_ss"}-${title}
        ? filter out files beginning with 2018, 2019, 2020.
        * better yet, use a function that gets the current datetime and pulls the year in order to filter instead of manually entering years. 
#>

$sourceDir = "C:\Users\dacole\Pictures\Greenshot\"
$pendingDir = "C:\Users\dacole\Pictures\Greenshot\Pending Deletion"
$sourceFileList = Get-ChildItem $sourceDir -File
$pendingFileList = Get-ChildItem $pendingDir -File

#* Moves files from $sourceDir to $pendingDir if they are more than 7 days old and do not have a year in the file name (default naming convention for greenshot)
foreach ($file in $sourceFileList) {

    $today = Get-Date
    [string] $yearString = $today.Year
    $fileDate = $file.CreationTime
    # Gets days between today and the file creation date
    $fileAge = $($today - $fileDate).Days
    
    if ($fileAge -gt 7 -and $file.Name -like "*$yearString*") {

        Move-Item -LiteralPath $sourceDir\$file -Destination $pendingDir  
    }
    e
}
#* Deletes files from $pendingDir after 2 weeks
foreach ($file in $sourceFileList) {

    $today = Get-Date
    [string] $yearString = $today.Year
    $fileDate = $file.CreationTime
    # Gets days between today and the file creation date
    $fileAge = $($today - $fileDate).Days
    
    if ($fileAge -gt 7 -and $file.Name -like "*$yearString*") {

        Move-Item -LiteralPath $sourceDir\$file -Destination $pendingDir
        
    }
}
