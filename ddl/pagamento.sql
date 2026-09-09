CREATE TABLE pagamento (
    id SERIAL PRIMARY KEY,
    id_consulta INT NOT NULL UNIQUE,
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
    data_pagamento DATE NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'Pendente',
    CONSTRAINT fk_pagamento_consulta
        FOREIGN KEY (id_consulta)
        REFERENCES consulta(id)
        ON DELETE CASCADE
);
