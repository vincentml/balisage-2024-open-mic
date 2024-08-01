@echo off
pushd "%~dp0.."
if ""%1"" == """" (set IN="files\in") else (set IN="%~f1")
if ""%2"" == """" (set OUT="files\out") else (set OUT="%~f2")
echo Processing files in source %IN% to destination %OUT%
call .\gradlew.bat process1 -Pi=%IN% -Po=%OUT%
popd
timeout 5 >nul
