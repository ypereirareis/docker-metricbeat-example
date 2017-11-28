#!/usr/bin/env bash

## Needed for metricbeat
sudo setfacl -m u:1000:rw /var/run/docker.sock

## Needed for elaxticsearch
sudo sysctl -w vm.max_map_count=262144
