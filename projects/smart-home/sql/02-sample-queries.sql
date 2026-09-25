-- =========================================================
-- Smart Home Management Platform
-- Sample SQL queries
-- PostgreSQL
-- =========================================================


-- 1. Получить дома пользователя, где он является владельцем

SELECT
    h.id,
    h.name,
    h.created_at
FROM homes h
WHERE h.owner_id = :user_id
ORDER BY h.created_at;


-- 2. Получить все дома, к которым пользователь имеет доступ

SELECT
    h.id,
    h.name,
    'owner' AS access_role
FROM homes h
WHERE h.owner_id = :user_id

UNION

SELECT
    h.id,
    h.name,
    hm.role AS access_role
FROM home_members hm
JOIN homes h
    ON h.id = hm.home_id
WHERE hm.user_id = :user_id;


-- 3. Получить комнаты выбранного дома

SELECT
    r.id,
    r.name,
    r.created_at
FROM rooms r
WHERE r.home_id = :home_id
ORDER BY r.name;


-- 4. Получить устройства дома вместе с комнатами и типами

SELECT
    d.id,
    d.name AS device_name,
    d.serial_number,
    d.connection_status,
    r.name AS room_name,
    dt.name AS device_type
FROM devices d
LEFT JOIN rooms r
    ON r.id = d.room_id
JOIN device_types dt
    ON dt.id = d.device_type_id
WHERE d.home_id = :home_id
ORDER BY r.name, d.name;


-- 5. Получить устройства, которые еще не добавлены в комнату

SELECT
    d.id,
    d.name,
    d.serial_number,
    d.connection_status
FROM devices d
WHERE d.home_id = :home_id
  AND d.room_id IS NULL
ORDER BY d.name;


-- 6. Получить текущее состояние устройства

SELECT
    d.id,
    d.name,
    d.connection_status,
    ds.state,
    ds.updated_at
FROM devices d
LEFT JOIN device_states ds
    ON ds.device_id = d.id
WHERE d.id = :device_id;


-- 7. Получить всех пользователей, имеющих доступ к дому

SELECT
    u.id,
    u.email,
    'owner' AS role,
    h.created_at
FROM homes h
JOIN users u
    ON u.id = h.owner_id
WHERE h.id = :home_id

UNION ALL

SELECT
    u.id,
    u.email,
    hm.role,
    hm.created_at
FROM home_members hm
JOIN users u
    ON u.id = hm.user_id
WHERE hm.home_id = :home_id

ORDER BY created_at;


-- 8. Получить историю команд устройства

SELECT
    c.id,
    c.command_type,
    c.status,
    c.created_at,
    u.email AS requested_by
FROM commands c
JOIN users u
    ON u.id = c.user_id
WHERE c.device_id = :device_id
ORDER BY c.created_at DESC;


-- 9. Получить последнюю команду для каждого устройства

SELECT DISTINCT ON (c.device_id)
    c.device_id,
    d.name AS device_name,
    c.command_type,
    c.status,
    c.created_at
FROM commands c
JOIN devices d
    ON d.id = c.device_id
ORDER BY c.device_id, c.created_at DESC;


-- 10. Подсчитать количество команд по статусам

SELECT
    c.status,
    COUNT(*) AS command_count
FROM commands c
WHERE c.created_at >= CURRENT_TIMESTAMP - INTERVAL '24 hours'
GROUP BY c.status
ORDER BY command_count DESC;