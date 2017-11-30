#!/usr/bin/env bash

## Needed for metricbeat
sudo setfacl -m u:1000:rw /var/run/docker.sock && echo "=> ACLs on /var/run/docker.sock OK"

## Needed for elaxticsearch
sudo sysctl -w vm.max_map_count=262144 && echo "=> vm.max_map_count=262144 OK"

## Docker network for metricbeat
docker network create metricbeat || true

## Building Metricbeat custom images
docker-compose build