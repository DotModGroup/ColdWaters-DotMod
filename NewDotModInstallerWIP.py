"""This program installs DotMod or any other DotMod addon to a specified game directory"""
# python -m nuitka --onefile --windows-onefile-tempdir --windows-icon-from-ico=DMEXE.ico DotModInstallerNew.py

# Imports
# File path checking
import os

# File tree copying and removal
import shutil

# Config (This installer is meant to be universal, for both the main mod and addons)
import configparser

# For new GUI
import PySimpleGUI as sg


def autopopulate_directory() -> str:
    """Autopopulate the directory to which to install the main mod or addon.

    Returns
    -------
    str
        First availible directory for Cold Waters
    """
    if os.path.exists("C:/Program Files (x86)/Steam/steamapps/common/Cold Waters"):
        return "C:/Program Files (x86)/Steam/steamapps/common/Cold Waters"

    if os.path.exists("D:/Steam/steamapps/common/Cold Waters"):
        return "D:/Steam/steamapps/common/Cold Waters"

    if os.path.exists("C:/Games/steamapps/common/Cold Waters"):
        return "C:/Games/steamapps/common/Cold Waters"

    if os.path.exists("D:/Games/steamapps/common/Cold Waters"):
        return "D:/Games/steamapps/common/Cold Waters"

    return ""


def get_install_location() -> str:
    """Create a GUI window to browse for the game directory

    Returns
    -------
    str
        Game directory to install to
    """
    install_directory = sg.popup_get_folder(
        title="DotMod Installer",
        message="Please select your Cold Waters directory",
        default_path=autopopulate_directory(),
        size=(100, 300),
    )
    if not install_directory:
        sg.popup_error("Please select an installation directory.")
        # return get_install_location()
        return ""
    else:
        return install_directory


def install_to_location(mod_name: str, folder: str):
    """Install to location specified

    Parameters
    ----------
    mod_name : str
        Name of mod or addon to install to JSGME
    folder : str
        Game directory to install to
    """
    mod_target = folder + f"/MODS/{mod_name}/ColdWaters_Data"
    if os.path.exists(f"{mod_target}/MODS/{mod_name}"):
        shutil.rmtree(f"{mod_target}/MODS/{mod_name}", ignore_errors=True)
        sg.popup("Previous version of the mod removed.")

    shutil.copytree(f"{os.getcwd()}/ColdWaters_Data", mod_target, dirs_exist_ok=True)


def install_jsgme(folder: str):
    """Install JSGME

    Parameters
    ----------
    folder : str
        Game directory to install to
    """
    shutil.copytree(f"{os.getcwd()}/JSGME", folder, dirs_exist_ok=True)
    sg.popup("JSGME Installed.")


def show_info(is_addon: bool = False) -> None:
    """Show information about mod usage

    Parameters
    ----------
    is_addon : bool, optional
        Whether to show generic addon info or main mod-specific information, by default False
    """
    if is_addon:
        sg.popup_scrolled(
            "This program is completed. Now, navigate to your Cold Waters directory and"
            "run JSGME.exe (if you used Epic Mod, this may be called Epic Mod Install) "
            "and enable the main mod there. Enable the main mod first, and then any "
            "addons you want over it. Thank you for using DotMod."
        )
        return

    sg.popup_scrolled(
        "This program is completed. Now, navigate to your Cold Waters directory and "
        "run JSGME.exe (if you used Epic Mod, this may be called Epic Mod Install) "
        "and enable this addon there. The installation of this addon is complete. "
        "If you experience any crashes, please remove all addons and re-enable them."
        "Please contact the addon's creator if the issue persists."
    )


def main():
    """Main entry point"""
    config = configparser.ConfigParser()
    config.read(f"{os.getcwd()}/Installer.ini")
    mod_name = config["Settings"]["mod_name"]
    install_folder = get_install_location()

    if not os.path.exists(f"{install_folder}/JSGME.ini"):
        install_jsgme(install_folder)

    install_to_location(mod_name, install_folder)
    show_info(mod_name == "DotMod")


if __name__ == "__main__":
    main()
