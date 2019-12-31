#!/bin/bash

curl -s https://api.github.com/repos/microsoft/vscode/tags >/tmp/vscode_tags
COMMIT=$(cat /tmp/vscode_tags | jq '.[] | select(.name == "'$VERSION'")' | jq .commit.sha | awk -F '"' '{print $2}')
wget https://update.code.visualstudio.com/commit:$COMMIT/server-linux-x64/stable -O /tmp/vscode-server-$VERSION
mkdir -p /tmp/.vscode-server/bin/
tar xf /tmp/vscode-server-$VERSION -C /tmp/.vscode-server/bin/
mv /tmp/.vscode-server/bin/vscode-server-linux-x64 /tmp/.vscode-server/bin/$COMMIT
touch /tmp/.vscode-server/bin/$COMMIT/0
cd /tmp/
tar zcvf vscode-server-$VERSION.tar.gz .vscode-server
rm -rf /tmp/.vscode-server
