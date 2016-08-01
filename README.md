Summary
-------

Docker image for MQTT broker ([mosquitto](https://mosquitto.org/)).


Build the image
---------------

To create this image, execute the following command in the docker-mosquitto folder.

    docker build -t cburki/mosquitto .


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
        cburki/mosquitto:latest
