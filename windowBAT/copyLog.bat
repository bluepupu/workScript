REM ***************************************************
REM Copy log from DUT to upload server
REM 
REM  WenYang, 2015/05/08
REM  
REM  @TO DO: 
REM    (1)Change the ref location, not only support current dir 
REM    (2)Set the some string to variable(ex. compress location)
REM ***************************************************

for /F "tokens=*" %%i in ('adb shell ls /sdcard/ ^| findstr 2015') do set LOG_DIR_NAME=%%i
echo %LOG_DIR_NAME%
set SOURCEDIR=/sdcard/%LOG_DIR_NAME%
mkdir %LOG_DIR_NAME%
cd %LOG_DIR_NAME%
adb pull %SOURCEDIR%

REM Compress the log and upload
cd ..
"C:\Program Files\7-Zip\7z.exe" a %LOG_DIR_NAME%.7z .\%LOG_DIR_NAME%

SET TodayYear=%date:~0,4%
SET TodayMonthP0=%date:~5,2%
SET TodayDayP0=%date:~8,2%
SET UPLAOD_DIR_BASE=\\10.57.62.193\Workspace2\AppMonkeyTest\
SET UPLOAD_DIR_NAME=%UPLAOD_DIR_BASE%\%TodayYear%%TodayMonthP0%%TodayDayP0%\APP_Email
mkdir %UPLOAD_DIR_NAME%

copy %LOG_DIR_NAME%.7z %UPLOAD_DIR_NAME%
