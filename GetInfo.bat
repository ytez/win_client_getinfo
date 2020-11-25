@echo off

rem chcp 437
rem pushd %~dp0
chdir %~dp0
if not "%CD%\" == "%~dp0" (
  echo Please execute this BAT from "Local Drive" ^(e.g. Desktop^)
  pause
  exit 1
)
    
rem ############### VARIBLES ###############
rem set OUTPUT_DIR=%USERPROFILE%\Desktop
set BATDIR=%~dp0
set OUTPUT_DIR=%BATDIR%output
set SUB_MODULES=%BATDIR%modules
set COMMAND_LIST=%BATDIR%modules\COMMAND_LIST.tsv

set CURRENT_DATETIME=
set WORKDIR=
set OUTPUT_FILENAME=
rem ########################################

call :get_current_datetime
call :make_output_dirfile
call :exec_command_list

echo ### FINISHED. ###
rem popd
rem pause
rem chcp 932
exit %ERRORLEVEL%


:make_output_dirfile
  set WORKDIR=%OUTPUT_DIR%\%COMPUTERNAME%_%CURRENT_DATETIME%
  set OUTPUT_FILENAME=%WORKDIR%\00_%COMPUTERNAME%_%CURRENT_DATETIME%.txt

  mkdir "%WORKDIR%"
  if not %ERRORLEVEL% == 0 goto :ERROR
  type nul > "%OUTPUT_FILENAME%"
  if not %ERRORLEVEL% == 0 goto :ERROR
exit /b 0


:get_current_datetime
  set d=%DATE%
  set t=%TIME: =0%
  
  set dYYYY=%d:~0,4%
  set   dMM=%d:~5,2%
  set   dDD=%d:~8,2%
  
  set   tHH=%t:~0,2%
  set   tMM=%t:~3,2%
  set   tSS=%t:~6,2%
  
  set CURRENT_DATETIME=%dYYYY%%dMM%%dDD%_%tHH%%tMM%%tSS%
exit /b 0


:exec_command_list
  chdir %SUB_MODULES%
  for /f "eol=# tokens=1,2 delims=	" %%a in (%COMMAND_LIST%) do (
    echo. & echo # Executing "%%a" ...
    echo. & echo # Executing "%%a" ... >> "%OUTPUT_FILENAME%"

    start "%%a" /WAIT /B %ComSpec% /c "1>%WORKDIR%\%%b %%a"

    type "%WORKDIR%\%%b"
    type "%WORKDIR%\%%b" >> "%OUTPUT_FILENAME%"
  )
  chdir %BATDIR%
exit /b 0


:ERROR
  echo ### ERROR OCCURED. ###
  pause
exit 1
