@echo off
set arg1=%1
REM javac "%arg1%.java"
REM java %arg1%

set mypath=%cd%
echo %mypath%
call javac "%mypath%/%arg1%.java"
call java -cp "%mypath%" "%arg1%"
