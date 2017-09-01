#!/bin/bash
echo 'Nhap dai IP: '
read ip;
echo 'Nhap Subnet: '
read sub;
# Check address
[ "$ip" != ' ' ] && [ "$sub" != ' ' ] && echo " Scanning $ip/$sub:" 
#list ip
nmap -sn "$ip/$sub" | cut -d " " -f 5 | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' > list.txt
#check OS
for i in $(cat list.txt);
do
	nc -z $i 22 > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "$i using linux"
	else
		nc -z $i 3389 > /dev/null 2>&1
		if [ $? -eq 0 ]; then
			echo "$i using Windows"
		else
			echo "$i unknow OS"
	fi
fi
done