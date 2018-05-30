#!/bin/sh
if [ $# -eq 0 ]
then
	echo "No arguments defined"
else
	echo "Number of args: $#"
fi
a = 10
echo "$a"
echo '$a'
echo `$a`