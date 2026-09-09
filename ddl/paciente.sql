CREATE TABLE paciente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    endereco VARCHAR(150),
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    id_convenio INT,
    CONSTRAINT fk_paciente_convenio
        FOREIGN KEY (id_convenio)
        REFERENCES convenio(id)
        ON DELETE SET NULL
);
