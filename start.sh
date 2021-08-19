#!/bin/bash
url=$1
echo $url
docker pull $url
# check if pulled
docker images
# Check all
docker ps -a
# Stop all running
docker kill $(docker ps -q)
# Get our Image ID
imageId=`docker images | awk '{print $3}' | awk 'NR==2'`
echo $imageId
# run this image ID
docker run -d --restart=unless-stopped -p 8081:8082 -v /var/log/docker:/var/log/ $imageId
# check running container and read logs
running=`docker ps | awk '{print $1}' | awk 'NR==2'`
docker logs -f $running