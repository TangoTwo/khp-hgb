#!/bin/sh
#by SydoxX

CYAN='\033[0;36m'
WHITE='\033[0;m'
RED='\033[0;31m'
if [ $# -eq 0 ] ; then
	echo "${RED}Argument is missing!"
	echo "${CYAN}Usage: $0 <file>"
	exit 1
elif [ ! -f $1 ]; then
	echo "${RED}File $1 does not exist!"
	exit 2
fi

rm liste 2> /dev/null

while read v1 v2 v3 vv ; do
	echo "${CYAN}processing ${WHITE}$v2 $v3"
	v4="S${v1}@students.fh-hagenberg.at"
	v5="${v3}.${v2}@students.fh-hagenberg.at"
	echo $v1 $v4 $v5 $v2 $v3 $vv >> liste

done < $1

less liste
