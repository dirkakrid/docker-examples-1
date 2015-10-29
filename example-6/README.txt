Docker:

docker build -t example-6 .
docker run --rm -p 8000:8000 example-6

docker run --rm -p 8000:8000 -u 33 example-6
docker run --rm -p 8000:8000 -u 10000 example-6

curl -v http://docker-host:8000

OpenShift:

oc login https://localhost:8443
oc new-project example-6
oc new-app https://github.com/GrahamDumpleton/docker-examples.git \
 --context-dir=example-6 --name=app
oc expose service app --hostname=ose-host

curl -v http://ose-host:1080
