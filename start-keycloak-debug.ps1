# 设置环境变量
$env:JAVA_HOME = "D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot"

# 切换到正确目录
Set-Location "D:\MyWebSite\vxture-keycloak\quarkus\server\target"

Write-Host "Starting Keycloak in development mode..."
Write-Host "Working directory: $(Get-Location)"
Write-Host "Java Home: $env:JAVA_HOME"

# 启动Keycloak
& "$env:JAVA_HOME\bin\java.exe" `
    --add-opens=java.base/java.lang=ALL-UNNAMED `
    -Dfile.encoding=UTF-8 `
    -jar lib\quarkus-run.jar `
    start-dev

Write-Host "Keycloak has stopped. Press any key to continue..."
Read-Host
