:mainFunc
@echo off
for /f "tokens=1-3 delims=/ " %%i in ('date /t') do (set Info_Date=%%i_%%j_%%k)  
for /f "tokens=2-3 delims=: " %%i in ('time /t') do (set Info_Time=%%i_%%j)  
for /f "tokens=1" %%i in ('adb shell getprop ro.serialno') do (set PID=%%i)
rem for /f "tokens=1" %%i in ('adb shell getprop ro.product.device') do (set DEV=%%i)
rem service.adb.root

echo -------------------------------------------
echo Before your dump log, Be sure your are root
echo -------------------------------------------
adb root
@pause

set INFO=[%Info_Date%][%Info_Time%][%PID%]
set DIR=[Log]%INFO%
set INTERNAL_STORAGE=Internal_Storage
set EXTERNAL_STORAGE=External_Storage
set CAPTURE_LOG=%DIR%/shell_log

md %DIR%
md %DIR%\%INTERNAL_STORAGE%
rem md %DIR%\%EXTERNAL_STORAGE%

echo Copying FIH Log
echo %INFO% > %CAPTURE_LOG%
echo. >> %CAPTURE_LOG%

call:fihLogFunc
call:commonLogFunc
call:otherInfoFunc
@pause
goto:eof

:adbPullCmdFunc
set SRC_PATH=%1
set DES_PATH=%2
echo adb pull %SRC_PATH% %DES_PATH% >> %CAPTURE_LOG%
adb pull %SRC_PATH% %DES_PATH% >> %CAPTURE_LOG% 2>&1
goto:eof

:fihLogFunc
echo Copying Log @ Internal Storage
for /f "tokens=1,2 delims=/" %%i in ('adb shell ls /data/logs/alog*') do (
	call:adbPullCmdFunc /%%i/%%j %DIR%/%INTERNAL_STORAGE%/FIH_Log/%%j )

rem echo Copying Log @ External Storage
rem external storage is not implemented now

echo Copying Black Box
call:adbPullCmdFunc /BBSYS/alog_fih %DIR%/%INTERNAL_STORAGE%/BBSYS

echo Copy FIH Statistics
call:adbPullCmdFunc /data/fih_statistics %DIR%/%INTERNAL_STORAGE%/FIH_Statistics
goto:eof

:commonLogFunc
rem data information
echo Copying MKY Log, ANR, TombStones
call:adbPullCmdFunc /data/MKY_LOG %DIR%/%INTERNAL_STORAGE%/MKY_Log
call:adbPullCmdFunc /data/anr %DIR%/%INTERNAL_STORAGE%/ANR
call:adbPullCmdFunc /data/tombstones %DIR%/%INTERNAL_STORAGE%/Tombstones


rem dropbox 
echo Copying Dropbox
call:adbPullCmdFunc /data/system/dropbox %DIR%/%INTERNAL_STORAGE%/Dropbox
adb shell dumpsys dropbox > %DIR%/%INTERNAL_STORAGE%/dropbox_file_list

rem subsystem
echo Copying Subsystem Ramdump
call:adbPullCmdFunc /data/ramdump %DIR%/%INTERNAL_STORAGE%/SS_Ramdump
goto:eof

:otherInfoFunc
rem last mechanism files
call:adbPullCmdFunc /proc/last_kmsg %DIR%/last_kmsg

rem power on cause & reboot reason
echo Record Power On Cause
adb shell cat /proc/poweroncause > %DIR%/poweroncause
echo Record Reboot Reason
adb shell cat /proc/rebootreason > %DIR%/rebootreason

rem report & dumpsys for phone hang case
echo Create Bug Report
adb shell bugreport > %DIR%/bugreport
echo Dump System Information
adb shell dumpsys > %DIR%/dumpsys
goto:eof

rem using function in batch
rem call:pullLog arg1 arg2 arg3
rem goto:eof
rem %~1: String @ source path
rem %~2: String @ destination path
rem %~3: String @ destination path
:pullLog
echo %~1
echo %~2
echo %~3
goto:eof
