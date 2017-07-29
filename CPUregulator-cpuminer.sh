#!/bin/bash

state="0"

while [ true ]
do
sleep 30
temp=$(sensors |grep -m 1 "temp1" | awk '/temp1/ {print substr($2,2,2)}')
echo $temp

max="85"

 if [[ "$temp" -gt "$max" ]]; then
        echo "CPU is to hot!"
        pkill -f ./cpuminer
	screen -X -S miner quit
        if [ "$temp" -lt "$max" ]; then
                state="0"
        fi

 elif [ "$temp" -lt "$max" ]; then 
	echo "CPU stable"
		if  ! pgrep -x "cpuminer" 
	 	then
			echo "Restarting cpuminer"
			screen -A -m -d -S "miner" "./mine.sh"
		fi
 fi
done

