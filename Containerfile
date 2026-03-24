FROM python:3.10-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN set -eux; \
    addgroup --gid 1000 ansible; \
    adduser --home /home/ansible --shell /bin/bash --ingroup ansible --uid 1000 --disabled-password ansible

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        jq \
    && apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    pip install --no-cache-dir --upgrade pip

RUN set -eux; \
    pip install --no-cache-dir --no-compile \
        ansible \
        ansible-lint \
        dnspython \
        yamllint \
        pypsexec; \
    ansible-galaxy collection install community.general community.crypto; \
    find /usr/local/lib/python3.10/site-packages/ -name '__pycache__' -print0 | xargs -0 rm -rf; \
    find /usr/local/lib/python3.10/site-packages/ -name '*.pyc' -print0 | xargs -0 rm -rf

WORKDIR /home/ansible

USER ansible

CMD ["/bin/bash"]
