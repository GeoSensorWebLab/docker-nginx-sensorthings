#!/bin/sh

IMAGE="nginx-sensorthings:0.1"
CONTAINER="nginx-sensorthings"

docker stop $CONTAINER && docker rm $CONTAINER
docker run -d -p 8080:8080 -p 9080:9080 --name $CONTAINER $IMAGE
