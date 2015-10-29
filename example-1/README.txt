Docker:

docker build -t example-1 .
docker run --rm -p 8000:80 example-1

curl -v  http://docker-host:8000

OpenShift:

oc login https://ose-host:8443
oc new-project example-1
oc new-app . --context-dir=example-1
