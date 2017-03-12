#!/bin/bash

if [ ${1} == "deploy_cert" ]; then

    echo " + Hook: Deploying to Apache/slapd/cyrus... $1"

    TARGETDIR=/etc/ssl/private

    echo "   + Sichere altes Zertifikat"
    cp -a $TARGETDIR/server.pem $TARGETDIR/server.pem_$(date +%Y%m%d.%H:%M)

    echo "   + Kopiere neues Zertifikat nach $TARGETDIR"
    cat "$3" > $TARGETDIR/server.pem
    cat "$5" >> $TARGETDIR/server.pem

    chmod 0640 $TARGETDIR/server.pem
    chown root:ssl-cert $TARGETDIR/server.pem

    echo "   + Reloading/restarting services"
    service apache2 reload
    service slapd restart
    service cyrus-imapd reload

    # Beispiel, um es  auf einen anderen Webserver zu kopieren. Dafür muss
    # es einen passwortlosen ssh-Zugang von hier nach "root@cloud" geben.
    #echo "   + Copy to cloudserver"
    #rsync -avP $TARGETDIR/server.pem root@cloud:/etc/ssl/private/server.pem
    #ssh root@cloud service apache2 reload
    
else
    echo " + Hook: Nothing to do... $1"
fi
