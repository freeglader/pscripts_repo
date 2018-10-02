<#
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$baseUrl = "https://dcole.policytech.com"
# $siteUrl = $baseUrl + "/dotnet/noauth/login.aspx?ReturnUrl=%2fdotnet%2fdb%2fdownloadlatestbackup.aspx"

$username = "admin"
$password = "admin"


$URI = "https://dcole.policytech.com/?auto=false#/DocumentExport"
$HTML = Invoke-WebRequest -Uri $URI

# Using "$HTML.ParsedHtml | gm" shows you methods you can use against the HTML document
#> 

$baseUrl = "https://dcole.policytech.com"
    
    $fileLocation = "C:\Users\dacole\Documents\PowerShell Scripts\test_nightly_backup.bak"
    $username = "admin"
    $password = "admin"
    $domain = 0

    $siteUrl = $baseUrl + "/dotnet/noauth/login.aspx?ReturnUrl=%2fdotnet%2fdb%2fdownloadlatestbackup.aspx"
    $logoutUrl = $baseUrl + "/dotnet/logout/logout.aspx"

    $response = Invoke-WebRequest -Uri $siteUrl -Method Default -SessionVariable rb -MaximumRedirection 10

    $form = $response.Forms[0]
    $form.Fields['ctl00$ContentBody$UIDUsername'] = $username
    $form.Fields['ctl00$ContentBody$UIDPassword'] = $password
    $form.Fields['ctl00$ContentBody$UIDDomain'] = 0
    $form.Fields["__EVENTTARGET"] = 'ctl00$ContentBody$btnLogin'

    Invoke-WebRequest -Uri $siteUrl -Method POST -Body $response -WebSession $rb -MaximumRedirection 10 -OutFile $fileLocation
    $logoutResponse = Invoke-WebRequest -Uri $logoutUrl -WebSession $rb

