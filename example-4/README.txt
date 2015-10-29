Docker:

docker build -t example-4 .
docker run --rm -p 8000:80 example-4

docker run --rm -p 8000:80 -u 33 example-4

curl -v http://docker-host:8000

OpenShift:

oc login https://localhost:8443
oc new-project example-4
oc new-app https://github.com/GrahamDumpleton/docker-examples.git \
 --context-dir=example-4 --name=app
oc expose service app --hostname=ose-host

curl -v http://ose-host:1080
