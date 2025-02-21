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
// Step 1: Extract InitLib to SchLib and PcbLib
// Step 2: List all file with SchLib and PcbLib extension using cmd
// Step 3: Compile?

// Altium path: "C:\Program Files\Altium\AD25\X2.EXE"

program CompileLibraries;

uses
  LibraryCompiler;  // Import the custom script unit

begin
  // Call the function with different library paths
  CompileSchLib('D:\PersonalAltiumLibrary\Button\B3F-1000.IntLib');
  CompileSchLib('D:\PersonalAltiumLibrary\Button\TL1105SPF160Q.IntLib');
  CompileSchLib('D:\PersonalAltiumLibrary\Button\TL1107BF130WQ.IntLib');
  CompileSchLib('D:\PersonalAltiumLibrary\Button\B3F-1000\B3F-1000.PcbLib');
  CompileSchLib('D:\PersonalAltiumLibrary\Button\Project Outputs for Button_Pack\Button_Pack.IntLib');
  CompileSchLib('D:\PersonalAltiumLibrary\Button\TL1105SPF160Q\SW_TL1105SPF160Q.PcbLib');
  CompileSchLib('D:\PersonalAltiumLibrary\Button\TL1107BF130WQ\SW_TL1107BF130WQ.PcbLib');
end.

