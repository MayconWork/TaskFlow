@echo off
setlocal enabledelayedexpansion

set current=

for /r %%f in (*.*) do (

    set path=%%~dpf

    set ignore=0

    if not "!path:vendor=!"=="!path!" set ignore=1
    if not "!path:node_modules=!"=="!path!" set ignore=1
    if not "!path:storage=!"=="!path!" set ignore=1
    if not "!path:logs=!"=="!path!" set ignore=1
    if not "!path:cache=!"=="!path!" set ignore=1
    if not "!path:node_modules=!"=="!path!" set ignore=1
    if not "!path:.git=!"=="!path!" set ignore=1

    if !ignore! == 0 (

        if not "!current!"=="!path!" (
            set current=!path!
            echo.
            echo Pasta: !current!
        )

        echo   %%~nxf
    )
)