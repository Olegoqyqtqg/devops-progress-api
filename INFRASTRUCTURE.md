# Infrastructure Notes

Заметки о проделанной работе по DevOps-роадмапу.
Файл ведётся от базовых инструментов к инфраструктуре.

---

## 1. Git — базовая настройка

- Установлен и настроен Git (`user.name`, `user.email` через noreply-адрес GitHub)
- Создан репозиторий `devops-progress-api`
- Настроен `.gitignore` для Python (`.venv/`, `__pycache__/`, `*.pyc`, `.env`)
- Освоены базовые операции: `init`, `add`, `commit`, `status`, `log`, `diff`
- Соглашение о сообщениях коммитов: `feat:`, `chore:`, `docs:`, `fix:`

## 2. Python + виртуальное окружение

- Создано изолированное окружение через `python3 -m venv .venv`
- Активация через `source .venv/bin/activate`
- Установлены зависимости: `fastapi`, `uvicorn[standard]`, `pydantic`
- Зафиксированы точные версии в `requirements.txt` через `pip freeze`

## 3. FastAPI — REST API

- Написано приложение `src/main.py` на FastAPI
- Реализованы эндпоинты:
  - `GET /health` — проверка статуса
  - `GET /progress` — список тем
  - `GET /progress/{item_id}` — одна тема по id
  - `GET /progress/filter/{status}` — фильтр по статусу
- Использованы Pydantic-модели для описания структуры данных
- Автодокументация доступна на `/docs` (Swagger UI) и `/redoc`
- Валидация параметров пути через type hints (`item_id: int` → 422 при невалидном вводе)
- Проверка работы: браузер, `curl`, Swagger UI

## 4. Git — ветки, merge, PR

- Освоены операции с ветками: `git switch -c`, `git switch`, `git merge`, `git branch -d`
- Практика: создана ветка `feature/progress-filter`, добавлен эндпоинт, смёржена в `main`
- Первый Pull Request на GitHub: ветка `docs/readme`, добавлен README, смёржен через веб-интерфейс
- Практика `git pull` после merge PR (fetch + merge)

## 5. GitHub — публикация

- Создан публичный репозиторий `devops-progress-api`
- Настроен `origin` remote
- Ветка переименована `master` → `main`
- Получен Personal Access Token (PAT) для push по HTTPS
- Первый push: 4 коммита отправлены на GitHub
- Проверка: файлы и коммиты видны в браузере, аватарка привязана к коммитам

## 6. Docker — установка и базовые операции

- Установлен Docker и Docker Compose
- Пользователь добавлен в группу `docker` (работа без `sudo`)
- Освоены команды: `docker ps`, `docker ps -a`, `docker images`, `docker logs`, `docker pull`
- Проверка связи между локальным репозиторием и GitHub через `git remote -v`, `git fetch`, `git push`

## 7. Self-hosted Gitea (Docker Compose)

Развёрнут локальный Git-сервер **Gitea** на Astra Linux как альтернатива публичному GitHub.

**Доступ:**
- Веб-интерфейс: `http://192.168.1.45:3000`
- SSH для Git: `ssh://git@192.168.1.45:2222/`

**Что сделано:**
- Написан `docker-compose.yml` с сервисом Gitea
- Настроены порты: `3000` (веб), `2222` (SSH) — порт `2222`, потому что `22` занят системным SSH
- Настроены volumes для персистентности данных (`./gitea:/data`)
- Заданы переменные окружения: `USER_UID=1000`, `ROOT_URL`, `SSH_PORT`, `DISABLE_REGISTRATION=true`
- Пройдена первичная настройка через веб-интерфейс: создан администратор
- Настроен SSH-доступ по ключам (без паролей)
- Проверена работа: `ssh -p 2222 git@192.168.1.45` → «Hi there, oleg!»

**Файл конфигурации:** `~/gitea-server/docker-compose.yml`

## 8. Мульти-remote в Git

Проект синхронизируется с двумя удалёнными репозиториями:

| Remote | Где | URL |
|--------|-----|-----|
| `origin` | GitHub | `https://github.com/Olegoqyqtqg/devops-progress-api.git` |
| `gitea` | Локальный Gitea | `ssh://git@192.168.1.45:2222/oleg/devops-progress-api.git` |

**Push в оба:**
```bash
git push origin main
git push gitea main
