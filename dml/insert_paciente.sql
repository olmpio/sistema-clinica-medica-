INSERT INTO paciente (nome, cpf, data_nascimento, telefone, email, endereco, id_convenio)
SELECT 
    'Paciente ' || gs,
    LPAD(gs::text, 11, '0'),
    DATE '1980-01-01' + (gs || ' days')::interval,
    '(75) 988' || LPAD(gs::text, 5, '0'),
    'paciente' || gs || '@meddata.com',
    'Rua das Flores, ' || gs,
    (gs % 3) + 1
FROM generate_series(1, 30) AS gs;
