@echo off
chcp 65001 > nul
title Tushi Whisper Sync
setlocal

set "PACK_DIR=%~dp0"
set "WHISPER_DIR=%PACK_DIR%ExePack\Whisper"
set "CONTENT_DIR=%WHISPER_DIR%\whisper_cli"
set "URL_PUBLIC=https://gitee.com/zttbb/tushi-whisper.git"

if not defined TUSHI_PROXY_HOST set "proxy_host=127.0.0.1"
if not defined TUSHI_PROXY_PORT set "proxy_port=11304"
if defined TUSHI_PROXY_HOST set "proxy_host=%TUSHI_PROXY_HOST%"
if defined TUSHI_PROXY_PORT set "proxy_port=%TUSHI_PROXY_PORT%"
set "proxy_url=http://%proxy_host%:%proxy_port%"

set "GIT_EXE=%PACK_DIR%..\git\cmd\git.exe"
if not exist "%GIT_EXE%" (
  where git >nul 2>&1
  if not errorlevel 1 (for /f "tokens=*" %%i in ('where git') do set "GIT_EXE=%%i") else (
    echo [whisper] git not found, skip.
    exit /b 0
  )
)
set GIT_TERMINAL_PROMPT=0
set GIT_ASKPASS=

if not exist "%WHISPER_DIR%" mkdir "%WHISPER_DIR%"

rem 独立模式：tushi-whisper 仓库本体克隆到 WHISPER_DIR（ExePack\Whisper），
rem 内容目录为 CONTENT_DIR（whisper_cli），whisper_cli.exe 位于其中

if exist "%WHISPER_DIR%\.git" (
  echo [whisper] updating...
  "%GIT_EXE%" -C "%WHISPER_DIR%" -c credential.helper= -c core.askpass= fetch --depth 1 origin
  if errorlevel 1 (
    "%GIT_EXE%" -C "%WHISPER_DIR%" -c http.proxy=%proxy_url% -c https.proxy=%proxy_url% -c credential.helper= -c core.askpass= fetch --depth 1 origin
  )
  "%GIT_EXE%" -C "%WHISPER_DIR%" reset --hard FETCH_HEAD >nul 2>&1
  goto MERGE
)

if exist "%CONTENT_DIR%\whisper_cli.exe" (
  echo [whisper] local copy exists, skip download.
  goto MERGE
)

echo [whisper] first download, about 670MB ...
"%GIT_EXE%" -c credential.helper= -c core.askpass= clone --depth 1 "%URL_PUBLIC%" "%WHISPER_DIR%"
if errorlevel 1 (
  echo [whisper] direct failed, try proxy ...
  "%GIT_EXE%" -c http.proxy=%proxy_url% -c https.proxy=%proxy_url% -c credential.helper= -c core.askpass= clone --depth 1 "%URL_PUBLIC%" "%WHISPER_DIR%"
  if errorlevel 1 (
    echo [whisper] download failed, subtitle feature unavailable.
    exit /b 0
  )
)

:MERGE
if exist "%CONTENT_DIR%\tools\MergeBigFiles.ps1" (
  powershell -NoProfile -ExecutionPolicy Bypass -File "%CONTENT_DIR%\tools\MergeBigFiles.ps1" -Root "%CONTENT_DIR%"
)
if exist "%CONTENT_DIR%\whisper_cli.exe" (
  echo [whisper] ready.
) else (
  echo [whisper] not installed, subtitle feature unavailable.
)
exit /b 0