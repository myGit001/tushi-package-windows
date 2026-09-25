@echo off
chcp 65001 > nul

REM 不再单独启用 HTTP 进程（process_server）：Windows 外部进程执行已改走本地桥（Game.WindowsProcessBridge），
REM 不再经 {BaseUrl}/execute-process。如需恢复服务端执行，取消下行注释。
REM start "" "%~dp0ExePack/process_server.exe" --host 127.0.0.1 --port 19111

REM 先启动途视主程序（start 立即返回，不等待、不阻塞途视）
if exist "%~dp0途视\途视.exe" (
    start "" /d "%~dp0途视" "%~dp0途视\途视.exe" --aicli-port 19112
) else (
    echo [错误] 未找到 途视\途视.exe
)

REM 途视已启动，此后再同步 Whisper 组件（不阻塞途视；此处输出更新日志）
if exist "%~dp0更新Whisper.bat" (
    echo ============================================
    echo   更新 Whisper 组件
    echo ============================================
    call "%~dp0更新Whisper.bat"
)

echo.
pause >nul