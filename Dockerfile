FROM debian:8.5
LABEL maintainer "erick saputra"
RUN apt-get update
RUN apt-get install -y wget vim locales net-tools
RUN locale-gen en_US.UTF-8
RUN localedef -i en_US -f UTF-8 en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
RUN wget https://repo.percona.com/apt/percona-release_0.1-4.jessie_all.deb
RUN dpkg -i percona-release_0.1-4.jessie_all.deb
RUN apt-get update
RUN apt-get install -y percona-xtrabackup percona-xtradb-cluster-56 percona-xtradb-cluster-client-5.6 percona-xtradb-cluster-common-5.6 percona-xtradb-cluster-galera-3 percona-xtradb-cluster-galera-3.x percona-xtradb-cluster-server-5.6 libmysqlclient18 libperconaserverclient18.1-dev libperconaserverclient18.1
RUN apt-get install -y python-mysqldb
RUN apt-get autoclean
RUN service mysql stop
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/mysql/*
RUN mv /etc/mysql/my.cnf /var/lib/mysql/my.cnf.old
RUN echo Asia/Jakarta > /etc/timezone && \ ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && \ dpkg-reconfigure -f noninteractive tzdata
CMD ["/bin/bash"]
