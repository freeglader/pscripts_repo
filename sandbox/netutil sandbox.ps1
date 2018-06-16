 $convertedIP=$null
 $counter = $null

function CIDR-ToDecimal ($cidr){
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
        if($counter -le 3) {[string]$convertedIP += "."}
    }
 }
    $convertedIP
}

CIDR-ToDecimal 8
