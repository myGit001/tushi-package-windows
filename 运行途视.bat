@echo off
chcp 65001 > nul

if exist "%~dp0途视\途视.exe" (
    start "" /d "%~dp0途视" "%~dp0途视\途视.exe" --aicli-port 19112
) else (
    echo [错误] 未找到 途视\途视.exe
)

REM 途视已启动，同步 Whisper 组件
if exist "%~dp0更新Whisper.bat" (
    echo ============================================
    echo   更新 Whisper 组件
    echo ============================================
    call "%~dp0更新Whisper.bat"
)

echo.
pause >nul