CREATE TABLE medico (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    id_especialidade INT NOT NULL,
    CONSTRAINT fk_medico_especialidade
        FOREIGN KEY (id_especialidade)
        REFERENCES especialidade(id)
        ON DELETE RESTRICT
);
