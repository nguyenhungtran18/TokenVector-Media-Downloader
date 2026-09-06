@echo off
cd /d "%~dp0"
echo ===============================================================================
echo  TOKENVECTOR MEDIA DOWNLOADER - WINDOWS GUI APPLICATION
echo  Source: src\gui_runner.tkv (Native .tkv compiled via tkvc.exe)
echo ===============================================================================
echo.
echo Dang khoi chay giao dien do hoa WinForms...
start "" "%~dp0tv-downloader-gui.exe"

