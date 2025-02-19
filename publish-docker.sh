#!/bin/bash -e

VERSION=$(mvn -q \
    -Dexec.executable="echo" \
    -Dexec.args='${project.version}' \
    --non-recursive \
    org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)

if [[ $VERSION = *"SNAPSHOT"* ]]; then
  echo "Do not publish a snapshot version of dependency-check"
  exit 1
fi
docker inspect --type=image gcr.io/feisty-outlet-325816/dependency-check:$VERSION  > /dev/null 2>&1
if [[ "$?" -ne 0 ]] ; then
  echo "docker image gcr.io/feisty-outlet-325816/dependency-check:$VERSION does not exist - run build_docker.sh first"
  exit 1
fi
docker inspect --type=image gcr.io/feisty-outlet-325816/dependency-check:latest  > /dev/null 2>&1
if [[ "$?" -ne 0 ]] ; then
  echo "docker image gcr.io/feisty-outlet-325816/dependency-check:latest does not exist - run build_docker.sh first"
  exit 1
fi

docker push gcr.io/feisty-outlet-325816/dependency-check:$VERSION 
docker push gcr.io/feisty-outlet-325816/dependency-check:latest
