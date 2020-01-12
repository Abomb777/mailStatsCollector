#!/bin/sh
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
#BASEDIR=$(dirname "$0")
cd $BASEDIR
secline=`cat $BASEDIR/stats.txt | tail -n +2`
#secline=`cat $BASEDIR/stats.txt | head -1`
line=`cat /var/log/maillog | /usr/sbin/pflogsumm | sed -n '/^Per\-Day Traffic Summary/,/Per.*/{/Per.*/d;p}' | tail -n2 | sed 's/ \+  /:/g'`
#echo `echo $line | awk -F: '{print $2}'`
#echo "-$secline-"
#exit 0

if [ "$line" == "" ]; then
#no statistic per day
	IN=`cat /var/log/maillog | /usr/sbin/pflogsumm | sed -n '/^messages/,/bytes.*/{/bytes.*/d;p}' | tail -n +2`
	lineparams=$(echo $IN | tr " " "\n")
	lineparams=$(echo $IN | grep -o '[^:]*\s*[^:]*' | grep -E '(received|delivered|deferred|bounced|rejected)' | sed -E "s/\(.*//")
	counter=0

	line=":"
	line="$line`date +'%-b %-d %Y'`"
	for addr in $lineparams
	do
			if [ "$counter" -eq 0 ] || [ "$counter" -eq 2 ] || [ "$counter" -eq 6 ] || [ "$counter" -eq 8 ] || [ "$counter" -eq 10 ] ; then
					line="$line:$addr"
			fi
			counter=$((counter+1))
	done
	#echo $line
fi

#echo -e "1$secline\n2$line\n"
echo -e "$secline\n$line\n" > $BASEDIR/stats.txt
sh $BASEDIR/calculate.sh
