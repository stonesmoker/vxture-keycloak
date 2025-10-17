@echo off
setlocal enabledelayedexpansion

set "JAVA_HOME=D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot"
cd /d "D:\MyWebSite\vxture-keycloak\quarkus\server\target"

echo Starting Keycloak server with initial admin user...
echo Working directory: %CD%
echo Java Home: %JAVA_HOME%
echo.

REM 设置初始管理员用户
set "KEYCLOAK_ADMIN=admin"
set "KEYCLOAK_ADMIN_PASSWORD=admin"

echo Admin user: %KEYCLOAK_ADMIN%
echo Admin password: %KEYCLOAK_ADMIN_PASSWORD%
echo.

"%JAVA_HOME%\bin\java.exe" --add-opens=java.base/java.lang=ALL-UNNAMED -jar lib\quarkus-run.jar start-dev

echo.
echo Keycloak has stopped. 
pause
