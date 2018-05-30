<#
Multi-line comment block
Cool beans
#>

# Array subexpression
Write-Host "I've created a variable `$a here with the value of 'aaa' to illustrate how powershell treats arrays 
when sorted."
$a = @('aaa' | sort)
Write-Host "Using @ to force an array returns the single item in an array: " $a[0]
Write-Host "Without @, it returns the first character from 'aaa', because powershell assumes you expect a scalar
value back when you sort it:" $($a=('aaa' | sort); $a[0])

# Comma operator order of operations/behavior
Write-Host "`nOrder of Operations with Commas:`n" -ForegroundColor "green"
"If I want an array consisting of three elements, but have the third calculated using addition, I need to put
parentheses around it."
'$a = 1,2,1+2: ' 
$a=1,2,1+2
$a
"With parentheses around the '1+2': "
$a=1,2,(1+2)
$a

# Nested arrays

$a = (((1,2),(3,4)),((5,6),(7,8)))
Write-Host "`nNested Arrays:`n" -ForegroundColor "green"
"First Level: " + $a[0] + ", " + $a[1]
# These return the pairs of numbers from the arrays. Equivalent of writing out $a if they weren't nested.
"Second: " + $a[0][0] + ", " + $a[0][1] + ", " + $a[1][0] + ", " + $a[1][1]
# Each of these return the single number from each of the bottom level arrays
"Third: " + $a[0][0][0] + ", " + $a[0][1][1] + ", " + $a[1][0][1] + ", " + $a[1][1][1]

# Practice with range operator (..)

$b = 1..5
"Range operator practice using 1..5: " + $b[0..4]

# Negative indexes

Write-Host "`nNegative indexes:`n" -ForegroundColor "green"
Write-Host '$b[-1] = ' $b[-1]
Write-Host '$b[-2] = ' $b[-2]

Write-Host "`nArray Slices:`n" -ForegroundColor "green"
'$b[2,3] = ' + $b[2,3]
'$b[2..4] = ' + $b[2..4]

Write-Host
