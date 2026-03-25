# ansible-tools
Minimal Ansible tooling image based on python:3.10-slim with a non-root ansible user, cleaned Python artifacts, and preinstalled collections for common automation.

## Install
Build locally with `docker build -t ansible-tools .` then run with `docker run --rm -it ansible-tools /bin/bash`. Published images are pushed to ghcr.io, quay.io, and docker.io under the repository name.

## Tools in the image
Ansible CLI and ansible-lint from requirements.txt.
ansible-galaxy with community.general and community.crypto collections. 
Python 3.10 userland.
helper binaries git, curl, and jq.
