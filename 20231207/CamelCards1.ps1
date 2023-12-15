$Text = Get-Content -Path $PSScriptRoot\input.txt
$CardsProcessed = [System.Collections.ArrayList]::new()
$TotalWinnings = 0
foreach ($Line in $Text) {
    $Hand = ($Line -split " ")[0]
    [int32]$Bid = ($Line -split " ")[1]
    $HandSort = $Hand -replace "A","A" -replace "K","B" -replace "Q","C" -replace "J","D" -replace "T","E" -replace "9","F" -replace "8","G" -replace "7","H" -replace "6","I" -replace "5","L" -replace "4","M" -replace "3","N" -replace "2","O" -replace "1","P"       
    $HandArray = $Hand.ToCharArray() | Group-Object
    $CardSort = ($Hand.ToCharArray() | Sort-Object) -join ""
    if ($HandArray.Count -eq 5 -and $HandArray[0].Count -eq 1) {
        [void]$CardsProcessed.Add([PSCustomObject]@{
            'Hand' = $Hand
            'Sort' = $HandSort
            'Cards' = $CardSort
            'Weight' = 1
            'Bid' = $Bid
        })
    }
    if ($HandArray.Count -eq 4) {
        [void]$CardsProcessed.Add([PSCustomObject]@{
            'Hand' = $Hand
            'Sort' = $HandSort
            'Cards' = $CardSort
            'Weight' = 2
            'Bid' = $Bid
        })
    }
    if ($HandArray.Count -eq 3) {
        if (($HandArray | Sort-Object -Property Count -Descending)[0].Count -eq 3) {
            [void]$CardsProcessed.Add([PSCustomObject]@{
                'Hand' = $Hand
                'Sort' = $HandSort
                'Cards' = $CardSort
                'Weight' = 4
                'Bid' = $Bid
            })
        }
        else {
            [void]$CardsProcessed.Add([PSCustomObject]@{
                'Hand' = $Hand
                'Sort' = $HandSort
                'Cards' = $CardSort
                'Weight' = 3
                'Bid' = $Bid
            })
        }
    }
    if ($HandArray.Count -eq 2) {
        if (($HandArray | Sort-Object -Property Count -Descending)[0].Count -eq 4) {
            [void]$CardsProcessed.Add([PSCustomObject]@{
                'Hand' = $Hand
                'Sort' = $HandSort
                'Cards' = $CardSort
                'Weight' = 6
                'Bid' = $Bid
            })
        }
        else {
            [void]$CardsProcessed.Add([PSCustomObject]@{
                'Hand' = $Hand
                'Sort' = $HandSort
                'Cards' = $CardSort
                'Weight' = 5
                'Bid' = $Bid
            })
        }
    }
    if (($HandArray | Sort-Object -Property Count -Descending)[0].Count -eq 5) {
        [void]$CardsProcessed.Add([PSCustomObject]@{
            'Hand' = $Hand
            'Sort' = $HandSort
            'Cards' = $CardSort
            'Weight' = 7
            'Bid' = $Bid
        })
    }
}
$Rank = 1
$CardsProcessed = $CardsProcessed | Sort-Object -Property Weight, @{expr={$_.Sort}; desc=$true}
foreach ($Set in $CardsProcessed) {
    $TotalWinnings = $TotalWinnings + ($Set.Bid * $Rank)
    $Rank++
}
$TotalWinnings