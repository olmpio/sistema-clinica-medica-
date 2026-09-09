CREATE TABLE receita (
    id SERIAL PRIMARY KEY,
    id_consulta INT NOT NULL UNIQUE,
    data_receita DATE NOT NULL,
    instrucoes VARCHAR(500),
    CONSTRAINT fk_receita_consulta
        FOREIGN KEY (id_consulta)
        REFERENCES consulta(id)
        ON DELETE CASCADE
);
