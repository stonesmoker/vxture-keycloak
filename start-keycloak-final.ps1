# Keycloak 启动脚本
Write-Host "正在启动 Keycloak 开发服务器..." -ForegroundColor Green

# 设置环境变量
$env:KEYCLOAK_ADMIN = "admin"
$env:KEYCLOAK_ADMIN_PASSWORD = "admin"

# 设置工作目录
$targetDir = "D:\MyWebSite\vxture-keycloak\quarkus\server\target"
Set-Location $targetDir
Write-Host "当前工作目录: $((Get-Location).Path)" -ForegroundColor Yellow

# 检查JAR文件是否存在
$jarPath = "lib\quarkus-run.jar"
if (Test-Path $jarPath) {
    Write-Host "JAR文件存在: $jarPath" -ForegroundColor Green
} else {
    Write-Host "错误: JAR文件不存在: $jarPath" -ForegroundColor Red
    exit 1
}

# 启动Keycloak
Write-Host "执行Java命令..." -ForegroundColor Yellow
$javaExe = "D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot\bin\java.exe"

try {
    & $javaExe -Dkc.home.dir=. -jar $jarPath start-dev
} catch {
    Write-Host "启动失败: $_" -ForegroundColor Red
}
