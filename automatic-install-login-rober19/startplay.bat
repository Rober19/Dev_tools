@echo off

setlocal enabledelayedexpansion

rem Read the Git for Windows installation path from the Registry.
for %%k in (HKCU HKLM) do (
    for %%w in (\ \Wow6432Node\) do (
        for /f "skip=2 delims=: tokens=1*" %%a in ('reg query "%%k\SOFTWARE%%wMicrosoft\Windows\CurrentVersion\Uninstall\Git_is1" /v InstallLocation 2^> nul') do (
            for /f "tokens=3" %%z in ("%%a") do (
                set GIT=%%z:%%b
                echo Found Git at "!GIT!".
                goto FOUND
            )
        )
    )
)

goto NOT_FOUND

:FOUND
:: call powershell.exe -file installScoop.ps1
powershell -Command "& {Set-ExecutionPolicy RemoteSigned -scope CurrentUser; iex (new-object net.webclient).downloadstring('https://get.scoop.sh')}"
call scoop bucket add extras
:: jq is a JSON processor
call scoop install jq
call scoop install nodejs-lts
call ng --version || call npm i -g @angular/cli
call heroku --version || call npm i -g heroku
call firebase --version || call npm i -g firebase-tools


for /f "tokens=*" %%a in ('jq ". | .git.user" -r database.json') do (
    set userName1=%%a
)
for /f "tokens=*" %%a in ('jq ". | .git.email" -r database.json') do (
    set email1=%%a
)
echo git config --global user.name %userName1%
call git config --global user.name %userName1%
echo git config --global user.email %email1%
call git config --global user.email %email1%

REM call heroku login --browser=chrome
REM call firebase login

rem Make sure Bash is in PATH (for running scripts).
rem set PATH=%GIT%bin;%PATH%


set "jsonfile=database.json"

set "psCmd="add-type -As System.Web.Extensions;^
$JSON = new-object Web.Script.Serialization.JavaScriptSerializer;^
$JSON.DeserializeObject($input)""



echo == npm ==
for /f "tokens=*" %%a in ('jq ". | .npm.user" -r database.json') do (
    set user=%%a
)
for /f "tokens=*" %%a in ('jq ". | .npm.password" -r database.json') do (
    set password=%%a
)
for /f "tokens=*" %%a in ('jq ". | .npm.email" -r database.json') do (
    set email=%%a
)
call npm-login-cli "https://registry.npmjs.org" %user% %password% %email%
sync_scripts.bat

echo ==========================================
echo         GitHub should be logged
echo           NPM should be logged
echo    Dont forget only use SSH repositories
echo         for: Gitlab and DevOps
echo ==========================================
echo           CHECK ALL OF THESE



rem Do something with Git ...
exit/b
:NOT_FOUND
echo You should install git first : https://www.git-scm.com/download/win
exit/b