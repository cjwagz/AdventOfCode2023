$Text = Get-Content -Path $PSScriptRoot\input.txt
$MapElementHash = New-Object System.Collections.Specialized.OrderedDictionary
$Directions = ($Text[0]).ToCharArray()
foreach ($MapElements in $Text[2..($Text.Count)]) {
    $Split = $MapElements -split " = "
    $MapElementHash.Add($Split[0], $Split[1])
}
$NextRow = "AAA"
$Steps = 0
for ($i = 0; $i -lt $Directions.Count + 1; $i++) {
    if ($i -eq ($Directions.Count)) {
        $i = 0
    }
    if ($Directions[$i] -eq "L") {
        $NextRow = ([regex]::Matches($MapElementHash[$NextRow], "[A-Z]{3,}")).Value[0]
        $Steps++
    }
    if ($Directions[$i] -eq "R") {
        $NextRow = ([regex]::Matches($MapElementHash[$NextRow], "[A-Z]{3,}")).Value[1]
        $Steps++
    }
    if ($NextRow -eq "ZZZ") {
        break
    }
}
$Steps