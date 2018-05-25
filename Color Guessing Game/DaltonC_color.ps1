#===================================================
# Program Name : Color
# Author: Dalton Cole
# I, Dalton Cole, wrote this script as original work completed by me.
# Special Feature:  <describe your special feature here>
#===================================================
# Hashtables for all the console colors
$Black=@{color = "Black"; guessed = $false}
$DarkBlue=@{color = "DarkBlue"; guessed = $false}
$DarkGreen=@{color = "DarkGreen"; guessed = $false}
$DarkCyan=@{color = "DarkCyan"; guessed = $false}
$DarkRed=@{color = "DarkRed"; guessed = $false}
$DarkMagenta=@{color = "DarkMagenta"; guessed = $false}
$DarkYellow=@{color = "DarkYellow"; guessed = $false}
$Gray=@{color = "Gray"; guessed = $false}
$DarkGray=@{color = "DarkGray"; guessed = $false}
$Blue=@{color = "Blue"; guessed = $false}
$Green=@{color = "Green"; guessed = $false}
$Cyan=@{color = "Cyan"; guessed = $false}
$Red=@{color = "Red"; guessed = $false}
$Magenta=@{color = "Magenta"; guessed = $false}
$Yellow=@{color = "Yellow"; guessed = $false}
$White=@{color = "White"; guessed = $false}

$validColors= $Black,$DarkBlue,$DarkGreen,$DarkCyan,$DarkRed,$DarkMagenta,$DarkYellow,$Gray,$DarkGray,$Blue,$Green,$Cyan,$Red,$Magenta,$Yellow,$White

do {
    Write-Host "Let's play a game, I have a favorite color, and you have to guess it. The valid colors you can guess are as follows: "
    foreach ($color in $validColors) {$color.color}
    $a = Read-Host -Prompt "Would you like to play again? (Y/n)"
    if ($a -eq "y") {
        $playAgain = $true
    }
    elseif ($a -eq "n") {
        $playAgain = $false
        Write-Host "Goodbye now!"
    }
} while ($playAgain -eq $true)
