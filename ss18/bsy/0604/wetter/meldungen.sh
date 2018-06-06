#!/bin/sh

fileIn="wetter.txt"
IFSAVE=$IFS

if [ ! -f $fileIn ]
then
	echo "File $fileIn not found!"
	exit 1
fi

if [ $# -ne 1 ]
then
	echo "Wrong number of arguments"
	exit 2
fi

R=`grep -Ec "^$1" $fileIn`
if [ $R -eq 0 ]
then
	echo "No weatherereignis found"
	exit 3
fi

grep -E "^$1" $fileIn > ./tmp
echo "$1 gab es in folgenden Orten:" > ./output

while read v1 v2 v3
do
	O=`echo $v3 | cut -f1 -d"("`
	B=`echo $v3 | cut -f2 -d"("`
	B1=`echo $B | sed -r 's/\)//g'`
	echo "$1 im Bezirk $B1" >> ./output
	
done < ./tmp

cat ./output