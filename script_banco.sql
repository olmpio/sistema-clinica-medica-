-- ================================================================
-- SISTEMA DE GESTAO DE CLINICA MEDICA - MedData
-- Script Final Unificado (DROP -> CREATE -> INSERT)
-- ================================================================

-- ================================================================
-- 1) DROP TABLES (FILHAS -> PAIS)
-- ================================================================
DROP TABLE IF EXISTS pagamento;
DROP TABLE IF EXISTS receita_medicamento;
DROP TABLE IF EXISTS receita;
DROP TABLE IF EXISTS consulta_exame;
DROP TABLE IF EXISTS consulta;
DROP TABLE IF EXISTS medico;
DROP TABLE IF EXISTS paciente;
DROP TABLE IF EXISTS medicamento;
DROP TABLE IF EXISTS exame;
DROP TABLE IF EXISTS convenio;
DROP TABLE IF EXISTS especialidade;

-- ================================================================
-- 2) CREATE TABLES (PAIS -> FILHAS)
-- ================================================================
CREATE TABLE especialidade (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255)
);

CREATE TABLE convenio (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    numero_registro VARCHAR(50) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE exame (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(255),
    valor DECIMAL(10,2) NOT NULL CHECK (valor > 0)
);

CREATE TABLE medicamento (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(100),
    fabricante VARCHAR(100)
);

CREATE TABLE medico (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    id_especialidade INT NOT NULL,
    CONSTRAINT fk_medico_especialidade
        FOREIGN KEY (id_especialidade)
        REFERENCES especialidade(id)
        ON DELETE RESTRICT
);

CREATE TABLE paciente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    endereco VARCHAR(150),
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    id_convenio INT,
    CONSTRAINT fk_paciente_convenio
        FOREIGN KEY (id_convenio)
        REFERENCES convenio(id)
        ON DELETE SET NULL
);

CREATE TABLE consulta (
    id SERIAL PRIMARY KEY,
    data_consulta DATE NOT NULL,
    horario TIME NOT NULL,
    motivo VARCHAR(255),
    diagnostico VARCHAR(255),
    observacoes VARCHAR(500),
    status VARCHAR(30) NOT NULL DEFAULT 'Agendada',
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    CONSTRAINT fk_consulta_paciente
        FOREIGN KEY (id_paciente)
        REFERENCES paciente(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_consulta_medico
        FOREIGN KEY (id_medico)
        REFERENCES medico(id)
        ON DELETE RESTRICT
);

CREATE TABLE consulta_exame (
    id SERIAL PRIMARY KEY,
    id_consulta INT NOT NULL,
    id_exame INT NOT NULL,
    data_exame DATE,
    resultado VARCHAR(500),
    status VARCHAR(30) NOT NULL DEFAULT 'Pendente',
    CONSTRAINT fk_consulta_exame_consulta
        FOREIGN KEY (id_consulta)
        REFERENCES consulta(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_consulta_exame_exame
        FOREIGN KEY (id_exame)
        REFERENCES exame(id)
        ON DELETE RESTRICT,
    CONSTRAINT uq_consulta_exame UNIQUE (id_consulta, id_exame)
);

CREATE TABLE receita (
    id SERIAL PRIMARY KEY,
    id_consulta INT NOT NULL UNIQUE,
    data_receita DATE NOT NULL,
    instrucoes VARCHAR(500),
    CONSTRAINT fk_receita_consulta
        FOREIGN KEY (id_consulta)
        REFERENCES consulta(id)
        ON DELETE CASCADE
);

CREATE TABLE receita_medicamento (
    id SERIAL PRIMARY KEY,
    id_receita INT NOT NULL,
    id_medicamento INT NOT NULL,
    dosagem VARCHAR(50),
    frequencia VARCHAR(50),
    duracao VARCHAR(50),
    CONSTRAINT fk_receita_medicamento_receita
        FOREIGN KEY (id_receita)
        REFERENCES receita(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_receita_medicamento_medicamento
        FOREIGN KEY (id_medicamento)
        REFERENCES medicamento(id)
        ON DELETE RESTRICT,
    CONSTRAINT uq_receita_medicamento UNIQUE (id_receita, id_medicamento)
);

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

-- ================================================================
-- 3) INSERTS - TABELAS AUXILIARES / CATALOGO (minimo 3 cada)
-- ================================================================
INSERT INTO especialidade (nome, descricao) VALUES
('Cardiologia', 'Cuidados com o coracao e sistema circulatorio'),
('Dermatologia', 'Cuidados com a pele, cabelo e unhas'),
('Ortopedia', 'Cuidados com ossos, musculos e articulacoes'),
('Pediatria', 'Cuidados medicos infantis'),
('Ginecologia', 'Saude do sistema reprodutor feminino'),
('Neurologia', 'Cuidados com o sistema nervoso');

INSERT INTO convenio (nome, numero_registro, telefone, ativo) VALUES
('Unimed', 'UNI-0001', '(71) 3333-1111', TRUE),
('Bradesco Saude', 'BRA-0002', '(71) 3333-2222', TRUE),
('SulAmerica', 'SUL-0003', '(71) 3333-3333', TRUE),
('Amil', 'AMI-0004', '(71) 3333-4444', TRUE),
('Hapvida', 'HAP-0005', '(71) 3333-5555', FALSE);

INSERT INTO exame (nome, descricao, valor) VALUES
('Hemograma Completo', 'Exame de sangue geral', 60.00),
('Raio-X de Torax', 'Radiografia da regiao toracica', 120.00),
('Ultrassonografia Abdominal', 'Exame de imagem abdominal', 180.00),
('Eletrocardiograma', 'Avaliacao da atividade eletrica do coracao', 90.00),
('Ressonancia Magnetica', 'Exame de imagem detalhado', 650.00),
('Glicemia em Jejum', 'Exame de nivel de glicose no sangue', 35.00),
('Colonoscopia', 'Exame do intestino grosso', 400.00),
('Tomografia Computadorizada', 'Exame de imagem por raios-X', 500.00);

INSERT INTO medicamento (nome, principio_ativo, fabricante) VALUES
('Paracetamol', 'Paracetamol', 'EMS'),
('Amoxicilina', 'Amoxicilina Triidratada', 'Eurofarma'),
('Ibuprofeno', 'Ibuprofeno', 'Medley'),
('Omeprazol', 'Omeprazol', 'Neo Quimica'),
('Losartana', 'Losartana Potassica', 'EMS'),
('Metformina', 'Cloridrato de Metformina', 'Medquimica'),
('Dipirona', 'Dipirona Sodica', 'Hipolabor'),
('Loratadina', 'Loratadina', 'Cimed');

-- ================================================================
-- 4) INSERTS - TABELAS CORE (minimo 30 cada)
-- ================================================================
-- 30 medicos
INSERT INTO medico (nome, crm, telefone, email, ativo, id_especialidade)
SELECT
    'Dr(a). Medico ' || gs,
    'CRM/BA ' || LPAD(gs::text, 5, '0'),
    '(75) 9' || LPAD((10000000 + gs)::text, 8, '0'),
    'medico' || gs || '@meddata.com',
    TRUE,
    ((gs - 1) % 6) + 1
FROM generate_series(1, 30) AS gs;

-- 30 pacientes
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

-- 40 consultas
INSERT INTO consulta (data_consulta, horario, motivo, diagnostico, observacoes, status, id_paciente, id_medico)
SELECT
    CURRENT_DATE - (gs || ' days')::interval,
    (TIME '08:00' + ((gs % 8) || ' hours')::interval),
    'Consulta de rotina ' || gs,
    CASE WHEN gs % 4 = 0 THEN NULL ELSE 'Diagnostico ' || gs END,
    'Observacoes da consulta ' || gs,
    CASE (gs % 3)
        WHEN 0 THEN 'Realizada'
        WHEN 1 THEN 'Agendada'
        ELSE 'Cancelada'
    END,
    ((gs - 1) % 30) + 1,
    ((gs - 1) % 30) + 1
FROM generate_series(1, 40) AS gs;

-- 35 consulta_exame
INSERT INTO consulta_exame (id_consulta, id_exame, data_exame, resultado, status)
SELECT
    gs,
    ((gs - 1) % 8) + 1,
    CURRENT_DATE - ((gs % 20) || ' days')::interval,
    'Resultado do exame referente a consulta ' || gs,
    CASE WHEN gs % 2 = 0 THEN 'Concluido' ELSE 'Pendente' END
FROM generate_series(1, 35) AS gs;

-- 30 receitas
INSERT INTO receita (id_consulta, data_receita, instrucoes)
SELECT
    gs,
    CURRENT_DATE - (gs || ' days')::interval,
    'Tomar conforme prescricao medica - receita ' || gs
FROM generate_series(1, 30) AS gs;

-- 30 receita_medicamento
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

-- 30 pagamentos
INSERT INTO pagamento (id_consulta, valor, data_pagamento, forma_pagamento, status)
SELECT
    gs + 5,
    (80 + (gs % 10) * 15)::numeric(10,2),
    CURRENT_DATE - (gs || ' days')::interval,
    CASE (gs % 4)
        WHEN 0 THEN 'Dinheiro'
        WHEN 1 THEN 'Cartao de Credito'
        WHEN 2 THEN 'Cartao de Debito'
        ELSE 'Pix'
    END,
    CASE WHEN gs % 5 = 0 THEN 'Pendente' ELSE 'Pago' END
FROM generate_series(1, 30) AS gs;
