FROM python:latest

ENV LANGUAGE C.UTF-8
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

USER root

# Update and install base packages
RUN apt update && \
    apt upgrade -y && \
    apt install locales locales-all sudo sshpass -y

# Add ansible user
RUN useradd -rm -d /home/ansible -s /bin/bash -g root -G sudo -u 1001 ansible && \
    usermod -aG sudo ansible && \
    passwd -d ansible

USER ansible
WORKDIR /home/ansible

# Add keys and Install Ansible
RUN mkdir -p /home/ansible/.ssh && \
    sudo ssh-keygen -A && \
    sudo ssh-keygen -t rsa -f .ssh/id_rsa -q -N "" && \
    cp .ssh/id_rsa.pub .ssh/authorized_keys && \
    sudo python -m pip install ansible

USER root

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.3/zsh-in-docker.sh)"

# Config ssh
RUN mkdir /var/run/sshd && \
    apt install openssh-client openssh-server nano -y && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config && \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config && \
    apt clean

USER ansible

# Install Ansible Galaxy roles
RUN sudo ansible-galaxy collection install azure.azcollection && \
    sudo python -m pip install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt && \
    sudo /etc/init.d/ssh start &

COPY start.sh /home/ansible/start.sh
COPY basic.yaml /home/ansible/basic.yaml
COPY inventory.ini /home/ansible/sampleInventory.ini

ENTRYPOINT ["zsh", "/home/ansible/start.sh"]

EXPOSE 22