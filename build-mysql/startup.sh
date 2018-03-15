#!/bin/sh

# parameters
MYSQL_DATADIR=${MYSQL_DATADIR:-"/var/lib/mysql"}

MYSQL_ROOT_PW=$(cat /run/secrets/crm_secrets | jq -r '.MYSQL_ROOT_PWD')
MYSQL_USER=$(cat /run/secrets/crm_secrets | jq -r '.MYSQL_USER')
MYSQL_USER_PWD=$(cat /run/secrets/crm_secrets | jq -r '.MYSQL_USER_PWD')
MYSQL_USER_DB=$(cat /run/secrets/crm_secrets | jq -r '.MYSQL_USER_DB')

if [ -d "/run/mysqld" ]; then
        echo "[i] MySQL directory already present, skipping creation"
else
	echo "[i] mysqld not found, creating...."
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
	echo 'Initializing database'
        mkdir -p "$MYSQL_DATADIR/mysql"
        chown -R mysql:mysql $MYSQL_DATADIR
	mysql_install_db --user=mysql --datadir="$MYSQL_DATADIR" --rpm
	echo 'Database initialized'

	tfile=`mktemp`
	if [ ! -f "$tfile" ]; then
	    return 1
	fi

	cat << EOF > $tfile
USE mysql;
SET @@SESSION.SQL_LOG_BIN=0 ;
FLUSH PRIVILEGES ;
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PWD}' ;
GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
DROP DATABASE IF EXISTS test ;
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PWD}' ;
CREATE USER '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_USER_PWD}' ;
EOF

	if [ "$MYSQL_USER_DB" != "" ]; then
	    echo "[i] Creating database: $MYSQL_USER_DB"
	    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_USER_DB\` CHARACTER SET utf8 COLLATE utf8_general_ci;" >> $tfile

	    if [ "$MYSQL_USER" != "" ]; then
		#echo "[i] Creating user: $MYSQL_USER with password $MYSQL_USER_PWD"
		echo "GRANT ALL PRIVILEGES ON \`$MYSQL_USER_DB\`.* to '$MYSQL_USER'@'%' identified by '${MYSQL_USER_PWD}' ;" >> $tfile
		echo "GRANT ALL PRIVILEGES ON \`$MYSQL_USER_DB\`.* to '$MYSQL_USER'@'localhost' identified by '${MYSQL_USER_PWD}' ;" >> $tfile
		echo "FLUSH PRIVILEGES ;" >> $tfile
	    fi
	fi

	/usr/bin/mysqld --user=mysql --bootstrap --verbose=1 --datadir="$MYSQL_DATADIR" < $tfile
    rm -f "$tfile"
fi

exec /usr/bin/mysqld --user=mysql --console --datadir="$MYSQL_DATADIR"
