CREATE TABLE dining_sessions(
    dining_session_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    table_id BIGINT NOT NULL ,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
        CHECK ( status IN ('CLOSED', 'ACTIVE')),
    started_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    closed_at TIMESTAMPTZ,

    -- Ensures the session status and closing timestamp are consistent.
    -- ACTIVE sessions must have no closing timestamp.
    -- CLOSED sessions must have a closing timestamp.
    CHECK (
        (status = 'ACTIVE' AND closed_at IS NULL)
            OR
        (status = 'CLOSED' AND closed_at IS NOT NULL)
        ),

    FOREIGN KEY (table_id) REFERENCES dining_tables(table_id)
);


-- Allows multiple historical sessions for the same table,
-- but prevents that table from having more than one ACTIVE session.
CREATE UNIQUE INDEX unique_active_session_per_table
    ON dining_sessions(table_id)
    WHERE status = 'ACTIVE';