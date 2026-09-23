CREATE EXTENSION IF NOT EXISTS pgcrypto;


-- =========================================================
-- Users
-- =========================================================

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Email должен быть уникальным без учета регистра
CREATE UNIQUE INDEX uq_users_email
    ON users (LOWER(email));


-- =========================================================
-- Homes
-- =========================================================

CREATE TABLE homes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_homes_owner
        FOREIGN KEY (owner_id)
        REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_homes_owner_id
    ON homes(owner_id);


-- =========================================================
-- Rooms
-- =========================================================

CREATE TABLE rooms (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    home_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_rooms_home
        FOREIGN KEY (home_id)
        REFERENCES homes(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_rooms_home_id
    ON rooms(home_id);


-- =========================================================
-- Device Types
-- =========================================================

CREATE TABLE device_types (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);


-- =========================================================
-- Devices
-- =========================================================

CREATE TABLE devices (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    home_id UUID NOT NULL,
    room_id UUID,
    device_type_id UUID NOT NULL,

    name VARCHAR(100) NOT NULL,
    serial_number VARCHAR(100) NOT NULL UNIQUE,
    connection_status VARCHAR(30) NOT NULL DEFAULT 'offline',

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_devices_home
        FOREIGN KEY (home_id)
        REFERENCES homes(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_devices_room
        FOREIGN KEY (room_id)
        REFERENCES rooms(id)
        ON DELETE SET NULL,

    CONSTRAINT fk_devices_type
        FOREIGN KEY (device_type_id)
        REFERENCES device_types(id)
);

CREATE INDEX idx_devices_home_id
    ON devices(home_id);

CREATE INDEX idx_devices_room_id
    ON devices(room_id);

CREATE INDEX idx_devices_device_type_id
    ON devices(device_type_id);


-- =========================================================
-- Home Members
-- =========================================================

CREATE TABLE home_members (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    home_id UUID NOT NULL,
    user_id UUID NOT NULL,
    role VARCHAR(30) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_home_members_home
        FOREIGN KEY (home_id)
        REFERENCES homes(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_home_members_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE CASCADE,

    CONSTRAINT uq_home_member
        UNIQUE (home_id, user_id)
);

CREATE INDEX idx_home_members_home_id
    ON home_members(home_id);

CREATE INDEX idx_home_members_user_id
    ON home_members(user_id);


-- =========================================================
-- Device States
-- =========================================================

CREATE TABLE device_states (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    device_id UUID NOT NULL UNIQUE,

    state JSONB NOT NULL DEFAULT '{}'::jsonb,

    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_device_states_device
        FOREIGN KEY (device_id)
        REFERENCES devices(id)
        ON DELETE CASCADE
);


-- =========================================================
-- Commands
-- =========================================================

CREATE TABLE commands (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    device_id UUID NOT NULL,
    user_id UUID NOT NULL,

    command_type VARCHAR(50) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'pending',

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_commands_device
        FOREIGN KEY (device_id)
        REFERENCES devices(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_commands_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
);

CREATE INDEX idx_commands_device_id
    ON commands(device_id);

CREATE INDEX idx_commands_user_id
    ON commands(user_id);

CREATE INDEX idx_commands_created_at
    ON commands(created_at);


-- =========================================================
-- updated_at trigger
-- =========================================================

CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();


CREATE TRIGGER trg_homes_updated_at
BEFORE UPDATE ON homes
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();


CREATE TRIGGER trg_rooms_updated_at
BEFORE UPDATE ON rooms
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();


CREATE TRIGGER trg_devices_updated_at
BEFORE UPDATE ON devices
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();


CREATE TRIGGER trg_device_states_updated_at
BEFORE UPDATE ON device_states
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();