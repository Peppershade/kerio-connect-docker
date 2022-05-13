CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    echo " * Starting Kerio Connect"
    /usr/bin/supervisord > /dev/null 2>&1 &
    sleep 15
    service kerio-connect stop
    echo " * Fixing permissions"
    chmod 777 /opt/kerio/mailserver/mailserver.cfg
    chmod 777 /opt/kerio/mailserver/users.cfg
    chmod -R 777 /opt/kerio/mailserver
    service kerio-connect start
else
    echo "-- Not first container startup --"
    /usr/bin/supervisord
fi
