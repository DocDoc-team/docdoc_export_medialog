@echo off
rem =========================================================================
rem Script for uploading export files to external FTP server
rem 
rem Developed for medical portal  Docdoc.ru
rem =========================================================================


rem # 1. Configure variables
SetLocal
call config.bat

rem # 2. Recreate temporary file with FTP commands
rem Check previous of temporary file with FTP commands
set ftpbatchfile=tmp\ftpcmd.dat
if exist %ftpbatchfile% del %ftpbatchfile%

rem Prepare header of temporary file with FTP commands
echo open ftp://%ftpuser%:%ftppass%@%ftphost%>> %ftpbatchfile%

echo option batch on>> %ftpbatchfile%
echo option confirm off>> %ftpbatchfile%
echo option reconnecttime 120>> %ftpbatchfile%

if not "%ftpstartdir%"=="" (
    echo CD %ftpstartdir%>> %ftpbatchfile%
)

echo BINARY>> %ftpbatchfile%

rem Make fresh data export from DB
for %%a in (%exportfiles%) do (
	echo PUT %exportpath%%%a.csv>> %ftpbatchfile%
)

rem Prepare footer of temporary file with FTP commands
echo CLOSE>> %ftpbatchfile%
echo EXIT>> %ftpbatchfile%

rem # 3. Run prepared FTP batch file
echo Uploading...
%winscppath%winscp.exe /console /script=%ftpbatchfile%  /log=%ftplogpath%

rem # 4. This batch is done. All must be OK.
echo Done.
