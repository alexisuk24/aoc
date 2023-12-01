$rows = Get-Content day1.txt

$answer1 = 0
foreach ($row in $rows)
{
    $rowNumber = 0
    $lastNumber = 0
    $isFirstNumber = $true
    foreach ($char in $row.ToCharArray())
    {
        if ([Char]::IsNumber($char))
        {
            if ($isFirstNumber)
            {
                $rowNumber = [int]::Parse($char)*10
                $isFirstNumber = $false
            }
            $lastNumber = [int]::Parse($char)
        }
    }
    $rowNumber += $lastNumber
    $answer1 += $rowNumber
}
$answer1

$numberMap = @{
    "zero" = 0
    "one" = 1
    "two" = 2
    "three" = 3
    "four" = 4
    "five" = 5
    "six" = 6
    "seven" = 7
    "eight" = 8
    "nine" = 9
}

$answer2 = 0
foreach ($row in $rows)
{
    $firstNumber = $row -replace ".*?(\d|one|two|three|four|five|six|seven|eight|nine).*", '$1'
    if ($firstNumber.Length -gt 1)
    {
        $firstNumber = $numberMap[$firstNumber]
    }
    $lastNumber = ""
    for ($i = $row.Length - 1; $i -ge 0; $i--) {
        $lastNumber = $row.Substring($i)
        if ($lastNumber -match '(\d|one|two|three|four|five|six|seven|eight|nine)') {
            $lastNumber = $Matches[0]
            break
        }
    }
    if ($lastNumber.Length -gt 1)
    {
        $lastNumber = $numberMap[$lastNumber]
    }
    $rowNumber = ([int]::Parse($firstNumber) * 10) + $lastNumber
    $answer2 += $rowNumber
}
$answer2
