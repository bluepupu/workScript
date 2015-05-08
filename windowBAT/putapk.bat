adb root
rem pause
java -classpath D:\setBatFiles SleepToolKit 5
adb remount
adb push %1 /system/app
rem pause
rem adb reboot
