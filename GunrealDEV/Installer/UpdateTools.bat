:: ----------------------------------------------------------------------------
::  EXE UPDATER
:: ----------------------------------------------------------------------------

COPY %SWITCH01%\ModBuild\trunk\vc_mswu\ModBuild.exe ModBuild.exe
@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE
COPY %SWITCH01%\ModBuild\trunk\ModBuild.xsd ModBuild.xsd
@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE
COPY %SWITCH01%\ModBuild\trunk\ModBuildActions.xml ModBuildActions.xml
@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE

COPY %SWITCH01%\ModUpdater\trunk\vc_mswu\ModUpdater.exe ..\Updater.exe
@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE
COPY %SWITCH01%\ModUpdater\trunk\UpdaterMirrors.xsd ..\UpdaterMirrors.xsd
@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE
COPY %SWITCH01%\ModUpdater\trunk\UpdaterPackages.xsd ..\UpdaterPackages.xsd
@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE

COPY %SWITCH01%\MSI_VerifyUT2K4Dir\trunk\Release\MSI_VerifyUT2K4Dir.dll MSI_VerifyUT2K4Dir.dll
@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE

COPY %SWITCH01%\UnINI\trunk\Release\MSI_PatchINI.dll MSI_PatchINI.dll
@IF %ERRORLEVEL% NEQ 0 GOTO FAILURE

COPY %SWITCH01%\XMLValidate\trunk\Release\XMLValidate.exe XMLValidate.exe
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