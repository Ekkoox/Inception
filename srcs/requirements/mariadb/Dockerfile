FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
 
COPY tools/mariadb_setup.sh /usr/local/bin/mariadb_setup.sh
RUN chmod +x /usr/local/bin/mariadb_setup.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/mariadb_setup.sh"]