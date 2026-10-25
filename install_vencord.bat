@echo off
setlocal enabledelayedexpansion
title Vencord Installer

REM ---- Administrator rights are needed to install Git and Node.js ----
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
cd /d "%~dp0"

echo Closing Discord...
taskkill /F /IM Discord.exe >nul 2>&1
echo.

REM ======================= GIT =======================
echo Checking Git...
where git >nul 2>&1
if %errorlevel% equ 0 goto :git_ok

echo Git is NOT installed. Installing...
where winget >nul 2>&1
if %errorlevel% neq 0 goto :git_direct
winget install --id Git.Git -e --source winget --silent --accept-package-agreements --accept-source-agreements
goto :git_refresh

:git_direct
echo winget not found, downloading the Git installer directly...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; $r=Invoke-RestMethod 'https://api.github.com/repos/git-for-windows/git/releases/latest' -Headers @{'User-Agent'='vencord-installer'}; $a=$r.assets | Where-Object { $_.name -like 'Git-*-64-bit.exe' } | Select-Object -First 1; Invoke-WebRequest -Uri $a.browser_download_url -OutFile ($env:TEMP+'\git_installer.exe')"
if not exist "%TEMP%\git_installer.exe" goto :git_refresh
echo Installing Git...
start /wait "" "%TEMP%\git_installer.exe" /VERYSILENT /NORESTART

:git_refresh
REM The current window does not see the new PATH yet, so add Git manually
set "PATH=!PATH!;!ProgramFiles!\Git\cmd"
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Git could not be installed automatically.
    echo Please install it from https://git-scm.com/download/win and run this script again.
    pause
    exit /b 1
)

:git_ok
echo Git is ready.
echo.

REM ======================= NODE.JS =======================
echo Checking Node.js...
where node >nul 2>&1
if %errorlevel% equ 0 goto :node_ok

echo Node.js is NOT installed. Installing the latest LTS version...
where winget >nul 2>&1
if %errorlevel% neq 0 goto :node_direct
winget install --id OpenJS.NodeJS.LTS -e --source winget --silent --accept-package-agreements --accept-source-agreements
goto :node_refresh

:node_direct
echo winget not found, downloading the Node.js installer directly...
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; $i=Invoke-RestMethod 'https://nodejs.org/dist/index.json'; $v=($i | Where-Object { $_.lts } | Select-Object -First 1).version; Invoke-WebRequest -Uri ('https://nodejs.org/dist/'+$v+'/node-'+$v+'-x64.msi') -OutFile ($env:TEMP+'\node_installer.msi')"
if not exist "%TEMP%\node_installer.msi" goto :node_refresh
echo Installing Node.js...
start /wait msiexec /i "%TEMP%\node_installer.msi" /quiet /norestart

:node_refresh
REM The current window does not see the new PATH yet, so add Node.js manually
set "PATH=!PATH!;!ProgramFiles!\nodejs"
where node >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Node.js could not be installed automatically.
    echo Please install it from https://nodejs.org and run this script again.
    pause
    exit /b 1
)

:node_ok
set "PATH=!PATH!;!ProgramFiles!\nodejs;!APPDATA!\npm"
echo Node.js is ready.
echo.

REM ======================= VENCORD INSTALLER =======================
echo Downloading Vencord Installer...
curl -fL -o "%TEMP%\VencordInstaller.exe" https://github.com/Vencord/Installer/releases/latest/download/VencordInstaller.exe
if not exist "%TEMP%\VencordInstaller.exe" (
    echo ERROR: Could not download the Vencord Installer. Check your internet connection.
    pause
    exit /b 1
)
echo.
echo Starting Vencord Installer...
start /wait "" "%TEMP%\VencordInstaller.exe"
echo.
echo Moving to Documents folder...
cd /d "%USERPROFILE%\Documents"
echo.
echo Cloning repository...
if not exist Vencord (
    git clone https://github.com/Vendicated/Vencord.git
) else (
    echo Vencord already exists.
)
cd Vencord
echo.
echo Installing pnpm...
call npm i -g pnpm
echo.
echo Installing project dependencies...
call pnpm i
echo.
cd src
if not exist userplugins (
    mkdir userplugins
)
cd userplugins
echo.

:pluginmenu
cls
echo.
echo   ##########################################################
echo   #                                                        #
echo   #              V E N C O R D   I N S T A L L E R         #
echo   #                                                        #
echo   ##########################################################
echo.
echo   Plugin installation options:
echo.
echo    [1] Skip  - install with no extra plugins
echo    [2] List  - choose a plugin from the predefined list
echo    [3] Custom - paste your own plugin repository URL
echo.
echo   This installer script: https://github.com/mateusz2024/Vencord-Plugins-installer
echo.
set /p pluginchoice=  Select an option (1/2/3): 

if "%pluginchoice%"=="1" goto :buildstep
if "%pluginchoice%"=="2" goto :listplugins
if "%pluginchoice%"=="3" goto :customplugin
echo.
echo   Invalid choice, please try again.
timeout /t 2 >nul
goto :pluginmenu

:listplugins
set "pluginurl="
cls
echo.
echo   ##########################################################
echo   #                  POPULAR  PLUGINS                      #
echo   ##########################################################
echo.
echo    [1]  Message Logger Enhanced   (most popular third-party plugin)
echo         - Logs deleted/edited messages, images and ghost pings.
echo.
echo    [2]  Complete Discord Quest
echo         - Automatically completes Discord quests in the background.
echo.
echo    [3]  D3SOX Userplugins   (BUNDLE)
echo         - BetterActivities, FollowUser, SilentTyping,
echo           VoiceChatUtilities, MediaPlaybackSpeed and more.
echo.
echo    [4]  NuzProjects Userplugins   (BUNDLE)
echo         - Math Count, Auto Reactor, Staff Crowns,
echo           Role Mention Icons, Fake Forward, Lock Group and more.
echo.
echo    [5]  Last Online Tracker
echo         - Shows when Discord users were last online.
echo.
echo    [6]  Activity Tracker
echo         - Logs presence changes, typing and activity updates
echo           and shows them in an in-app window.
echo.
echo    [7]  PluralKit Prism
echo         - PluralKit integration for Vencord.
echo.
echo    [8]  Song Spotlight
echo         - Lets you pin songs to your Discord profile.
echo.
echo    [9]  WakaTime
echo         - Automatic time tracking and stats about your Discord usage.
echo.
echo   [b] Back to main menu
echo.
set /p listchoice=  Select a plugin number (or b for back): 

if /i "%listchoice%"=="b" goto :pluginmenu

if "%listchoice%"=="1" set pluginurl=https://github.com/Syncxv/vc-message-logger-enhanced
if "%listchoice%"=="2" set pluginurl=https://github.com/nicola02nb/completeDiscordQuest
if "%listchoice%"=="3" set pluginurl=https://github.com/D3SOX/vencord-userplugins
if "%listchoice%"=="4" set pluginurl=https://github.com/NuzProjects/Vencord-Userplugins
if "%listchoice%"=="5" set pluginurl=https://github.com/k1ng0p/LastOnlineTracker
if "%listchoice%"=="6" set pluginurl=https://github.com/Ondra-D/vencord-activity-tracker
if "%listchoice%"=="7" set pluginurl=https://github.com/KassieKitsune/pkPrism
if "%listchoice%"=="8" set pluginurl=https://github.com/nexpid/vc-songSpotlight
if "%listchoice%"=="9" set pluginurl=https://github.com/wakatime/vencord-wakatime

if "%pluginurl%"=="" (
    echo.
    echo   Invalid choice, please try again.
    timeout /t 2 >nul
    goto :listplugins
)
goto :clonecheck

:customplugin
cls
echo.
echo   ##########################################################
echo   #               CUSTOM  PLUGIN  URL                      #
echo   ##########################################################
echo.
set /p pluginurl=  Paste plugin repository URL: 
if "%pluginurl%"=="" (
    echo.
    echo   No URL provided. Returning to menu.
    timeout /t 2 >nul
    goto :pluginmenu
)
goto :clonecheck

:clonecheck
echo.
for %%F in ("%pluginurl%") do set "plugindir=%%~nF"

if exist "%plugindir%" if not exist "%plugindir%\index.ts" if not exist "%plugindir%\index.tsx" (
    set "foundSub="
    for /d %%D in ("%plugindir%\*") do (
        if exist "%%D\index.ts" set "foundSub=%%D"
        if exist "%%D\index.tsx" set "foundSub=%%D"
    )
    if not defined foundSub (
        echo Found an incomplete or broken folder "%plugindir%", removing it first...
        rmdir /s /q "%plugindir%"
    )
)

if exist "%plugindir%" (
    echo Plugin folder "%plugindir%" already exists, skipping clone.
) else (
    echo Cloning plugin from %pluginurl% ...
    git clone "%pluginurl%"
)

REM Some plugin repos nest the actual plugin inside a subfolder instead of
REM putting index.ts/index.tsx at the repo root. Flatten that here so
REM Vencord's build can resolve "./userplugins/%plugindir%" correctly.
if exist "%plugindir%" if not exist "%plugindir%\index.ts" if not exist "%plugindir%\index.tsx" (
    set "foundSub="
    for /d %%D in ("%plugindir%\*") do (
        if exist "%%D\index.ts" set "foundSub=%%D"
        if exist "%%D\index.tsx" set "foundSub=%%D"
    )
    if defined foundSub (
        echo Detected nested plugin folder, fixing structure...
        move "!foundSub!" "%plugindir%_flat" >nul
        rmdir /s /q "%plugindir%"
        ren "%plugindir%_flat" "%plugindir%"
    )
)

echo Building Vencord with the new plugin...
cd ..\..
call pnpm build
echo Injecting Vencord...
call pnpm inject
goto :startdiscord

:buildstep
echo Skipping plugin installation.
cd ..\..

:startdiscord
echo.
echo Starting Discord...
start "" "%LOCALAPPDATA%\Discord\Update.exe" --processStart Discord.exe
echo.
echo ##########################################################
echo   DONE! Vencord and any selected plugins have been installed.
echo.
echo   IMPORTANT: Newly installed plugins are NOT enabled by default.
echo   Open Discord, go to Vencord Settings -^> Plugins, find the
echo   plugin(s) you installed, and toggle them ON to activate them.
echo ##########################################################
echo.
pause
