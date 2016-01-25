@echo off
rem =======  Database connection settings  ==================================

rem DB User, Password and Role for connection
rem 
rem This user must have enought privileges for retrieving data from required 
rem tables.
rem For more information see readme.txt
rem
set dbservername=MEDIALOG-VR\SQLEXPRESS
set dbname=Medialog_750
set dbuser=sa
set dbpass=1


rem Full path to 'sqlcmd' tool of MS SQL - command line client for MS SQL
set "sql_cmd_path=C:\Program Files\Microsoft SQL Server\100\Tools\Binn\"


rem =======  FTP upload settings  ===========================================

rem FTP host & port, user and password settings
rem FTP host examples:
rem   ftphost=ftp.docdoc.ru
rem   ftphost=ftp.docdoc.ru:21
set ftphost=ftp.docdoc.ru
set ftpuser=testuser
set ftppass=testpassword
set ftpstartdir=testdir
rem path to winscp ftp client
set "winscppath=winscp\"
set ftplogpath=ftp.log



rem =======  Internal variables (DO NOT MODIFY THEM if not sure)  ===========

rem Subpath to sql commandlets
set sqlpath=.\sql\
rem Subpath where to put export files
set exportpath=.\export\
rem List of subnames of sql commandlets (and corresponding export files)
rem set exportfiles=clinics doctors depts doctschedule schedule
set exportfiles=clinics doctors doctors_days
