include:
  - modules.database.mysql.slave

start-slave:
  cmd.script:
    - name: salt://bbs/files/start_slave.sh
    - unless: test $(/usr/local/mysql/bin/mysql -e 'show slave status\G' 2>/dev/null|grep -E 'Slave_IO_Running|Slave_SQL_Running'|awk '{print $2}'|grep -c Yes) -eq 2

