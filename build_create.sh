#!/usr/bin/env bash

figlet -f standard "Create containers for Oracle, Tomcat, and Sonarqube"

docker-compose up -d

echo "Waiting for Oracle to start"
while true ; do
  curl -s localhost:8081 > tmp.txt
  result=$(grep -c "DOCTYPE HTML PUBLIC" tmp.txt)
  if [ $result = 1 ] ; then
    echo "Oracle has started"
    break
  fi
  sleep 1
done
rm tmp.txt

echo "Waiting for Tomcat to start"
while true ; do
  curl -s localhost:8080 > tmp.txt
  result=$(grep -c "Apache Tomcat/9.0.8" tmp.txt)
  if [ $result = 2 ] ; then
    echo "Tomcat has started"
    break
  fi
  sleep 1
done
rm tmp.txt

echo "Waiting for Sonarqube to start"
while true ; do
  result=$(docker logs sonarqube 2> /dev/null | grep -c "SonarQube is up")
  if [ $result = 1 ] ; then
    echo "Sonarqube has started"
    break
  fi
  sleep 1
done

figlet -f standard "Create the Oracle database"

echo "Build the liquibase.properties file for Liquibase to run against"
echo "driver: oracle.jdbc.driver.OracleDriver" > liquibase.properties
echo "classpath: lib/ojdbc8.jar" >> liquibase.properties
echo "url: jdbc:oracle:thin:@"$(hostname)":1521:xe" >> liquibase.properties
echo "username: system" >> liquibase.properties
echo "password: oracle" >> liquibase.properties

echo "Create database schema and load sample data"
liquibase --changeLogFile=src/main/db/changelog.xml update