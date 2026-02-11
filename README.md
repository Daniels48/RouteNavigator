# 🚌 Сервис поиска оптимального маршрута между остановками

📌 О проекте

Веб-приложение для поиска кратчайшего маршрута между двумя остановками общественного транспорта в г. Воронеж.

Поиск маршрута реализован с использованием алгоритма A* (A-star) по графу остановок и маршрутов.

🛠 Технологии

Backend:

Python 3.10+

FastAPI (async)

SQLAlchemy (async)

PostgreSQL

Frontend:

Jinja2

Leaflet.js

OpenStreetMap tiles


🚀 Запуск проекта
1️⃣ Клонировать репозиторий
git clone <repo_url>
cd project

2️⃣ Создать виртуальное окружение
python -m venv venv
source venv/bin/activate

3️⃣ Установить зависимости
pip install -r requirements.txt

4️⃣ Настроить подключение к БД

В файле конфигурации указать параметры PostgreSQL:

DATABASE_URL=postgresql+asyncpg://user:password@localhost/dbname

5️⃣ Запустить сервер
uvicorn app.main:app --reload


Открыть в браузере:

http://127.0.0.1:8000/
