#!/bin/sh
INFILE_NAME="curriculum.txt"
OUTFILE_NAME="curr.txt"

rm OUTFILE_NAME 2> /dev/null

IFSAVE=$IFS
IFS=";"
semesterStunden=0

while read text v1 v2 v3 v4 v5 v6
do
	if [ -n "$v1" ]
	then
		semesterStunden1=$(($semesterStunden1+$v1))
		semesterStunden2=$(($semesterStunden2+$v2))
		semesterStunden3=$(($semesterStunden3+$v3))
		semesterStunden4=$(($semesterStunden4+$v4))
		semesterStunden5=$(($semesterStunden5+$v5))
		semesterStunden6=$(($semesterStunden6+$v6))
	fi
done < $INFILE_NAME

echo "ECTs 1.Semester: $semesterStunden1 Wochenstunden" >> OUTFILE_NAME
echo "ECTs 2.Semester: $semesterStunden2 Wochenstunden" >> OUTFILE_NAME
echo "ECTs 3.Semester: $semesterStunden3 Wochenstunden" >> OUTFILE_NAME
echo "ECTs 4.Semester: $semesterStunden4 Wochenstunden" >> OUTFILE_NAME
echo "ECTs 5.Semester: $semesterStunden5 Wochenstunden" >> OUTFILE_NAME
echo "ECTs 6.Semester: $semesterStunden6 Wochenstunden" >> OUTFILE_NAME

if test -e $OUTFILE_NAME
then
	echo "Exists!"
else
	echo "No exist!"
fi

IFS=$IFSAVE