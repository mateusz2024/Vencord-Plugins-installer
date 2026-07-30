@echo off
setlocal enabledelayedexpansion
echo Closing Discord...
taskkill /F /IM Discord.exe >nul 2>&1
echo.
echo Checking Git...
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Git is NOT installed. Downloading...
    curl -L -o git_installer.exe https://github.com/git-for-windows/git/releases/latest/download/Git-64-bit.exe
    echo Installing Git...
    start /wait "" git_installer.exe /VERYSILENT /NORESTART
) else (
    echo Git is already installed.
)
echo.
echo Checking Node.js...
node -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js is NOT installed. Downloading...
    curl -L -o node_installer.msi https://nodejs.org/dist/latest/node-v20-x64.msi
    echo Installing Node.js...
    start /wait msiexec /i node_installer.msi /quiet /norestart
) else (
    echo Node.js is already installed.
)
echo.
echo Downloading Vencord Installer...
curl -L -o VencordInstaller.exe https://github.com/Vencord/Installer/releases/latest/download/VencordInstaller.exe
echo.
echo Starting Vencord Installer...
start /wait VencordInstaller.exe
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
goto :listpage1

:listpage1
cls
echo.
echo   ##########################################################
echo   #             AVAILABLE PLUGINS  (page 1/2)              #
echo   ##########################################################
echo.
echo    [1]  Complete Discord Quest
echo         - Automatically completes Discord quests in the background.
echo.
echo    [2]  Fake Voice Options
echo         - Adds fake/extra voice channel settings and options.
echo.
echo    [3]  Mute Alert
echo         - Plays a sound alert when you get muted/unmuted.
echo.
echo    [4]  Giphy Gif Search
echo         - Lets you search and send GIFs from Giphy directly in chat.
echo.
echo    [5]  Vencord Shazam
echo         - Identifies songs playing in a voice channel, Shazam-style.
echo.
echo    [6]  Plugin Repo
echo         - Adds an in-app browser to discover and install other
echo           third-party Vencord plugins directly from Discord settings.
echo.
echo    [7]  Quest Completer (alt)
echo         - Alternative, simpler quest-completing plugin.
echo.
echo    [8]  VencordPlugins (verticalsync)
echo         - BUNDLE: a collection of several community plugins in one repo.
echo.
echo    [9]  vc-plugins (ImLvna)
echo         - BUNDLE: another collection of several community plugins.
echo.
echo   [n] Next page   [b] Back to main menu
echo.
goto :listinputloop

:listpage2
cls
echo.
echo   ##########################################################
echo   #             AVAILABLE PLUGINS  (page 2/2)              #
echo   ##########################################################
echo.
echo   [10]  D3SOX Userplugins
echo         - BUNDLE: BetterActivities, FollowUser, SilentTyping,
echo           VoiceChatUtilities, MediaPlaybackSpeed and more.
echo.
echo   [11]  ErdbeerbaerLP Userplugins
echo         - BUNDLE: a collection of various custom plugins.
echo.
echo   [12]  nmsturcke Vencord-Plugins
echo         - BUNDLE: handy plugins that never made it into official Vencord.
echo.
echo   [13]  002-sans VencordPlugins
echo         - BUNDLE: badge selectors, custom UI tweaks and more.
echo.
echo   [14]  owoyi Userplugins
echo         - BUNDLE: AutoAttendance, SendButton and more.
echo.
echo   [15]  zaher-neon Userplugins
echo         - BUNDLE: a collection of various custom mods.
echo.
echo   [16]  theokyr Vencord-Plugins
echo         - BUNDLE: UI enhancements, keyboard navigation, dev tools.
echo.
echo   [17]  coreknee VencordPlugins
echo         - BUNDLE: an assortment of third-party plugins.
echo.
echo   [p] Previous page   [b] Back to main menu
echo.
goto :listinputloop

:listinputloop
set /p listchoice=  Select a plugin number, [n]/[p] to change page, or [b] for back: 

if /i "%listchoice%"=="n" goto :listpage2
if /i "%listchoice%"=="p" goto :listpage1
if /i "%listchoice%"=="b" goto :pluginmenu

if "%listchoice%"=="1" set pluginurl=https://github.com/nicola02nb/completeDiscordQuest
if "%listchoice%"=="2" set pluginurl=https://github.com/eightcon/FakeVoiceOptions
if "%listchoice%"=="3" set pluginurl=https://github.com/FawazTakahji/muteAlert.desktop
if "%listchoice%"=="4" set pluginurl=https://github.com/caffeinepx/GiphyGifSearch
if "%listchoice%"=="5" set pluginurl=https://github.com/kadrxy/vencord-shazam
if "%listchoice%"=="6" set pluginurl=https://github.com/ScattrdBlade/pluginRepo
if "%listchoice%"=="7" set pluginurl=https://github.com/Koma4k0/Quest-Completer
if "%listchoice%"=="8" set pluginurl=https://github.com/verticalsync/VencordPlugins
if "%listchoice%"=="9" set pluginurl=https://github.com/ImLvna/vc-plugins
if "%listchoice%"=="10" set pluginurl=https://github.com/D3SOX/vencord-userplugins
if "%listchoice%"=="11" set pluginurl=https://github.com/ErdbeerbaerLP/vencord-userplugins
if "%listchoice%"=="12" set pluginurl=https://github.com/nmsturcke/Vencord-Plugins
if "%listchoice%"=="13" set pluginurl=https://github.com/002-sans/VencordPlugins
if "%listchoice%"=="14" set pluginurl=https://github.com/owoyi/vencord-userplugins
if "%listchoice%"=="15" set pluginurl=https://github.com/zaher-neon/vencord-userplugins
if "%listchoice%"=="16" set pluginurl=https://github.com/theokyr/vencord-plugins
if "%listchoice%"=="17" set pluginurl=https://github.com/coreknee/VencordPlugins

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
