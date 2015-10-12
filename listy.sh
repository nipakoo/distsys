#!/bin/bash

port=$(<nc_port_number)

nc -lk $port | while IFS=, read -a p
do
	echo $p >> cmsg
done