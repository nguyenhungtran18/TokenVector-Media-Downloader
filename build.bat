@echo off
setlocal enabledelayedexpansion

echo ===============================================================================
echo  TokenVector Media Downloader Engine - Build Automation Pipeline via tkvc.exe
echo  Repository: https://github.com/nguyenhungtran18/TokenVector
echo ===============================================================================

:: 1. Kiem tra trinh bien dich tkvc.exe
set "TKVC_BIN=tkvc.exe"
if exist "tkvc.exe" (
    set "TKVC_BIN=..\tkvc.exe"
) else (
    where tkvc.exe >nul 2>&1
    if !errorlevel! equ 0 (
        set "TKVC_BIN=tkvc.exe"
    ) else (
        echo [ERROR] Khong tim thay trinh bien dich tkvc.exe!
        echo Vui long dat tkvc.exe tai thu muc goc du an hoac them vao PATH.
        exit /b 1
    )
)

echo [INFO] Su dung trinh bien dich TokenVector: tkvc.exe

:: 2. Thiet lap thu muc output
if not exist "bin" mkdir "bin"

:: 3. Bien dich CLI Engine tu ma nguon cli_runner.tkv
echo.
echo [BUILD] Dang bien dich src\cli_runner.tkv qua tkvc.exe...
cd src
%TKVC_BIN% build cli_runner.tkv --entry main --out ..\bin\tv-downloader-cli.exe
if !errorlevel! neq 0 (
    echo [ERROR] Bien dich cli_runner.tkv that bai!
    cd ..
    exit /b !errorlevel!
)
echo [SUCCESS] Tao thanh cong: bin\tv-downloader-cli.exe

:: 4. Bien dich GUI Engine tu ma nguon gui_runner.tkv
echo.
echo [BUILD] Dang bien dich src\gui_runner.tkv qua tkvc.exe...
%TKVC_BIN% build gui_runner.tkv --entry run --out ..\bin\tv-downloader-gui.exe
if !errorlevel! neq 0 (
    echo [ERROR] Bien dich gui_runner.tkv that bai!
    cd ..
    exit /b !errorlevel!
)
cd ..
echo [SUCCESS] Tao thanh cong: bin\tv-downloader-gui.exe

echo.
echo ===============================================================================
echo  Build hoan tat thanh cong 100%% bang tkvc.exe! Binary san sang tai bin\
echo ===============================================================================
exit /b 0
