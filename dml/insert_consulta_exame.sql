INSERT INTO consulta_exame (data_exame, resultado, status, id_consulta, id_exame)
SELECT 
    CURRENT_DATE - (gs || ' days')::interval,
    'Resultado normal para o parâmetro ' || gs,
    'Finalizado',
    gs,
    (gs % 3) + 1
FROM generate_series(1, 30) AS gs;
