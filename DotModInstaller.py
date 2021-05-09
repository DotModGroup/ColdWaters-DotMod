#Imports
import os
import shutil

def main():
    user = os.getlogin()

    #Welcome/Install instructions
    print('Thank you for choosing DotMod! This program will help you automatically install/update the mod.')
    print('If you have JSGME installed, disable all mods currently enabled, and make sure the game is closed.')
    #Delete old options to prevent starting bugs
    delOptions = input('Have you ever used Epic Mod or any other mod besides DotMod that modifies the game\'s code (even if you\'ve unistalled since)? Y/N: ')
    if os.path.exists(f'C:\\Users\\{user}\\AppData\\LocalLow\\Killerfish Games\\Cold Waters\\options.txt') and delOptions.lower() == 'y':
        os.remove(f'C:\\Users\\{user}\\AppData\LocalLow\\Killerfish Games\\Cold Waters\\options.txt')
        
        if os.path.exists(f'C:\\Users\\{user}\\AppData\\LocalLow\\Killerfish Games\\Cold Waters\\DMD_options.txt'):
            os.remove(f'C:\\Users\\{user}\\AppData\\LocalLow\\Killerfish Games\\Cold Waters\\DMD_options.txt')
        print('Please note that this has reset your options.') 

    #Auto-locate; Simply checks likely locations for the game to be installed to       
    if os.path.exists('C:\Program Files (x86)\Steam\steamapps\common\Cold Waters'):
        print('\nInstalling to Steam on drive C.\n')
        installDirectory = 'C:\Program Files (x86)\Steam\steamapps\common\Cold Waters'
        
    elif os.path.exists('D:\Steam\steamapps\common\Cold Waters'):
        print('\nInstalling to Steam on drive D.\n')
        installDirectory = 'D:\Steam\steamapps\common\Cold Waters'
        
    elif os.path.exists('D:\Games\steamapps\common\Cold Waters'):
        print('\nInstalling to Games on drive D.\n')
        installDirectory = 'D:\Games\steamapps\common\Cold Waters'
        
    else:
        print('Auto-locate failed.')
        installDirectory = input('Please input the directory of your Cold Waters install:')

    #Make sure everything's correct:
    if input(f'This will install DotMod to {installDirectory}. \nIs that correct? Y/N:').lower() != 'y':
        print('Program exited without installing.')
        return()
    
    #Install JSGME
    JSGME = '%s/JSGME' % (os.getcwd())
    if os.path.exists(f'{installDirectory}\\JSGME.ini'):
        print('JSGME already installed.')

    else:
        shutil.copytree(JSGME, installDirectory, dirs_exist_ok=True)
        print('JSGME installed. Please read through JSGME Help.txt and JoneSoft.txt.')

    #Install the mod to JSGME
    mod = '%s/ColdWaters_Data' % (os.getcwd())
    modTarget = installDirectory + '\\MODS\\DotMod\\ColdWaters_Data'
    if os.path.exists(f'{installDirectory}\\MODS\DotMod'):
        shutil.rmtree(f'{installDirectory}\\MODS\DotMod', ignore_errors=True)
        print('Previous version of DotMod removed.')

    print('Working, please wait...\nThis may take a minute.')
    shutil.copytree(mod, modTarget, dirs_exist_ok=True)
    print('Mod installed.')

    #Delete temporary files
    #os.remove(f'{installDirectory}\\MODS\\!BACKUP\\temp.txt')
    #os.remove(f'{installDirectory}\\MODS\\!INSTLOGS\\temp.txt')
    #os.remove(f'{modTarget}\\temp.txt')

    #And we're done!
    print(f'\nThis program is completed. Now, navigate to your Cold Waters directory, at {installDirectory}, and run JSGME.exe.')
    print('Enable DotMod first, and then any addons you want over it.')
    print('Thank you for using DotMod.')
    input('Press Return to exit.')

if __name__ == '__main__':
    main()
