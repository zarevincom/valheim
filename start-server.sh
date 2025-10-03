#!/bin/bash

# Valheim Server Startup Script
# Скрипт для запуска Valheim сервера

echo "🚀 Запуск Valheim сервера..."

# Проверяем наличие Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не установлен. Установите Docker и попробуйте снова."
    exit 1
fi

# Проверяем наличие Docker Compose
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose не установлен. Установите Docker Compose и попробуйте снова."
    exit 1
fi

# Создаем необходимые директории
echo "📁 Создание директорий..."
mkdir -p valheim/saves
mkdir -p valheim/server
mkdir -p valheim/logs

# Запускаем сервер
echo "🐳 Запуск Docker контейнера..."
docker-compose up -d

# Проверяем статус
if [ $? -eq 0 ]; then
    echo "✅ Сервер успешно запущен!"
    echo ""
    echo "📋 Информация о сервере:"
    echo "   IP: localhost (или ваш внешний IP)"
    echo "   Порт: 2457"
    echo "   Пароль: 0"
    echo "   Имя сервера: Valheim Server"
    echo "   Мир: Dedicated"
    echo ""
    echo "📊 Для просмотра логов используйте:"
    echo "   docker-compose logs -f valheim"
    echo ""
    echo "🛑 Для остановки сервера используйте:"
    echo "   docker-compose down"
else
    echo "❌ Ошибка при запуске сервера!"
    echo "Проверьте логи: docker-compose logs valheim"
    exit 1
fi

