-- Shipping / logistics module

CREATE TABLE IF NOT EXISTS shipping.address (
    id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id       UUID NOT NULL,
    street        VARCHAR(255) NOT NULL,
    city          VARCHAR(100) NOT NULL,
    state         VARCHAR(100),
    country       VARCHAR(100) NOT NULL DEFAULT 'Colombia',
    postal_code   VARCHAR(20),
    is_default    BOOLEAN NOT NULL DEFAULT FALSE,
    created_at    TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by    VARCHAR(100),
    updated_at    TIMESTAMP,
    updated_by    VARCHAR(100),
    state_field   VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_address_user
        FOREIGN KEY (user_id) REFERENCES security."user"(id)
);

CREATE TABLE IF NOT EXISTS shipping.shipment (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    bill_id         UUID NOT NULL,
    address_id      UUID NOT NULL,
    tracking_code   VARCHAR(100),
    carrier         VARCHAR(100),
    status          VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    shipped_at      TIMESTAMP,
    delivered_at    TIMESTAMP,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by      VARCHAR(100),
    updated_at      TIMESTAMP,
    updated_by      VARCHAR(100),
    state           VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_shipment_bill
        FOREIGN KEY (bill_id) REFERENCES bill.bill(id),
    CONSTRAINT fk_shipment_address
        FOREIGN KEY (address_id) REFERENCES shipping.address(id)
);
