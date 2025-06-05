#!/bin/bash

# Stop and remove containers, networks, images, and volumes
docker compose down

# Build the hadoop-client image
docker compose build hadoop-client

# Remove the NameNode directory
docker compose run --rm --user root namenode rm -rf /opt/hadoop/dfs/name/*

# Change ownership of the namenode data directory
docker compose run --rm --user root namenode chown -R 1000:1000 /opt/hadoop/dfs/name

docker compose run --rm namenode hdfs namenode -format -force

docker compose run --rm --user root datanode rm -rf /opt/hadoop/dfs/data/*
docker compose run --rm --user root datanode chown -R 1000:1000 /opt/hadoop/dfs/data

# Start the containers in detached mode
docker compose up -d
