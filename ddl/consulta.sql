CREATE TABLE consulta (
    id SERIAL PRIMARY KEY,
    data_consulta DATE NOT NULL,
    horario TIME NOT NULL,
    motivo VARCHAR(255),
    diagnostico VARCHAR(255),
    observacoes VARCHAR(500),
    status VARCHAR(30) NOT NULL DEFAULT 'Agendada',
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    CONSTRAINT fk_consulta_paciente
        FOREIGN KEY (id_paciente)
        REFERENCES paciente(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_consulta_medico
        FOREIGN KEY (id_medico)
        REFERENCES medico(id)
        ON DELETE RESTRICT
);
