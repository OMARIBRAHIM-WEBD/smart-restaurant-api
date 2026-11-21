CREATE TABLE categories(
    category_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    category_name VARCHAR(255) NOT NULL UNIQUE
);
CREATE TABLE products(
    product_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
    product_name VARCHAR(255) NOT NULL ,
    description TEXT ,
    price NUMERIC(10, 2) NOT NULL CHECK ( price > 0 ),
    availability_status VARCHAR(255) NOT NULL DEFAULT 'AVAILABLE'
        CHECK ( availability_status IN ('UNAVAILABLE', 'AVAILABLE')),
    image_url TEXT ,
    category_id INTEGER NOT NULL,

    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE RESTRICT
);