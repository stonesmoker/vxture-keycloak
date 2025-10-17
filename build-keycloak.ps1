# 设置环境变量
$env:JAVA_HOME = "D:\Program Files\Eclipse Adoptium\jdk-25.0.0.36-hotspot"
$env:M2_HOME = "D:\temp-maven\apache-maven-3.9.8"
$env:MAVEN_OPTS = "-Xmx3072m --add-opens=java.base/java.lang=ALL-UNNAMED"

# 验证环境
Write-Host "Java Home: $env:JAVA_HOME"
Write-Host "Maven Home: $env:M2_HOME"

# 验证Java
& "$env:JAVA_HOME\bin\java.exe" -version

Write-Host "`nStarting Keycloak build..."
Write-Host "This may take 10-30 minutes..."

# 构建Keycloak
& "$env:M2_HOME\bin\mvn.cmd" -pl quarkus/server -am clean install -DskipTests

if ($LASTEXITCODE -eq 0) {
    Write-Host "`nBuild completed successfully!"
    Write-Host "You can now run: .\start-keycloak.bat"
} else {
    Write-Host "`nBuild failed with exit code: $LASTEXITCODE"
    Write-Host "Trying alternative build approach..."
    # 如果失败，尝试构建整个项目
    & "$env:M2_HOME\bin\mvn.cmd" clean install -DskipTests -Dquickly
}

Write-Host "`nPress any key to continue..."
Read-Host
