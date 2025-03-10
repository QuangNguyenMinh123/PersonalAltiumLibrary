# Brief
This is my repository containing Altium Library <br>
# Altium automating script
Altium_Auto_Script contains DelphiScript to automating update library whenever a new IntLib file is added. <br>
+ Go to Altium_Auto_Script directory
+ set SourceDir variable on Compile_IntLib.bat file
+ Run Compile_IntLib.bat
+ An Altium windows will be opened. This windows contains CompileLibraries.pas script to extract all existing IntLib to SchLib and PcbLib.<br>
    Run it by File -> Run Script. A new window will be prompted indicating that the process has finished. Close it and close Altium to continue <br  
+ Next, the extracted SchLib and PcbLib files will be move to Temp folder.<br>
  A new Altium windows will be prompted. Create a new Altium library file and add those existing files to library<br>
  Compile it, and now you have a new Library file
# Celestial library
https://altiumlibrary.com/GetStarted/Troubleshooting
