$content = Get-Content -Path .\website\weaponguide.html -Delimiter "<!--split-->"
$tablestring = "<tbody>"

$log = New-Object System.Collections.Generic.List[String]
$data = New-Object System.Collections.Generic.List[Weapon]

Get-ChildItem "main/ColdWaters_Data/StreamingAssets/dotmod/weapons" -Filter weapon_*.txt -Recurse | 
Foreach-Object {
    $weaponFile = Get-Content $_.FullName

    Foreach ($line in $lines) {
        if ($line.StartsWith('WeaponObjectReference') ){
            $weaponObjectReference = $line.Split("=")[1].Trim()
        }
        elseif ($line.StartsWith('WeaponSprite') ){
            $weaponSprite = $line.Split("=")[1].Trim()
        }
    }

    try{
        $sprite = Get-Item -Path "main/ColdWaters_Data/StreamingAssets/dotmod/$($weaponSprite)"
        $log.Add("$(Get-Date) -  SUCCESS: Got sprite from main/ColdWaters_Data/StreamingAssets/dotmod/$($weaponSprite)")
        If(!(test-path "website/media/weapons")) {
            New-Item -ItemType Directory -Force -Path "website/media/weapons"
            $log.Add("$(Get-Date) -  DIRECTORY: Created website/media/weapons")
        }
        $weaponSprite = $sprite.Name
        $sprite.CopyTo("website/media/weapons/$($sprite.Name)")
        $log.Add("$(Get-Date) -  SUCCESS: Copied sprite to website/media/weapons")
    }
    catch{
        $log.Add("$(Get-Date) -  ERROR: Failed to copy Sprite for $($weapon.ObjectReference) from main/ColdWaters_Data/StreamingAssets/dotmod/$($weapon.Sprite)")
        $weaponSprite = "WIP.png"
    }

     try{
        $content = Get-Content "main/ColdWaters_Data/StreamingAssets/dotmod/language_en/weapon/$($weaponObjectReference)_description.txt"
        $lines = $content.Split("\n")

        For ($i = 0; $i -lt $lines.Count; $i++) {
            $weaponDescription = ""
            if ($lines[$i].StartsWith('WeaponName') ){
                $weaponName = $lines[$i].Split("=")[1].Trim()
            }
            elseif ($lines[$i].StartsWith('WeaponDescription') ){
                $weaponDescription = $lines[$i].Split("=")[1].Trim()
            }
            elseif ($weaponDescription -ne ""){
                $weaponDescription = $weaponDescription + "<br/>" + $lines[$i] 
            }
        }
    }
    catch{
        $log.Add("$(Get-Date) -  ERROR: Failed to get Description for $($weapon.ObjectReference) from main/ColdWaters_Data/StreamingAssets/dotmod/language_en/weapon/$($weapon.ObjectReference)_description.txt")
    }
    $tablestring = $tablestring + "<tr><td>$($WeaponObjectReference)</td><td>$($weaponName)</td><td><img src='https://github.com/DotModGroup/DotModGroup.github.io/raw/main/media/weapons/$($weaponSprite)?raw=true' alt='$($weaponSprite)'></td><td>$($weaponDescription)</td></tr>"
}
$tablestring = $tablestring + "</tbody>"
$outstring = $content[0] + $tablestring + "<!--split-->" + $content[2]
$outstring | Out-File ( New-Item -Path "weaponguide.html" -Force)
