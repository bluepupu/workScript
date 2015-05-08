@echo off

SET SECS=%1
if NOT DEFINED SECS (SET SECS=3)

echo test: %SECS%

ping -n %SECS% 127.0.0.1 > null