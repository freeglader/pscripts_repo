<#
    ? 4. How many cmdlets are available for working with processes? (Hint: remember
    ? that cmdlets all use a singular noun.)
#>

$processCmdlets = Get-Command *process*
$count = 0;
foreach ($p in $processCmdlets) {
	if ($p.CommandType -eq "Cmdlet") {
		$count += 1} else {continue}
		}
	write-host "The number of cmdlets related to processes is " $count

# The output for this is 11 cmdlets

