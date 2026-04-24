@echo off
setlocal

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
set /p pluginurl=Paste plugin repository URL:

echo.
git clone "%pluginurl%"

echo.
echo Starting Discord...

start "" "%LOCALAPPDATA%\Discord\Update.exe" --processStart Discord.exe

echo.
echo DONE.
pause