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


@SET GFTP_FILE=%1
@IF "%GFTP_FILE%"=="" GOTO FAILURE


curl.exe -T "%GFTP_FILE%" -K %GFTP_CONFIG%
    

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