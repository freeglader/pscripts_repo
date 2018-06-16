function Test-IPHost ($HostName,$Count = 1) {
        foreach ($name in $HostName) {
        Write-Host -ForegroundColor "Magenta" "The `$name variable holds these values: " $name
        $ip = ((Resolve-DnsName $name).where({$_.Section -eq "Answer"})).IP4Address
        Write-Host -Foreground "green" $name ": " $ip
        Write-Host "The hostnames I tested are: " $HostName
        Write-Host "Value in `$args is: " $args
    }


}

Test-IPHost -HostName google.com,reddit.com,youtube.com