FROM python:3.12-slim

# Создаем непривилегированного пользователя
RUN useradd --system --no-create-home app

WORKDIR /app

# Сначала копируем только зависимости (для кэширования)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Затем копируем код приложения
COPY app.py .

# Переключаемся на пользователя app
USER app

# Открываем порт для нашего варианта
EXPOSE 8004

# Запускаем gunicorn в exec-форме, слушаем все интерфейсы
CMD ["gunicorn", "--bind", "0.0.0.0:8004", "app:app"]