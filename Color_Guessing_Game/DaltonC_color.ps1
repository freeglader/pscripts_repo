#===================================================
# Program Name : Color
# Author: Dalton Cole
# I, Dalton Cole, wrote this script as original work completed by me.
# Special Feature:  <Created a menu using switch statements that can be accessed during the game>
#===================================================
# Hashtables for all the console colors

# valid console colors
$validColors= "Black","DarkBlue","DarkGreen","DarkCyan","DarkRed","DarkMagenta","DarkYellow","Gray","DarkGray","Blue","Green","Cyan","Red","Magenta","Yellow","White"
# initialize color guess attempts var
$attempts = 0
# a hashtable to match rounds won with the time it took to win
$winTimes = [ordered]@{}
# initialize rounds counter var
$rounds = 0
# initialize arraylist to record incorrect guesse
[System.Collections.ArrayList]$guessedWrong = @()
# target to direct execution flow
$targetGuess = "guessPrompt"

# function that displays menu
function Show-Menu
{

     cls
     Write-Host "================ Menu ================"
    
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
    # start stopwatch
    $timer = [system.diagnostics.stopwatch]::StartNew()

    # begin guessing loop
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
                        # quit game early
                        "Sorry to see you go! You didn't finish this round, but here are your stats: "
                        # How long it took to win each game
                        Write-Host "Games and Win Times: "
                        $winTimes
                        # How many games were played
                        Write-Host "# of Games Played: " -NoNewline
                        $rounds
                        # Average time to win
                        Write-Host "Average Win Time: "
                        foreach ($pair in $winTimes.GetEnumerator()) {
                            $totalTime += $pair.value
                            $avgTime = $totalTime / $rounds
                        }
                        Write-Host $avgTime " seconds"
                        return
                    }
                }
                pause
            }
            until ($input -eq 'q')
        }
        # incorrect guess response
        if ($guess -ne $randomColor) {
            Write-Host "Sorry, " -NoNewline
            Write-Host $guess -ForegroundColor $guess -NoNewline
            Write-Host " is not my favorite color."
            # add incorrect guesses to arraylist, throw annoying output in the trash
            $guessedWrong.Add("$guess") > $null
            # for quick and easy debugging
            # Write-Host "Correct answer is " -NoNewline
            # $randomColor
        }
        # increment guess attempts
        $attempts += 1
        
    }
    until ($guess -eq $randomColor)
    if ($guess -eq $randomColor) {
        # stop timer for the round
        $timer.Stop()
        # increment round
        $rounds += 1
        # get rounded time of round... round. lol
        $roundTime = ([math]::Round($timer.Elapsed.TotalSeconds,0))
        # add match to hashtable, consisting of the round number and time to win in seconds.
        $winTimes.Add("round$rounds",$roundTime)
        # let the user know they won!
        Write-Host "Congrats, you won! My favorite color was " -NoNewline
        Write-Host $randomColor -ForegroundColor $randomColor -NoNewline
        # some round based stats
        Write-Host ". You guessed incorrectly" ($attempts -1) -NoNewline
        Write-Host " time(s), and guessed correctly on try number" $attempts "."
        Write-Host "This round took you " $roundTime " seconds!"
        Write-Host "These are the colors you guessed incorrectly: "
        foreach ($color in $guessedWrong) {Write-Host $color -ForegroundColor $color}
              
    }
    # rematch 
    try {
        $rematchPrompt = Read-Host -Prompt "Would you like to play again? (Y/n)"
        if ($rematchPrompt -ne "y" -and $rematchPrompt -ne "n") {
            throw
        }
    }
    catch {
        Write-Host "Invalid input, please try again."
        continue
    }
    # starts game again, re-initializes variables, resets timer
    if ($rematchPrompt -eq "y") {
        $playAgain = $true
        $attempts = 0
        $guessedWrong = @()
        $timer.reset()
    }
    # quits game and provides more stats
    elseif ($rematchPrompt -eq "n") {
        $playAgain = $false
        Write-Host "Sorry to see you go, here are some cool stats: "
        # How long it took to win each game
        Write-Host "Games and Win Times: "
        $winTimes
        # How many games were played
        Write-Host "# of Games Played: " -NoNewline
        $rounds
        # Average time to win
        Write-Host "Average Win Time: "
        foreach ($pair in $winTimes.GetEnumerator()) {
            $totalTime += $pair.value
            $avgTime = $totalTime / $rounds
        }
        Write-Host $avgTime " seconds"
    }
} while ($playAgain -eq $true)
