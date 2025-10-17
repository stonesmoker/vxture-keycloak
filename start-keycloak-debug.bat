@echo off
set "JAVA_HOME=D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot"
cd /d "D:\MyWebSite\vxture-keycloak\quarkus\server\target"

echo Starting Keycloak server...
echo Working directory: %CD%
echo Java Home: %JAVA_HOME%
echo.

"%JAVA_HOME%\bin\java.exe" --add-opens=java.base/java.lang=ALL-UNNAMED -jar lib\quarkus-run.jar start-dev

echo.
echo Keycloak has stopped. 
pause
