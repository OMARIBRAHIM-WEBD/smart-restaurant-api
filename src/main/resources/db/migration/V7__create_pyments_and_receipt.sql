CREATE TABLE payments(
    payment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    payment_method VARCHAR(255) NOT NULL ,
    payment_status VARCHAR(255) NOT NULL ,
    payment_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    transaction_ref VARCHAR(255) UNIQUE ,
    amount NUMERIC(10, 2) NOT NULL CHECK ( amount > 0 ) ,
    session_id BIGINT NOT NULL ,

    FOREIGN KEY (session_id) REFERENCES dining_sessions(dining_session_id)
);
CREATE TABLE receipts(
    receipt_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    payment_id BIGINT NOT NULL UNIQUE ,
    receipt_number VARCHAR(100) NOT NULL UNIQUE ,
    issued_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (payment_id) REFERENCES payments (payment_id)
);