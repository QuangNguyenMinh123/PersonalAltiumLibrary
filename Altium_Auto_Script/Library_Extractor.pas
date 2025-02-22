////////////////////////////////////////////////////////////////////////////////
// Authot: Nguyen Minh Quang                                                  //
// email: nguyenminhquangcn1@gmail.com                                        //
////////////////////////////////////////////////////////////////////////////////
Program ExtractSourceLibsFromIntLibs;
////////////////////////////////////////////////////////////////////////////////
// Extract all IntLib from a given folder                                     //
////////////////////////////////////////////////////////////////////////////////
procedure ExtractSourcesFromIntLibs(const Folder: String; FilesList: TStringList);
Var
   i            : Integer;
   ExtractedFiles: String;
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

        ExtractedFiles := '';
        // Extract sources from each found IntLib file
        For i := 0 To FilesList.Count - 1 Do
        Begin
            IntegratedLibraryManager.ExtractSources(FilesList.Strings[i]);
            ExtractedFiles := ExtractedFiles + FilesList.Strings[i] + sLineBreak;
        End;

        ShowMessage('The following files have been extracted successfully:' + sLineBreak + ExtractedFiles);
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


