INSERT INTO receita (data_receita, instrucoes, id_consulta)
SELECT 
    CURRENT_DATE - (gs || ' days')::interval,
    'Tomar medicamentos conforme horários indicados ' || gs,
    gs
FROM generate_series(1, 30) AS gs;
