$Text = Get-Content -Path $PSScriptRoot\input.txt
$SumOfExtrapolatedValues = 0
foreach ($History in $Text) {
    $Full = [System.Collections.ArrayList]::new()
    $HistArray = $History -split " "
    [void]$Full.Add($History)
    do {
        $Temp = $null
        for ($i = 0; $i -lt $HistArray.Count-1; $i++) {
            $Diff = $HistArray[($i + 1)] - $HistArray[$i]
            if ($Temp) { $Temp = $Temp + " " + $Diff}
            else { $Temp = "$Diff"}
        }
        $HistArray = $Temp -split " "
        [void]$Full.Add($Temp)
    } until (
        ($Temp -split " " | Measure-Object -Sum).Sum -eq 0
    )
    $HistoryValue = 0
    for ($i = $Full.Count-1; $i -ne -1; $i--) {
        $HistoryValue = $HistoryValue + ($Full[$i] -split " ")[-1]
    }
    $SumOfExtrapolatedValues = $SumOfExtrapolatedValues + $HistoryValue
}
$SumOfExtrapolatedValues