@ECHO OFF
rem    Author: WenYang,Liu                   UPDATE: 2012/10/15
rem    cleanDispatch    
rem    remove directories and files of codebase for checkout
rem    
rem    
rem    
rem
rem


IF "%1" == "" (
	ECHO "cleanCheckoutDir <TARGET_PATH>"
	GOTO LBL_END
) 

SET TARGET_DIR=%1
ECHO "CodeBase Directory : %TARGET_DIR%"

CALL:FUNC_CLEAN_APK_WORK
CALL:FUNC_CLEAN_OVERLAY_WORK

ECHO ======================================
ECHO Task Finished!!!!&GOTO:LBL_END


:FUNC_REMOVE_DATA
ECHO "------------------------------------"
rd /s/q %~1
ECHO "------------------------------------"
GOTO LBL_END

:FUNC_CLEAN_OVERLAY_WORK
ECHO "Remove Common overlay...."
SET WORK_DIR=%TARGET_DIR%\android\device\fih\common\overlay
CALL:FUNC_REMOVE_DATA %WORK_DIR%

ECHO "Remove MK5 overlay...."
SET WORK_DIR=%TARGET_DIR%\android\device\fih\MK5\overlay
CALL:FUNC_REMOVE_DATA %WORK_DIR%

ECHO "Remove S1U overlay...."
SET WORK_DIR=%TARGET_DIR%\android\device\fih\S1U\overlay
CALL:FUNC_REMOVE_DATA %WORK_DIR%
GOTO LBL_END

REM ECHO "Remove S1M overlay...."
REM SET WORK_DIR=%TARGET_DIR%\android\device\fih\S1M\overlay
REM CALL:FUNC_REMOVE_DATA %WORK_DIR%
REM GOTO LBL_END

:FUNC_CLEAN_APK_WORK
ECHO "Remove Settings APK...."
SET WORK_DIR=%TARGET_DIR%\android\packages\apps\Settings
CALL:FUNC_REMOVE_DATA %WORK_DIR%
GOTO LBL_END

:LBL_END

