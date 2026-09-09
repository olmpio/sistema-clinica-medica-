INSERT INTO receita_medicamento (dosagem, frequencia, duracao, id_receita, id_medicamento)
SELECT 
    '500mg',
    'A cada 8 horas',
    '7 dias',
    gs,
    (gs % 3) + 1
FROM generate_series(1, 30) AS gs;
