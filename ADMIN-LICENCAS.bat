@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Painel de Licencas Speedpost
node ADMIN-LICENCAS.js
pause
