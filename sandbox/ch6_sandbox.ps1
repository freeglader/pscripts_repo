<#
#Functions up in this lil bitty
#>

Set-Alias -Name wh -Value Write-Host

# Super simple function
function whatup {
    
    wh "What's up!" -Foreground "green"

}

$a = Read-Host -Prompt "Say hello"

if ($a -ne $null) {
    whatup
}

#@ Function using $arg parameters

function argwhatup {
    $OFS = ", "
    "What's up $arg!"
}

$b = Read-Host -Prompt "What is your name?"

if ($b -ne $null) {
    argwhatup $b
}
