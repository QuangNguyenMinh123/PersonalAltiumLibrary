////////////////////////////////////////////////////////////////////////////////
// Authot: Nguyen Minh Quang                                                  //
// email: nguyenminhquangcn1@gmail.com                                        //
// This script is used as a compiler for automatically combining all .IntLib  //
// to a single .LibPkg file                                                   //
////////////////////////////////////////////////////////////////////////////////
Procedure CreateAndCompileLibPkg();
Var
    LibPkg: ISch_LibraryPackage;
    ProjectFilePath, SchLibFilePath, PcbLibFilePath, IntLibOutputPath: String;
Begin
    // Define paths (Modify these paths as needed)
    SchLibFilePath  := 'C:\AltiumProjects\MyComponent.SchLib';
    PcbLibFilePath  := 'C:\AltiumProjects\MyComponent.PcbLib';
    IntLibOutputPath := 'C:\AltiumProjects\MyLibrary.IntLib';

    // Create a new Library Package project
    LibPkg := SchServer.NewLibraryPackage;
    If LibPkg = Nil Then
    Begin
        ShowMessage('Failed to create Library Package.');
        Exit;
    End;

    // Set the Library Package file name
    LibPkg.SetFileName(ProjectFilePath);

    // Add the schematic and PCB library files to the package
    LibPkg.AddLibrary(SchLibFilePath);
    LibPkg.AddLibrary(PcbLibFilePath);

    // Save the Library Package
    If Not LibPkg.Save Then
    Begin
        ShowMessage('Failed to save the Library Package.');
        Exit;
    End;

    // Compile the Library Package into an Integrated Library
    If Not LibPkg.Compile(IntLibOutputPath) Then
    Begin
        ShowMessage('Failed to compile the Integrated Library.');
        Exit;
    End;

    ShowMessage('Library Package compiled successfully: ' + IntLibOutputPath);
End;


