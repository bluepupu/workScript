

echo "CopyRes <source res dir> <retrieve file name>"
REM CopyRes U:\LSOL_201032\LINUX\LINUX\android\packages\apps\UnifiedEmail\res ic_menu_search.png

SET SOURCE_RES=%1
SET SOURCE_FILENAME=%2

SET TodayYear=%date:~0,4%
SET TodayMonthP0=%date:~5,2%
SET TodayDayP0=%date:~8,2%

SET UPLOAD_DIR_NAME=.\%TodayYear%%TodayMonthP0%%TodayDayP0%_Email_Res

mkdir %UPLOAD_DIR_NAME%\drawable-mdpi
copy %SOURCE_RES%\drawable-mdpi\%SOURCE_FILENAME%  %UPLOAD_DIR_NAME%\drawable-mdpi\

mkdir %UPLOAD_DIR_NAME%\drawable-hdpi
copy %SOURCE_RES%\drawable-hdpi\%SOURCE_FILENAME%  %UPLOAD_DIR_NAME%\drawable-hdpi\

mkdir %UPLOAD_DIR_NAME%\drawable-xhdpi
copy %SOURCE_RES%\drawable-xhdpi\%SOURCE_FILENAME%  %UPLOAD_DIR_NAME%\drawable-xhdpi\

mkdir %UPLOAD_DIR_NAME%\drawable-xxhdpi
copy %SOURCE_RES%\drawable-xxhdpi\%SOURCE_FILENAME%  %UPLOAD_DIR_NAME%\drawable-xxhdpi\

mkdir %UPLOAD_DIR_NAME%\drawable-xxxhdpi
copy %SOURCE_RES%\drawable-xxxdpi\%SOURCE_FILENAME%  %UPLOAD_DIR_NAME%\drawable-xxxdpi\


