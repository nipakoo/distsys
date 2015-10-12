#!/bin/bash

cmd="$1"
name="$2"
node="$3"

port=$(<nc_port_number)
listy_node=$(<listy_location)

f_to_listy() {
	echo "F $node $name" | nc $listy_node $port
}

n_to_listy() {
	echo "N $node $name" | nc $listy_node $port
}

g_to_listy() {
	echo "G $node name" | nc $listy_node $port
}

attack_mouse() {
	sleep 6
	trap 'g_to_listy' SIGINT 
	echo "MEOW $$" | nc $node $port
}

search_node() {
	sleep 12
	output=$(nc -zv $node $port 2>&1)
	if [[ $output == *"succeeded"* ]]; then
		f_to_listy
	else
		n_to_listy
	fi
}

if [ $cmd = "S" ]; then
	search_node
else
	attack_mouse
fi