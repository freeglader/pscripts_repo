<# 
2.	Create a cmdlet Import-Photos with the following features
    a.	Arguments
        i.	SourceFolder:  Location of image files to import, if omitted use current
        ii.	DestinationFolder:  Location to copy/move files if omitted use current
        iii.	Move:  switch parameter, moves files rather than copies files
    b.	Functionality
        i.	Move photos to destination creating a destination folder structure based on the date the photo was taken.
        ii.	Group photos by meaningful date range
        iii.	Support –Whatif
        iv.	Support –Verbose
#>
$ModulePath=Split-Path $MyInvocation.mycommand.Source -Parent
$TagSharpDLL=Join-Path $ModulePath 'taglib-sharp.dll'
[System.Reflection.Assembly]::LoadFile($TagSharpDLL)>$null

function Import-Photos {
    Param (
        [string] $SourceFolder = "./",
        [string] $DestinationFolder = "./",
        [switch] $Move
    )

    # Create a list of files from source folder & a list of valid photo file types
    $SourceFileList = Get-ChildItem $SourceFolder -File
    # $ValidFileTypes = ".jpg",".png"
    # loop through file list and check if the files are valid types, then execute logic inside if statements
    foreach ($file in $SourceFileList) {
       <# if ($file.extension -in $ValidFileTypes) { #>
            $photoTags = [TagLib.File]::Create($file.FullName)
            $date = $photoTags.Tag.DateTime
            
            Write-Host "Name: $file Date: $date"
           <# if ($move) {
                Move-Item -Path $file.FullName -Destination $DestinationFolder

            } #>
        # }
        <# else {
        Write-Host "$file I'm not a photo"
        } #>
    }
}

Import-Photos -SourceFolder "C:\Users\Dalton\Documents\pscripts_repo\Photo_Module\Photo_Source" -DestinationFolder "C:\Users\Dalton\Documents\pscripts_repo\Photo_Module\Photo_Dest"
<#
3.	Create a cmdlet named Rename-Photos
    a.	Arguments
        i.	SourceFolder:  Location to process: use current folder if none specified
        ii.	Recurse:  Switch to determine if we process sub folders
        iii.	NameRoot:  Folder where naming begins
        iv.	Separator:  Character used to separate elements in filename, default to “-“
        v.	Force: Switch to Rename all
    b.	Functionality
        i.	Rename photos based on folder location, separate elements of name with the Separator character.  Use some sort of id to distinguish individual pictures in a folder.
        ii.	Don’t rename files that already match folder location unless –force is specified 
        iii.	Validate separator character
        iv.	Support –Whatif
        v.	Support –Verbose
    c.  Provide Help for cmdlets
#>

function Rename-Photos {
    Param (
        [string] $SourceFolder,
        [Parameter(Switch)] $Recurse,
        [string] $NameRoot,
        [string] $Separator,
        [Parameter(switch)] $Force
    )


}

Import-Photos -SourceFolder .\Photo_Source