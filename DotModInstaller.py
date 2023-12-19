# Compile with python -m nuitka --onefile --windows-icon-from-ico=DMEXE.ico DotModInstaller.py

# Imports
# File path checking
import os

# File tree copying and removal
import shutil

# Config (This installer is meant to be universal, for both the main mod and addons)
import configparser

def likelypaths():
    # Produce a list of likely places the game would be installed

    # Check drive letters C-Z and generate a list of those that exist on this system
    drives = [ chr(x) + ":" for x in range(ord("C"),ord("Z"))
            if os.path.exists(chr(x) + ":/") ]
    paths = [
        "Program Files (x86)",
        "Steam",
        "Games",
        ]
    middles = [
        "Steam",
        "Games",
        "",
        ]
    suffix = "steamapps/common/Cold Waters"

    for drive in drives:
      for path in paths:
        for middle in middles:
          yield f"{drive}/{path}/{middle}/{suffix}"

if __name__ == "__main__":
    main()

# Good programming practices
def main():
    config = configparser.ConfigParser()
    config.read("%s/Installer.ini" % (os.getcwd()))
    mod_name = config["Settings"]["mod_name"]
    mod = "%s/ColdWaters_Data" % (os.getcwd())

    install_directory = None
    # Auto-locate; Simply checks likely locations for the game to be installed
    for possiblepath in likelypaths():
        if os.path.exists(possiblepath):
            install_directory = possiblepath
            break

    if install_directory is None:
        print("Auto-locate failed.")
        install_directory = input(
            "Please input the directory of your Cold Waters install: "
        )

    # Make sure everything's correct:
    if (
        input(
            f"This will install {mod_name} to {install_directory}. \nIs that correct? Y/N: "
        ).lower()
        != "y"
    ):
        install_directory = input(
            "Please input the directory of your Cold Waters install: "
        )

    mod_target = f"{install_directory}/MODS/{mod_name}/ColdWaters_Data"

    if mod_name == "DotMod":
        # Welcome/Install instructions for the main mod
        print(
            "\nReminder: Only download DotMod from the GitHub page. Any other downloads are *unauthorized* and cannot "
            "be verified."
        )
        print(
            "If you did not download the mod's files from the GitHub, close this program at once and run a malware "
            "scan."
        )
        input("Press Return to continue. ")
        print(
            "\nThank you for choosing DotMod! This program will help you automatically install/update the mod."
        )
        print(
            "If you have JSGME installed, disable all mods currently enabled, and make sure the game is closed."
        )

        # Install JSGME
        JSGME = "%s/JSGME" % (os.getcwd())
        if os.path.exists(f"{install_directory}/JSGME.ini"):
            print("JSGME already installed.")

        else:
            shutil.copytree(JSGME, install_directory, dirs_exist_ok=True)
            print(
                "JSGME installed. Please read through JSGME Help.txt and JoneSoft.txt."
            )

        # Remove the old files
        if os.path.exists(f"{install_directory}/MODS/{mod_name}"):
            shutil.rmtree(f"{install_directory}/MODS/{mod_name}", ignore_errors=True)
            print("Previous version of the mod removed.")

    # Install the mod
    print("Working, please wait...\nThis may take some time.")
    shutil.copytree(mod, mod_target, dirs_exist_ok=True)
    print("Mod installed.")

    # And we're done!
    if mod_name == "DotMod":
        print(
            f"\nThis program is completed. Now, navigate to your Cold Waters directory, at {install_directory}, and "
            f"run JSGME.exe (if you used Epic Mod, this may be called Epic Mod Install) and enable the main mod "
            f"there."
        )
        print("Enable the main mod first, and then any addons you want over it.")
        print("Thank you for using DotMod.")
        input("Press Return to exit.")
    else:
        print(
            f"\nThis program is completed. Now, navigate to your Cold Waters directory, at {install_directory}, and "
            f"run JSGME.exe (if you used Epic Mod, this may be called Epic Mod Install) and enable this addon there."
        )
        print(
            "The installation of this addon is complete. If you experience any crashes, please remove all addons and "
            "re-enable them."
        )
        print("Please contact the addon's creator if the issue persists.")
        input("Press Return to exit.")


if __name__ == "__main__":
    main()
