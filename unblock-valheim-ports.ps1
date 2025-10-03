# Valheim Port Unblocking Script
# Скрипт для разблокировки портов Valheim в Windows Firewall

Write-Host "🔥 Разблокировка портов для Valheim сервера..." -ForegroundColor Green

# Проверяем права администратора
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "❌ Этот скрипт требует прав администратора!" -ForegroundColor Red
    Write-Host "Запустите PowerShell от имени администратора и попробуйте снова." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Порты для Valheim сервера
$valheimPorts = @(
    @{Port=2456; Protocol="UDP"; Name="Valheim Server Query"},
    @{Port=2457; Protocol="UDP"; Name="Valheim Server Game"},
    @{Port=2458; Protocol="UDP"; Name="Valheim Server Steam"}
)

Write-Host "📋 Открываем следующие порты:" -ForegroundColor Cyan
foreach ($port in $valheimPorts) {
    Write-Host "   - Порт $($port.Port)/$($port.Protocol) - $($port.Name)" -ForegroundColor White
}

Write-Host ""

# Создаем правила для каждого порта
foreach ($port in $valheimPorts) {
    $ruleName = "Valheim - $($port.Name) - $($port.Port)/$($port.Protocol)"
    
    try {
        # Удаляем существующее правило если есть
        Remove-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
        
        # Создаем новое правило
        New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -Protocol $port.Protocol -LocalPort $port.Port -Action Allow -Profile Any
        Write-Host "✅ Порт $($port.Port)/$($port.Protocol) успешно открыт" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Ошибка при открытии порта $($port.Port)/$($port.Protocol): $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Дополнительные порты для Steam (если нужны)
$steamPorts = @(
    @{Port=27015; Protocol="UDP"; Name="Steam Query"},
    @{Port=27036; Protocol="UDP"; Name="Steam Master Server"}
)

Write-Host ""
Write-Host "🎮 Дополнительные порты для Steam:" -ForegroundColor Cyan

foreach ($port in $steamPorts) {
    $ruleName = "Steam - $($port.Name) - $($port.Port)/$($port.Protocol)"
    
    try {
        Remove-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
        New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -Protocol $port.Protocol -LocalPort $port.Port -Action Allow -Profile Any
        Write-Host "✅ Порт $($port.Port)/$($port.Protocol) успешно открыт" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Ошибка при открытии порта $($port.Port)/$($port.Protocol): $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "🔍 Проверяем созданные правила..." -ForegroundColor Cyan

# Показываем созданные правила
$valheimRules = Get-NetFirewallRule -DisplayName "Valheim*" | Sort-Object DisplayName
if ($valheimRules) {
    Write-Host "📋 Созданные правила Valheim:" -ForegroundColor Green
    foreach ($rule in $valheimRules) {
        $direction = if ($rule.Direction -eq "Inbound") { "Входящий" } else { "Исходящий" }
        $action = if ($rule.Action -eq "Allow") { "Разрешить" } else { "Заблокировать" }
        Write-Host "   - $($rule.DisplayName) ($direction, $action)" -ForegroundColor White
    }
} else {
    Write-Host "⚠️ Правила Valheim не найдены" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "✅ Настройка портов завершена!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Информация о сервере:" -ForegroundColor Cyan
Write-Host "   - IP: $(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.IPAddress -notlike "127.*" -and $_.IPAddress -notlike "169.254.*"} | Select-Object -First 1 -ExpandProperty IPAddress)" -ForegroundColor White
Write-Host "   - Порт подключения: 2457" -ForegroundColor White
Write-Host "   - Пароль: 121314" -ForegroundColor White
Write-Host "   - Имя сервера: Karjalainen" -ForegroundColor White
Write-Host ""
Write-Host "🚀 Теперь можно запускать сервер командой: docker-compose up -d" -ForegroundColor Green

Read-Host "Press Enter to exit"
