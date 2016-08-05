Summary
-------

Docker image for MQTT broker ([mosquitto](https://mosquitto.org/)).


Build the image
---------------

To create this image, execute the following command in the docker-mosquitto folder.

    docker build -t cburki/mosquitto .


Configure the image
-------------------

The following environment variables could be used to configure a user.

- MQTT_USRNAME : The username of the user to configure.
- MQTT_PASSWORD : The password of the user.

No authentication is configured if these two variables are not given when you run
the image.


Run the image
-------------

When you run the image, you will bind the port 1883 (MQTT) and 9883 (MQTT WebSocket).
Add the containers from which to mount the volumes you would like to access.

    docker run \
        --name mosquitto \
        --volumes-from <container_id> \
        -d \
        -p 1883:1883 \
        -p 9883:9883 \
        -e MQTT_USERNAME=<username> \
        -e MQTT_PASSWORD=<secret_password> \
        cburki/mosquitto:latest

Additional user could be added by issuing the mosquitto_passwd command into a running
image.

    docker exec -it mosquitto /bin/bash
    
    root@cb479d4b3fdb:/# mosquitto_passwd /data/mqtt/password <username>

Enter the password for the new user when prompted.
