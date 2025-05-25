# Keep WSL Ready on Boot
Want your Windows Subsystem for Linux (WSL) to be always ready to go right after Windows starts? Here's a simple method to keep a lightweight WSL process running in the background, ensuring your WSL environment is immediately available when you need it.

1. Create the Startup Script
First, we'll create a small VBScript that quietly launches a background process in WSL.

Create a new file, for example, named start_wsl_background.vbs, and paste the following code into it:

VBScript
``` vbs
' This VBScript ensures a WSL instance is always running in the background.
' It executes a simple command within WSL without showing a console window.

Set WshShell = CreateObject("WScript.Shell")

' Run the 'dbus-launch true' command within WSL.
' This command helps initialize the D-Bus system, often needed for WSL apps.
' The '0' hides the command window, and 'False' means the script doesn't wait for it to finish.
WshShell.Run Chr(34) & "C:\Program Files\WSL\wsl.exe" & Chr(34) & " --exec dbus-launch true", 0, False

Set WshShell = Nothing
```
2. Place it in Your Startup Folder
Next, we'll tell Windows to run this script automatically when you log in.

3. Press `Win + R` to open the Run dialog.
4. Type `shell:startup` and press Enter. This will open your user-specific Startup folder.
5. Drag and drop the start_wsl_background.vbs file you created into this folder. Alternatively, you can create a shortcut to the .vbs file in this folder.
6. Restart and Enjoy!
That's it! The next time you restart your computer, or even just log out and log back in, this script will run silently in the background, ensuring your WSL environment is quickly accessible whenever you open a WSL terminal or application.
