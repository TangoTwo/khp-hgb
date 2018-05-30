#!/bin/sh

INFILE_NAME=$1
OUTFILE_NAME="leute"

IFSAVE=$IFS
IFS=";"

while read institution personen
do
	IFS=","
	for name in $personen
	do
		VN=`echo $name | cut -d " " -f1`
		NN=`echo $name | cut -d " " -f2`
		if [ $VN = "Georg" ]
		then
			lisaCounter=$(($lisaCounter+1))
		fi
		echo "$NN $VN" >> OUTFILE_NAME
	done
	IFS=";"
done < $INFILE_NAME
echo $lisaCounter
IFS=$IFSAVE
sort leute > sort_leute