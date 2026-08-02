Define the purpose, scope, initial entities, and planned artifacts for the Smart Home data model.# ERD

## Назначение раздела

В разделе представлена модель данных Smart Home Management Platform.

ERD описывает основные сущности системы, их атрибуты и связи, необходимые для регистрации пользователей, управления домами, комнатами и устройствами.

---

## Цель моделирования

Спроектировать логическую структуру данных, которая поддерживает основные сценарии MVP:

- регистрацию пользователей;
- создание домов;
- добавление комнат;
- подключение устройств;
- управление устройствами;
- хранение текущего состояния устройств;
- предоставление совместного доступа к дому.

---

## Основные сущности

| Сущность | Назначение |
|---|---|
| User | учетная запись пользователя |
| Home | дом, созданный пользователем |
| Room | помещение внутри дома |
| Device | подключенное устройство |
| DeviceType | тип и возможности устройства |
| DeviceState | текущее состояние устройства |
| HomeMember | доступ пользователей к дому |
| Command | история команд управления устройствами |

---

## Планируемые артефакты

- логическая ERD в формате Draw.io;
- PNG-предпросмотр модели;
- описание сущностей и связей;
- первичные и внешние ключи;
- SQL-схема PostgreSQL.

---

## Статус

В работе

---

## Связанные документы

- [Functional Requirements](../requirements/05-functional-requirements/README.md)
- [Non-functional Requirements](../requirements/06-non-functional-requirements/README.md)
- [Use Cases](../requirements/08-use-cases/README.md)
- [Business Rules](../requirements/09-business-rules/README.md)
- [BPMN](../bpmn/README.md)