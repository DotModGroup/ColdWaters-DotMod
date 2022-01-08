$content = Get-Content -Path "website/weaponguide.html" -Delimiter "<!--split-->"
$tablestring = "<tbody>"

$log = New-Object System.Collections.Generic.List[String]

Get-ChildItem "main/ColdWaters_Data/StreamingAssets/dotmod/weapons" -Filter weapon_*.txt -Recurse | 
Foreach-Object {
    $weaponFile = Get-Content $_.FullName

    $log.Add("$(Get-Date) -  File: Got file $($_.FullName)")

    $lines = $weaponFile.Split("\n")

    Foreach ($line in $lines) {
        if ($line.StartsWith('WeaponObjectReference') ){
            $weaponObjectReference = $line.Split("=")[1].Trim()
            $log.Add("$(Get-Date) -  SUCCESS: Got weapon $($weaponObjectReference)")
        }
        elseif ($line.StartsWith('WeaponSprite') ){
            $weaponSprite = $line.Split("=")[1].Trim()
            $log.Add("$(Get-Date) -  SUCCESS: Got sprite $($weaponSprite)")
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
        $log.Add("$(Get-Date) -  ERROR: Failed to copy Sprite for $($weaponObjectReference) from main/ColdWaters_Data/StreamingAssets/dotmod/$($weaponSprite)")
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
        $log.Add("$(Get-Date) -  ERROR: Failed to get Description for $($weaponObjectReference) from main/ColdWaters_Data/StreamingAssets/dotmod/language_en/weapon/$($weaponObjectReference)_description.txt")
    }
    $tablestring = $tablestring + "<tr><td>$($WeaponObjectReference)</td><td>$($weaponName)</td><td><img src='https://github.com/DotModGroup/DotModGroup.github.io/raw/main/media/weapons/$($weaponSprite)?raw=true' alt='$($weaponSprite)'></td><td>$($weaponDescription)</td></tr>"
}
$tablestring = $tablestring + "</tbody>"
$outstring = "$($content[0])<!--split-->$($tablestring)<!--split-->$($content[$content.Count-1])"
$outstring | Out-File ( New-Item -Path "website/weaponguide.html" -Force)

$log | Out-File ( New-Item -Path "website/logs/buildWeaponDataTable.log" -Force)