#!/bin/sh
#by SydoxX

RES=`file $1`
WIN=`echo $RES | grep -Ec 'CRLF'`
if [ $WIN -eq 1 ]
then
	dos2unix $1
	echo 'Windows file detected --> Converting...'
fi;
COD=`echo $RES | grep -Ec 'ISO-8859'`
if [ $COD -eq 1 ] 
then
	iconv -f ISO-8859 -t UTF-8 $1
fi
echo 'Convering file to UTF-8'
sed -r 's/\n//g' $1 > $1
