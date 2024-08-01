@echo off
pushd "%~dp0.."
call dev\docker-rm.cmd
@echo Redeploying to local Docker Desktop container
docker build -t balisage-2024-open-mic .
docker run --name balisage-2024-open-mic -p 9080:80 -d -v balisage-2024-open-mic-data:/srv/basex/data balisage-2024-open-mic
docker logs -n all balisage-2024-open-mic
@echo Open http://localhost:9080/ in a web browser
start "" http://localhost:9080/
docker exec -it balisage-2024-open-mic /bin/bash
popd
