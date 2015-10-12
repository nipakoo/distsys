#!/bin/bash

port=$(<nc_port_number)

nc -lk $port | while IFS=, read -a p
do
	msg=${p:0:4}
	pid=${p:5:${#p}}
	if [ $msg = "MEOW" ]; then
		kill -2 $pid
	fi
done
