@echo off
setlocal enabledelayedexpansion

REM 设置Java环境
set "JAVA_HOME=D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot"
set "PATH=%JAVA_HOME%\bin;%PATH%"

REM 设置Maven配置，使用没有空格的路径
set "MAVEN_USER_HOME=D:\maven-cache"
if not exist "%MAVEN_USER_HOME%" mkdir "%MAVEN_USER_HOME%"

REM 设置Maven选项
set "MAVEN_OPTS=-Xmx3072m -XX:MaxPermSize=512m --add-opens=java.base/java.lang=ALL-UNNAMED"

echo Building Keycloak Quarkus server...
echo Java Version:
java -version
echo.
echo Maven version:
call mvnw.cmd --version
echo.

echo Starting build process...
echo This may take 10-30 minutes for first build...
call mvnw.cmd -pl quarkus/server -am clean install -DskipTests -X

if %errorlevel% neq 0 (
    echo.
    echo Build failed! Trying alternative approach...
    echo Attempting to build just the essential components...
    call mvnw.cmd clean install -DskipTests -Dquickly -T 1C
)

if %errorlevel% eq 0 (
    echo.
    echo Build completed successfully!
    echo You can now run: .\start-keycloak.bat
) else (
    echo.
    echo Build failed. Please check the error messages above.
)

pause
