# SQL

## Назначение раздела

В разделе представлены SQL-скрипты для модели данных Smart Home Management Platform.

Структура базы данных основана на ERD проекта и реализуется для PostgreSQL.

---

## Используемая СУБД

PostgreSQL

---

## Основные таблицы

- users
- homes
- home_members
- rooms
- device_types
- devices
- device_states
- commands

---

## Артефакты

- `01-schema.sql` — создание структуры базы данных;
- `02-sample-queries.sql` — примеры запросов к данным.

---

## Статус

В работе

---

## Связанные документы

- [ERD](../erd/README.md)
- [Functional Requirements](../requirements/05-functional-requirements/README.md)
- [Business Rules](../requirements/09-business-rules/README.md)