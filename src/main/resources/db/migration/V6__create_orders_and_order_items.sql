CREATE TABLE orders(
    order_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    waiter_id BIGINT ,
    session_id BIGINT NOT NULL ,
    order_type VARCHAR(20) NOT NULL
        CHECK (order_type IN ('DINE_IN', 'TAKEAWAY')),
    order_status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    order_number VARCHAR(30) NOT NULL,
    order_date DATE NOT NULL,
    UNIQUE (order_number, order_date),

    total_amount NUMERIC(10, 2) NOT NULL CHECK (total_amount >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (waiter_id) REFERENCES staff(staff_id),
    FOREIGN KEY (session_id) REFERENCES dining_sessions(dining_session_id)
);

CREATE TABLE order_items(
    order_item_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    order_id BIGINT NOT NULL ,
    product_id BIGINT NOT NULL ,
    quantity INTEGER NOT NULL CHECK ( quantity > 0 ),
    unit_price NUMERIC(10, 2) NOT NULL CHECK ( unit_price >= 0 ),

    UNIQUE (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE ,
    FOREIGN KEY (product_id) REFERENCES products (product_id) ON DELETE RESTRICT
);