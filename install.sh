#!/bin/sh
yum update -y
pack="pflogsumm"
isinstalled=$(rpm -q $pack)
if [ ! "$isinstalled" == "package $pack is not installed" ]; then
	echo "Package  $pack already installed"
else
	echo "$pack is not INSTALLED!!!!"
	yum install $pack -y
fi

BASEDIR=$(dirname "$0")
cd $BASEDIR

#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "*/5 * * * *     sh $BASEDIR/stats.sh" >> mycron
#install new cron file
crontab mycron
rm mycron