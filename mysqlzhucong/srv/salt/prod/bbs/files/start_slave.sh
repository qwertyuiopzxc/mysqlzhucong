#!/bin/bash

mysql=/usr/local/mysql/bin/mysql
master_ip=192.168.218.133
repl_user=repl
repl_pass=repl123

log_file=$($mysql -u$repl_user -p$repl_pass -h$master_ip -e "show master status\G" 2>/dev/null | grep -E 'File|Position'|awk  'NR==1{print $2}')

log_pos=$($mysql -u$repl_user -p$repl_pass -h$master_ip -e "show master status\G" 2>/dev/null | grep -E 'File|Position'|awk  'NR==2{print $2}')

$mysql -e "change master to master_host='$master_ip',master_user='$repl_user',master_password='$repl_pass',master_log_file='$log_file',master_log_pos=$log_pos;start slave;"
