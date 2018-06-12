#!/bin/sh

rm -rf filterInfo.txt
rm -rf sorted_temp.txt
rm -rf filterInfo2.txt

if [ $1 -gt 100 ]; then
	echo "Score must be between 0 and 100"
	exit
elif [ $1 -lt 0 ]; then
	echo "Score must be between 0 and 100"
	exit
fi

if [ "$2" != "filterInfo.txt" ]; then
	echo "Name of output file must be 'filterInfo.txt'"
	exit
fi

if test -e 'wetter_at.txt'
then
	echo "wetter_at.txt exists!"
else
	echo "wetter_at.txt does not exist!"
	exit
fi

if [ $# -ne 2 ]; then
	echo "Wrong number of arguments"
	exit
fi

echo "Converting wetter_at.txt to unix format"
dos2unix wetter_at.txt

IFSAVE=$IFS
IFS=';'
totalTemp=0

while read t hs
do
	tem2=0
	temp=0.0
	#echo "$hs"
	IFS=':'
	read temt tem2
	temp=`echo $tem2 | sed -r 's/ Grad//g'`
	echo "$temp: $hs" >> sorted_temp.txt

	score=`echo $t | sed -r 's/:.*//g'`
	score=`echo $score | sed -r 's/ .*//g'`
	#echo "$score"
	if [ $score -gt $1 ]; then
		echo "$score $hs" >> $2
	fi
	
	totalTemp=$(echo "$totalTemp + $temp" | bc)
	IFS=';'
done < wetter_at.txt

sort -r -o sorted_temp.txt sorted_temp.txt
sort -n -o filterInfo.txt filterInfo.txt
echo "$totalTemp" >> $2
IFS=':'

grep "Linz" filterInfo.txt > filterInfo2.txt
grep "Graz" filterInfo.txt | sed 's/Graz/Klagenfurt/g' >> filterInfo2.txt