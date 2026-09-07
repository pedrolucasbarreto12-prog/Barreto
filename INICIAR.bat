@echo off
chcp 65001 >nul
title Conectar contas - Speedpost
cd /d "%~dp0"
setlocal enabledelayedexpansion

echo.
echo  ==========================================================
echo    Conectar contas a Speedpost
echo  ==========================================================
echo.

set "WTEST=%~dp0__permissao.tmp"
break > "%WTEST%" 2>nul
if not exist "%WTEST%" (
    echo  ERRO: esta pasta nao permite gravar arquivos.
    echo  Extraia o ZIP para uma pasta normal e tente novamente.
    pause
    exit /b 1
)
del "%WTEST%" >nul 2>nul

set "NODE=node"
if exist "%~dp0node\node.exe" set "NODE=%~dp0node\node.exe"
"%NODE%" --version >nul 2>nul
if errorlevel 1 (
    echo  [1/3] Instalando Node.js LTS...
    winget install -e --id OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
    set "NODE=node"
    "!NODE!" --version >nul 2>nul
    if errorlevel 1 (
        echo  ERRO: instale o Node.js LTS em https://nodejs.org
        pause
        exit /b 1
    )
) else (
    echo  [1/3] Node.js encontrado.
)

if not exist "node_modules\" (
    echo  [2/3] Instalando o necessario e baixando o navegador...
    call npm install --omit=dev --no-audit --no-fund
    if errorlevel 1 (
        echo  ERRO na instalacao. Verifique a internet e o antivirus.
        pause
        exit /b 1
    )
) else (
    echo  [2/3] Dependencias ja instaladas.
)

echo  [3/3] Abrindo http://localhost:7878
"%NODE%" src\server.js
pause
