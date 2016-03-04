#!/bin/bash
#
user=liujunshi@dayima.com
a=`mysql -h10.10.99.103 -udata_sync -p3908ryefh0_9348t9f0hs9f8 data_sync -e"select count(1) from user_changes\G"| grep count| awk -F: '{print $2}'`
b=`mysql -h10.10.99.103 -udata_sync -p3908ryefh0_9348t9f0hs9f8 data_sync -e"select count(1) from topic_category_changes\G"| grep count| awk -F: '{print $2}'`
c=`mysql -h10.10.99.103 -udata_sync -p3908ryefh0_9348t9f0hs9f8 data_sync -e"select count(1) from topic_changes\G"| grep count| awk -F: '{print $2}'`
if [ $a -gt 1000 ]
then
    echo  user_changes:$a | mail -s "data_sync warning!!!" $user ;
fi
if [ $b -gt 1000 ]
then
        echo topic_category_changes:$b | mail -s "data_sync warning!!!" $user;
fi
if [ $c -gt 1000 ]
then
        echo topic_changes:$c | mail -s "data_sync warning!!!" $user;
fi
exit 0;
