Docker:

docker build -t example-7 .
docker run --rm -p 8000:8000 example-7

docker run --rm -p 8000:8000 -u 33 example-7
docker run --rm -p 8000:8000 -u 10000 example-7

docker run -it --rm -p 8000:8000 -u 10000 example-7 bash

docker run --rm -p 8000:8000 -v `pwd`:/app:ro example-7

docker run --rm -p 8000:8000 -v `pwd`:/app:ro \
    -e MOD_WSGI_RELOAD_ON_CHANGES=1 example-7

curl -v http://docker-host:8000

OpenShift:

oc login https://localhost:8443
oc new-project example-7
oc new-app https://github.com/GrahamDumpleton/docker-examples.git \
 --context-dir=example-7 --name=app
oc expose service app --hostname=ose-host

curl -v http://ose-host:1080
