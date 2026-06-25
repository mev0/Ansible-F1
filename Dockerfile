FROM python:3.12-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    openssh-client \
    sshpass \
    nano \
    iputils-ping \
    iproute2 \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*


RUN echo "    KexAlgorithms +diffie-hellman-group14-sha1" >> /etc/ssh/ssh_config && \
    echo "    HostKeyAlgorithms +ssh-rsa" >> /etc/ssh/ssh_config && \
    echo "    PubkeyAcceptedAlgorithms +ssh-rsa" >> /etc/ssh/ssh_config


RUN echo "Ciphers +aes128-cbc,aes256-cbc" >> /etc/ssh/ssh_config

RUN pip install --no-cache-dir ansible-core paramiko ansible-pylibssh

COPY requirements.yml /tmp/requirements.yml
RUN ansible-galaxy collection install -r /tmp/requirements.yml

WORKDIR /ansible

COPY . /ansible

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
