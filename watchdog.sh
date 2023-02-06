#!/bin/sh

# check if exists first second and third argument
if [ $# -ne 3 ]; then
	echo "Usage: $0 <ip-address> <telegram-bot-token> <telegram-chat-id>"
	exit 1
fi

FLAG=true

# infinite loop
while [ $FLAG ]; do
	# check if the server is online
	if ping -c 3 $1 > /dev/null; then
		if [ $FLAG = false ]; then
			FLAG=true
			curl -s -X POST https://api.telegram.org/bot$2/sendMessage -d chat_id=$3 -d text="connection to $1 is back"
		fi
	else
		if [ $FLAG = true ]; then
			FLAG=false
			curl -s -X POST https://api.telegram.org/bot$2/sendMessage -d chat_id=$3 -d text="connection to $1 is lost"
		fi
	fi
	# wait 1 min
	sleep 60
done
