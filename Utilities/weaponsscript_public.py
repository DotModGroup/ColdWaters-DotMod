file = open(
    input("Input the complete file directory of where your weapons.txt is located\n> "),
    encoding="utf8",
)
save_location = input(
    "Input the complete file directory of where your output should go."
    " Note that the directory must exist completely.\n> "
)

weapon = None
weapon_name = None
weapon_type = None

for line in file:
    if line == "\n":
        continue

    if line.startswith("WeaponObjectReference"):
        weapon_name = line[22:]
        weapon = line
        weapon_type = "weapon_"

    elif line.startswith("DepthWeaponObjectReference"):
        weapon_name = line[27:]
        weapon = line
        weapon_type = "depthweapon_"

    elif line.startswith("CountermeasureName"):
        weapon = line
        weapon_type = "countermeasure_"

    elif line.startswith("CountermeasureObjectReference"):
        weapon_name = line[30:]
        weapon += line

    elif line.startswith("[/Model]") and weapon is not None:
        weapon += line
        file_save = open(
            "%s\\%s%s.txt" % (save_location, weapon_type, weapon_name[0:-1]),
            encoding="utf8",
            mode="a",
        )
        file_save.write(weapon)
        file_save.close()
        weapon = None
        weapon_type = None

    elif weapon is not None:
        weapon += line

print("Program completed without errors.")
