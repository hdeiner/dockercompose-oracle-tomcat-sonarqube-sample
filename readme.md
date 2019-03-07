This project demonstrates a way to build and test directly on the desktop command line (and by implication, on CI servers as well) between an Oracle database and a Tomcat application.  Sonarqube is also locally incorporated for static code analysis.

```bash
./build_and_test.sh
```
1. Docker-compose containers for Oracle, Tomcat, and Sonarqube to life.
2. Wait appropriately for the containers to start and be ready for operations.
3. Build a liquibase.properties file and invoke Liquibase to create the test database.
4. Build the Tomcat war to test along with an oracleConfig.properties to configure the app to the database it needs.
5. Deploy those two artifacts to Tomcat.
6. Perform a smoke test against the integrated system.
7. Build the rest_webservice.properties file used by our Cucumber tests. 
8. Run the full integration regression test suite (Cucumber for Java used).
9. Run the Sonarqube analysis 
10. Enjoy the results!
![Image of Sonarqube](readme.md.sonarqube.screenshot.png)

```bash
./build_destroy.sh
```
1. Docker-compose away the containers we built.
2. Delete the temporary files we created during the run that facilitated the integration of components.
