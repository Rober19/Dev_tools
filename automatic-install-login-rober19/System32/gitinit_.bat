@echo off

set a=%1
set b=%2
IF NOT "%a%"=="" (
    IF NOT "%b%"=="" (
        git init
        git add -A 
        git remote add %a% %b%   
        echo =============================
        git remote -v
        echo =============================
    ) ELSE (
        echo ERROR!
        echo example: gitinit_ "ExampleOrigin" "exampleURL"
    )
) ELSE (
    echo ERROR!
    echo example: gitinit_ "ExampleOrigin" "exampleURL"
)
