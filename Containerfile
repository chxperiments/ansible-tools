FROM python:3.10-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN set -eux; \
    addgroup --gid 1000 ansible; \
    adduser --home /home/ansible --shell /bin/bash --ingroup ansible --uid 1000 --disabled-password ansible

COPY system-packages.txt /tmp/system-packages.txt

RUN set -eux; \
    apt-get update; \
    xargs -r apt-get install -y --no-install-recommends < /tmp/system-packages.txt; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/* /tmp/system-packages.txt; \
    pip install --no-cache-dir --upgrade pip

WORKDIR /home/ansible

COPY requirements.txt /tmp/requirements.txt

RUN set -eux; \
    pip install --no-cache-dir --no-compile -r /tmp/requirements.txt; \
    rm -f /tmp/requirements.txt

COPY collections/requirements.yml /tmp/collections.yml

RUN set -eux; \
    ansible-galaxy collection install -r /tmp/collections.yml; \
    rm -f /tmp/collections.yml; \
    find /usr/local/lib/python3.10/site-packages/ -name '__pycache__' -print0 | xargs -0 rm -rf; \
    find /usr/local/lib/python3.10/site-packages/ -name '*.pyc' -print0 | xargs -0 rm -rf

USER ansible

CMD ["/bin/bash"]
