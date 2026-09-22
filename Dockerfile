# Базовый образ — Python 3.11 slim (урезанная версия)
FROM python:3.11-slim

# Метаданные образа
LABEL maintainer="oleg"
LABEL description="DevOps Progress API — FastAPI application"

# Отключаем создание .pyc файлов и включаем небуферизованный вывод
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Рабочая директория внутри контейнера
WORKDIR /app

# Сначала копируем только requirements.txt
# Это нужно для кэширования: если файл не менялся,
# pip install не будет перезапускаться
COPY requirements.txt .
ARG HTTP_PROXY
ARG HTTPS_PROXY

ENV HTTP_PROXY=${HTTP_PROXY} \
    HTTPS_PROXY=${HTTPS_PROXY}
# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код приложения
COPY src/ ./src/

# Создаём непривилегированного пользователя
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app
USER appuser

# Документируем, что контейнер слушает порт 8000
EXPOSE 8000

# Команда запуска при старте контейнера
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
