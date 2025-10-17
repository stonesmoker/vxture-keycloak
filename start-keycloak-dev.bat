@echo off
set KEYCLOAK_ADMIN=admin
set KEYCLOAK_ADMIN_PASSWORD=admin
cd /d "D:\MyWebSite\vxture-keycloak\quarkus\server\target"
echo 启动Keycloak开发服务器...
"D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot\bin\java.exe" ^
  --add-opens=java.base/java.security=ALL-UNNAMED ^
  --add-opens=java.base/java.util=ALL-UNNAMED ^
  --add-opens=java.base/java.lang.invoke=ALL-UNNAMED ^
  --add-opens=java.base/java.io=ALL-UNNAMED ^
  --add-opens=java.base/java.util.concurrent=ALL-UNNAMED ^
  -Dkc.home.dir=. ^
  -jar lib\quarkus-run.jar start-dev --http-enabled=true --hostname=localhost --http-port=8080
pause
