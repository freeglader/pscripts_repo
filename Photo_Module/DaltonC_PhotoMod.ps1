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