<#
 #======================================================================================================
 #  Author: DC
 #
 #  Description: A short script created to generate the ever elusive URLs for older versions of PolicyTech. After many
 #  cases spent badgering Sean and scouring KB's, Confluence, Salesforce, documentation for these URLs, I finally decided
 #  to get these into a central location for techs in the future. Alton had these files stored on his computer, and I 
 #  had one link for 10.5 that I could use, so this script was created to combine the file names with the URL I had and
 #  save a list of URLs to the shared drive.
 #
 #  If this script needs to be repurposed, change the $SourceFolder & $OutputFile paths to whatever you need.
 #  You might also want to change the $URLprefix as well. It doesn't need to be a URL, but maybe you want to combine
 #  file names with something else.
 #======================================================================================================
 #>

# Declares the starting point to look for files
$SourceFolder= "C:\Users\ahansen\Desktop\Programs"

# Gets a list of all the files in the source folder
$SourceFileList = Get-ChildItem -Path $SourceFolder # Use -Recursive option if desired to grab all files in source directory and the files in any child directories

# Sets the first part of the URL so other versions can be appended
$URLprefix = "http://update.policytech.com/"

# Initializes a blank array to store the URLs in when they've been created
$URLcomplete = @()

# Sets the file path and the name of the text file to be created when the script runs, so the URLs will have a place to be stored
$OutputFile = 'C:\Users\ahansen\Desktop\upgrade_URLs.txt'

# Loops through the list of files, so each filename that begins with update can be extracted and appended to the URLprefix
foreach ($file in $SourceFileList) {
    if ($file.Name -like "update*") {
        $URLcomplete += $URLprefix + $file.Name
    }
}

# Feeds the list of completed URLs into the text file which is created on the desktop
$URLcomplete | Out-File $OutputFile