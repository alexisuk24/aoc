$inputFile = Get-Content .\input.txt

$stackArray = [System.Collections.Stack[]]::new(9)
for ($i = 0; $i -lt $stackArray.Count; $i++) {
    $stackArray[$i] = New-Object System.Collections.Stack
    $boxInput = "start"
    while($boxInput -ne "")
    {
        $boxInput = Read-Host -Prompt "Box to load on pile $i"
        if ($boxInput -ne "")
        {
            $stackArray[$i].Push($boxInput)
        }
    }
}

$part2 = $true

foreach ($action in $inputFile)
{
    $actionData = select-string -InputObject $action -Pattern "move (?<count>\d+) from (?<start>\d+) to (?<dest>\d+)"
    
    $moveCount = $actionData.Matches.Groups[1].Value
    $fromPile = $actionData.Matches.Groups[2].Value - 1 # - 1 for zero based
    $toPile = $actionData.Matches.Groups[3].Value - 1 # - 1 for zero based

    $shuffleStack = New-Object System.Collections.Stack

    $craneCapacity = $part2 ? 99 : 1
    $craneLoad = 0
    $movesComplete = 0

    while ($movesComplete -lt $moveCount) {
        while ($craneLoad -lt $craneCapacity -and $movesComplete -lt $moveCount)
        {
            $objectPopped = $stackArray[$fromPile].Pop()
            $shuffleStack.Push($objectPopped)
            $craneLoad++
            $movesComplete++
        }
        while ($shuffleStack.Count -gt 0)
        {
            $objectPopped = $shuffleStack.Pop()
            $stackArray[$toPile].Push($objectPopped)
        }
        $craneLoad = 0        
    }
}

for ($i = 0; $i -lt $stackArray.Count; $i++) {
    if ($stackArray[$i].Count -eq 0)
    {
        Write-Output "Pile $i is Empty"
    }
    else 
    {
        $topPeek = $stackArray[$i].Peek()
        Write-Output "Pile $i has $topPeek at top"
    }
}