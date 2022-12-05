$inputString = import-csv ~/input.txt

$scoreCounter = 0
$elfGroupCounter = 0
$elfGroupMembers = @("1", "2", "3")
$elfGroupScoreCounter = 0

foreach ($str in $inputString)
{
    $elfGroupMembers[$elfGroupCounter] = $str.inputstring
    if (++$elfGroupCounter -eq 3)
    {
         $elfGroupCounter = 0
         $abDifferences = compare-object -ReferenceObject $elfGroupMembers[0].ToCharArray() -DifferenceObject $elfGroupMembers[1].ToCharArray() -ExcludeDifferent -IncludeEqual -PassThru
         $abcDifferences = compare-object -ReferenceObject $abDifferences -DifferenceObject $elfGroupMembers[2].ToCharArray() -ExcludeDifferent -IncludeEqual -PassThru
         
         $difference = $abcDifferences[0]
        if ($difference -cmatch "[A-Z]")
        {
            $elfGroupScoreCounter += [byte]$difference - 38
        }
        else
        {
            $elfGroupScoreCounter += [byte]$difference - 96
        }
    }
    
    $leftString = $str.inputstring.Substring(0,$str.inputstring.Length/2)
    $rightString = $str.inputstring.Substring($str.inputstring.Length/2, $str.inputstring.Length/2)

    $lsa = $leftString.ToCharArray()
    $rsa = $rightString.ToCharArray()
    
    $differences = compare-object -ReferenceObject $lsa -DifferenceObject $rsa -ExcludeDifferent -IncludeEqual -PassThru

    $difference = $differences[0]
    if ($difference -cmatch "[A-Z]")
    {
        $scoreCounter += [byte]$difference - 38
    }
    else
    {
        $scoreCounter += [byte]$difference - 96
    }
}

$scoreCounter
$elfGroupScoreCounter