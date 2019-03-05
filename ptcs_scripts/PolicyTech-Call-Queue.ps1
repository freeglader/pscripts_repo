$url ='http://www.gamestop.com/nintendo-switch/consoles/nintendo-switch-console-with-neon-blue-and-neon-red-joy-con/141887'
 
While ($($InStock -eq $notInStock)){
$response = Invoke-WebRequest -Uri $url
$classname ='ats-prodBuy-inventory'
$notInStock = 'Currently unavailable online'
 
$InStock = $response.ParsedHtml.body.getElementsByClassName($classname) | select -expand innertext
"$(get-date) is device in stock? $($InStock -ne $notInStock)`n-----$InStock"
Start-Sleep -Seconds (60*30)
}
Send-PushMessage -Type Message -title "NintendoSwitch" -msg "In stock, order now!!!!"

#>

# class names = current_statistics


$URI = "http://cltitvcorpmar01/IWP/Marquee/p/Client%20Support%20-%20Display%201c/"

$response = Invoke-WebRequest -Uri $URI

$classname = "current_statistics*"

$testclass = $response.ParsedHtml.body