#!/bin/bash

if [ ${1} == "deploy_cert" ]; then
    echo " + Hook: Restarting Apache..."
    /etc/init.d/apache2 reload
else
    echo " + Hook: Nothing to do..."
fi
~                      
