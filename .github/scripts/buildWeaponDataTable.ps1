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
        $sprite.CopyTo("website/media/weapons/$($sprite.Name)", $true)
        $log.Add("$(Get-Date) -  SUCCESS: Copied sprite to website/media/weapons/$($sprite.Name)")
    }
    catch{
        $log.Add("$(Get-Date) -  ERROR: Failed to copy Sprite for $($weaponObjectReference) from main/ColdWaters_Data/StreamingAssets/dotmod/$($weaponSprite)")
        $weaponSprite = "WIP.png"
    }

     try{
        $content = Get-Content "main/ColdWaters_Data/StreamingAssets/dotmod/language_en/weapon/$($weaponObjectReference)_description.txt"
        #$lines = $content.Split("\n")
        $lines = $content -split [Environment]::NewLine
        For ($i = 0; $i -lt $lines.Count; $i++) {
            if ($lines[$i].StartsWith('WeaponDescriptiveName') ){
                $weaponName = $lines[$i].Split("=")[1].Trim()
                $log.Add("$(Get-Date) -  SUCCESS: Got Name $($weaponName)")
            }
            elseif ($lines[$i].StartsWith('WeaponDescription') ){
                $weaponDescription = $lines[$i].Split("=")[1].Trim().Replace("\n","<br/>")
                $log.Add("$(Get-Date) -  SUCCESS: Got Description $($weaponDescription)")
            }
        }
    }
    catch{
        $log.Add("$(Get-Date) -  ERROR: Failed to get Description for $($weaponObjectReference) from main/ColdWaters_Data/StreamingAssets/dotmod/language_en/weapon/$($weaponObjectReference)_description.txt")
    }

    $tablestring = $tablestring + "<tr><td>$($weaponName)</td><td><img src='https://github.com/DotModGroup/DotModGroup.github.io/raw/main/media/weapons/$($weaponSprite)?raw=true' alt='$($weaponSprite)'></td><td>$($weaponDescription)</td></tr>"
}

$beginning = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Techro is a modern and fully responsive Template by WebThemez.">
    <meta name="author" content="webThemez.com">
    <title>DotMod - Cold Waters</title>
    <link rel="favicon" href="assets/images/favicon.png">
    <link rel="stylesheet" media="screen" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <!-- Custom styles for our template -->
    <link rel="stylesheet" href="assets/css/bootstrap-theme.css" media="screen">
    <link rel="stylesheet" href="assets/css/style.css">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
	<script src="assets/js/html5shiv.js"></script>
	<script src="assets/js/respond.min.js"></script>
	<![endif]-->
</head>

<body>
    <!-- Fixed navbar -->
    <div class="navbar navbar-inverse">
        <div class="container">
            <div class="navbar-header">
                <!-- Button for smallest screens -->
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
                <a class="navbar-brand" href="index.html">
                    <img src="assets/images/logo.png" alt="Techro HTML5 template">
				</a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav pull-right">
                    <li><a href="index.html">Home</a></li>
                    <li><a href="about.html">About</a></li>
                    <li><a href="coldwaters.html">Cold Waters - DotMod</a></li>
                    <li><a href="gallery.html">Gallery</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Guides <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li class="active"><a href="weaponguide.html">Weapons</a></li>
                            <li><a href="#">Dummy Link1</a></li>
                            <li><a href="#">Dummy Link2</a></li>
                            <li><a href="#">Dummy Link3</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!--/.nav-collapse -->
        </div>
    </div>
    <!-- /.navbar -->

    <header id="head" class="secondary"></header>

    <!-- container -->
    <div class="container">
        <div class="row">
            <!-- Article content -->
            <section class="col-sm-12 maincontent">
                <header class="page-header">
                    <h1 class="page-title">Cold Waters - DotMod Weapons</h1>
                </header>
                <table id="myTable">
					<thead>
						<tr class="header">
							<th style='width: 15%'>WeaponName</th>
							<th style='width: 15%'>WeaponSprite</th>
							<th>WeaponDescription</th>
						</tr>
					</thead>
					<!--split-->
					<tbody>
"@

$end = @"
                    </tbody>
					<!--split-->
				</table>
            </section>
        </div>
    </div>

    <footer id="footer" class="top-space">

        <div class="footer1">
            <div class="container">
                <div class="row">
                    <div class="col-md-5 panel">
                        <h3 class="panel-title">About DotModGroup</h3>
                        <div class="panel-body">
                            <p>The DotModGroup is an international group of modders making new content for Killerfish Games's 2017 arcade submarine simulation, Cold Waters. As a team, we have developed new UI, models, features, textures, and more to bring new content to the modern naval combat genre.</p>
                        </div>
                    </div>

                    <div class="col-md-4 panel contact">
                        <h3 class="panel-title">Contact Info</h4>
						<div class="panel-body">
                            <p>Contact us on our Discord Server.</p>
                            <ul>
                                <li><a href="https://discord.gg/DrmztcDYYf">https://discord.gg/DrmztcDYYf</a></li>
                            </ul>
                        </div>
                    </div>

                </div>
                <!-- /row of panels -->
            </div>
        </div>

        <div class="footer2">
            <div class="container">
                <div class="row">

                    <div class="col-md-6 panel">
                        <div class="panel-body">
                            <p class="simplenav">
                                <a href="index.html">Home</a> | 
								<a href="about.html">About</a> |
								<a href="coldwaters.html">Cold Waters - DotMod</a> |
								<a href="gallery.html">Gallery</a>
                            </p>
                        </div>
                    </div>

                    <div class="col-md-6 panel">
                        <div class="panel-body">
                            <p class="text-right">
                                Copyright &copy; 2014. Template by <a href="http://webthemez.com/" rel="develop">WebThemez.com</a>
                            </p>
                        </div>
                    </div>

                </div>
                <!-- /row of panels -->
            </div>
        </div>

    </footer>
    <!-- JavaScript libs are placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="https://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
    <script src="assets/js/custom.js"></script>
</body>
</html>
"@

$outstring = "$($beginning)$($tablestring)$($end)"
$outstring | Out-File ( New-Item -Path "website/weaponguide.html" -Force)

$log | Out-File ( New-Item -Path "website/logs/buildWeaponDataTable.log" -Force)