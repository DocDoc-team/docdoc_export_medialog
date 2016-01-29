@echo off
rem =========================================================================
rem Script for generating export files from MIS Infoclinic database.
rem 
rem Developed for medical portal  Docdoc.ru
rem =========================================================================


rem # 1. Configure variables
SetLocal EnableDelayedExpansion EnableExtensions
echo Loading config...
call config.bat

rem # 2. Delete previous existing export files if its exists
echo Cleaning from old export files
for %%a in (%exportfiles%) do (
    if exist %exportpath%%%a.csv del /Q /F %exportpath%%%a.csv
)

rem # 3. Make fresh data export from DB
echo Generate new fresh export files
for %%a in (%exportfiles%) do (
    echo - %%a
   "%sql_cmd_path%sqlcmd" -U %dbuser% -P %dbpass% -S %dbservername% -d %dbname% -i %sqlpath%get_%%a.sql -o %exportpath%%%a.csv -W -h-1 -s";"
)

rem # 4. This batch is done.
rem To upload exported files run docdoc_upload.bat
echo Export files generated.
