# ColdWaters-DotMod

 Welcome to DotMod!

 DotMod is an attempt to create a more organized mod that is closer to vanilla vessel and weapons characteristics for Cold Waters than other, currently-existing mods. This also generally results in more realistic sensor and performance comparisons.

 DotMod also adds RPG elements to the Cold Waters campaigns, adds new campaigns, introduces a new fleet of vessels (mostly) custom built for the game by our team of modellers, and adds new gameplay elements like deployable towed arrays, playable helicopters, and surface-to-air missiles.

 Come join our community on Discord, we are mostly English language but have supporters and modders from around the world! https://discord.gg/DrmztcDYYf

 DotMod's latest release can be found at https://github.com/Dot-M134/ColdWaters-DotMod/releases.

 For upcoming features check out the #showcase channel on our Discord!

## Features

### New Features
 * Player Surface Ships
 * Player Helicopters
 * Surface-to-Air Missiles and MANPADS
 * Player RBUs
 * Player Guns
 * Visible/Deployable Towed Arrays
 * NIXIE for (Player) Surface Ships
 * Smarter AI Evasion Algorithm
 * New HUD Panels for New Features
 * Dynamically Generated Wakes
 * Placeable Navmarkers
 * Re-Wrote Torpedo Logic
 * Wake-Homing Torpedoes
 * Prestige System for Campaigns
 * RPG Elements for Campaigns
 * New Loading Screen
 * New Options Menu
 * Language Support
 * Voiceline Support
 * Limited Enemy Vessels Numbers for Campaigns
 * Removed Baffles-Seeing Eye for AI
 * Re-Balanced Torpedo and Sensor Performance around Realism

### New Vessels

#### United States
 * Barbel-class SSK
 * Nautilus-class SSN
 * Virginia-class SSN
 * George Washington-class SSBN
 * Ohio-class SSBN
 * Oliver Hazard Perry-class FFG (Long and Short Hull)
 * Gearing-class DD (FRAM I)
 * Charles F. Adams-class DDG
 * Spruance-class DDG
 * Arleigh Burke-class DDG (Flight I, II, and IIA)
 * Ticonderoga-class CG
 * Iowa-class BB
 * Nimitz-class CVN
 * Austin-class LPD
 * Iwo-Jima class LPH
 * Algol-class FSS

#### Soviet Union
 * Zulu-class SS
 * Mike-class SSN
 * Papa-class SSGN

#### United Kingdom
 * Oberon-class SSK
 * Dreadnought-class SSN
 * Valiant-class SSN
 * Churchill-class SSN
 * Trafalgar-class SSN
 * Resolution-class SSBN
 * Type 21-class FFG
 * County-class DDG
 * Type 42-class DDG

#### Norway
 * Kobben-class SSK
 * Oslo-class FFG
 * Nordkapp-class CGV

#### Netherlands
 * Dolfijn-class SSK (Future Update)
 * Zwaardvis-class SSK

#### Australia
 * Collins-class SSK
 * Adelaide-subclass (Oliver Hazard Perry) FFG

#### Civilian
 * Atlantic Conveyor-class Merchant

### New Weapons

#### United States
 * Reworked Vanilla USN Torpedo Models
 * NT37C Torpedo
 * Mark 45 Torpedo (Conventional Modification)
 * Mark 50 Torpedo
 * RIM-7 Sea Sparrow Missile
 * RIM-66/67 Standard Missile
 * RIM-156 Standard-ER Missile
 * UGM-27 Polaris A3 Missile
 * UGM-96 Trident I C4 Missile
 * RUR-5 Mod 5 ASROC Missile
 * RUM-139 VL-ASROC Missile

#### Soviet Union
 * New Models for SS-N-15/16 Variants
 * 53-65 Torpedo
 * 65-76 Torpedo
 * SAET-60 Torpedo
 * VA-111 Shkval Torpedo
 * MG-14 Anabar Decoy
 * MG-74 Korund Decoy
 * SA-14 Gremlin MANPADS
 * SA-18 Grouse MANPADS
 * SA-N-3 Goblet Missile
 * SA-N-4 Gecko Missile
 * SA-N-6 Grumble Missile
 * SA-N-7 Gadfly Missile
 * SA-N-9 Gauntlet Missile
 * SS-N-3a Shaddock Missile
 * SS-N-9 Siren Missile
 * SS-N-14 Silex Missile
 * SS-N-19 Shipwreck Missile
 * SS-N-22 Sunburn Missile
 * SS-N-21 Sampson Missile
 * SS-N-5 Sark/Serb Missile
 * SS-N-6 Serb Missile
 * SS-N-30A Sizzler Missile

#### United Kingdom
 * Mark VIII** Torpedo
 * Mark 20 Bidder Torpedo
 * Mark 23 Grog Torpedo
 * Mark 24 Tigerfish Torpedo
 * Spearfish Torpedo
 * Sting Ray Torpedo
 * Exocet Missile
 * Seacat Missile
 * Sea Dart Missile

#### Norway
 * Penguin Missile

#### Republic of China
 * A184 Torpedo

### New Aircraft

#### United States
 * SH-34J Seabat
 * SH-60B Seahawk
 * P-3C Orion
 * QH-50 DASH

#### United Kingdom
 * Wessex HAS.3
 * Avro Shackleton MR2

### New Developer Optimizations
 * Added ability to load in 3rd-party models from custom asset bundles
 * Removed vessel_list.txt and replaced with tree search
 * Split weapons.txt into individual files
 * Split aircraft.txt into individual files
 * Split sensors.txt into individual files
 * Split sensor language file into individual files
 * Modularized missions
 * Added developer mode for campaigns
 * More informational logging options
 * Added game integrity checking on first run
 * Added dotmod and priority folders to game loading order (default > dotmod > override > priority)
 * Skip loading override and priority on first run
 * Added vessel inventory and vessel selectors to campaigns
 * Loadout System Improvment Project implemeneted
 * Allow for locking vessels to a certain amount of each caliber of weapon

## Known Issues
 * Completing NATO campaign is impossible in vessels with no ASW capabilities
 * Some weapons exist in configurations which did not serve in the timeline or never existed

## Installation
DotMod comes with an installer that will walk you through the steps of installation (unfortunately this does NOT work on Windows 7 at present). If this fails, a manual install can be performed by following these instructions: https://cdn.discordapp.com/attachments/866120539512373268/880131182367498321/Cold_Waters_DotMod_Manual_Install_Guide.pdf


## Support  
If you have trouble with DotMod, please let us know on our #tech-support Discord channel, and we will endeavour to sort you out. Alternatively, raise an Issue here on GitHub. Be sure to include an output_log.txt and a description of what caused the error to occur (or at the very least what you were doing when it happened).

## CREDITS
DotMod team:
 * Ivan Baranov a.k.a. Dot - Started the project and has done work on just about everything
 * Dsmirnoff - Accoustics system supervision, advanced programming, research and correction, additional modeling, work on russian text
 * Masha Sklyarova - Main tester, tactics assesement, work on russian text
 * TheHappyYachter - Advanced coding, modeling
 * HobbitJack - Campaigns, cleanup, tech support, minor programming
 * Electric Boat - Modeling
 * that_person - Campaign 001, modeling, single missions
 * Minsk CVGH - Additional Russian translation
 * ghostdog688 - Coordination, presentation, PR
 * Goldmaster11 - Testing
 * Russian_Wolf - Russian Translations
 * Kevin DDSSTT - Texture art for new vessel models
 * Steel Shark - UI Sprites, Textures, and HUD
 * Misfit - Sounds for USN Sonars and Mk7 Guns
 * Tionstav - Modeling
 * RedEagle - Modeling
-----------
Our team also wants thank several people for their help and inspiration:
 * Nils a.k.a. Julhelm - Without you there would not be CW and without your help our mod would be missing small, yet critical, info! We'd also like to thank you for that Marmoset material that kept our ships hidden by fog. 
 * Gsmith93 - We thank you for your incredible 1990 campaign! It gave us such a good base to work off of and saved us so much time.
 * Oleg Vygovsky - You've showed that impossible is actually possible and provided info and support
 * Nikita Nichagin - If you hadn't called Dot to CW, we woldnt be here now! Additionally, thanks for the info and support through the years.
 * Kostya Martynov - Your analysis and info you've posted in your group was very valuable for creation of this mod.
 * Evgeny Mas - Your voiceover adds an incredible amount of immersion to playing Russian vessels.
 * Epic - Credits for ideas on chaff and WH behaviour and assistance in WH parameters setup, Shkval sprite and several medals sprites and edited parameters of the wake trals. It was fun to improve EM, but sadly your attitude eventually drove all content makers from the project.
-----------
 * Electric Boat would like to thank by name the following:
 * George Bieda (Windjammers Arts) and TheFloatingDrydock - For all the drawings that constitute my main reference for all US Navy vessels, and
 * Boris Volkhov (Polar Bear Productions) - For static scale models and drawings that are my constant and most precious source of reference for all soviet submarines.

Special thanks is also given to model makers who have uploaded thier models for anyone to use, especially on 3D Warehouse!

## DISTRIBUTION
If planning to distribute the main mod without modification, you may do so under the condition that you link to the GitHub page and not to any mirror, torrent, or other distribution.
If planning to distribute the main mod with modification, you may do so under the condition that you also provide a link to the unmodified version found on the GitHub and not to any mirror, torrent, or other distribution.
If planning to distribute a modification to the main mod separately from the main mod, no restrictions are provided on your work. However, you are encouraged to provide a link to the GitHub. You may include DotModInstaller.exe as well as a configuration .ini file to allow the modification to be automatically installed to JSGME.
You may copy, edit, delete, add, etc. content under the condition that you do not do so in order to distribute with or for Epic Mod. (Yes Epic, this applies to you. Don't say we didn't warn you.)
 - Note that some models are licensed under the Sketchfab license. As per that license you are free to make derivative works of said models, provided that you do not sell them. For a full list of terms, see https://help.sketchfab.com/hc/en-us/articles/115004276346-Licenses and https://sketchfab.com/licenses.