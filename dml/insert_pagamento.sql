INSERT INTO pagamento (valor, data_pagamento, forma_pagamento, status, id_consulta)
SELECT 
    150.00 + (gs * 5),
    CURRENT_DATE - (gs || ' days')::interval,
    CASE (gs % 3) 
        WHEN 0 THEN 'Cartão de Crédito'
        WHEN 1 THEN 'Pix'
        ELSE 'Dinheiro'
    END,
    'Pago',
    gs
FROM generate_series(1, 30) AS gs;
