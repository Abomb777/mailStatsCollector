# mailStatsCollector
Mail Stats Collector

```ssh
yum update -y
yum install http://opensource.wandisco.com/centos/6/git/x86_64/wandisco-git-release-6-1.noarch.rpm
yum install git
yum update -y nss curl libcurl
yum install pflogsumm
```
pflogsumm perl and date lib required
```ssh
sudo yum install perl-Date-Cal
```


Use wget to download Pflogsumm at /usr/local directory:
```ssh
sudo wget -O http://jimsun.linxnet.com/downloads/pflogsumm-1.1.3.tar.gz /usr/local/pflogsumm-1.1.3.tar.gz
```
Expand the files:
```ssh
sudo tar -xzf /usr/local/pflogsumm-1.1.3.tar.gz
```
Rename the Pflogsumm directory:
```ssh
sudo mv /usr/local/pflogsumm-1.1.3 /usr/local/pflogsumm
```
Make the Pflogsumm directory executable:
```ssh
sudo chmod a+x /usr/local/pflogsumm/pflogsumm.pl
```
##Testing
```ssh
sudo perl /usr/local/pflogsumm/pflogsumm.pl /var/log/maillog
```
# Crontab send mail log summary at AM 1:00 everyday to root
```ssh
00 01 * * * perl /usr/sbin/pflogsumm -e -d yesterday /var/log/maillog | mail -s 'Logwatch for Postfix' root
```
