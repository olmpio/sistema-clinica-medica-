INSERT INTO receita_medicamento (id_receita, id_medicamento, dosagem, frequencia, duracao)
SELECT
    gs,
    ((gs - 1) % 8) + 1,
    (10 + (gs % 5) * 10) || 'mg',
    CASE (gs % 3)
        WHEN 0 THEN '8/8h'
        WHEN 1 THEN '12/12h'
        ELSE '1x ao dia'
    END,
    (5 + (gs % 10)) || ' dias'
FROM generate_series(1, 30) AS gs;
