@echo off
set a=%1
set b=%2
IF NOT "%a%"=="" (
    IF NOT "%b%"=="" (
        echo =============================
        git remote -v
        echo =============================
        git remote rm %a%
        git remote add %a% %b%
        echo =============================
        git remote -v
        echo =============================
    ) ELSE (
        echo ERROR!
        echo example: gitcr "ExampleOrigin" "exampleURL"
    )
) ELSE (
    echo ERROR!
    echo example: gitcr "ExampleOrigin" "exampleURL"
)


