$Text = Get-Content -Path $PSScriptRoot\input.txt
$TotalPoints = 0
foreach ($Card in $Text) {
    $CardPoints = 0
    $Card = $Card -replace "Card\s+\d+:\s+"
    $Card -split "\s\|\s"
    $WinningNumbers = ($Card -split "\s\|\s")[0] -split "\s+"
    $CardNumbers = (($Card -split "\s\|\s")[1]) -split "\s+"
    foreach ($Number in $WinningNumbers) {
        if ($CardNumbers -contains $Number) {
            if ($CardPoints -eq 0) {
                $CardPoints = 1
            }
            else {
                $CardPoints = $CardPoints * 2
            }
        }
    }
    $TotalPoints = $TotalPoints + $CardPoints
}
$TotalPoints