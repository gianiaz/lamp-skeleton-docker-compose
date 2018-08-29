#!/usr/bin/env bash

set -e

docker-compose up -d
docker-compose run --rm php zsh
