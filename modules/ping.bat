@echo off

PowerShell.exe -NoProfile -ExecutionPolicy RemoteSigned %~dp0ping_default_route.ps1

set PINGLIST=%~dp0ping_list.txt
call :exec_ping
rem pause
exit %ERRORLEVEL%


:exec_ping
  for /f "eol=# delims=" %%a in (%PINGLIST%) do (
    echo.
    echo # PING to "%%a"
    1>&2 echo # PING to "%%a"
    ping.exe -w 2000 -n 2 "%%a"
  )
exit /b 0
