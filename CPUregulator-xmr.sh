#!/bin/bash

state="0"

while [ true ]
do
sleep 30
temp=$(sensors |grep -m 1 "temp1" | awk '/temp1/ {print substr($2,2,2)}')
echo $temp

max="73"

 if [[ "$temp" -gt "$max" ]]; then
        echo "CPU is to hot!"
        pkill -f ./xmr-stak-cpu
	screen -X -S miner quit
        if [ "$temp" -lt "$max" ]; then
                state="0"
        fi


 elif [ "$temp" -lt "$max" ]; then 
	echo "CPU stable"
		if  ! pgrep -x "xmr-stak-cpu" 
	 	then
			echo "Restarting xmr-miner"
			screen -A -m -d -S "miner" "./xmr-stak-cpu"
		fi
 fi
done

