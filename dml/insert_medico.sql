INSERT INTO medico (nome, crm, telefone, email, id_especialidade)
SELECT 
    'Dr. Médico ' || gs,
    'CRM-BA ' || LPAD(gs::text, 5, '0'),
    '(75) 999' || LPAD(gs::text, 5, '0'),
    'medico' || gs || '@meddata.com',
    (gs % 3) + 1
FROM generate_series(1, 30) AS gs;
