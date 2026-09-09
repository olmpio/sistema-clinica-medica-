🩺 Sistema de Gestão de Clínica Médica - MedData

Status: 🚀 Em Desenvolvimento (Etapa DDL & DML Concluída)

❇️ Projeto acadêmico de Banco de Dados SQL para gerenciamento de uma clínica médica.

✍️ Sobre

O sistema permite gerenciar pacientes, médicos, especialidades, consultas, exames, receitas, medicamentos e pagamentos.

🛠️ Tecnologias 

- PostgreSQL
- SQL
- DBeaver
- GitHub

📚 Conceitos

Chaves primárias (PK), Chaves estrangeiras (FK), Relacionamentos, Normalização, JOINs, Views, Triggers e Procedures.

👥 Equipe

| Nome |
|----------------------------------------|
| 1- Pedro Olímpio Arantes Freire Brandão |
| 2- Gabriel de Oliveira de Assis |
| 3- Eduardo Almeida |

📂 Estrutura do Repositório

- `/ddl`: Scripts de criação das tabelas e relacionamentos (`CREATE TABLE`).
- `/dml`: Scripts de povoamento e carga de dados (`INSERT`).
- `script_banco.sql`: Script unificado completo (`DROP` → `CREATE` → `INSERT`) para execução sequencial.

---

# Modelagem de Banco de Dados — MedData

## 1. Entidades

1. **Paciente** — armazena os dados dos pacientes da clínica.
2. **Médico** — armazena os dados dos médicos que trabalham na clínica.
3. **Especialidade** — representa as especialidades médicas dos profissionais.
4. **Consulta** — registra os atendimentos realizados ou agendados.
5. **Exame** — armazena os tipos de exames disponíveis na clínica.
6. **Consulta_Exame** — relaciona as consultas aos exames solicitados (associativa).
7. **Receita** — registra as receitas emitidas pelos médicos.
8. **Medicamento** — armazena os medicamentos que podem ser prescritos.
9. **Receita_Medicamento** — relaciona as receitas aos medicamentos prescritos (associativa).
10. **Convênio** — armazena os convênios aceitos pela clínica.
11. **Pagamento** — registra os pagamentos relacionados às consultas.

---

## 2. Justificativa do domínio

O domínio escolhido foi um **Sistema de Gestão Interna de Clínica Médica**, com o objetivo de organizar e centralizar as informações utilizadas no funcionamento da clínica.

O sistema permitirá o gerenciamento de pacientes, médicos, especialidades, consultas, exames, receitas, medicamentos, convênios e pagamentos.

A escolha desse domínio possibilita trabalhar diferentes tipos de relacionamentos e aplicar conceitos de modelagem de banco de dados e seus relacionamentos.

---

## 3. Atributos das Entidades

### Convênio
- `id` (PK)
- `nome`
- `numero_registro` (UNIQUE)
- `telefone`
- `ativo`

### Especialidade
- `id` (PK)
- `nome` (UNIQUE)
- `descricao`

### Exame
- `id` (PK)
- `nome` (UNIQUE)
- `descricao`
- `valor`

### Medicamento
- `id` (PK)
- `nome`
- `principio_ativo`
- `fabricante`

### Paciente
- `id` (PK)
- `nome`
- `cpf` (UNIQUE)
- `data_nascimento`
- `telefone`
- `email` (UNIQUE)
- `endereco`
- `ativo`
- `id_convenio` (FK)

### Médico
- `id` (PK)
- `nome`
- `crm` (UNIQUE)
- `telefone`
- `email` (UNIQUE)
- `ativo`
- `id_especialidade` (FK)

### Consulta
- `id` (PK)
- `data_consulta`
- `horario`
- `motivo`
- `diagnostico`
- `observacoes`
- `status`
- `id_paciente` (FK)
- `id_medico` (FK)

### Consulta_Exame
- `id` (PK)
- `id_consulta` (FK)
- `id_exame` (FK)
- `data_exame`
- `resultado`
- `status`

### Receita
- `id` (PK)
- `id_consulta` (FK, UNIQUE)
- `data_receita`
- `instrucoes`

### Receita_Medicamento
- `id` (PK)
- `id_receita` (FK)
- `id_medicamento` (FK)
- `dosagem`
- `frequencia`
- `duracao`

### Pagamento
- `id` (PK)
- `id_consulta` (FK, UNIQUE)
- `valor`
- `data_pagamento`
- `forma_pagamento`
- `status`

---

## Relacionamentos

* **Convênio** `1 ─── N` **Paciente**
* **Especialidade** `1 ─── N` **Médico**
* **Paciente** `1 ─── N` **Consulta**
* **Médico** `1 ─── N` **Consulta**
* **Consulta** `N ─── N` **Exame** *(via Consulta_Exame)*
* **Consulta** `1 ─── 0..1` **Receita**
* **Receita** `N ─── N` **Medicamento** *(via Receita_Medicamento)*
* **Consulta** `1 ─── 0..1` **Pagamento**

> **Nota:** Todos os relacionamentos e restrições de integridade referencial (*Foreign Keys*) foram devidamente implementados via DDL com tratamento de ações de deleção (`ON DELETE RESTRICT`, `ON DELETE CASCADE` e `ON DELETE SET NULL`).
