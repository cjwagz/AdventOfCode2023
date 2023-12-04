$Text = Get-Content -Path $PSScriptRoot\input.txt
$Sum = 0
ForEach ($Line in $Text)
{
    $Sum = $Sum + (-join (($Line -replace "\D").ToCharArray()[0], ($Line -replace "\D").ToCharArray()[-1]))
}
$Sum