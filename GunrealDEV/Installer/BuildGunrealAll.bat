:: ----------------------------------------------------------------------------
::  Compile Gunreal and build files for release (installer, etc)
:: ----------------------------------------------------------------------------

ModBuild.exe BuildGunrealScript.xml
@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE

ModBuild.exe BuildGunrealRelease.xml
@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE


:: ----------------------------------------------------------------------------
::  Exit Points
:: ----------------------------------------------------------------------------

:SUCCESS
PAUSE
@GOTO ENDOFFILE

:FAILURE
@COLOR 4F
@PAUSE
@COLOR
@GOTO ENDOFFILE


:ENDOFFILE
:: ----------------------------------------------------------------------------
::  EOF
:: ----------------------------------------------------------------------------