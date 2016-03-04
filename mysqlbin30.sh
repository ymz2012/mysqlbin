#!/bin/bash
#
logpath=/var/ftp/binlog101
path=/var/mysqlbinbak/binlog101
year=`date -d "today" +"%Y" `
#30days=`date -d "30 days ago" +%F`
for a in `ls -l  $logpath | awk '{print $6}'|grep -v "^$"|sort -u`
do
    mouth=`echo $a | awk -F- '{print $1}'`
    day=`echo $a | awk -F- '{print $2}'`
    if [ ! -d $path/$year/$mouth/$day ]
    then
        mkdir -p $path/$year/$mouth/$day
    fi
    cd $logpath
    for b in `ls -l  $logpath | grep -w "$a"|awk '{print $NF}'`
    do
                        /usr/bin/md5sum $b > $b.MD5
                        /usr/bin/sha1sum $b > $b.SHA1
                        /usr/bin/sha256sum $b > $b.SHA256
        mv $b $b.MD5  $b.SHA1 $b.SHA256  $path/$year/$mouth/$day
    done
done
old_year=`date -d "30 days ago" +%F|awk -F- '{print $1}'`
old_month=`date -d "30 days ago" +%F|awk -F- '{print $2}'`
old_day=`date -d "30 days ago" +%F|awk -F- '{print $3}'`
if [ -d $path/$old_year/$old_month/$old_day ]
then
    rm -rf $path/$old_year/$old_month/$old_day
    echo OK!
fi
exit 0
