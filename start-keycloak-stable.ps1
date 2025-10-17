param(
    [switch]$Background
)

# 稳定启动 Keycloak 的脚本（支持前台与后台）
# 用法：
#   前台（在终端显示日志）： .\start-keycloak-stable.ps1
#   后台（写日志并返回 PID）： .\start-keycloak-stable.ps1 -Background

# 环境变量（如需改管理员密码请在运行前修改）
$env:KEYCLOAK_ADMIN = $env:KEYCLOAK_ADMIN ? $env:KEYCLOAK_ADMIN : 'admin'
$env:KEYCLOAK_ADMIN_PASSWORD = $env:KEYCLOAK_ADMIN_PASSWORD ? $env:KEYCLOAK_ADMIN_PASSWORD : 'admin'

# 默认 JDK 路径（如你的系统不同，请修改）
if (-not $env:JAVA_HOME -or -not (Test-Path "$env:JAVA_HOME\bin\java.exe")) {
    $env:JAVA_HOME = 'D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot'
}

$java = Join-Path $env:JAVA_HOME 'bin\java.exe'
if (-not (Test-Path $java)) {
    Write-Error "无法找到 java.exe: $java. 请设置 JAVA_HOME 或修改脚本。"
    exit 1
}

$root = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$target = Join-Path $root 'quarkus\server\target'
if (-not (Test-Path $target)) {
    Write-Error "找不到 target 目录: $target. 请先构建 quarkus/server 模块。"
    exit 1
}

Set-Location $target

$jar = Join-Path $target 'lib\quarkus-run.jar'
if (-not (Test-Path $jar)) {
    Write-Error "找不到 quarkus-run.jar: $jar"
    exit 1
}

# 日志目录
$logDir = Join-Path $target 'logs'
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir | Out-Null }
$timestamp = (Get-Date).ToString('yyyyMMdd_HHmmss')
$outLog = Join-Path $logDir "start_$timestamp.log"
$errLog = Join-Path $logDir "start_$timestamp.err.log"

# JVM 参数与 Keycloak 参数（保持 JVM 参数在 -jar 之前）
$jvmArgs = @(
    "-Dkc.home.dir=$target",
    "-Dquarkus.http.host=0.0.0.0",
    "-Dquarkus.log.level=info"
)

$kcArgs = @('start-dev','--http-enabled=true','--hostname=localhost','--http-port=8080')

if ($Background) {
    Write-Host "以后台方式启动 Keycloak，日志: $outLog 和 $errLog"
    $startArgs = $jvmArgs + @('-jar', $jar) + $kcArgs
    $proc = Start-Process -FilePath $java -ArgumentList $startArgs -RedirectStandardOutput $outLog -RedirectStandardError $errLog -WorkingDirectory $target -PassThru
    Write-Host "Started PID: $($proc.Id)"
    exit 0
} else {
    Write-Host "在前台启动 Keycloak，日志同时写入: $outLog"
    $startArgs = $jvmArgs + @('-jar', $jar) + $kcArgs
    # 在前台运行并把输出 tee 到日志
    & $java @startArgs 2>&1 | Tee-Object -FilePath $outLog
}
