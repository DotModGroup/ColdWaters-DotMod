Class Weapon{
    [String]$ObjectReference
    [String]$Name
    [String]$Sprite
    [String]$Description
}

$data = @()

Get-ChildItem "main/ColdWaters_Data/StreamingAssets/dotmod/weapons" -Filter weapon_*.txt | 
Foreach-Object {
    $content = Get-Content $_.FullName
    $lines = $content.Split("\n")

    $weapon = New-Object Weapon

    Foreach ($line in $lines) {
        if ($line.StartsWith('WeaponObjectReference') ){
            $weapon.ObjectReference = $line.Split("=")[1].Trim()
        }
        elseif ($line.StartsWith('WeaponSprite') ){
            $weapon.ObjectReference = $line.Split("=")[1].Trim()
        }
    }

    $content = Get-Content "main/ColdWaters_Data/StreamingAssets/dotmod/language_en/weapon/${weapon.ObjectReference}_description.txt"
    $lines = $content.Split("\n")

    Foreach ($line in $lines) {
        if ($line.StartsWith('WeaponName') ){
            $weapon.ObjectReference = $line.Split("=")[1].Trim()
        }
        elseif ($line.StartsWith('WeaponDescription') ){
            $weapon.ObjectReference = $line.Split("=")[1].Trim()
        }
    }

    $data.Add($weapon)
}

$data | ConvertTo-Json -depth 5 | Out-File "website/content/weapons.json"