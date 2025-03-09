import os
import shutil
import subprocess
import multiprocessing
import time
################################################################################
# Variable definition                                                          #
################################################################################
SOURCE_DIR = r"P:\PersonalAltiumLibrary\Antenna"
# Dummy file
tempFolder = SOURCE_DIR + r"\Temp"
# Altium path
ALTIUM_EXE = r"C:\Program Files\Altium\AD25\X2.EXE"
# Get current working directory (equivalent to %CD%)
pwd = os.getcwd()
# Set up paths
destination_dir = os.path.join(SOURCE_DIR, "Temp")
folder_name = os.path.basename(SOURCE_DIR)
final_lib = os.path.join(SOURCE_DIR, f"{folder_name}.IntLib")
################################################################################
# Multi process                                                                #
################################################################################
# Process to extract the IntLib
def extractor(filename, event):
    print("Process 1: Running")
    # Create empty FinalLib file (equivalent to type nul >)
    with open(final_lib, 'w') as f:
        pass
    # Write SourceDir to Mytext.txt
    with open("Mytext.txt", 'w') as f:
        f.write(SOURCE_DIR)
    # Run Altium with script
    script_path = os.path.join(pwd, "CompileLibraries.pas")
    subprocess.run([ALTIUM_EXE, "-run", script_path, final_lib], shell=True)
    # Process subdirectories
    for root, dirs, files in os.walk(SOURCE_DIR, topdown=False):
        for dir_name in dirs:
            full_path = os.path.join(root, dir_name)
            # Skip if it's the destination directory
            if full_path.lower() != destination_dir.lower():
                # Move all contents to destination directory
                for item in os.listdir(full_path):
                    source = os.path.join(full_path, item)
                    dest = os.path.join(destination_dir, item)
                    shutil.move(source, dest)
                
                # Remove the now-empty directory
                shutil.rmtree(full_path)
            else:
                print(f"Excluded folder: {full_path}")
    event.set()  # Signal that file has been created

# Function for the second process - waits for file and deletes it
def courier(filename, event):
    print("Process 2: Waiting for " + tempFolder)
    event.wait()  # Wait until file is created
    while not os.path.isdir(filename):
        time.sleep(0.5)
    print("Process 2: File Detected")
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
    p1.start()
    p2.start()
    
    # Wait for both processes to complete
    p2.join()
    p1.join()
    
    
    # Clean up
    if os.path.exists(destination_dir):
        shutil.rmtree(destination_dir)
    if os.path.exists(final_lib):
        os.remove(final_lib)
################################################################################
# Main                                                                         #
################################################################################
if __name__ == '__main__':
    main()
