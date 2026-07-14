#!/bin/bash

set -e

cleanup() {
    echo "Removing runner..."

    ./config.sh remove \
        --token "${GITHUB_TOKEN}" || true
}

# run cleanup whenever the script stops
trap cleanup EXIT

# configure the runner dynamically at startup
./config.sh --url "https://github.com/${GITHUB_OWNER}/${GITHUB_REPO}" \
            --token "${GITHUB_TOKEN}" \
            --name "docker-runner" \
            --work "_work" \
            --labels docker,self-hosted \
            --replace \
            --ephemeral \
            --unattended

# run the runner agent
./run.sh