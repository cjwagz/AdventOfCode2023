$Text = Get-Content -Path $PSScriptRoot\input.txt
$Sum = 0
ForEach ($Line in $Text)
{
    $Line = $Line -replace "one", "o1e" -replace "two", "t2o" -replace "three", "t3e" -replace "four", "f4r" -replace "five", "f5e" -replace "six", "s6x" -replace "seven", "s7n" -replace "eight", "e8t" -replace "nine", "n9e"
    $Line
    $Sum = $Sum + (-join (($Line -replace "\D").ToCharArray()[0], ($Line -replace "\D").ToCharArray()[-1]))
}
$Sum