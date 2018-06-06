#!/bin/sh

dSum=0;
fSum=0;

if [ $# -ne 1 ]
then
	echo "Usage: $0 [FOLDER]";
	exit;
fi

dir=$1;

if [ ! -d $dir ]
then
	echo 'Folder does not exist!';
	exit;
fi

cd $dir;

for i in *
do
	if [ -d $i ]
	then
		var=`ls -ld $i | cut -d' ' -f5`
		dSum=$(($dSum + $var))
	elif [ -f $i ]
	then
		var=`ls -l $i | cut -d' ' -f5`
		fSum=$(($fSum + $var))
	fi
done

echo "Size of Directories in VZ: $folder is $dSum Bytes";
echo "Size of Files in VZ: $folder is $fSum Bytes";