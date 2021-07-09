#! /bin/bash

docker run --volume=$(pwd):/home/user/workdir \
           --workdir /home/user/workdir -i -t glpk 