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

<#
    ? 5. What cmdlet might you use to write to an event log? (This one’s possible on non-
    ? Windows operating systems, but you’ll get a different answer.)
#>

# * Write-EventLog

<#
    ? 15 How many cmdlets are available that can deal with generic objects? (Hint:
    ? remember to use a singular noun like object rather than a plural one like objects.)
#>

$objectCmdlets = get-command -Noun object

Write-Host "The number of cmdlets that work on generic objects is " + $objectCmdlets.Length
Write-Host -foreground  green "List of object cmdlets: " + $objectCmdlets


