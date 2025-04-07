@echo off
pushd "%~dp0.."
call .\gradlew.bat src_xquery_process3.xq
popd
timeout 5 >nul
