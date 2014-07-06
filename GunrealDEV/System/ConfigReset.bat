:: ----------------------------------------------------------------------------
::  UT2004 TC Config Resetter, (C) 2006 Roman Switch` Dzieciol
:: ----------------------------------------------------------------------------

@SET MOD_NAME=Gunreal
@SET MOD_SYS=..\..\%MOD_NAME%\System
@SET MOD_HELP=If you need assistance please contact us.
@SET MOD_URL=http://www.gunreal.com

@ECHO // ---------------------------------------------------------------------------
@ECHO // Creates default config files, uses UT2004 settings.
@ECHO // ---------------------------------------------------------------------------

::
:: Verify current path
::
CD %MOD_SYS%
@IF ERRORLEVEL 1 GOTO FAILURE

::
:: Delete old config
::
DEL /F %MOD_NAME%.ini
@IF ERRORLEVEL 1 GOTO FAILURE
DEL /F %MOD_NAME%User.ini
@IF ERRORLEVEL 1 GOTO FAILURE

::
:: Forced hard reset
::
@IF /I "%1" == "-HARD" GOTO RESETCONFIG_HARD

::
:: Try to reset using UT2004 ini's
::
@IF EXIST ..\..\System\UT2004.ini (@ECHO Found UT2004.ini) ELSE GOTO RESETCONFIG_HARD
@IF EXIST ..\..\System\User.ini (@ECHO Found User.ini) ELSE GOTO RESETCONFIG_HARD


cPatchINI.exe Default.ini ..\..\System\UT2004.ini %MOD_NAME%.ini
@IF ERRORLEVEL 1 GOTO FAILURE
cPatchINI.exe DefUser.ini ..\..\System\User.ini %MOD_NAME%User.ini
@IF ERRORLEVEL 1 GOTO FAILURE

@IF EXIST My.ini cPatchINI.exe My.ini %MOD_NAME%.ini %MOD_NAME%.ini
@IF ERRORLEVEL 1 GOTO FAILURE
@IF EXIST MyUser.ini cPatchINI.exe MyUser.ini %MOD_NAME%User.ini %MOD_NAME%User.ini
@IF ERRORLEVEL 1 GOTO FAILURE

::
:: Success 
::
@GOTO SUCCESS


::
:: Try to reset using UT2004 default ini's
::
:RESETCONFIG_HARD

@IF EXIST ..\..\System\Default.ini (@ECHO Found Default.ini) ELSE GOTO FAILURE
@IF EXIST ..\..\System\DefUser.ini (@ECHO Found DefUser.ini) ELSE GOTO FAILURE

cPatchINI.exe Default.ini ..\..\System\Default.ini %MOD_NAME%.ini
@IF ERRORLEVEL 1 GOTO FAILURE
cPatchINI.exe DefUser.ini ..\..\System\DefUser.ini %MOD_NAME%User.ini
@IF ERRORLEVEL 1 GOTO FAILURE

@IF EXIST My.ini cPatchINI.exe My.ini %MOD_NAME%.ini %MOD_NAME%.ini
@IF ERRORLEVEL 1 GOTO FAILURE
@IF EXIST MyUser.ini cPatchINI.exe MyUser.ini %MOD_NAME%User.ini %MOD_NAME%User.ini
@IF ERRORLEVEL 1 GOTO FAILURE



::
:: Success 
::
@GOTO SUCCESS

::
:: Something's wrong
:: Delete Gunreal ini's in case they are corrupted somehow
::
:FAILURE
@COLOR 4F
DEL /F %MOD_NAME%.ini
DEL /F %MOD_NAME%User.ini
@ECHO.
@ECHO.
@ECHO !!! ERROR !!!
@ECHO.
@ECHO %MOD_HELP%
@ECHO %MOD_URL%
@ECHO.
@PAUSE
@COLOR


:SUCCESS


