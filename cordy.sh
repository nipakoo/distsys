#!/bin/bash

IFS=$'\n' read -d '' -r -a lines < ukkonodes
nodes=(${lines[@]:2})

cmd=""

mouse_found="neither"

send_search() {
	./chase_cat.sh S ${cmd:10:15} $1
}

send_attack() {
	./chase_cat.sh A ${cmd:10:15} $mouse_found
}

handle_f_msg() {
	if [ mouse_found = "neither" ]; then
		mouse_found=${cmd:2:9}
	else
		send_attack
	fi
}

handle_n_msg() {
	if [ mouse_found = "neither" ]; then
		send search $1
	else
		send_search mouse_found
	fi
}

get_command() {
	IFS=$'\n' read -d '' -r -a cmds < cmsg
	cmd=${cmds[0]}
	new_file=(${cmds[@]:1})
	echo ${new_file[0]}
	printf "%s\n" "${new_file[@]}" > cmsg
}

printf "%s" $(hostname) > listy_location
./listy.sh

send_search ${lines[0]}
send_search ${lines[1]}

for i in "${nodes[@]}"
do
	while : ; do
		get_command
		size=${#cmd}
		if [ size != 0 ]; then
			break;
		fi
	done
	
	case ${cmd:0:1} in
		F) handle_f_msg ;;
		N) handle_n_msg i ;;
		G) echo "MOUSE DESTROYED" ;;
	esac

	sleep 4
done