#!/bin/bash

git clone https://github.com/seldonio/seldon-server -b v1.4.10

cd seldon-server/kubernetes/conf/

make clean conf

cd ../bin/

./seldon-up