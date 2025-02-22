////////////////////////////////////////////////////////////////////////////////
// Authot: Nguyen Minh Quang                                                  //
// email: nguyenminhquangcn1@gmail.com                                        //
// This script is used for automatically combining all .IntLib to a single    //
// .LibPkg file                                                               //
////////////////////////////////////////////////////////////////////////////////
// To display all file with IntLib and PcbLib extension, run:
// dir /s /b *.IntLib *.PcbLib
////////////////////////////////////////////////////////////////////////////////
// STEP:                                                                      //
// Step 1: Extract InitLib to SchLib and PcbLib: DONE
// Step 2: List all file with SchLib and PcbLib extension using cmd
// Step 3: Compile?

// Altium path: "C:\Program Files\Altium\AD25\X2.EXE"

program CompileLibraries;

uses
  Library_Extractor, Library_Compiler, SysUtils, Classes;
Var
   SourceIitFilesListFolder : String; // Variable to save the folder containing IitLib libraries
   IntFilesList             : TStringList;
   SourceFolder             : String;
Begin
     SourceFolder := 'F:\PersonalAltiumLibrary\Button\';
     IntFilesList := TStringList.Create;
     IntFilesList.CaseSensitive := True;
     // Ensure folder path ends with a backslash
    If (SourceFolder <> '') Then
        If (SourceFolder[Length(SourceFolder)] <> '\') Then
            SourceFolder := SourceFolder + '\';
    // Extract all IntLib in folder SourceFolder and pass variable to IntFilesList
    ExtractSourcesFromIntLibs(SourceFolder, IntFilesList);
    // Create New folder and gather all data

    CreateNewFolder(SourceFolder, 'MyButton');
    RemoveFile('F:\PersonalAltiumLibrary\Button\Button.IntLib');
End.

