#!/bin/bash

IFS=$'\n' read -d '' -r -a lines < ukkonodes

cmd=""
cmd_idx=0
line_idx=2

mouse_found="neither"

send_search() {
	./chase_cat.sh S ${cmd:29:34} $1 &
}

send_attack() {
	scp chase_cat.sh $mouse_found:
	scp listy_location $mouse_found:
	scp nc_port_number $mouse_found:
	ssh $mouse_found ./chase_cat.sh "A" "${cmd:29:34}" "$mouse_found"
}

handle_f_msg() {
	if [ $mouse_found == "neither" ]; then
		mouse_found=${cmd:2:26}
		if [ ${cmd:29:34} == "Jazzy" ]; then
			cmd="                             Catty"
		else
			cmd="                             Jazzy"
		fi
		send_search $mouse_found
	else
		send_attack
	fi
}

handle_n_msg() {
	if [ $mouse_found == "neither" ]; then
		line_idx=$((line_idx+1))
		send_search $1
	fi
}

get_command() {
	IFS=$'\n' read -d '' -r -a cmds < cmsg
	cmd=${cmds[$cmd_idx]}
}

finish_execution() {
	echo "MOUSE DESTROYED"
	exit 0
}

./listy.sh &

cmd="                             Jazzy"
send_search ${lines[0]}
cmd="                             Catty"
send_search ${lines[1]}

while : ; do
	while : ; do
		get_command
		size=${#cmd}
		if [ $size -ne 0 ]; then
			cmd_idx=$((cmd_idx+1))
			break;
		fi
	done
	
	case ${cmd:0:1} in
		F) handle_f_msg ;;
		N) handle_n_msg ${lines[$line_idx]} ;;
		G) finish_execution ;;
	esac



	sleep 4
done