$elfGroups = Get-Content ./input.txt

$contained = 0
$overlap = 0
foreach ($elfGroup in $elfGroups)
{
    $groupSplit = $elfGroup.Split(",")

    [int]$elfAleft, [int]$elfAright = $groupSplit[0].Split("-")
    [int]$elfBleft, [int]$elfBright = $groupSplit[1].Split("-")

    if ($elfAleft -le $elfBleft -and $elfAright -ge $elfBright) {
        $contained++
    } elseif ($elfBleft -le $elfAleft -and $elfBright -ge $elfAright) {
        $contained++
    }

    if ($elfAleft -in $elfBleft..$elfBright) {
        $overlap++
    } elseif ($elfAright -in $elfBleft..$elfBright) {
        $overlap++
    } elseif ($elfBleft -in $elfAleft..$elfAright) {
        $overlap++
    } elseif ($elfBright -in $elfAleft..$elfAright) {
        $overlap++
    }
}

$contained
$overlap