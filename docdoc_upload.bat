@echo off
rem =========================================================================
rem Script for uploading export files to external FTP server
rem 
rem Developed for medical portal  Docdoc.ru
rem =========================================================================


rem # 1. Configure variables
SetLocal
call config.bat

rem # 2. Recreate temporary file with script commands

rem Check previous of temporary file with FTP commands
set ftpbatchfile=tmp\ftpcmd.dat
if exist %ftpbatchfile% del %ftpbatchfile%

set settings=

if not "%winscpsettings%"=="" (
  set "settings=-rawsettings %winscpsettings%"
)

rem Prepare header of temporary file with FTP commands
if "%uploadmode%"=="webdav" (
  if "%ftpstartdir%"=="" (
    set ftpstartdir=/
  )

  echo open -certificate=* https://%ftpuser%:%ftppass%@%ftphost%/upload/%ftpuser%%ftpstartdir% %settings%>> %ftpbatchfile%
)  else (
  echo open ftp://%ftpuser%:%ftppass%@%ftphost% %settings%>> %ftpbatchfile%

  if not "%ftpstartdir%"=="" (
    echo CD %ftpstartdir%>> %ftpbatchfile%
  )

  echo BINARY>> %ftpbatchfile%
)

echo option batch on>> %ftpbatchfile%
echo option confirm off>> %ftpbatchfile%

rem Make fresh data export from DB
for %%a in (%exportfiles%) do (
  echo PUT %exportpath%%%a.csv>> %ftpbatchfile%
)

rem Prepare footer of temporary file with FTP commands
echo CLOSE>> %ftpbatchfile%
echo EXIT>> %ftpbatchfile%



rem # 3. Run prepared FTP batch file
echo Uploading...
%winscppath%winscp.exe /console /script=%ftpbatchfile% /log=%ftplogpath%


rem # 4. This batch is done. All must be OK.
echo Done.
