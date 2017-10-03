@echo off
powershell -ExecutionPolicy Unrestricted -File "%~dpn0.ps1" %*
pause
