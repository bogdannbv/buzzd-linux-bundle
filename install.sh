#!/usr/bin/env bash

ymsgr_installer="./bin/ymsgr9002162-us.exe"
flash_installer="./bin/flash-ax-11.3.300.268.exe"
patcher="./bin/bzdpatcher-1.2.1.exe"

WINEPREFIX="${HOME}/.wine-buzzd-chat"

if ! command -v "wine" >/dev/null 2>&1
then
    echo "ERROR: wine could not be found"
    exit 1
fi

if ! command -v "winetricks" >/dev/null 2>&1
then
    echo "ERROR: winetricks could not be found"
    exit 1
fi

echo "INFO: Creating ${WINEPREFIX} prefix directory if it doesn't exist..."
mkdir -p "${WINEPREFIX}"
export WINEPREFIX

if [ -n "$( ls -A "${WINEPREFIX}" )" ]; then
   echo "ERROR: ${WINEPREFIX} is not empty, exiting..."
   exit 1
fi

echo "INFO: Installing Flash Player..."
wine "${flash_installer}" -install

echo "INFO: Installing Yahoo! Messenger..."
wine "${ymsgr_installer}" /S /Q

echo "INFO: Starting BZDPatcher..."
wine "${patcher}"

echo "INFO: Installing fonts"
winetricks -q corefonts tahoma

echo "INFO: Installing Internet Explorer 8"
winetricks -q ie8
