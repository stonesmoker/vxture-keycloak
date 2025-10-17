@echo off
set "JAVA_HOME=D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot"
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "MAVEN_USER_HOME=C:\maven-repo"
set "MAVEN_OPTS=-Xmx2048m --add-opens=java.base/java.lang=ALL-UNNAMED"

echo Building Keycloak server...
mvnw.cmd -pl quarkus/deployment,quarkus/dist -am -DskipTests clean install
