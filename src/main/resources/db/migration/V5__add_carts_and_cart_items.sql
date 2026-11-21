CREATE TABLE carts(
    cart_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    session_id BIGINT NOT NULL ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES dining_sessions(dining_session_id)

);
CREATE TABLE cart_items(
    cart_item_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    cart_id BIGINT NOT NULL ,
    quantity INTEGER NOT NULL  CHECK ( quantity >= 0 ),
    product_id BIGINT NOT NULL ,
    UNIQUE (cart_id, product_id),

    FOREIGN KEY (cart_id) REFERENCES carts(cart_id) ON DELETE CASCADE ,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);