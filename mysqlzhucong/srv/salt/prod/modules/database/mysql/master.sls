/etc/my.cnf.d/master.cnf:
  file.managed:
    - source: salt://modules/database/mysql/files/master.cnf
    - user: root
    - group: root
    - mode: '0644'

master-mysql-service:
  service.running:
    - name: mysqld.service
    - enable: true
    - reload: true
    - watch:
       - file: /etc/my.cnf.d/master.cnf

restart-master:
  cmd.run:
    - name: systemctl restart mysqld
    - unless: /usr/local/mysql/bin/mysql -e "show master status\G"|grep mysql_bin"
