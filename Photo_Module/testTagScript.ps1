﻿$ModulePath=Split-Path $MyInvocation.mycommand.Source -Parent
$TagSharpDLL=Join-Path $ModulePath 'taglib-sharp.dll'
[System.Reflection.Assembly]::LoadFile($TagSharpDLL)>$null

function Import-Photos {
    Param (
        [string] $SourceFolder = "C:\Users\Dalton\Documents\pscripts_repo\Photo_Module\Photo_Source",
        [string] $DestinationFolder = "C:\Users\Dalton\Documents\pscripts_repo\Photo_Module\Photo_Dest",
        [switch] $Move
    )

    # Create a list of files from source folder & a list of valid photo file types
    $SourceFileList = Get-ChildItem $SourceFolder -File
    $ValidFileTypes = ".jpg",".png"
    
    # loop through file list and check if the files are valid types, then execute logic inside if statements
    foreach ($file in $SourceFileList) {
        if ($file.extension -in $ValidFileTypes) {
            Write-Host "I'm a photo!"
            $photoTags = [TagLib.File]::Create($file.FullName)
            $photoDate = $photoTags.Tag.DateTime
            Write-Host "Tags: "$photoTags
            Write-Host "Date: " $photoTags.Tag.DateTime
            #Write-Host "$file date: $photoDate"
            #if ($move) {
            #    Move-Item -Path file.path

           # }
            

        }
        else {
        #Write-Host "$file I'm not a photo"
        }
    }
   
    Write-Host "Src: "$SourceFolder
    Write-Host "Dest: "$DestinationFolder
}

Import-Photos 
