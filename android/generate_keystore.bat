@echo off
echo ========================================
echo Android 签名密钥生成脚本
echo ========================================
echo.

REM 设置密钥信息
set KEYSTORE_FILE=upload-keystore.jks
set KEY_ALIAS=upload
set KEY_PASSWORD=medical2024
set STORE_PASSWORD=medical2024
set VALIDITY=10000
set KEY_SIZE=2048

echo 正在生成签名密钥...
echo.
echo 密钥文件: %KEYSTORE_FILE%
echo 密钥别名: %KEY_ALIAS%
echo 密钥密码: %KEY_PASSWORD%
echo 密钥库密码: %STORE_PASSWORD%
echo 有效期: %VALIDITY% 天
echo.

REM 检查 keytool 是否可用
where keytool >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [错误] 未找到 keytool 命令
    echo 请确保已安装 JDK 并将其添加到 PATH 环境变量
    pause
    exit /b 1
)

REM 生成密钥
keytool -genkey -v ^
    -keystore %KEYSTORE_FILE% ^
    -alias %KEY_ALIAS% ^
    -keyalg RSA ^
    -keysize %KEY_SIZE% ^
    -validity %VALIDITY% ^
    -storepass %STORE_PASSWORD% ^
    -keypass %KEY_PASSWORD% ^
    -dname "CN=Medical Training, OU=Development, O=Medical, L=Beijing, ST=Beijing, C=CN"

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [错误] 密钥生成失败
    pause
    exit /b 1
)

echo.
echo ========================================
echo 密钥生成成功！
echo ========================================
echo.
echo 密钥文件已保存到: %KEYSTORE_FILE%
echo.
echo 正在创建 key.properties 配置文件...

REM 创建 key.properties 文件
(
echo storePassword=%STORE_PASSWORD%
echo keyPassword=%KEY_PASSWORD%
echo keyAlias=%KEY_ALIAS%
echo storeFile=%KEYSTORE_FILE%
) > key.properties

echo.
echo key.properties 文件已创建
echo.
echo ========================================
echo 重要提示：
echo ========================================
echo 1. 请妥善保管 %KEYSTORE_FILE% 文件
echo 2. 请妥善保管密钥密码: %KEY_PASSWORD%
echo 3. 请妥善保管密钥库密码: %STORE_PASSWORD%
echo 4. 密钥丢失将无法更新已发布的应用
echo 5. 建议将密钥文件备份到安全位置
echo.
echo 按任意键退出...
pause >nul
