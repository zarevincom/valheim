@echo off
REM Valheim Port Unblocking Batch Script
REM Script for unblocking Valheim ports in Windows Firewall

echo.
echo ========================================
echo    VALHEIM PORTS UNBLOCKING
echo ========================================
echo.

REM Check administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This script requires administrator privileges!
    echo Please run Command Prompt as administrator and try again.
    pause
    exit /b 1
)

echo Opening ports for Valheim server...
echo.

REM Main Valheim ports
echo [1/6] Opening port 2456/UDP (Valheim Server Query)...
netsh advfirewall firewall add rule name="Valheim - Server Query - 2456/UDP" dir=in action=allow protocol=UDP localport=2456
if %errorLevel% equ 0 (echo   ✓ Port 2456/UDP opened) else (echo   ✗ Error opening port 2456/UDP)

echo [2/6] Opening port 2457/UDP (Valheim Server Game)...
netsh advfirewall firewall add rule name="Valheim - Server Game - 2457/UDP" dir=in action=allow protocol=UDP localport=2457
if %errorLevel% equ 0 (echo   ✓ Port 2457/UDP opened) else (echo   ✗ Error opening port 2457/UDP)

echo [3/6] Opening port 2458/UDP (Valheim Server Steam)...
netsh advfirewall firewall add rule name="Valheim - Server Steam - 2458/UDP" dir=in action=allow protocol=UDP localport=2458
if %errorLevel% equ 0 (echo   ✓ Port 2458/UDP opened) else (echo   ✗ Error opening port 2458/UDP)

REM Additional Steam ports
echo [4/6] Opening port 27015/UDP (Steam Query)...
netsh advfirewall firewall add rule name="Steam - Query - 27015/UDP" dir=in action=allow protocol=UDP localport=27015
if %errorLevel% equ 0 (echo   ✓ Port 27015/UDP opened) else (echo   ✗ Error opening port 27015/UDP)

echo [5/6] Opening port 27036/UDP (Steam Master Server)...
netsh advfirewall firewall add rule name="Steam - Master Server - 27036/UDP" dir=in action=allow protocol=UDP localport=27036
if %errorLevel% equ 0 (echo   ✓ Port 27036/UDP opened) else (echo   ✗ Error opening port 27036/UDP)

REM Additional RCON port (if needed)
echo [6/6] Opening port 25575/TCP (RCON)...
netsh advfirewall firewall add rule name="Valheim - RCON - 25575/TCP" dir=in action=allow protocol=TCP localport=25575
if %errorLevel% equ 0 (echo   ✓ Port 25575/TCP opened) else (echo   ✗ Error opening port 25575/TCP)

echo.
echo ========================================
echo         CONFIGURATION COMPLETED
echo ========================================
echo.
echo Server information:
echo   - Connection port: 2457
echo   - Password: 121314
echo   - Server name: Karjalainen
echo.
echo To start the server use:
echo   docker-compose up -d
echo.
echo To check open ports use:
echo   netstat -an | findstr "245"
echo.
pause
