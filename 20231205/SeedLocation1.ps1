function Calculate-Map {
    param (
        $Section,
        $ItemToCalc
    )
    for ($i = 1; $i -lt $Section.Count; $i++) {
        $Map = $Section[$i].Split(" ")
        [int64]$Destination = $Map[0]
        [int64]$Source = $Map[1]
        [int64]$Length = $Map[2]
        [int64]$SourceRangeEnd = $Source + $Length
        if ($ItemToCalc -ge $Source -and $ItemToCalc -le $SourceRangeEnd) {
            $Output = $Destination + ($ItemToCalc - $Source)
            return $Output
        }
    }
    return $ItemToCalc
}
$Text = Get-Content -Raw -Path $PSScriptRoot\input.txt
$LowLocation = 0
$Sections = $Text -split '(?m)\n{2,}'
$Seeds = ([regex]::Matches($Sections[0], "\d+")).Value
$SeedToSoil = $Sections[1] -split '(?m)\n'
$SoilToFertilizer = $Sections[2] -split '(?m)\n'
$FertilizerToWater = $Sections[3] -split '(?m)\n'
$WaterToLight = $Sections[4] -split '(?m)\n'
$LightToTemperature = $Sections[5] -split '(?m)\n'
$TemperatureToHumidity = $Sections[6] -split '(?m)\n'
$HumidityToLocation = $Sections[7] -split '(?m)\n'
foreach ($Seed in $Seeds) {
    [int64]$Item = $Seed
    $Soil = Calculate-Map $SeedToSoil $Item
    $Fertilizer = Calculate-Map $SoilToFertilizer $Soil
    $Water = Calculate-Map $FertilizerToWater $Fertilizer
    $Light = Calculate-Map $WaterToLight $Water
    $Temperature = Calculate-Map $LightToTemperature $Light
    $Humidity = Calculate-Map $TemperatureToHumidity $Temperature
    $Location = Calculate-Map $HumidityToLocation $Humidity
    if ($LowLocation -eq 0) {
        $LowLocation = $Location
    }
    elseif ($LowLocation -gt $Location) {
        $LowLocation = $Location
    }
}
$LowLocation