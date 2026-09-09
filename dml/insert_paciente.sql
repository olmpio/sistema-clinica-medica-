INSERT INTO paciente (nome, cpf, data_nascimento, telefone, email, endereco, ativo, id_convenio)
SELECT
    'Paciente ' || gs,
    '000.' || LPAD(gs::text, 3, '0') || '.000-' || LPAD((gs % 100)::text, 2, '0'),
    DATE '1960-01-01' + (gs * 200 || ' days')::interval,
    '(75) 9' || LPAD((20000000 + gs)::text, 8, '0'),
    'paciente' || gs || '@email.com',
    'Rua ' || gs || ', Feira de Santana - BA',
    TRUE,
    CASE WHEN gs % 5 = 0 THEN NULL ELSE ((gs - 1) % 5) + 1 END
FROM generate_series(1, 30) AS gs;
