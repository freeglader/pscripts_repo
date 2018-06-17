#===================================================
# Program Name : Netutils
# Author: <Dalton Cole>
# I, Dalton Cole, wrote this script as original work completed by me.
# Your Network Utility:  <describe your network utility here>
# Support functions: Describe your network support functions.
#===================================================

#! Genius way to convert binary strings into IPv4 addresses
<#
 $a=$i=$null

"11111111","11111111","11111000","00000000" |

 % {

     $i++

     [string]$a += [convert]::ToInt32($_,2)

     if($i -le 3) {[string]$a += "."}

   }

$a
#>
# pushing to repo from new pc test
#! Functions for Repeatable tasks
$convertedIP=$null
$counter = $null
function Convert-CIDR ($cidr){
 if($cidr -le 32){
 [Int[]]$totalBits = (1..32)
 for($i=0;$i -lt $totalBits.length;$i++){
 if($totalBits[$i] -gt $cidr){$totalBits[$i]="0"}else{$totalBits[$i]="1"}
 }
 $cidr = $totalBits -join ""
 #Write-Host -Foreground "green" $cidr.Substring(0,8)
 #Write-Host -Foreground "green" $cidr.Substring(24,8)
 $octetArray = @($cidr.Substring(0,8), $cidr.Substring(8,8), $cidr.Substring(16,8), $cidr.Substring(24,8))
 $octetArray | foreach { 
        $counter++
        [string]$convertedIP += [convert]::ToInt32($_,2)
        #! Counts octets so it can add a "." after each octet except the last.
        #? (might want to change this to a join)
        if($counter -le 3) {[string]$convertedIP += "."}
    }
 }
    return $convertedIP
}

<#
    3. #? Function 1
        a. #* Description:  Function takes a hostname, determines the IP address(es) for the host and pings each IP address to determine if it is online.  Return output that shows results of ping.
        b. #* Name: 
            i. #* Test-IPHost
        c. #* Parameters:  
            i. #* –HostName  (name of host to ping)
            ii. #* -Count:  Optional Number of times to ping the device
        d. #? Features:  
            i. #todo: Provide an appropriate error if the host is not found
            ii. #* Allow multiple hostnames to be tested
#>

function Test-IPHost ($HostName,$Count = 1) {
    foreach ($name in $HostName) {
    Write-Host -Foreground "green" "Up-status for $name"
    $ip = ((Resolve-DnsName -Name $name).where({$_.Section -eq "Answer"})).IP4Address
        foreach ($i in $ip) {
            $upStatus = Test-Connection $i -Count $Count -Quiet
            Write-Host -Foreground "magenta" "$i`: " -NoNewline
            $(if($upStatus -eq $True){Write-Host -Foreground "green" "Up"} else {Write-Host -Foreground "red" "down"})
            
        }
    }
}

# Test-IPHost -HostName google.com,reddit.com,youtube.com


<#
    4. #! Function 2
        a. #! Description:  The second function is used to determine if two IP addresses are on the same network.  Return a $true it they are a $false if they are not.  
        b. #todo: Name: Test-IPNetwork
        c. #! Parameters
            i. #todo: -IP1, -IP2:  IP addresses to test
            ii. #todo: –SubnetMask:  Subnet mask to use in tests
        d. #! Features
            i. #todo: Allow subnet mask to be entered in CIDR or dotted decimal format.
            ii. #todo: Validate IP address and subnet mask, return error if they are not valid.
#>

function Test-IPNetwork () {
    Param(
        [Parameter(Mandatory=$true)]
        [Net.IPAddress] $IP1,

        [Parameter(Mandatory=$true)]
        [Net.IPAddress] $IP2,

        [Parameter(Mandatory=$true)]
        [string] $SubnetMask
    )
    if ($SubnetMask.length -lt 3) {
        #$SubnetMask.length
        #$SubnetMask.gettype()
        [Net.IPAddress]$SubnetMask = Convert-CIDR $SubnetMask
        Write-Host -foreground "green" "the converted cidr mask is: " $SubnetMask
    }
    else {[Net.IPAddress]$SubnetMask = $SubnetMask}

    if (($IP1.address -band $SubnetMask.address) -eq ($IP2.address -band $SubnetMask.address)) {
        Write-Host "The addresses you entered are on the same network."
        Write-Host -ForegroundColor "green" "The subnet mask is " $SubnetMask
        "IP1 = " + $IP1.gettype()
        "IP2 = " + $IP2.gettype()
        "SubnetMask = " + $SubnetMask.gettype()

    }
    else {
        Write-Host "The addresses you entered are not on the same network."
        "IP1 = " + $IP1.gettype()
        "IP2 = " + $IP2.gettype()
        "SubnetMask = " + $SubnetMask.gettype()
    }
}

#* Test-IPNetwork 192.168.10.5 172.16.15.5 255.255.255.0
# bitconverter class gets bytes out of something (ip address)
# hash table with bits as key and netmask as value? 11111111 = 255?
 
#[net.IPaddress]$SubnetMask = $SubnetMask
# $globalVARforSubnetMask = New-CidrToIPAdd 24
# $globalVARforSubnetMask
<#
    5. #! Function 3
        a. #! Description:  Given an IP address and a Subnet mask return the network ID
        b. #* Name: 
            i. #*: Get-IPNetID
        c. #! Parameters
            i. #*: –IP:  IP address to test
            ii. #*: –SubnetMask:  Optional, Subnet Mask to test
        d. #! Features
            i. #*: Allow subnet mask to be entered in CIDR or dotted decimal format.
            ii. #todo: Validate IP address and subnet mask, return error if they are not valid.
            iii. #*: If no subnet mask is entered use the class full subnet mask based on the IP address
#>

function Get-IPNetID {
    Param(
        [Parameter(Mandatory=$true)]
        [Net.IPAddress] $IP,

        [Parameter()]
        [string] $SubnetMask
    )

    if ($SubnetMask.length -lt 3 -and $SubnetMask.Length -gt 0) {
        Write-Host -ForegroundColor "red" "-------------------------------DEBUGGING-----------------------------------"
        "SubnetMask: " + $SubnetMask
        "SubnetMask.Length: " + $SubnetMask.Length
        "SubnetMask.GetType(): " + $SubnetMask.GetType()
        Write-Host -ForegroundColor "red" "---------------------------------------------------------------------------"

        [Net.IPAddress]$SubnetMask = Convert-CIDR $SubnetMask
        Write-Host -foreground "green" "the converted cidr mask is: " $SubnetMask
    }
    elseif ($SubnetMask.Length -eq 0) {
        Write-Host "You did not provide a subnetmask - the default classful netmask will be used."
        [string]$IP = $IP.IPAddressToString
        $IParray = "$IP" -split ".",0,'SimpleMatch'
        if ([int]$IParray[0] -in 1..127) {
            if ($IParray[0] -eq 127 -and ($IParray[1] -in 0..255)) {
                Write-Host -Foreground "blue" "IP address provided is part of reserved range for loopback addresses, it uses a /8 mask"
                [Net.IPAddress]$SubnetMask = Convert-CIDR 8
            }
            else {
                Write-Host "Using Class A default mask..."
                [Net.IPAddress]$SubnetMask = Convert-CIDR 8
                $SubnetMask.IPAddressToString 
            }
        }
        elseif ([int]$IParray[0] -in 128..191) {
            if ($IParray[0] -eq 172 -and ($IParray[1] -in 16..31)) {
                Write-Host -Foreground "blue" "IP address provided is part of reserved range that uses a /12 mask"
                [Net.IPAddress]$SubnetMask = Convert-CIDR 12
            }
            else {
                Write-Host "Using Class B default mask..."
                [Net.IPAddress]$SubnetMask = Convert-CIDR 16
                $SubnetMask.IPAddressToString 
            }           
        }
        elseif ([int]$IParray[0] -in 192..223) {
            if ($IParray[0] -eq 192 -and $IParray[1] -eq 168) {
                Write-Host -Foreground "blue" "IP address provided is part of reserved range that uses a /16 mask"
                [Net.IPAddress]$SubnetMask = Convert-CIDR 16
            }
            else {
                Write-Host "Using Class C default mask..."
                [Net.IPAddress]$SubnetMask = Convert-CIDR 24
                $SubnetMask.IPAddressToString
            }
            
        }
    }
    else {[Net.IPAddress]$SubnetMask = $SubnetMask}
    [Net.IPAddress]$IP = $IP
    [Net.IPAddress]$netID = $IP.Address -band $SubnetMask.address
    Write-Host -Foreground "green" "The network ID for $IP is" $netID

}   

Get-IPNetID 172.30.5.10


<#
    6. #! Function 4
        a. #todo: You get to make your own network utility, it can do whatever you want, have fun and be creative
#>

