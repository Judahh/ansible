#!/bin/bash
echo ${INVENTORY} > /home/ansible/inventory.ini;
sudo service ssh restart;
exec "$@";