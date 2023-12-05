function TestSymbolAdjacency {
    param (
        $Schematic,
        $x,
        $y
    )
    $SymbolAdjacent = $false
    if ($x -ne 0 -and $y -ne 0) {
        if ($Schematic[($x-1)][($y-1)] -match "[^\d\.]") { $SymbolAdjacent = $true }
    }
    if ($x -ne 0) {
        if ($Schematic[($x-1)][($y)] -match "[^\d\.]") { $SymbolAdjacent = $true }
    }
    if ($x -ne 0 -and $y -ne 139) {
        if ($Schematic[($x-1)][($y+1)] -match "[^\d\.]") { $SymbolAdjacent = $true }
    }
    if ($y -ne 0) {
        if ($Schematic[($x)][($y-1)] -match "[^\d\.]") { $SymbolAdjacent = $true }
    }
    if ($y -ne 139) {
        if ($Schematic[($x)][($y+1)] -match "[^\d\.]") { $SymbolAdjacent = $true }
    }
    if ($x -ne 139 -and $y -ne 0) {
        if ($Schematic[($x+1)][($y-1)] -match "[^\d\.]") { $SymbolAdjacent = $true }
    }
    if ($x -ne 139) {
        if ($Schematic[($x+1)][($y)] -match "[^\d\.]") { $SymbolAdjacent = $true }
    }
    if ($x -ne 139 -and $y -ne 139) {
        if ($Schematic[($x+1)][($y+1)] -match "[^\d\.]") { $SymbolAdjacent = $true }
    }
    return $SymbolAdjacent
}

$Text = Get-Content -Path $PSScriptRoot\input.txt
$Sum = 0
for ($x = 0; $x -lt $Text.Count; $x++) {  
    $LineArray = $Text[$x].ToCharArray()
    $PartNum = [string]::Empty
    $ValidPart = $false

    for ($y = 0; $y -lt $LineArray.Count; $y++) {
        if ($Text[$x][$y] -match "\d") {
            if(TestSymbolAdjacency $Text $x $y) {$ValidPart = $True}
            if ($PartNum) {$PartNum = $PartNum + [string]$Text[$x][$y]}
            else {$PartNum = [string]$Text[$x][$y]}
            if ($Text[$x][($y+1)] -notmatch "\d") {
                if ($ValidPart) {$Sum = $Sum + $PartNum}
                $PartNum = [string]::Empty
                $ValidPart = $false
            }
        }
    }
}
$Sum