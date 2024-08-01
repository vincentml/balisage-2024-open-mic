@echo off
pushd "%~dp0.."
set GRADLE_OPTS=-Xmx5048m
call .\gradlew.bat basex_http_start
popd
start "" http://localhost:80/
