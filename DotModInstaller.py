#Personal Reminder: Compile with python -m nuitka --onefile --windows-onefile-tempdir --windows-icon-from-ico=DMEXE.ico DotModInstaller.py
#------------

#Imports
#------------
#File path checking and user-getting for killing bad options
import os
#File tree copying and removal
import shutil
#Config (This installer is meant to be universal, for both the main mod and addons)
import configparser

#Good programming practices
def main():
    user = os.getlogin()
    config = configparser.ConfigParser()
    config.read('%s/Installer.ini' % (os.getcwd()))
    modName = config['Settings']['modName']
    mod = '%s/ColdWaters_Data' % (os.getcwd())
    
    #Auto-locate; Simply checks likely locations for the game to be installed to       
    if os.path.exists('C:\Program Files (x86)\Steam\steamapps\common\Cold Waters'):
        installDirectory = 'C:\Program Files (x86)\Steam\steamapps\common\Cold Waters'
        
    elif os.path.exists('D:\Steam\steamapps\common\Cold Waters'):
        installDirectory = 'D:\Steam\steamapps\common\Cold Waters'
        
    elif os.path.exists('D:\Games\steamapps\common\Cold Waters'):
        installDirectory = 'D:\Games\steamapps\common\Cold Waters'
        
    else:
        print('Auto-locate failed.')
        installDirectory = input('Please input the directory of your Cold Waters install: ')

    #Make sure everything's correct:
    if input(f'This will install {modName} to {installDirectory}. \nIs that correct? Y/N: ').lower() != 'y':
        installDirectory = input('Please input the directory of your Cold Waters install: ')
        if installDirectory == 'yourmom.com':
            print('Stealing is bad, Epic.')
            input('Press Return to exit.')
            return
        
    modTarget = installDirectory + f'\\MODS\\{modName}\ColdWaters_Data'
        
    if modName == 'DotMod':
        #Welcome/Install instructions for the main mod
        print('\nReminder: Only download DotMod from the GitHub page. Any other downloads are *unauthorized* and cannot be verified.')
        print('If you did not download the mod\'s files from the GitHub, close this program at once and run a malware scan.')
        input('Press Return to continue. ')
        print('\nThank you for choosing DotMod! This program will help you automatically install/update the mod.')
        print('If you have JSGME installed, disable all mods currently enabled, and make sure the game is closed.')
            
        #Install JSGME
        JSGME = '%s/JSGME' % (os.getcwd())
        if os.path.exists(f'{installDirectory}\\JSGME.ini'):
            print('JSGME already installed.')

        else:
            shutil.copytree(JSGME, installDirectory, dirs_exist_ok=True)
            print('JSGME installed. Please read through JSGME Help.txt and JoneSoft.txt.')

    #Remove the old files
        if os.path.exists(f'{installDirectory}\\MODS\{modName}'):
            shutil.rmtree(f'{installDirectory}\\MODS\{modName}', ignore_errors=True)
            print('Previous version of the mod removed.')

    #Install the mod
    print('Working, please wait...\nThis may take some time.')
    shutil.copytree(mod, modTarget, dirs_exist_ok=True)
    print('Mod installed.')

    #And we're done!
    if modName == 'DotMod':
        print(f'\nThis program is completed. Now, navigate to your Cold Waters directory, at {installDirectory}, and run JSGME.exe (if you used Epic Mod, this may be called Epic Mod Install) and enable the main mod there.')
        print('Enable the main mod first, and then any addons you want over it.')
        print('Thank you for using DotMod.')
        input('Press Return to exit.')
    else:
        print(f'\nThis program is completed. Now, navigate to your Cold Waters directory, at {installDirectory}, and run JSGME.exe (if you used Epic Mod, this may be called Epic Mod Install) and enable this addon there.')
        print('The installation of this addon is complete. If you experience any crashes, please remove all addons and re-enable them.')
        print('Please contact the addon\'s creator if the issue persists.')
        input('Press Return to exit.')

if __name__ == '__main__':
    main()
