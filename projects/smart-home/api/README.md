# API

## Назначение раздела

В разделе представлена спецификация REST API для Smart Home Management Platform.

API описывает взаимодействие клиентского приложения с Backend и поддерживает основные сценарии системы: регистрацию и авторизацию пользователей, управление домами, комнатами и устройствами, а также отправку команд устройствам.

---

## Формат API

- REST
- JSON
- OpenAPI 3.0.3
- HTTPS
- JWT Bearer Authentication

---

## Основные группы методов

| Группа | Назначение |
|---|---|
| Auth | регистрация и авторизация пользователей |
| Homes | управление домами |
| Rooms | управление комнатами |
| Devices | подключение и управление устройствами |
| Commands | отправка команд и просмотр истории их выполнения |

---

## Основные endpoints

### Auth

- `POST /auth/register` — регистрация пользователя
- `POST /auth/login` — авторизация пользователя

### Homes

- `GET /homes` — получить доступные пользователю дома
- `POST /homes` — создать дом
- `GET /homes/{homeId}` — получить дом
- `PATCH /homes/{homeId}` — изменить дом
- `DELETE /homes/{homeId}` — удалить дом

### Rooms

- `GET /homes/{homeId}/rooms` — получить комнаты дома
- `POST /homes/{homeId}/rooms` — создать комнату
- `GET /rooms/{roomId}` — получить комнату
- `PATCH /rooms/{roomId}` — изменить комнату
- `DELETE /rooms/{roomId}` — удалить комнату

### Devices

- `GET /homes/{homeId}/devices` — получить устройства дома
- `POST /homes/{homeId}/devices` — подключить устройство
- `GET /devices/{deviceId}` — получить устройство
- `PATCH /devices/{deviceId}` — изменить устройство
- `DELETE /devices/{deviceId}` — удалить устройство
- `GET /devices/{deviceId}/state` — получить текущее состояние устройства

### Commands

- `POST /devices/{deviceId}/commands` — отправить команду устройству
- `GET /devices/{deviceId}/commands` — получить историю команд устройства
- `GET /commands/{commandId}` — получить информацию о выполнении команды

---

## Аутентификация

Для защищенных методов используется JWT Bearer Token.

Токен возвращается после успешной регистрации или авторизации пользователя и передается в заголовке:

```text
Authorization: Bearer <access_token>