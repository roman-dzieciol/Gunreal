:: ----------------------------------------------------------------------------
::  Compile Gunreal
:: ----------------------------------------------------------------------------

ModBuild.exe BuildGunrealScript.xml
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