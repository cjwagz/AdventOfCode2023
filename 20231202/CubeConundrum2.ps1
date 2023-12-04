$Text = Get-Content -Path $PSScriptRoot\input.txt
$PowerSum = 0
ForEach ($Game in $Text)
{
    $Red = 0
    $Green = 0
    $Blue = 0
    ForEach ($Round in ($Game -replace "Game\s\d{1,3}:\s" -split ";"))
    {
        ForEach ($Color in ($Round -split ","))
        {
            If($Color -match "red")
            {
                If([Int]($Color -replace "\D") -gt $Red) { $Red = [Int]($Color -replace "\D") } 
            }
            If($Color -match "green")
            {
                If([Int]($Color -replace "\D") -gt $Green) { $Green = [Int]($Color -replace "\D") } 
            }
            If($Color -match "blue")
            {
                If([Int]($Color -replace "\D") -gt $Blue) { $Blue = [Int]($Color -replace "\D") } 
            }
        }
    }
    $Power = $Red * $Green * $Blue
    $PowerSum = $PowerSum + $Power
}
$PowerSum