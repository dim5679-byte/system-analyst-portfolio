# Add Device — Sequence Diagram

## Назначение

Диаграмма последовательности описывает взаимодействие компонентов Smart Home Management Platform при подключении нового устройства к дому.

---

## Участники

- `User` — пользователь системы;
- `Mobile App` — клиентское приложение;
- `Smart Home Backend` — серверная часть системы;
- `Database` — база данных PostgreSQL.

---

## Основной сценарий

1. Пользователь сканирует QR-код устройства.
2. Mobile App отправляет `POST /homes/{homeId}/devices`.
3. Backend проверяет QR-код устройства.
4. Backend проверяет, не подключено ли устройство ранее.
5. Backend сохраняет устройство с привязкой к дому.
6. База данных подтверждает сохранение устройства.
7. Backend возвращает `201 Created`.
8. Mobile App сообщает пользователю об успешном подключении устройства.

---

## Альтернативные сценарии

### Некорректный QR-код

Если QR-код устройства некорректен, Backend возвращает:

`400 Bad Request`

Mobile App отображает сообщение об ошибке.

### Устройство уже подключено

Если устройство уже привязано к дому, Backend возвращает:

`409 Conflict`

Mobile App сообщает пользователю, что устройство уже подключено.

---

## Связанные документы

- [BPMN — Add Device](../../bpmn/02-add-device/README.md)
- [Functional Requirements](../../requirements/05-functional-requirements/README.md)
- [Use Cases](../../requirements/08-use-cases/README.md)
- [OpenAPI](../../api/openapi.yaml)
- [ERD](../../erd/README.md)
- [SQL](../../sql/README.md)

---

## Статус

Завершено