# 12 red cubes, 13 green cubes, and 14 blue cubes

$cubeMax = @{
    'red' = 12
    'green' = 13
    'blue' = 14
}

$content = Get-Content 'day 2/input.txt'

$goodGames = 0
foreach ($row in $content)
{
    $gameid = $row -match '(\d{1,3})' | Out-Null
    $gameid = $Matches[0]

    $gameinput = $row -match ':(.*)' | Out-Null
    $gameinput = $Matches[1]

    $games = $gameinput.Split(';')

    $gameGood = $true

    $cubeMin = @{
        'red' = 0
        'green' = 0
        'blue' = 0
    }
    $cubeProduct = 0

    foreach ($game in $games)
    {
        $cubes = $game.Split(',')
        
        foreach ($cube in $cubes)
        {
            $cube -match '\s(?<count>\d{1,3})\s(?<color>red|green|blue)' | Out-Null

            if ([int]$Matches.count -gt [int]$cubeMax[$Matches.color])
            {
                $gameGood = $false
            }

            if ([int]$cubeMin[$Matches.color] -lt $Matches.count)
            {
                $cubeMin[$Matches.color] = $Matches.count
            }
        }
    }

    $cubeProduct = [int]$cubeMin['red'] * [int]$cubeMin['green'] * [int]$cubeMin['blue']
    $cubeProductSum+= $cubeProduct

    if ($gameGood)
    {
        $goodGames+= $gameid
    }
}

$goodGames
$cubeProductSum
