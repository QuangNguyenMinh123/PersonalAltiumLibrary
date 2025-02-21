////////////////////////////////////////////////////////////////////////////////
// Authot: Nguyen Minh Quang                                                  //
// email: nguyenminhquangcn1@gmail.com                                        //
// This script is used as a compiler for automatically combining all .IntLib  //
// to a single .LibPkg file                                                   //
////////////////////////////////////////////////////////////////////////////////

unit LibraryCompiler;  // Declare the unit name

interface  // Interface section where functions/procedures are declared
procedure CompileSchLib(LibPath: String);  // Declare the procedure or function

implementation  // Implementation section where logic is written

uses
  SchServer, Dialogs;  // Import necessary Altium modules

procedure CompileSchLib(LibPath: String);
var
  Doc: ISch_Lib;  // Declare a variable to store the library document
begin
  // Load the Schematic Library
  Doc := SchServer.LoadSchLib(LibPath);

  if Doc <> nil then  // Check if the library was loaded successfully
  begin
    Doc.Compile;  // Compile the library
    ShowMessage('Compilation successful: ' + LibPath);  // Display success message
  end
  else
    ShowMessage('Error: Could not open library!');  // Display error message if load fails
end;

end;  // End of the unit

