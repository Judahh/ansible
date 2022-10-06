#!/bin/bash
echo ${INVENTORY} > /home/ansible/inventory.ini;
sudo service ssh restart;
echo -n 'ansible:ansible' | sudo chpasswd;
exec "$@";