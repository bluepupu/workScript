@echo off

SET TodayYear=%date:~0,4%
SET TodayMonthP0=%date:~5,2%
SET TodayDayP0=%date:~8,2%

SET TodayDate=%date:~0,4%%date:~5,2%%date:~8,2%
SET TodayTime=%time:~0,2%%time:~3,2%%time:~6,2%

SET FileName=%TodayDate%_%TodayTime%.log
echo Log filename: %cd%%FileName%

adb shell logcat -c && adb shell logcat -v threadtime > %FileName%