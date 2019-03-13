#!/usr/bin/env bash

figlet -f standard "Build and deploy the Tomcat application"

echo "Build fresh war for Tomcat deployment"
mvn -q clean compile war:war

echo "Build the oracleConfig.properties files for Tomcat war to run with"
echo "url=jdbc:oracle:thin:@oracle:1521/xe" > oracleConfig.properties
echo "user=system" >> oracleConfig.properties
echo "password=oracle" >> oracleConfig.properties

echo "Deploy the app to Tomcat"
docker cp oracleConfig.properties tomcat:/usr/local/tomcat/webapps/oracleConfig.properties
docker cp target/passwordAPI.war tomcat:/usr/local/tomcat/webapps/passwordAPI.war
sleep 15

echo Smoke test
echo "curl -s http://localhost:8080/passwordAPI/passwordDB"
curl -s http://localhost:8080/passwordAPI/passwordDB > temp
if grep -q "RESULT_SET" temp
then
    echo "SMOKE TEST SUCCESS"
    figlet -f slant "Smoke Test Success"

    echo "Configuring test application to point to Tomcat endpoint"
    echo "hosturl=http://localhost:8080" > rest_webservice.properties

    echo "Run integration tests"
    mvn -q verify failsafe:integration-test

    figlet -f slant "Do Sonarqube Static Analysis"
    mvn sonar:sonar
else
    echo "SMOKE TEST FAILURE!!!"
    figlet -f slant "Smoke Test Failure"
fi
rm temp

