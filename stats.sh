#!/bin/sh
BASEDIR=$(dirname "$0")
cd $BASEDIR
secline=`cat $BASEDIR/stats.txt | tail -n +2`
#secline=`cat $BASEDIR/stats.txt | head -1`
line=`cat /var/log/maillog | /usr/sbin/pflogsumm | sed -n '/^Per\-Day Traffic Summary/,/Per.*/{/Per.*/d;p}' | tail -n2 | sed 's/ \+ /:/g'`
#echo `echo $line | awk -F: '{print $2}'`
#echo "-$secline-"
#exit 0
echo -e "1$secline\n2$line\n"
echo -e "$secline\n$line\n" > $BASEDIR/stats.txt
