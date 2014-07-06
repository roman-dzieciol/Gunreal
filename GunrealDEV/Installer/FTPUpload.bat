:: ----------------------------------------------------------------------------
::  UT2004 Mod Upload Automation, (C) 2007 Roman Switch` Dzieciol
:: ----------------------------------------------------------------------------

@CLS
@ECHO.
@ECHO // ---------------------------------------------------------------------------
@ECHO // Uploading...
@ECHO // ---------------------------------------------------------------------------
@ECHO.

@SET GFTP_CONFIG=cURLConfig.txt

@SET GFTP_UPLOAD_INFODATA=1
@SET GFTP_UPLOAD_ZIP=1
@SET GFTP_UPLOAD_EXE=1

@CALL FTPUploadOverride.bat


@SET GFTP_DIR=%1
@IF "%GFTP_DIR%"=="" GOTO FAILURE


@IF %GFTP_UPLOAD_EXE% EQU 1 @FOR %%a IN ("%GFTP_DIR%\*.exe") DO curl.exe -T "%%a" -K %GFTP_CONFIG%
@IF %GFTP_UPLOAD_EXE% EQU 1 @FOR %%a IN ("%GFTP_DIR%\*-exe.md5") DO curl.exe -T "%%a" -K %GFTP_CONFIG%
@IF %GFTP_UPLOAD_ZIP% EQU 1 @FOR %%a IN ("%GFTP_DIR%\*.zip") DO curl.exe -T "%%a" -K %GFTP_CONFIG%
@IF %GFTP_UPLOAD_ZIP% EQU 1 @FOR %%a IN ("%GFTP_DIR%\*-zip.md5") DO curl.exe -T "%%a" -K %GFTP_CONFIG%
@IF %GFTP_UPLOAD_ZIP% EQU 1 @FOR %%a IN ("%GFTP_DIR%\*.7z") DO curl.exe -T "%%a" -K %GFTP_CONFIG%
@IF %GFTP_UPLOAD_INFODATA% EQU 1 @FOR %%a IN ("%GFTP_DIR%\*.xml") DO curl.exe -T "%%a" -K %GFTP_CONFIG%
@IF %GFTP_UPLOAD_INFODATA% EQU 1 @FOR %%a IN ("%GFTP_DIR%\*.txt") DO curl.exe -T "%%a" -K %GFTP_CONFIG%
@IF %GFTP_UPLOAD_INFODATA% EQU 1 @FOR %%a IN ("%GFTP_DIR%\*.ini") DO curl.exe -T "%%a" -K %GFTP_CONFIG%
    

@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE




:: ----------------------------------------------------------------------------
::  Exit Points
:: ----------------------------------------------------------------------------

::
:: Success 
::
:SUCCESS
@ECHO.
@ECHO.
@ECHO Success.
@ECHO.
@GOTO ENDOFFILE


::
:: Failure
::
:FAILURE
@COLOR 4F
@ECHO.
@ECHO.
@ECHO !!! ERROR !!!
@ECHO.
@ECHO.
@PAUSE
@COLOR
@GOTO ENDOFFILE


:ENDOFFILE
:: ----------------------------------------------------------------------------
::  EOF
:: ----------------------------------------------------------------------------