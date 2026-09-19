@echo off
chcp 65001 > nul

REM 不再单独启用 HTTP 进程（process_server）：Windows 外部进程执行已改走本地桥（Game.WindowsProcessBridge），
REM 不再经 {BaseUrl}/execute-process。如需恢复服务端执行，取消下行注释。
REM start "" "%~dp0ExePack/process_server.exe" --host 127.0.0.1 --port 19111
start "" /d "%~dp0途视" "%~dp0途视/途视.exe" --aicli-port 19112