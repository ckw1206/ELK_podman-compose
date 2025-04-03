#!/bin/bash

source ./.env
git push https://$GITHUB_USERNAME:$GITHUB_TOKEN@github.com/ckw1206/ELK_podman-compose.git
