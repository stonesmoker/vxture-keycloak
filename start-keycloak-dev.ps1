# Keycloak开发模式启动脚本
$env:KEYCLOAK_ADMIN = "admin"
$env:KEYCLOAK_ADMIN_PASSWORD = "admin"

Set-Location "D:\MyWebSite\vxture-keycloak\quarkus\server\target"

Write-Host "启动Keycloak开发服务器..." -ForegroundColor Green

& "D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot\bin\java.exe" `
  "--add-opens=java.base/java.security=ALL-UNNAMED" `
  "--add-opens=java.base/java.util=ALL-UNNAMED" `
  "--add-opens=java.base/java.lang.invoke=ALL-UNNAMED" `
  "--add-opens=java.base/java.io=ALL-UNNAMED" `
  "--add-opens=java.base/java.util.concurrent=ALL-UNNAMED" `
  "-Dkc.home.dir=." `
  "-jar" "lib\quarkus-run.jar" "start-dev" "--http-enabled=true" "--hostname=localhost" "--http-port=8080"

Write-Host "按任意键继续..."
Read-Host
