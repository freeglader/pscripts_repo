#===================================================
# Program Name : Netutils
# Author: <Dalton Cole>
# I, Dalton Cole, wrote this script as original work completed by me.
# Your Network Utility:  <describe your network utility here>
# Support functions: Describe your network support functions.
#===================================================

<#
    3. #! Function 1
        a. #! Description:  Function takes a hostname, determines the IP address(es) for the host and pings each IP address to determine if it is online.  Return output that shows results of ping.
        b. #! Name: 
            i. #todo: Test-IPHost
        c. #! Parameters:  
            i. #todo: –HostName  (name of host to ping)
            ii. #todo: -Count:  Optional Number of times to ping the device
        d. #! Features:  
            i. #todo: Provide an appropriate error if the host is not found
            ii. #todo: Allow multiple hostnames to be tested
#>
#? $a = Resolve-DnsName google.com
#? $a = array
#? $a[0].IP4Address = IP
#? A records are IPv4, AAAA records are IPv6

function Test-IPHost ($HostName,$Count) {
        $ip = $((Resolve-DnsName $HostName).IP4Address)
        $ip
}

Test-IPHost -HostName google.com


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





<#
    5. #! Function 3
        a. #! Description:  Given an IP address and a Subnet mask return the network ID
        b. #! Name: 
            i. #todo: Get-IPNetID
        c. #! Parameters
            i. #todo: –IP:  IP address to test
            ii. #todo: –SubnetMask:  Optional, Subnet Mask to test
        d. #! Features
            i. #todo: Allow subnet mask to be entered in CIDR or dotted decimal format.
            ii. #todo: Validate IP address and subnet mask, return error if they are not valid.
            iii. #todo: If no subnet mask is entered use the class full subnet mask based on the IP address
#>





<#
    6. #! Function 4
        a. #todo: You get to make your own network utility, it can do whatever you want, have fun and be creative
#>

