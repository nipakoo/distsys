#!/bin/bash

port=$(<nc_port_number)

nc -lk $port | while IFS=, read -a p
do
	msg=${p:0:4}
	address=${p:5:29}
	pid=${p:30:${#p}}
	if [ $msg = "MEOW" ]; then
		ssh $address "kill -2 $pid"
	fi
done
