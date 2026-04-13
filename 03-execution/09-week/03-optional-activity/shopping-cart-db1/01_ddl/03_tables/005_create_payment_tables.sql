-- Payment module

CREATE TABLE IF NOT EXISTS payment.payment_method (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id     UUID NOT NULL,
    type        VARCHAR(50) NOT NULL,          -- CREDIT_CARD, PSE, NEQUI, etc.
    provider    VARCHAR(100),
    token       TEXT,                           -- tokenized card / account ref
    is_default  BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by  VARCHAR(100),
    updated_at  TIMESTAMP,
    updated_by  VARCHAR(100),
    state       VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_pm_user
        FOREIGN KEY (user_id) REFERENCES security."user"(id)
);

CREATE TABLE IF NOT EXISTS payment.payment (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    bill_id             UUID NOT NULL,
    payment_method_id   UUID NOT NULL,
    amount              NUMERIC(14,2) NOT NULL,
    currency            CHAR(3) NOT NULL DEFAULT 'COP',
    status              VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    gateway_reference   VARCHAR(200),
    paid_at             TIMESTAMP,
    created_at          TIMESTAMP NOT NULL DEFAULT NOW(),
    created_by          VARCHAR(100),
    updated_at          TIMESTAMP,
    updated_by          VARCHAR(100),
    state               VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT fk_payment_bill
        FOREIGN KEY (bill_id) REFERENCES bill.bill(id),
    CONSTRAINT fk_payment_method
        FOREIGN KEY (payment_method_id) REFERENCES payment.payment_method(id)
);
