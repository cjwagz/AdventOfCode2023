$Text = Get-Content -Path $PSScriptRoot\input.txt
$GameIDSum = 0
ForEach ($Game in $Text)
{
    $GameID = ([regex]::Matches($Game, "Game\s(\d{1,3})")).Groups[1].Value
    $GamePossible = $true
    ForEach ($Round in ($Game -replace "Game\s\d{1,3}:\s" -split ";"))
    {
        ForEach ($Color in ($Round -split ","))
        {
            If($Color -match "red")
            {
                If([Int]($Color -replace "\D") -gt 12) { $GamePossible = $false } 
            }
            If($Color -match "green")
            {
                If([Int]($Color -replace "\D") -gt 13) { $GamePossible = $false } 
            }
            If($Color -match "blue")
            {
                If([Int]($Color -replace "\D") -gt 14) { $GamePossible = $false } 
            }
        }
    }
    If($GamePossible) {$GameIDSum = $GameIDSum + $GameID}
}
$GameIDSum