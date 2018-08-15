FROM centos:centos7


# Build packages
RUN yum clean all -y && \
      yum update -y && \
      yum -y install vim wget rpm-build which tar git gcc java mysql


ENV JAVA_HOME /usr/java/default/

RUN mkdir /opt/ranger_home

WORKDIR /opt/ranger_home

ADD ./install.properties /opt/ranger_home/install.properties
ADD ./hdp.repo /etc/yum.repos.d/hdp.repo
ADD ./bootstrap.sh .
ADD ./ranger.sql .

RUN yum install -y ranger-admin ranger-usersync ranger-tagsync


# Download SQL connetor JAR
RUN wget -P /opt/ranger https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.41.tar.gz && \
     tar -xvf /opt/ranger/mysql-connector-java-5.1.41.tar.gz -C /opt/ranger_home


# Change permission
RUN chmod 755 ./bootstrap.sh

CMD ./bootstrap.sh
