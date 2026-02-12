# 🚌 Поиск кратчайшего маршрута между остановками

## 📌 О проекте

Веб-приложение для поиска кратчайшего маршрута между двумя остановками общественного транспорта в г. Воронеж.

Поиск маршрута реализован с использованием алгоритма A* (A-star) по графу остановок и маршрутов.

## 🛠 Технологии

### Backend ⚙️
- **Python 3.10+**
- **FastAPI** (async)
- **SQLAlchemy** (async)
- **PostgreSQL**

### Frontend 🎨
- **Jinja2**
- **Leaflet.js**
- **OpenStreetMap**


## 🚀 Запуск проекта

### 1️⃣ Клонировать репозиторий
```bash
git clone https://github.com/Daniels48/RouteNavigator.git
```

### 2️⃣ Создать файл .env
```env
DB_NAME=mydb
DB_HOST=localhost
DB_PORT=5432
DB_USER=example
DB_PASSWORD=example
```

### 3️⃣ Запустить контейнеры
```bash
docker compose up -d --build
```

### 4️⃣ Загрузить тестовые данные
```bash
docker exec -e PGPASSWORD=example -i db psql -U example -d mydb < 02_data.sql
```

### 5️⃣ Открыть в браузере: http://localhost:8000/
