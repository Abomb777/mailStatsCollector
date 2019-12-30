#BASEDIR=$(dirname "$0")
BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $BASEDIR

firstline=`cat $BASEDIR/stats.txt | head -n 1`
secline=`cat $BASEDIR/stats.txt | tail -n 2`

#echo `echo $firstline | awk -F: '{print $3}'`

#echo (expr `echo $firstline | awk -F: '{print $3}'` + 0)

#echo $((`echo $firstline | awk -F: '{print $3}'` + 1))

#received=$((`echo $firstline | awk -F: '{print $3}'` + 0)) - $((`echo $secline| awk -F: '{print $3}'` + 0))
adate=`echo $firstline | awk -F: '{print $2}'`
bdate=`echo $secline| awk -F: '{print $2}'`

received=$(( rb  - ra ))

ra=`echo $firstline | awk -F: '{print $3}'`
rb=`echo $secline| awk -F: '{print $3}'`

received=$(( rb  - ra ))
#########################
#echo "received:$received"

da=`echo $firstline | awk -F: '{print $4}'`
db=`echo $secline| awk -F: '{print $4}'`

delivered=$(( db - da ))
#########################
#echo "delivered:$delivered"

dfa=`echo $firstline | awk -F: '{print $5}'`
dfb=`echo $secline| awk -F: '{print $5}'`

deferred=$(( dfb - dfa ))
#########################
#echo "deferred:$deferred"

ba=`echo $firstline | awk -F: '{print $6}'`
bb=`echo $secline| awk -F: '{print $6}'`

bounced=$(( bb - ba ))
#########################
#echo "bounced:$bounced"

rja=`echo $firstline | awk -F: '{print $7}'`
rjb=`echo $secline| awk -F: '{print $7}'`

rejected=$(( rjb - rja ))
#########################
#echo "rejected:$rejected"
if [[ "$adate"=="$bdate" ]]; then
	echo "{ received:$received, delivered:$delivered, deferred:$deferred, bounced:$bounced, rejected:$rejected }" > results
else
	echo "{ received:$ra, delivered:$da, deferred:$dfa, bounced:$ba, rejected:$rja }" > results
fi