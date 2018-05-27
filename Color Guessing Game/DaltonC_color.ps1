#===================================================
# Program Name : Color
# Author: Dalton Cole
# I, Dalton Cole, wrote this script as original work completed by me.
# Special Feature:  <describe your special feature here>
#===================================================
# Hashtables for all the console colors

$validColors= "Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White"
$attempts = 0
[System.Collections.ArrayList]$guessedWrong = @()
$targetGuess = "guessPrompt"


function Show-Menu
{
     param (
           [string]$Title = 'Menu'
     )
     cls
     Write-Host "================ $Title ================"
    
     Write-Host "1: Press '1' to return to game"
     Write-Host "2: Press '2' to list valid colors"
     Write-Host "3: Press '3' to list colors you have guessed for this round"
     Write-Host "4: Press '4' to reveal a hint"
     Write-Host "Q: Press 'Q' to quit round"
}

# Begin the round
do {
    Write-Host "Let's play a game, I have a favorite color, and you have to guess it. The valid colors you can guess are as follows: "
    # Prints a list of all the valid console colors in their respective color
    foreach ($color in $validColors) {Write-Host $color -ForegroundColor $color}
    # Get the random color for the round and assign it to a variable
    $randomColor = Get-Random $validColors

    :guessPrompt do {
        try {
            # Prompt the user to enter a guess and record the guess in a variable
            $guess = Read-Host -Prompt "What is your guess? (Press 'm' for menu)"
            if ($guess -notin $validColors -and $guess -ne "m") {
                throw
            }
        }
        catch {
            Write-Host "Your guess must be one of the valid colors."
            continue
        }
        # display menu if user presses 'm' at prompt
        if ($guess -eq "m") {
            # this ":menuPrompt" line is a target to return to when "continue $targetname" is called in the loop
            do {
                # call the menu function
                Show-Menu
                $input = Read-Host "Please make a selection"
                # all menu options and respective code
                switch ($input) {
                    '1' {
                        # return to game
                        cls
                        # brings user back to the guess prompt with ":guessPrompt" target
                        continue $targetGuess
                    } '2' {
                        # list valid colors
                        cls
                        foreach ($color in $validColors) {Write-Host $color -ForegroundColor $color}
                        continue
                    } '3' {
                        # list guesses made this round
                        cls
                        # check if user has made any guesses and provide appropriate response                        
                        if ($guessedWrong.length -ne 0) {
                            "Colors guessed this round:"
                            foreach ($color in $guessedWrong) {Write-Host $color -ForegroundColor $color}
                            continue
                        }
                        else {
                            "You have not made any guesses. Please return to game to make your guess"
                            continue $targetGuess
                        }
                        
                    } '4' {
                        # provide user with hint (1st letter of color)
                        cls
                        "My favorite color begins with the letter '" + ($randomColor.Substring(0,1)) + "'"
                        continue
                    } 'q' {
                        return
                    }
                }
                pause
            }
            until ($input -eq 'q')
        }
        if ($guess -ne $randomColor) {
            Write-Host "Sorry, " -NoNewline
            Write-Host $guess -ForegroundColor $guess -NoNewline
            Write-Host " is not my favorite color."
            $guessedWrong.Add("$guess") > $null
            Write-Host "Correct answer is " -NoNewline
            $randomColor
        }
        $attempts += 1
        
    }
    until ($guess -eq $randomColor)
    if ($guess -eq $randomColor) {
        Write-Host "Congrats, you won! My favorite color was " -NoNewline
        Write-Host $randomColor -ForegroundColor $randomColor -NoNewline
        Write-Host ". You guessed incorrectly" ($attempts -1) -NoNewline
        Write-Host " time(s), and guessed correctly on try number" $attempts
        Write-Host "These are the colors you guessed incorrectly: "
        foreach ($color in $guessedWrong) {Write-Host $color -ForegroundColor $color}
    }

    $a = Read-Host -Prompt "Would you like to play again? (Y/n)"
    if ($a -eq "y") {
        $playAgain = $true
        $attempts = 0
        $guessedWrong = @()
    }
    elseif ($a -eq "n") {
        $playAgain = $false
        Write-Host "Goodbye now!"
    }
} while ($playAgain -eq $true)
