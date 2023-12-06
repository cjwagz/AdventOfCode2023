$Text = Get-Content -Path $PSScriptRoot\input.txt
$CardInstances = @(1) * $Text.Count
$CardX = 0
foreach ($Card in $Text) {
    $CardPoints = 0
    $CardY = $CardX
    $Card = $Card -replace "Card\s+\d+:\s+"
    $WinningNumbers = ($Card -split "\s\|\s")[0] -split "\s+"
    $CardNumbers = ($Card -split "\s\|\s")[1] -split "\s+"
    foreach ($Number in $WinningNumbers) {
        if ($CardNumbers -contains $Number) { $CardPoints++ }
    }
    for ($i = 0; $i -lt $CardPoints; $i++) {
        $CardY++
        $CardInstances[$CardY] = $CardInstances[$CardY] + $CardInstances[$CardX]
    }
    $CardX++
}
($CardInstances | Measure-Object -Sum).Sum