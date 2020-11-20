@echo off

set PINGLIST=%~dp0ping_list.txt
call :exec_ping
rem pause
exit %ERRORLEVEL%


:exec_ping
  for /f "eol=# delims=" %%a in (%PINGLIST%) do (
    echo.
    echo # PING to "%%a"
    ping.exe -w 2000 -n 2 "%%a"
  )
exit /b 0
