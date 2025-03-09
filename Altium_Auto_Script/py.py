import os
import shutil
import subprocess
import multiprocessing
import time
################################################################################
# Variable definition                                                          #
################################################################################
source_dir = r"P:\PersonalAltiumLibrary\Antenna"
# Dummy file
tempFolder = source_dir + r"\Temp"
# Altium path
ALTIUM_EXE = r"C:\Program Files\Altium\AD25\X2.EXE"
# Output
outputFileName = os.path.basename(source_dir) 
# Get current working directory (equivalent to %CD%)
pwd = os.getcwd()
# Set up paths
destination_dir = os.path.join(source_dir, "Temp")
folder_name = os.path.basename(source_dir)
final_lib = os.path.join(source_dir, f"{folder_name}.LibPkg")
################################################################################
# Multi process                                                                #
################################################################################
# Process to extract the IntLib
def extractor(filename, event):
    print("Process 1: Running")
    # Create empty FinalLib file (equivalent to type nul >)
    with open(final_lib, 'w') as finalLib:
        pass
    # Write SourceDir to Mytext.txt
    with open("Mytext.txt", 'w') as f:
        f.write(source_dir)
    # Run Altium with script
    script_path = os.path.join(pwd, "CompileLibraries.pas")
    subprocess.run([ALTIUM_EXE, "-run", script_path, final_lib], shell=True)

# Function for the second process - waits for file and deletes it
def courier(filename, event):
    print("Process 2: Waiting for " + tempFolder)
    while not os.path.isdir(filename):
        time.sleep(1)
    print("Process 2: File Detected")
    # Process subdirectories
    for root, dirs, files in os.walk(source_dir, topdown=False):
        for dir_name in dirs:
            full_path = os.path.join(root, dir_name)
            # Skip if it's the destination directory
            if full_path.lower() != destination_dir.lower():
                # Move all contents to destination directory
                for item in os.listdir(full_path):
                    source = os.path.join(full_path, item)
                    dest = os.path.join(destination_dir, item)
                    shutil.move(source, dest)
            else:
                print(f"Excluded folder: {full_path}")
################################################################################
# Main                                                                         #
################################################################################
def main():
    # Create an Event object to synchronize processes
    folder_created_event = multiprocessing.Event()
    # Create two processes
    p1 = multiprocessing.Process(
        target=extractor,
        args=(tempFolder, folder_created_event)
    )
    p2 = multiprocessing.Process(
        target=courier,
        args=(tempFolder, folder_created_event)
    )

    # Create an Event object to synchronize processes
    file_created_event = multiprocessing.Event()
    p2.start()
    p1.start()
    # Wait for both processes to complete
    p2.join()
    p1.join()
    
    
    # Clean up
    if os.path.exists(destination_dir):
        shutil.rmtree(destination_dir)
    if os.path.exists(final_lib):
        os.remove(final_lib)
    if not os.path.exists(source_dir + '\\Output'):
        os.mkdir(source_dir + '\\Output')
    finalFilePath = source_dir + "\\" + outputFileName + '\\Project Outputs for ' + outputFileName
    finalFilePath += '\\' + outputFileName +'.IntLib'
    if os.path.exists(finalFilePath):
        shutil.move(finalFilePath, source_dir + '\\Output')
    for root, dirs, files in os.walk(source_dir, topdown=False):
        for dir_name in dirs:
            full_path = os.path.join(root, dir_name)
            # Skip if it's the destination directory
            if full_path.lower() != destination_dir.lower():
                if full_path != source_dir + '\\Output':
                    shutil.rmtree(full_path)

################################################################################
# Main                                                                         #
################################################################################
if __name__ == '__main__':
    main()
