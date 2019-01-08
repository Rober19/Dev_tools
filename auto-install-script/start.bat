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


set /p userName1=Enter commit name: 
echo git config --global user.name %userName1%
call git config --global user.name %userName1%
set /p email1=Enter commit name: 
echo git config --global user.email %email1%
call git config --global user.email %email1%


echo ==========================================
echo             DEV-PACK @rober19
echo ==========================================
echo           CHECK ALL OF THESE


pause
rem Do something with Git ...
exit/b

:NOT_FOUND
echo You should install git first : https://www.git-scm.com/download/win
exit/b