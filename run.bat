@echo off

if "%~1"=="" (
    echo Usage: run.bat query api_key output
    exit /b 1
)
if "%~2"=="" (
    echo Usage: run.bat query api_key output
    exit /b 1
)
if "%~3"=="" (
    echo Usage: run.bat query api_key output
    exit /b 1
)

set query=%~1
set key=%~2
set output=%~3

if not exist "%~dp0output" (
    mkdir "%~dp0output"
)

python intelx-crawls.py -q "%query%" -k "%key%" -o "%~dp0output\%output%"

sort "%~dp0output\%output%" | findstr /v /r "^$" > "%~dp0output\sorted_output.txt"
findstr /r /c:"^" "%~dp0output\sorted_output.txt" > "%~dp0output\unique.txt"

findstr /i "%query%" "%~dp0output\unique.txt" > "%~dp0output\result.txt"

del "%~dp0output\sorted_output.txt"

echo Done. Result saved in output\result.txt
