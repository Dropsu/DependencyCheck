#!/bin/bash -e

VERSION=$(mvn -q \
    -Dexec.executable="echo" \
    -Dexec.args='${project.version}' \
    --non-recursive \
    org.codehaus.mojo:exec-maven-plugin:1.3.1:exec)

FILE=./cli/target/dependency-check-$VERSION-release.zip
if [ -f "$FILE" ]; then
    docker build . --build-arg VERSION=$VERSION -t gcr.io/feisty-outlet-325816/dependency-check:$VERSION
    if [[ ! $VERSION = *"SNAPSHOT"* ]]; then
        docker tag gcr.io/feisty-outlet-325816/dependency-check:$VERSION gcr.io/feisty-outlet-325816/dependency-check:latest
    fi
else 
    echo "$FILE does not exist - run 'mvn package' first"
    exit 1
fi
