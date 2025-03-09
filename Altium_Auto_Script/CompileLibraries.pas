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
// Step 1: Extract InitLib to SchLib and PcbLib: DONE                         //
// Step 2: List all file with SchLib and PcbLib extension using cmd
// Step 3: Compile?
////////////////////////////////////////////////////////////////////////////////
uses
  Library_Extractor, SysUtils, Windows;
////////////////////////////////////////////////////////////////////////////////
procedure ExtractSourcesFromIntLibs(const Folder: String; FilesList: TStringList);
Var
   i            : Integer;
   SearchFolder : String; // New variable to avoid modifying 'const' Folder
Begin
    // Ensure folder path ends with a backslash
    SearchFolder := Folder;
    If (SearchFolder <> '') Then
        If (SearchFolder[Length(SearchFolder)] <> '\') Then
            SearchFolder := SearchFolder + '\';

    // Check if the specified directory exists
    If (DirectoryExists(SearchFolder)) Then
    Begin
        FilesList.Duplicates := dupIgnore; // Ignore duplicates
        FilesList.CaseSensitive := True;

        // Find all .IntLib files in the specified folder
        FindFiles(SearchFolder, '*.IntLib', faAnyFile, False, FilesList);

        // Check if no IntLib files were found
        If FilesList.Count = 0 Then
        Begin
            ShowMessage('No IntLib files found in the specified folder.');
            Exit;
        End;
        // Extract sources from each found IntLib file
        For i := 0 To FilesList.Count - 1 Do
        Begin
            IntegratedLibraryManager.ExtractSources(FilesList.Strings[i]);
        End;
    End
    Else
    Begin
        ShowMessage('The specified source directory does not exist.');
    End;
End;

////////////////////////////////////////////////////////////////////////////////
// Create new Folder                                                          //
////////////////////////////////////////////////////////////////////////////////
procedure CreateNewFolder(const ParentFolder: String, const FolderName: String);
Var
   FilesList    : TStringList;
Begin
     If DirectoryExists(ParentFolder) Then
        If Not DirectoryExists(ParentFolder + FolderName) Then
        Begin
            CreateDir(ParentFolder + FolderName); // Create the new folder
        End;
End;
////////////////////////////////////////////////////////////////////////////////
// Remove an IntLib file                                                      //
////////////////////////////////////////////////////////////////////////////////
Procedure RemoveFile(const FileName: String);
Begin
    // Check if the file exists before deleting
    If FileExists(FileName) Then
       DeleteFile(FileName)
End;
////////////////////////////////////////////////////////////////////////////////
// Main                                                                       //
////////////////////////////////////////////////////////////////////////////////
Var
   SourceIitFilesListFolder            : String; // Variable to save the folder containing IitLib libraries
   IntFilesList                        : TStringList;
   SourceDir                           : String;
   Path, LibPkgName, LibPkgPath        : String;
   PathParts                           : TArray;
   FileHandle, Document                : IDocument;
   F                                   : TextFile;
   LastDelimiterPos                    : Integer;
   CurrentDir                          : string;
Begin
     AssignFile(F, 'P:\PersonalAltiumLibrary\Altium_Auto_Script\Mytext.txt');
     Reset(F);
     ReadLn(F, SourceDir);
     CloseFile(F);
     IntFilesList := TStringList.Create;
     IntFilesList.CaseSensitive := True;
     // Ensure folder path ends with a backslash
    If (SourceDir <> '') Then
        If (SourceDir[Length(SourceDir)] = ' ') Then
            SourceDir[Length(SourceDir)] := '\';
        If (SourceDir[Length(SourceDir)] <> '\') Then
            SourceDir := SourceDir + '\';
     // Read Final IntLib name
     Path := SourceDir;
     Path := ExcludeTrailingPathDelimiter(Path);
     LastDelimiterPos := LastDelimiter('\', Path);
     LibPkgName := Copy(Path, LastDelimiterPos + 1, Length(Path) - LastDelimiterPos);
     LibPkgPath := SourceDir + LibPkgName + '.IntLib';
     // Extract all IntLib in folder SourceDir and pass variable to IntFilesList
     ExtractSourcesFromIntLibs(SourceDir, IntFilesList);
     // Create Temp
     CreateNewFolder(SourceDir, 'Temp');
     ShowMessage('IntLib files are extracted successfully');
End.

