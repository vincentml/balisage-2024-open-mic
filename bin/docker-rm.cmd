@echo off
pushd "%~dp0.."
@echo Removing local Docker Desktop container
docker stop balisage-2024-open-mic
docker rm balisage-2024-open-mic
docker rmi balisage-2024-open-mic
docker volume rm balisage-2024-open-mic-data
popd
