# User Registration — Sequence Diagram

## Назначение

Диаграмма последовательности описывает взаимодействие компонентов Smart Home Management Platform при регистрации нового пользователя.

---

## Участники

- `User` — пользователь системы;
- `Mobile App` — клиентское приложение;
- `Smart Home Backend` — серверная часть системы;
- `Database` — база данных PostgreSQL.

---

## Основной сценарий

1. Пользователь вводит Email и пароль.
2. Mobile App отправляет `POST /auth/register`.
3. Backend проверяет уникальность Email.
4. Backend хеширует пароль.
5. Новый пользователь сохраняется в базе данных.
6. Backend формирует JWT access token.
7. Mobile App получает данные пользователя и токен.
8. Пользователю отображается успешная регистрация.

---

## Альтернативный сценарий

Если пользователь с указанным Email уже существует, Backend возвращает:

`409 Conflict`

Mobile App отображает сообщение об ошибке регистрации.

---

## Связанные документы

- [BPMN — User Registration](../../bpmn/01-user-registration/README.md)
- [Functional Requirements](../../requirements/05-functional-requirements/README.md)
- [Use Cases](../../requirements/08-use-cases/README.md)
- [OpenAPI](../../api/openapi.yaml)
- [SQL](../../sql/README.md)

---

## Статус

Завершено