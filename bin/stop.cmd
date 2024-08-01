@echo off
pushd "%~dp0.."
call .\gradlew.bat basex_http_stop
popd
