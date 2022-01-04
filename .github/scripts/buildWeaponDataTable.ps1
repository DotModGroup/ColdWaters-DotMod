Class Weapon{
    [String]$ObjectReference
    [String]$Name
    [String]$Sprite
    [String]$Description
}

$log = @()
$data = @()

Get-ChildItem "main/ColdWaters_Data/StreamingAssets/dotmod/weapons" -Filter weapon_*.txt -Recurse | 
Foreach-Object {
    $content = Get-Content $_.FullName
    $lines = $content.Split("\n")

    $weapon = New-Object Weapon

    Foreach ($line in $lines) {
        if ($line.StartsWith('WeaponObjectReference') ){
            $weapon.ObjectReference = $line.Split("=")[1].Trim()
        }
        elseif ($line.StartsWith('WeaponSprite') ){
            $weapon.Sprite = $line.Split("=")[1].Trim()
        }
    }

    try{
        $sprite = Get-Item -Path "main/ColdWaters_Data/StreamingAssets/dotmod/${weapon.Sprite}"
        $sprite.CopyTo("website/media/weapons")
    }
    catch{
        $log.Add("ERROR: Failed to copy Sprite for ${weapon.ObjectReference} from main/ColdWaters_Data/StreamingAssets/dotmod/${weapon.Sprite}")
    }

    try{
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
    }
    catch{
        $log.Add("ERROR: Failed to get Description for ${weapon.ObjectReference} from main/ColdWaters_Data/StreamingAssets/dotmod/language_en/weapon/${weapon.ObjectReference}_description.txt")
    }

    $data.Add($weapon)

}

ConvertTo-Json -InputObject $data -Depth 5 | Out-File ( New-Item -Path "website/content/weapons.json" -Force)

$log | Out-File ( New-Item -Path "website/logs/buildWeaponDataTable.log" -Force)