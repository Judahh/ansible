FROM python:latest

ENV LANGUAGE C.UTF-8
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

USER root

RUN apt update && \
    apt upgrade -y && \
    apt install locales locales-all -y

# RUN adduser -ms /bin/bash ansible && \
#     echo -n 'ansible:ansible' | chpasswd

RUN useradd -rm -d /home/ansible -s /bin/bash -g root -G sudo -u 1001 ansible
USER ansible
WORKDIR /home/ansible

USER root

RUN ssh-keygen -A && \
    mkdir /var/run/sshd && \
    apt install openssh-client openssh-server nano -y && \
    # cp /usr/share/defaults/ssh /etc/ssh && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config && \
    sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config && \
    apt clean && \
    cp .ssh/id_rsa.pub .ssh/authorized_keys

RUN python -m pip install ansible; \
    ansible-galaxy collection install azure.azcollection; \
    pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt

CMD echo ${INVENTORY} > /home/ansible/inventory.ini && tail -f /dev/null

EXPOSE 22