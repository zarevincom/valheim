#!/bin/bash

# Valheim Server Stop Script
# Скрипт для остановки Valheim сервера

echo "🛑 Остановка Valheim сервера..."

# Останавливаем контейнер
docker-compose down

if [ $? -eq 0 ]; then
    echo "✅ Сервер успешно остановлен!"
else
    echo "❌ Ошибка при остановке сервера!"
    echo "Попробуйте принудительную остановку:"
    echo "docker-compose down --remove-orphans"
    exit 1
fi

