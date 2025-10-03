# Valheim Dedicated Server

Настроенный Valheim сервер с использованием Docker контейнера `mbround18/valheim`.

## Быстрый старт

1. **Клонируйте репозиторий и перейдите в директорию:**
   ```bash
   git clone <your-repo-url>
   cd valheim
   ```

2. **Запустите сервер:**
   ```bash
   docker-compose up -d
   ```

3. **Подключитесь к серверу:**
   - IP: `localhost` (или ваш внешний IP)
   - Порт: `2457` (на единицу больше чем PORT)
   - Пароль: `0`

## Конфигурация

### Основные настройки (в файле `valheim.env`):

- `PORT=2456` - порт сервера (подключение через 2457)
- `SERVER_NAME=Valheim Server` - имя сервера
- `WORLD_NAME=Dedicated` - имя мира
- `SERVER_PASSWORD=0` - пароль для подключения
- `TIMEZONE=Europe/Moscow` - часовой пояс

### Дополнительные настройки:

- `PUBLIC_SERVER=1` - сервер виден в списке публичных
- `AUTO_UPDATE=1` - автоматические обновления
- `AUTO_BACKUP=1` - автоматическое резервное копирование
- `BACKUP_SCHEDULE=*/15 * * * *` - расписание бэкапов (каждые 15 минут)
- `BACKUP_DAYS_TO_LIVE=3` - хранить бэкапы 3 дня

## Управление сервером

### Запуск:
```bash
docker-compose up -d
```

### Остановка:
```bash
docker-compose down
```

### Просмотр логов:
```bash
docker-compose logs -f valheim
```

### Перезапуск:
```bash
docker-compose restart valheim
```

## Структура файлов

```
valheim/
├── docker-compose.yml    # Конфигурация Docker Compose
├── valheim.env          # Переменные окружения
├── README.md            # Документация
└── valheim/             # Данные сервера (создается автоматически)
    ├── saves/           # Сохранения мира
    ├── server/          # Файлы сервера
    └── logs/            # Логи сервера
```

## Подключение к серверу

1. Запустите игру Valheim
2. Выберите "Join Game"
3. Введите IP адрес сервера и порт `2457`
4. Введите пароль: `0`

## Полезные команды

### Просмотр статуса контейнера:
```bash
docker-compose ps
```

### Вход в контейнер:
```bash
docker-compose exec valheim bash
```

### Обновление образа:
```bash
docker-compose pull
docker-compose up -d
```

## Резервное копирование

Сервер автоматически создает резервные копии каждые 15 минут. Файлы сохраняются в директории `valheim/saves/`.

Для ручного создания бэкапа:
```bash
docker-compose exec valheim /bin/bash -c "backup"
```

## Модификации

Для использования модов измените в `valheim.env`:
```
SERVER_TYPE=BepInEx
MODS=mod1,mod2,mod3
```

**Внимание:** Модификации могут вызывать ошибки, так как официальная поддержка модов в Valheim отсутствует.

## Поддержка

- [GitHub репозиторий](https://github.com/mbround18/valheim-docker)
- [Docker Hub](https://hub.docker.com/r/mbround18/valheim)

