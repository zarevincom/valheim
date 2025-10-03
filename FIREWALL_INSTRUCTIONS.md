# 🔥 Инструкция по разблокировке портов Valheim

## ⚠️ ВАЖНО: Требуются права администратора!

Для разблокировки портов в Windows Firewall необходимо запустить командную строку или PowerShell **от имени администратора**.

## 🚀 Способы разблокировки портов:

### Способ 1: Использование готового скрипта

1. **Щелкните правой кнопкой мыши** на файл `unblock-ports.bat`
2. Выберите **"Запуск от имени администратора"**
3. Следуйте инструкциям на экране

### Способ 2: Ручные команды в командной строке

1. Нажмите `Win + R`, введите `cmd`
2. Нажмите `Ctrl + Shift + Enter` (запуск от имени администратора)
3. Перейдите в папку проекта: `cd /d G:\Projects\valheim`
4. Выполните команды:

```cmd
REM Основные порты Valheim
netsh advfirewall firewall add rule name="Valheim - Server Query - 2456/UDP" dir=in action=allow protocol=UDP localport=2456
netsh advfirewall firewall add rule name="Valheim - Server Game - 2457/UDP" dir=in action=allow protocol=UDP localport=2457
netsh advfirewall firewall add rule name="Valheim - Server Steam - 2458/UDP" dir=in action=allow protocol=UDP localport=2458

REM Дополнительные порты для Steam
netsh advfirewall firewall add rule name="Steam - Query - 27015/UDP" dir=in action=allow protocol=UDP localport=27015
netsh advfirewall firewall add rule name="Steam - Master Server - 27036/UDP" dir=in action=allow protocol=UDP localport=27036

REM RCON порт (опционально)
netsh advfirewall firewall add rule name="Valheim - RCON - 25575/TCP" dir=in action=allow protocol=TCP localport=25575
```

### Способ 3: Через PowerShell (от имени администратора)

1. Нажмите `Win + X`, выберите **"Windows PowerShell (администратор)"**
2. Перейдите в папку: `cd G:\Projects\valheim`
3. Выполните: `.\unblock-valheim-ports.ps1`

## 📋 Необходимые порты для Valheim:

| Порт | Протокол | Назначение |
|------|----------|------------|
| 2456 | UDP | Valheim Server Query |
| 2457 | UDP | Valheim Server Game (основной порт подключения) |
| 2458 | UDP | Valheim Server Steam |
| 27015 | UDP | Steam Query (опционально) |
| 27036 | UDP | Steam Master Server (опционально) |
| 25575 | TCP | RCON (опционально) |

## ✅ Проверка открытых портов:

После выполнения команд проверьте, что порты открыты:

```cmd
netsh advfirewall firewall show rule name="Valheim*"
```

Или проверьте все правила:
```cmd
netsh advfirewall firewall show rule name=all | findstr "Valheim"
```

## 🔍 Проверка через netstat:

```cmd
netstat -an | findstr "245"
```

## 🚀 После разблокировки портов:

1. Запустите сервер: `docker-compose up -d`
2. Подключитесь к серверу:
   - **IP**: localhost (или ваш внешний IP)
   - **Порт**: 2457
   - **Пароль**: 121314
   - **Имя сервера**: Karjalainen

## 🛠️ Устранение проблем:

### Если порты не открываются:
1. Убедитесь, что запускаете командную строку от имени администратора
2. Проверьте, не блокирует ли антивирус брандмауэр
3. Попробуйте временно отключить брандмауэр для тестирования

### Если сервер не виден в списке:
1. Убедитесь, что `PUBLIC_SERVER=1` в файле `valheim.env`
2. Проверьте, что порт 2457 открыт
3. Попробуйте подключиться по IP напрямую

### Если не можете подключиться:
1. Проверьте, что сервер запущен: `docker-compose ps`
2. Посмотрите логи: `docker-compose logs valheim`
3. Убедитесь, что используете правильный порт (2457, не 2456)

## 📞 Поддержка:

Если возникли проблемы, проверьте:
- Логи Docker: `docker-compose logs -f valheim`
- Статус контейнера: `docker-compose ps`
- Правила брандмауэра: `netsh advfirewall firewall show rule name="Valheim*"`

