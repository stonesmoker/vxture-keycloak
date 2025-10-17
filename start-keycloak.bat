@echo off
set "JAVA_HOME=D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot"
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo Starting Keycloak server in development mode...
echo.
echo Keycloak will be available at: http://localhost:8080
echo Admin console: http://localhost:8080/admin
echo.
echo Default admin credentials (if not set):
echo Username: admin
echo Password: admin
echo.
echo Press Ctrl+C to stop the server
echo.

cd /d "quarkus\server\target"
if exist "lib\quarkus-run.jar" (
    java --add-opens=java.base/java.lang=ALL-UNNAMED -jar lib\quarkus-run.jar start-dev
) else (
    echo Error: Keycloak server not built yet. Please run build-keycloak.bat first.
    pause
)
