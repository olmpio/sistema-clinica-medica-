CREATE TABLE convenio (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    numero_registro VARCHAR(50) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);
