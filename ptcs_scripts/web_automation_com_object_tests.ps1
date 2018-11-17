<#
This script will use COM objects to create an instance of Internet Explorer and automate that way instead of using Invoke-WebRequest.
Might be easier this way to automate PT stuff.
#>
# stuff
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"

function Invoke-IEWait {
    [cmdletbinding()]
    Param(
        [Parameter(
            Mandatory,
            ValueFromPipeLine
        )]
        $ieObject
    )

    While ($ieObject.Busy) {

        Start-Sleep -Milliseconds 10

    }

}

$ieobject = New-Object -ComObject 'InternetExplorer.Application'

$ieobject.Visible = $true
# For some reason, Navigate2 works but Navigate does not. Navigate method erases the content of the document.
$ieobject.Navigate('http://cltitvcorpmar01/IWP/Marquee/p/Client%20Support%20-%20Display%201c/')
# THIS IS WHY. It needed to pause for a little bit to let the site load. Duh. 
$ieobject | Invoke-IEWait
$currentDocument = $ieobject.Document
# $currentDocument.IHTMLDocument3_getElementsByTagName("input") | Select-Object Type,Name
$downloadLink = $currentDocument.links | Where-Object {$_.outerText -eq 'Download'} | Select-Object -ExpandProperty href
$downloadLink