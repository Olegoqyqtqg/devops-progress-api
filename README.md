# DevOps Progress API

Учебный проект для отслеживания прогресса по DevOps-роадмапу.
Реализован как REST API на FastAPI.

## Стек

- Python 3.11+
- FastAPI — веб-фреймворк
- Uvicorn — ASGI-сервер
- Pydantic — валидация данных

## Запуск локально

\`\`\`bash
# Клонировать репозиторий
git clone https://github.com/Olegoqyqtqg/devops-progress-api.git
cd devops-progress-api

# Создать виртуальное окружение
python3 -m venv .venv
source .venv/bin/activate

# Установить зависимости
pip install -r requirements.txt

# Запустить сервер
uvicorn src.main:app --reload
\`\`\`

Сервер будет доступен по адресу: http://127.0.0.1:8000

## Эндпоинты

| Метод | Путь | Описание |
|-------|------|----------|
| GET | `/health` | Проверка статуса сервиса |
| GET | `/progress` | Список всех тем |
| GET | `/progress/{item_id}` | Одна тема по id |
| GET | `/progress/filter/{status}` | Фильтр тем по статусу |

## Документация API

После запуска сервера интерактивная документация доступна:

- Swagger UI: http://127.0.0.1:8000/docs
- ReDoc: http://127.0.0.1:8000/redoc

## Структура проекта

\`\`\`
devops-progress-api/
├── src/
│   └── main.py          # FastAPI-приложение
├── .gitignore
├── requirements.txt
└── README.md
\`\`\`

## Прогресс

- [x] Неделя 1: Git, Python, FastAPI
- [ ] Неделя 2: Docker
- [ ] Неделя 3-4: Linux, Nginx
- [ ] Неделя 5-6: Kubernetes, Helm
- [ ] Неделя 7-8: Terraform, Ansible
- [ ] Неделя 9-10: CI/CD, ArgoCD
- [ ] Неделя 11-12: Мониторинг, БД
- [ ] Неделя 13-14: Облака
- [ ] Неделя 15-16: GenAI
