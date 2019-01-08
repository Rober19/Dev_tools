@echo off
git status
MD tempF1
CD tempF1
for /F "usebackq tokens=1" %%A IN (`git config user.name`) do (
  set gituser=%%A
)
echo  ^<-- GIT User> "%gituser%"
findstr /A:0a /S "<--" "%gituser%" 
cd..
RD /s /q tempF1
::call node exec.js repo=devops

call sync.bat

git add -A
call npm version -f patch 
git push origin master
pause