@echo off
chcp 65001 >nul
echo 正在启动 Keycloak 开发服务器...

set KEYCLOAK_ADMIN=admin
set KEYCLOAK_ADMIN_PASSWORD=admin

cd /d "D:\MyWebSite\vxture-keycloak\quarkus\server\target"
echo 当前工作目录: %CD%

if exist "lib\quarkus-run.jar" (
    echo JAR文件存在: lib\quarkus-run.jar
) else (
    echo 错误: JAR文件不存在: lib\quarkus-run.jar
    pause
    exit /b 1
)

echo 执行Java命令...
"D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot\bin\java.exe" -Dkc.home.dir=. -jar lib\quarkus-run.jar start-dev

pause
