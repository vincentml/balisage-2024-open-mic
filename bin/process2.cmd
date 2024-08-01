@echo off
pushd "%~dp0.."
call .\gradlew.bat process2
popd
timeout 5 >nul
