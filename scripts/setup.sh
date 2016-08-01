#!/bin/bash

MQTT_PATH=/data/mqtt
MQTT_CONF_PATH=${MQTT_PATH}/config
MQTT_LOG_PATH=${MQTT_PATH}/log
MQTT_DATA_PATH=${MQTT_PATH}/data

STATUS_FILE=/opt/setup.status

if [ -f ${STATUS_FILE} ]; then
    exit 0
fi

useradd --system --shell /bin/false -U mosquitto

if [ ! -d ${MQTT_CONF_PATH} ]; then
    mkdir -p ${MQTT_CONF_PATH}
    mkdir -p ${MQTT_CONF_PATH}/conf.d
fi

if [ ! -d ${MQTT_LOG_PATH} ]; then
    mkdir -p ${MQTT_LOG_PATH}
fi

if [ ! -d ${MQTT_DATA_PATH} ]; then
    mkdir -p ${MQTT_DATA_PATH}
fi

cp /opt/mosquitto/mosquitto.conf ${MQTT_CONF_PATH}/mosquitto.conf
cp /opt/mosquitto/conf.d/websockets.conf ${MQTT_CONF_PATH}/conf.d/websockets.conf

chown -R mosquitto:mosquitto ${MQTT_PATH}


echo "done" >> ${STATUS_FILE}

exit 0
