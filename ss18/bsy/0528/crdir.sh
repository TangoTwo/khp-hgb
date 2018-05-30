#!/bin/sh
SEMESTER=6
N=1
while [ $N -le $SEMESTER ]
do
	mkdir ${N}_sem
	mkdir ${N}_sem/ADS
	N=`expr $N + 1`
done