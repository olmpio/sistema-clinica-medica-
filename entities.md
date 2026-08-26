# Modelagem de Banco de Dados — MedSys

## 1. Entidades

Serão usadas essas entidades 

1. **Paciente** — armazena os dados dos pacientes da clínica.
2. **Médico** — armazena os dados dos médicos que trabalham na clínica.
3. **Especialidade** — representa as especialidades médicas dos profissionais.
4. **Consulta** — registra os atendimentos realizados ou agendados.
5. **Exame** — armazena os tipos de exames disponíveis na clínica.
6. **Consulta_Exame** — relaciona as consultas aos exames solicitados.
7. **Receita** — registra as receitas emitidas pelos médicos.
8. **Medicamento** — armazena os medicamentos que podem ser prescritos.
9. **Receita_Medicamento** — relaciona as receitas aos medicamentos prescritos.
10. **Convênio** — armazena os convênios aceitos pela clínica.
11. **Pagamento** — registra os pagamentos relacionados às consultas.

As entidades foram definidas de acordo com as principais atividades realizadas internamente em uma clínica médica.

---

## 2. Justificativa do domínio

O domínio escolhido foi um **Sistema de Gestão Interna de Clínica Médica**, com o objetivo de organizar e centralizar as informações utilizadas no funcionamento da clínica.

O sistema permitirá o gerenciamento de pacientes, médicos, especialidades, consultas, exames, receitas, medicamentos, convênios e pagamentos.

A escolha desse domínio possibilita trabalhar diferentes tipos de relacionamentos e aplicar conceitos de modelagem de banco de dados e seus relacionamentos.

---

## 3. Atributos das Entidades

Aqui estão os  principais atributos de cada entidade, que será implementado no SQL.

( NÂO FOI ADICIONADO AINDA AS FK, como solicitado na atividade )

### Paciente

- `id`
- `nome`
- `cpf`
- `data_nascimento`
- `telefone`
- `email`
- `endereco`
- `ativo`

### Médico

- `id`
- `nome`
- `crm`
- `telefone`
- `email`
- `ativo`

### Especialidade

- `id`
- `nome`
- `descricao`

### Consulta

- `id`
- `data`
- `horario`
- `motivo`
- `diagnostico`
- `observacoes`
- `status`

### Exame

- `id`
- `nome`
- `descricao`
- `valor`

### Consulta_Exame

- `id`
- `data_exame`
- `resultado`
- `status`

### Receita

- `id`
- `data_receita`
- `instrucoes`

### Medicamento

- `id`
- `nome`
- `principio_ativo`
- `fabricante`

### Receita_Medicamento

- `id`
- `dosagem`
- `frequencia`
- `duracao`

### Convênio

- `id`
- `nome`
- `numero_registro`
- `telefone`
- `ativo`

### Pagamento

- `id`
- `valor`
- `data_pagamento`
- `forma_pagamento`
- `status`


## Relacionamentos

Os principais relacionamentos previstos para o sistema são:

* **Especialidade** `1 ─── N` **Médico**
* **Paciente** `1 ─── N` **Consulta**
* **Médico** `1 ─── N` **Consulta**
* **Consulta** `N ─── N` **Exame**
* **Consulta** `1 ─── 0..1` **Receita**
* **Receita** `N ─── N` **Medicamento**
* **Convênio** `1 ─── N` **Paciente**
* **Consulta** `1 ─── 0..1` **Pagamento**

> **Nota:** Nesta etapa, os relacionamentos são definidos apenas conceitualmente. As *Foreign Keys* (chaves estrangeiras) serão adicionadas posteriormente, conforme a evolução da modelagem lógica.


