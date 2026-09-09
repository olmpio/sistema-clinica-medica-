INSERT INTO consulta (data_consulta, horario, motivo, diagnostico, observacoes, status, id_paciente, id_medico)
SELECT 
    CURRENT_DATE - (gs || ' days')::interval,
    TIME '08:00:00' + (gs || ' hours')::interval,
    'Consulta de rotina ' || gs,
    'Avaliação concluída ' || gs,
    'Sem alterações graves',
    'Concluída',
    gs,
    gs
FROM generate_series(1, 30) AS gs;
