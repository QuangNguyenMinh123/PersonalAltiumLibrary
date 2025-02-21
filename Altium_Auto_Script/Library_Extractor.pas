////////////////////////////////////////////////////////////////////////////////
// Authot: Nguyen Minh Quang                                                  //
// email: nguyenminhquangcn1@gmail.com                                        //
////////////////////////////////////////////////////////////////////////////////
Program ExtractSourceLibsFromIntLibs;
Var
   SourceFolder : String;
   FilesList    : TStringList;
   i            : Integer;
Begin
    If IntegratedLibraryManager = Nil then Exit;

    If (SourceFolder <> '') Then
        If (SourceFolder[Length(SourceFolder)] <> '\') Then
            SourceFolder := SourceFolder + '\';

    If (DirectoryExists('D:\PersonalAltiumLibrary\Button')) Then
    Begin
       Try
              FilesList            := TStringList.Create;
              FilesList.Sorted     := True;
              FilesList.Duplicates := dupIgnore;

              // FindFiles function is a built in function from Scripting...
              FindFiles(SourceFolder,'*.IntLib',faAnyFile,False,FilesList);

              For i := 0 To FilesList.Count - 1 Do
                   IntegratedLibraryManager.ExtractSources(FilesList.Strings[i]);

       Finally
                  FilesList.Free;
       End;
    End;
End.
