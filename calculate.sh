firstline=`cat /projects/parse_stats/stats.txt | head -n 1`
secline=`cat /projects/parse_stats/stats.txt | tail -n 2`

#echo `echo $firstline | awk -F: '{print $3}'`

#echo (expr `echo $firstline | awk -F: '{print $3}'` + 0)

#echo $((`echo $firstline | awk -F: '{print $3}'` + 1))

#received=$((`echo $firstline | awk -F: '{print $3}'` + 0)) - $((`echo $secline| awk -F: '{print $3}'` + 0))

ra=`echo $firstline | awk -F: '{print $3}'`
rb=`echo $secline| awk -F: '{print $3}'`

received=$(( rb  - ra ))
echo $received

da=`echo $firstline | awk -F: '{print $4}'`
db=`echo $secline| awk -F: '{print $4}'`

delivered=$(( db - da ))
echo $delivered

dfa=`echo $firstline | awk -F: '{print $5}'`
dfb=`echo $secline| awk -F: '{print $5}'`

deferred=$(( dfb - dfa ))
echo $deferred

ba=`echo $firstline | awk -F: '{print $6}'`
bb=`echo $secline| awk -F: '{print $6}'`

bounced=$(( bb - ba ))
echo $bounced

ra=`echo $firstline | awk -F: '{print $7}'`
rb=`echo $secline| awk -F: '{print $7}'`

rejected=$(( rb - ra ))
echo $rejected
