$Text = Get-Content -Path $PSScriptRoot\input.txt
$Times = ([regex]::Matches($Text[0], "\d+")).Value
$Distances = ([regex]::Matches($Text[1], "\d+")).Value
$Result = 1
for ($i = 0; $i -lt $Times.Count; $i++) {
    $WaysToBeat = 0
    $RaceTime = $Times[$i]
    for ($d = 0; $d -lt $Times[$i]; $d++) {
        $HoldButton = $d
        $Speed = 1 * $d
        $TimeRemaining = $RaceTime - $HoldButton
        $Distance = $Speed * $TimeRemaining
        if ($Distance -gt $Distances[$i]) {
            $WaysToBeat++
        }
    }
    $Result = $Result * $WaysToBeat
}
$Result