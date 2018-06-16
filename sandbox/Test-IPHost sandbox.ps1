function Test-IPHost ($HostName,$Count = 1) {
    foreach ($name in $HostName) {
    Write-Host -Foreground "green" "Up-status for $name"
    $ip = ((Resolve-DnsName -Name $name).where({$_.Section -eq "Answer"})).IP4Address
        foreach ($i in $ip) {
            Write-Host -Foreground "magenta" "$i`: " -NoNewline
            Test-Connection $i -Count $Count -Quiet
        }
    }
}

Test-IPHost -HostName google.com,reddit.com,youtube.com
