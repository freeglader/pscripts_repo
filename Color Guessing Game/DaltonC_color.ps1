#===================================================
# Program Name : Color
# Author: Dalton Cole
# I, Dalton Cole, wrote this script as original work completed by me.
# Special Feature:  <describe your special feature here>
#===================================================
# Hashtables for all the console colors
# The purpose of using hashtables is to be able to track which colors the user has already guessed in order to provide stats.
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

# Put all the hashtables of console colors into an array
$validColors= $Black,$DarkBlue,$DarkGreen,$DarkCyan,$DarkRed,$DarkMagenta,$DarkYellow,$Gray,$DarkGray,$Blue,$Green,$Cyan,$Red,$Magenta,$Yellow,$White

# Begin the round
do {
    Write-Host "Let's play a game, I have a favorite color, and you have to guess it. The valid colors you can guess are as follows: "
    # Prints a list of all the values for "color" in the hashtables using the $validColors array
    foreach ($color in $validColors) {$color.color}
    # Get the random color for the round and assign it to a variable
    $randomColor = Get-Random $validColors
    do {
        try {
            # Prompt the user to enter a guess and record the guess in a variable
            $guess = Read-Host -Prompt "What is your guess?"
            if ($guess.ToLower() -notin $validColors.color.ToLower()) {
                throw
            }
        }
        catch {
            Write-Host "Your guess must be one of the valid colors."
            continue
        }
        if ($guess.ToLower() -ne $randomColor.color.ToLower()) {
            Write-Host "Sorry, $guess not my favorite color."
        }
        
    }
    until ($guess -eq $randomColor.color)
    if ($guess -eq $randomColor.color) {
        Write-Host "Congrats u won!"
    }

    $a = Read-Host -Prompt "Would you like to play again? (Y/n)"
    if ($a -eq "y") {
        $playAgain = $true
    }
    elseif ($a -eq "n") {
        $playAgain = $false
        Write-Host "Goodbye now!"
    }
} while ($playAgain -eq $true)
