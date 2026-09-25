# API

## Назначение раздела

В разделе представлена спецификация REST API для Smart Home Management Platform.

API обеспечивает взаимодействие мобильного приложения с Backend и поддерживает основные сценарии системы: регистрацию и авторизацию пользователей, управление домами, комнатами и устройствами.

---

## Формат API

- REST
- JSON
- OpenAPI 3.0
- HTTPS

---

## Основные ресурсы

- Authentication
- Users
- Homes
- Rooms
- Devices
- Commands

---

## Планируемые группы методов

| Группа | Назначение |
|---|---|
| Auth | регистрация и авторизация пользователя |
| Homes | управление домами |
| Rooms | управление комнатами |
| Devices | подключение и управление устройствами |
| Commands | отправка команд устройствам |

---

## Спецификация

- [OpenAPI](./openapi.yaml)

---

## Статус

В работе

---

## Связанные документы

- [Functional Requirements](../requirements/05-functional-requirements/README.md)
- [Use Cases](../requirements/08-use-cases/README.md)
- [Business Rules](../requirements/09-business-rules/README.md)
- [ERD](../erd/README.md)
- [BPMN](../bpmn/README.md)