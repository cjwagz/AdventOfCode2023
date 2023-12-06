$Text = Get-Content -Path $PSScriptRoot\input.txt
$Time = [int32]([regex]::Matches(($Text[0] -replace " "), "\d+")).Value
$Win = [int64]([regex]::Matches(($Text[1] -replace " "), "\d+")).Value
$WaysToBeat = 0
for ($d = 0; $d -lt $Time; $d++) {
    $HoldButton = $d
    $Speed = 1 * $d
    $TimeRemaining = $Time - $HoldButton
    $Distance = $Speed * $TimeRemaining
    if ($Distance -gt $Win) {
        $WaysToBeat++
    }
}
$WaysToBeat