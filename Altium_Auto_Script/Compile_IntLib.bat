::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: This script used to run pas 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Color definition
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Change your library here
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set "SourceDir=F:\PersonalAltiumLibrary\Button"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Main
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

setlocal enabledelayedexpansion
set "Altium_exe=C:\Program Files\Altium\AD25\X2.EXE"
set "PWD=%CD%"

echo %SourceDir% > Mytext.txt
"%Altium_exe%" -RunScript "%PWD%\CompileLibraries.pas"
:: Extract the folder name from the path
for %%a in ("%SourceDir%") do set "foldername=%%~nxa"

set "DestinationDir=%SourceDir%\Temp"
set "FinalLib=%SourceDir%\%foldername%.IntLib"
for /d /r "%SourceDir%" %%f in (*) do (
    :: Check if the current folder is equal to the DestinationDir folder
    if "%%f" neq "%DestinationDir%" (
        move "%%f\*" "%DestinationDir%"
        rmdir /s /q "%%f"
    ) else (
        echo Excluded folder: %%f
    )
)
type nul > "%FinalLib%"
"%Altium_exe%" -run "%FinalLib%"
rmdir /s /q "%DestinationDir%"
del  "%FinalLib%"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Some  functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: End
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::