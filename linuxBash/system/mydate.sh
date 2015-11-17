#!/bin/bash


if [ "$1" == "" ];then
	echo "mydate.sh <million_seconds>"
        echo "./mydate.sh 1420070436538"
fi

millionSeconds=${1:0:10}
otherPart=${1:10:3}

myFormat=`date +%Y/%m/%d\ %H:%M:%S -d\@$millionSeconds`".$otherPart"
echo $myFormat
