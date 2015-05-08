@ECHO OFF
rem    Author: WenYang,Liu                   UPDATE: 2012/10/12
rem    svnDispatch    
rem    checkout the part of codebase, and copy them to codebase
rem    
rem    update list:
rem    1.Settings
rem
rem

IF "%1" == "" (
	ECHO "svnDispatch <TARGET_PATH>"
	GOTO LBL_END
) 


SET TARGET_DIR=%1
SET MY_PASSWORD="my_password"
SET MY_USERNAME="my_account"
SET PFAI_URL=http://10.57.55.228/svn/PFAJ/MYPRJ


ECHO "CodeBase Directory : %TARGET_DIR%"

CALL:FUNC_DO_APK_WORK
CALL:FUNC_DO_OVERLAY_WORK

ECHO ======================================
ECHO Task Finished!!!!&GOTO:LBL_END


:FUNC_CHECKOUT
ECHO "------------------------------------"
svn co %~1 --username "%MY_USERNAME%" --password "%MY_PASSWORD%" %~2 
ECHO "------------------------------------"
GOTO LBL_END

:FUNC_DO_OVERLAY_WORK
ECHO "Checkout Common overlay...."
SET WORK_DIR=%TARGET_DIR%\android\device\fih\common\overlay
SET CHECKOUT_URL=%PFAI_URL%/android/device/fih/common/overlay
CALL:FUNC_CHECKOUT %CHECKOUT_URL% %WORK_DIR%

ECHO "Checkout MK5 overlay...."
SET WORK_DIR=%TARGET_DIR%\android\device\fih\MK5\overlay
SET CHECKOUT_URL=%PFAI_URL%/android/device/fih/MK5/overlay
CALL:FUNC_CHECKOUT %CHECKOUT_URL% %WORK_DIR%

ECHO "Checkout S1U overlay...."
SET WORK_DIR=%TARGET_DIR%\android\device\fih\S1U\overlay
SET CHECKOUT_URL=%PFAI_URL%/android/device/fih/S1U/overlay
CALL:FUNC_CHECKOUT %CHECKOUT_URL% %WORK_DIR%

REM ECHO "Checkout S1M overlay...."
REM SET WORK_DIR=%TARGET_DIR%\android\device\fih\S1M\overlay
REM SET CHECKOUT_URL=%PFAI_URL%/android/device/fih/S1M/overlay
REM CALL:FUNC_CHECKOUT %CHECKOUT_URL% %WORK_DIR%
REM GOTO LBL_END

:FUNC_DO_APK_WORK
ECHO "Checkout Settings APK...."
SET WORK_DIR=%TARGET_DIR%\android\packages\apps\Settings
SET CHECKOUT_URL=%PFAI_URL%/android/packages/apps/Settings
CALL:FUNC_CHECKOUT %CHECKOUT_URL% %WORK_DIR%
GOTO LBL_END

:LBL_END

