#!/bin/bash
if [ "$SPARK_MODE" == "master" ]; then
    echo "Starting Spark Master..."
    $SPARK_HOME/sbin/start-master.sh
    # Keep the container running so you can see logs
    tail -f $SPARK_HOME/logs/*
elif [ "$SPARK_MODE" == "worker" ]; then
    if [ -z "$SPARK_MASTER_URL" ]; then
        echo "Error: SPARK_MASTER_URL is not set"
        exit 1
    fi
    echo "Starting Spark Worker connecting to $SPARK_MASTER_URL..."
    $SPARK_HOME/sbin/start-slave.sh $SPARK_MASTER_URL
    tail -f $SPARK_HOME/logs/*
else
    echo "Please set SPARK_MODE environment variable to 'master' or 'worker'"
    exit 1
fi
