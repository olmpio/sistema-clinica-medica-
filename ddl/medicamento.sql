CREATE TABLE medicamento (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(100),
    fabricante VARCHAR(100)
);
