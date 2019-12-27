#!/bin/sh
yum update -y

check_for_program() {
  local program 
  program="${1}"

#  printf "Checking for ${program}\\n  "
  command -v "${program}"

  if [[ "${?}" -ne 0 ]]; then
    printf "${program} is not installed, exiting\\n"
	yum install $pack -y
#    exit 1
  else 
	printf "${program} is  installed!\\n"
  fi 
}

check_for_program "pflogsumm"
#pack="pflogsumm"
#isinstalled=$(rpm -q $pack)
#if [ ! "$isinstalled" == "package $pack is not installed" ]; then
#	echo "Package  $pack already installed"
#else
#	echo "$pack is not INSTALLED!!!!"
#	yum install $pack -y
#fi

BASEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

#BASEDIR=$(dirname "$0")
cd $BASEDIR

#write out current crontab
crontab -l > mycron
croncheck=`cat mycron`
#echo "$croncheck"
#if [[ ! "$croncheck" == *"parse_stats"* ]]; then
#	echo "1111"
#else
#	echo "0000"
#fi
if [[ "$croncheck" == *"mailStatsCollector"* ]]; then
	echo "Cron installed"
else
	echo "Going to add CRONJOB!!!!"
	#echo new cron into cron file
	echo "*/5 * * * *     sh $BASEDIR/stats.sh" >> mycron
	#install new cron file
	crontab mycron
#	yum install $pack -y
fi
rm mycron