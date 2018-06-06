#!/bin/sh

file="schi_gebiet.txt"
fileOut="schigebiet2.txt"

if [ ! -f $file ]
then
	echo 'File does not exist!'
	exit
fi

IFSAVE=$IFS
rm ./schigebiet2.txt ./gemeinde.txt > /dev/null

while read name
do
	IFS=':'
	read temp orte
	read temp lifte
	read temp preis
	read leerzeile
	echo $name
	echo "$name;$lifte;$preis" >> $fileOut
	echo "$orte" >> $fileOut
	IFS=','
	for i in $orte
	do
		echo "$i">> gemeinde.txt
	done
done < $file
sort -r -o gemeinde.txt gemeinde.txt
IFS=$IFSAVE