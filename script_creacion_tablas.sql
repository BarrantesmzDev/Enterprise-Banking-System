CREATE TABLE STATES (
    state_id INT PRIMARY KEY,
    state_name VARCHAR2(50) NOT NULL
);

CREATE TABLE CLIENTS (
    client_id INT PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone_number VARCHAR2(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    state_id INT,
    CONSTRAINT fk_client_state FOREIGN KEY (state_id) REFERENCES STATES(state_id)
);

CREATE TABLE EMPLOYEES (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone_number VARCHAR2(15),
    hire_date DATE NOT NULL,
    state_id INT,
    CONSTRAINT fk_employee_state FOREIGN KEY (state_id) REFERENCES STATES(state_id)
);

CREATE TABLE BRANCHES (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR2(100) NOT NULL,
    address VARCHAR2(200),
    state_id INT,
    CONSTRAINT fk_branch_state FOREIGN KEY (state_id) REFERENCES STATES(state_id)
);

CREATE TABLE ACCOUNTS (
    account_id INT PRIMARY KEY,
    client_id INT,
    branch_id INT,
    account_type VARCHAR2(20) NOT NULL,
    balance NUMBER(15,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_account_client FOREIGN KEY (client_id) REFERENCES CLIENTS(client_id),
    CONSTRAINT fk_account_branch FOREIGN KEY (branch_id) REFERENCES BRANCHES(branch_id)
);

CREATE TABLE CARDS (
    card_id INT PRIMARY KEY,
    account_id INT,
    card_number VARCHAR2(16) UNIQUE NOT NULL,
    expiration_date DATE NOT NULL,
    cvv VARCHAR2(4) NOT NULL,
    card_type VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_card_account FOREIGN KEY (account_id) REFERENCES ACCOUNTS(account_id)
);

CREATE TABLE TRANSFERS (
    transfer_id INT PRIMARY KEY,
    from_account_id INT,
    to_account_id INT,
    amount NUMBER(15,2) NOT NULL,
    transfer_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_transfer_from FOREIGN KEY (from_account_id) REFERENCES ACCOUNTS(account_id),
    CONSTRAINT fk_transfer_to FOREIGN KEY (to_account_id) REFERENCES ACCOUNTS(account_id)
);

CREATE TABLE LOANS (
    loan_id INT PRIMARY KEY,
    client_id INT,
    loan_amount NUMBER(15,2) NOT NULL,
    interest_rate NUMBER(5,2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CONSTRAINT fk_loan_client FOREIGN KEY (client_id) REFERENCES CLIENTS(client_id)
);

CREATE TABLE PAYMENTS (
    payment_id INT PRIMARY KEY,
    loan_id INT,
    payment_amount NUMBER(15,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_payment_loan FOREIGN KEY (loan_id) REFERENCES LOANS(loan_id)
);

CREATE TABLE AUDIT_LOGS (
    audit_id INT PRIMARY KEY,
    table_name VARCHAR2(50) NOT NULL,
    operation_type VARCHAR2(10) NOT NULL,
    operation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL
);

CREATE TABLE USERS (
    user_id INT PRIMARY KEY,
    username VARCHAR2(50) UNIQUE NOT NULL,
    password_hash VARCHAR2(255) NOT NULL,
    role VARCHAR2(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ROLES (
    role_id INT PRIMARY KEY,
    role_name VARCHAR2(50) UNIQUE NOT NULL
);

CREATE TABLE PERMISSIONS (
    permission_id INT PRIMARY KEY,
    permission_name VARCHAR2(50) UNIQUE NOT NULL
);

CREATE TABLE LOGS (
    log_id INT PRIMARY KEY,
    user_id INT,
    action VARCHAR2(100) NOT NULL,
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_log_user FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE NOTIFICATIONS (
    notification_id INT PRIMARY KEY,
    user_id INT,
    message VARCHAR2(255) NOT NULL,
    is_read NUMBER(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_notification_user FOREIGN KEY (user_id) REFERENCES USERS(user_id)
);

CREATE TABLE ACCOUNT_TYPES (
    account_type_id INT PRIMARY KEY,
    account_type_name VARCHAR2(50) UNIQUE NOT NULL
);

CREATE TABLE HISTORY (
    history_id INT PRIMARY KEY,
    account_id INT,
    action VARCHAR2(100) NOT NULL,
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_history_account FOREIGN KEY (account_id) REFERENCES ACCOUNTS(account_id)
);

CREATE TABLE RECORDS (
    record_id INT PRIMARY KEY,
    client_id INT,
    record_type VARCHAR2(50) NOT NULL,
    description CLOB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_record_client FOREIGN KEY (client_id) REFERENCES CLIENTS(client_id)
);

CREATE TABLE REPORTS (
    report_id INT PRIMARY KEY,
    report_name VARCHAR2(100) NOT NULL,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

