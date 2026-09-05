#!/usr/bin/env bash
set -euo pipefail

echo "==============================================================================="
echo " TokenVector Media Downloader Engine - Build Pipeline (Linux/macOS)"
echo " Repository: https://github.com/nguyenhungtran18/TokenVector"
echo "==============================================================================="

TKVC_BIN="tkvc"
if [ -f "./tkvc" ]; then
    TKVC_BIN="./tkvc"
fi

mkdir -p bin

echo "[BUILD] Bien dich src/cli_runner.tkv qua tkvc..."
cd src
"$TKVC_BIN" build cli_runner.tkv --entry main --out ../bin/tv-downloader-cli
cd ..

echo "[BUILD] Bien dich src/gui_runner.tkv qua tkvc..."
cd src
"$TKVC_BIN" build gui_runner.tkv --entry run --out ../bin/tv-downloader-gui
cd ..

chmod +x bin/*
echo "[SUCCESS] Build hoan tat qua tkvc!"
