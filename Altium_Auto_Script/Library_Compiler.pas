////////////////////////////////////////////////////////////////////////////////
// Authot: Nguyen Minh Quang                                                  //
// email: nguyenminhquangcn1@gmail.com                                        //
// This script is used as a compiler for automatically combining all .IntLib  //
// to a single .LibPkg file                                                   //
////////////////////////////////////////////////////////////////////////////////
Procedure CreateAndCompileLibPkg;
Var
    LibPkg: IServerDocument;
    LibPkgPath: String;


Begin
    // Define paths (Modify these paths as needed)
    LibPkgPath  := 'F:\PersonalAltiumLibrary\Button\MyButton\Integrated.LibPkg';
    // IntLibOutputPath := 'F:\PersonalAltiumLibrary\Button\TL1105SPF160Q\SW_TL1105SPF160Q.IntLib';
    LibPkg := Client.OpenDocument('LibPkg',LibPkgPath);


  If LibPkg <> Nil Then
  Begin
    // Save the new Library Package to the specified path
    LibPkg.SaveAs(LibPkgPath);
    ShowMessage('Library Package Created: ' + LibPkgPath);
  End
  Else
    ShowMessage('Failed to create Library Package');


End;
////////////////////////////////////////////////////////////////////////////////
// CreateLibPkg                                                               //
////////////////////////////////////////////////////////////////////////////////

