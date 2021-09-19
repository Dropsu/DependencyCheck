#/bin/bash

curl -s https://hub.docker.com/v2/repositories/gcr.io/feisty-outlet-325816/dependency-check/ | python3 -c "import sys, json; print(json.load(sys.stdin)['pull_count'])"