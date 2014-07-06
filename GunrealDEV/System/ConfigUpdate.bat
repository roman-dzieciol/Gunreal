:: ----------------------------------------------------------------------------
::  UT2004 TC Config Updater, (C) 2006 Roman Switch` Dzieciol
:: ----------------------------------------------------------------------------

@SET MOD_NAME=Gunreal
@SET MOD_SYS=..\..\%MOD_NAME%\System
@SET MOD_HELP=If you need assistance please contact us.
@SET MOD_URL=http://www.gunreal.com

@ECHO // ---------------------------------------------------------------------------
@ECHO //  Updates Gunreal config files, for manual patching.
@ECHO // ---------------------------------------------------------------------------

::
:: Verify current path
::
CD %MOD_SYS%
@IF ERRORLEVEL 1 GOTO FAILURE

::
:: Try to reset using UT2004 ini's
::
@IF EXIST %MOD_NAME%.ini (@ECHO Found %MOD_NAME%.ini) ELSE GOTO FAILURE
@IF EXIST %MOD_NAME%User.ini (@ECHO Found %MOD_NAME%User.ini) ELSE GOTO FAILURE


cPatchINI.exe Default.ini %MOD_NAME%.ini %MOD_NAME%.ini
@IF ERRORLEVEL 1 GOTO FAILURE
cPatchINI.exe DefUser.ini %MOD_NAME%User.ini %MOD_NAME%User.ini
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


