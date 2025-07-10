#!/bin/bash

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)

echo "PULLING v1adych/skvis"
docker pull v1adych/skvis
echo "PULLING v1adych/fpgen"
docker pull v1adych/fpgen
echo "PULLING v1adych/rembg"
docker pull v1adych/rembg

echo "STARTING v1adych/skvis"
docker run --rm -d -p 8080:8000 \
    -e STABILITY_KEY=sk-rwSizTbrmOsKWC0Rzeg4uMFRCRBmwnPQpGnTVHfTGAoRM8tG \
    -e MESHY_KEY=msy_tWwIKnjycNho8r85oqmI7oSZQfbMoR2V8tzD \
    -e device=cuda:0 \
    v1adych/skvis
echo "STARTING v1adych/fpgen"
docker run --rm -d -p 8160:8000 \
    -e device=cuda:0 \
    v1adych/fpgen
echo "STARTING v1adych/rembg"
docker run --rm -d -p 8240:8000 \
    -e device=cuda:0 \
    v1adych/rembg