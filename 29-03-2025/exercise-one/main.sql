-- Questão 1 (1 ponto) – Desenvolva o código SQL da criação do banco de dados
-- “maternidade” de acordo com a estrutura abaixo (utilize os nomes e domínio dos atributos
-- conforme especificado no esquema abaixo, sendo que, todas as chaves primárias são do
-- tipo INT AUTO_INCREMENT. Deve conter a instrução de criação do esquema e para tornar
-- o esquema padrão para a execução do código.
CREATE SCHEMA Maternidade;
SELECT schema_name FROM information_schema.schemata;
SET search_path TO Maternidade;

CREATE TABLE Cidade (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL
);

CREATE TABLE Mae (
    id SERIAL PRIMARY KEY,
    id_cidade INT REFERENCES Cidade(id) ON DELETE SET NULL,
    nome VARCHAR(100) NOT NULL,
    celular VARCHAR(15)
);

CREATE TABLE Medico (
    id SERIAL PRIMARY KEY,
    crm VARCHAR(10) NOT NULL UNIQUE,
    id_cidade INT REFERENCES Cidade(id) ON DELETE SET NULL,
    nome VARCHAR(100) NOT NULL,
    celular VARCHAR(15),
    salario DECIMAL(10,2),
    status SMALLINT NOT NULL
);

CREATE TABLE Nascimento (
    id SERIAL PRIMARY KEY,
    id_mae INT REFERENCES Mae(id) ON DELETE CASCADE,
    id_medico INT REFERENCES Medico(id) ON DELETE SET NULL,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    peso DECIMAL(5,3),
    altura SMALLINT
);

CREATE TABLE Agendamento (
    id SERIAL PRIMARY KEY,
    id_nascimento INT REFERENCES Nascimento(id) ON DELETE CASCADE,
    inicio TIMESTAMP NOT NULL,
    fim TIMESTAMP NOT NULL
);

---------------------------------------------------------------------------------------------------

--Questão 2 (1 ponto) – Simule a inserção de, no mínimo, 5 registros em cada tabela do
-- banco de dados criado na Questão 1.
INSERT INTO cidade (nome, uf) VALUES 
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ'),
('Belo Horizonte', 'MG'),
('Curitiba', 'PR'),
('Santa Catarina', 'SC');

INSERT INTO mae (id_cidade, nome, celular) VALUES 
(1, 'Ana Souza', '11987654321'),
(2, 'Mariana Lima', '21987654321'),
(3, 'Clara Mendes', '31987654321'),
(4, 'Juliana Rocha', '41987654321'),
(5, 'Patrícia Almeida', '51987654321');

INSERT INTO medico (crm, id_cidade, nome, celular, salario, status) VALUES 
('12345-SP', 1, 'Dr. João', '11912345678', 15000.00, 1),
('67890-RJ', 2, 'Dra. Carla', '21912345678', 18000.00, 1),
('11223-MG', 3, 'Dr. Pedro', '31912345678', 17000.00, 1),
('44556-PR', 4, 'Dra. Fernanda', '41912345678', 16000.00, 1),
('77889-BA', 5, 'Dr. Roberto', '51912345678', 15500.00, 1);

INSERT INTO nascimento (id_mae, id_medico, nome, data_nascimento, peso, altura) VALUES 
(1, 1, 'Lucas Souza', '2025-01-10', 3.2, 50),
(2, 2, 'Beatriz Lima', '2025-02-15', 3.1, 48),
(3, 3, 'Fernando Mendes', '2025-03-20', 3.4, 51),
(4, 4, 'Gabriela Rocha', '2025-04-05', 3.3, 49),
(5, 5, 'Ricardo Almeida', '2025-05-10', 3.25, 50);

INSERT INTO agendamento (id_nascimento, inicio, fim) VALUES 
(1, '2025-06-01 10:00:00', '2025-06-01 11:00:00'),
(2, '2025-06-02 14:00:00', '2025-06-02 15:00:00'),
(3, '2025-06-03 09:00:00', '2025-06-03 10:00:00'),
(4, '2025-06-04 16:00:00', '2025-06-04 17:00:00'),
(5, '2025-06-05 11:00:00', '2025-06-05 12:00:00');

---------------------------------------------------------------------------------------------------

-- Questão 3 – De acordo com o banco de dados criado na Questão 1, faça os seguintes
-- procedimentos armazenados:
-- 1. (1 ponto) Crie um procedimento armazenado, utilizando a linguagem SQL, que
-- receba por parâmetro o mês (inteiro) e o ano (inteiro), e retorne a quantidade de
-- nascimentos no período por médico, e o nome do médico. Ordenar por quantidade
-- (decrescente) e por nome (alfabética). Apresente uma instrução para o teste do
-- procedimento armazenado. Insira dados necessários para o teste do procedimento
CREATE OR REPLACE FUNCTION nascimentos_por_medico(
    p_mes INT,
    p_ano INT
) 
RETURNS TABLE (
    nome_medico VARCHAR(100),
    quantidade_nascimentos INT
) 
AS $$
    SELECT 
        m.nome AS nome_medico,
        COUNT(n.id)::INT AS quantidade_nascimentos
    FROM nascimento n
    JOIN medico m ON n.id_medico = m.id
    WHERE EXTRACT(MONTH FROM n.data_nascimento) = p_mes
    AND EXTRACT(YEAR FROM n.data_nascimento) = p_ano
    GROUP BY m.nome
    ORDER BY quantidade_nascimentos DESC, nome_medico ASC;
$$ LANGUAGE sql;

SELECT * FROM nascimentos_por_medico(3, 2025); -- Dr. Pedro | 1
SELECT * FROM nascimentos_por_medico(3, 2022); -- Nenhum registro

---------------------------------------------------------------------------------------------------

-- 2. (1 ponto) Crie um procedimento armazenado, utilizando a linguagem PL/pgSQL,
-- que receba por parâmetro os dados do bebê, e insira um registro na tabela
-- “nascimento”. Faça uma validação, antes de inserir, para lançar uma exceção
-- caso o ID da mãe não exista; e caso o CRM do médico informado não exista ou
-- esteja inativo. Apresente uma instrução para o teste do procedimento armazenado.
-- Insira dados necessários para o teste do procedimento.
CREATE OR REPLACE FUNCTION inserir_nascimento(
    p_id_mae INT,
    p_crm_medico VARCHAR(10),
    p_nome_bebe VARCHAR(100),
    p_data_nascimento DATE,
    p_peso DECIMAL(5,3),
    p_altura SMALLINT
) RETURNS VOID AS $$
DECLARE
    v_id_medico INT;
    v_mae_existente INT;
    v_medico_existente INT;
BEGIN
    SELECT COUNT(*) INTO v_mae_existente 
	FROM mae 
	WHERE id = p_id_mae;
    IF v_mae_existente = 0 THEN
        RAISE EXCEPTION 'Erro: O ID da mãe % não existe.', p_id_mae;
    END IF;

    SELECT id INTO v_id_medico 
	FROM medico 
	WHERE crm = p_crm_medico 
	AND status = 1;
    IF v_id_medico IS NULL THEN
        RAISE EXCEPTION 'Erro: O CRM % não existe ou o médico está inativo.', p_crm_medico;
    END IF;

    INSERT INTO nascimento (id_mae, id_medico, nome, data_nascimento, peso, altura)
    VALUES (p_id_mae, v_id_medico, p_nome_bebe, p_data_nascimento, p_peso, p_altura);
END;
$$ LANGUAGE plpgsql;

-- OBS: Adicionei CAST porque ele identificava como desconhecido.
-- O bebê deve ser inserido sem nenhum problema.
SELECT inserir_nascimento(
    1, 
    CAST('12345-SP' AS VARCHAR),
    CAST('Daniel Alves' AS VARCHAR),
    CAST('2025-03-10' AS DATE),
    CAST(3.2 AS DECIMAL(5,3)),
    CAST(50 AS SMALLINT)
);
-- O bebê "Daniel Alves" deve estar presente na tabela.
SELECT * FROM Nascimento;

-- O bebê não deve ser inserido porque a mãe não existe.
SELECT inserir_nascimento(
    999, -- ID não existente.
    CAST('12345-SP' AS VARCHAR),
    CAST('Daniel Alves' AS VARCHAR),
    CAST('2025-03-10' AS DATE),
    CAST(3.2 AS DECIMAL(5,3)),
    CAST(50 AS SMALLINT)
);

-- O bebê não deve ser inserido porque o médico tem um CRM que não existe.
SELECT inserir_nascimento(
    1, 
    CAST('99999-SP' AS VARCHAR), -- CRM não existente.
    CAST('Daniel Alves' AS VARCHAR),
    CAST('2025-03-10' AS DATE),
    CAST(3.2 AS DECIMAL(5,3)),
    CAST(50 AS SMALLINT)
);

-- Insere um médico com status inativo para testar.
INSERT INTO medico (crm, id_cidade, nome, celular, salario, status) VALUES
('12345-SC', 2, 'Dr. Felipe', '21912345678', 18000.00, 0);

-- O bebê não deve ser inserido porque o médico está com o status de inativo.
SELECT inserir_nascimento(
    1, 
    CAST('12345-SC' AS VARCHAR), -- CRM não existente.
    CAST('Daniel Alves' AS VARCHAR),
    CAST('2025-03-10' AS DATE),
    CAST(3.2 AS DECIMAL(5,3)),
    CAST(50 AS SMALLINT)
);

---------------------------------------------------------------------------------------------------

-- 3. (2 pontos) Crie um procedimento armazenado, utilizando a linguagem PL/pgSQL,
-- que receba por parâmetro o CRM do médico, o mês (inteiro) e o ano (inteiro), e
-- retorne o valor do salário líquido. O salário do médico é composto pelo salário fixo
-- do médico mais R$ 3.500,00 por nascimento realizado no período. Caso o
-- nascimento tenha sido em uma cidade (considerar a cidade da mãe) diferente da
-- cidade que o médico mora, há um custo de R$ 1.000,00 de descolamento por
-- nascimento. Faça uma validação para lançar uma exceção caso o CRM do
-- médico informado não exista ou esteja inativo. Apresente uma instrução para o
-- teste do procedimento armazenado. Insira dados necessários para o teste do
-- procedimento.
CREATE OR REPLACE FUNCTION calcular_salario_liquido(
    p_crm_medico VARCHAR(10),
    p_mes INT,
    p_ano INT
) RETURNS DECIMAL(10,2) AS $$
DECLARE
    v_id_medico INT;
    v_salario_fixo DECIMAL(10,2);
    v_nascimentos INT;
    v_deslocamentos INT;
    v_salario_liquido DECIMAL(10,2);
BEGIN
    SELECT id, salario INTO v_id_medico, v_salario_fixo 
    FROM medico 
    WHERE crm = p_crm_medico AND status = 1;

    IF v_id_medico IS NULL THEN
        RAISE EXCEPTION 'Erro: O CRM % não existe ou o médico está inativo.', p_crm_medico;
    END IF;

    SELECT COUNT(*) INTO v_nascimentos 
    FROM nascimento n
    WHERE n.id_medico = v_id_medico 
    AND EXTRACT(MONTH FROM n.data_nascimento) = p_mes
    AND EXTRACT(YEAR FROM n.data_nascimento) = p_ano;

    SELECT COUNT(*) INTO v_deslocamentos
    FROM nascimento n
    JOIN mae m ON n.id_mae = m.id
    JOIN medico med ON n.id_medico = med.id
    WHERE n.id_medico = v_id_medico
    AND EXTRACT(MONTH FROM n.data_nascimento) = p_mes
    AND EXTRACT(YEAR FROM n.data_nascimento) = p_ano
    AND m.id_cidade <> med.id_cidade;

    v_salario_liquido = v_salario_fixo + (v_nascimentos * 3500) - (v_deslocamentos * 1000);

    RETURN v_salario_liquido;
END;
$$ LANGUAGE plpgsql;

SELECT calcular_salario_liquido('12345-SP', 3, 2025); -- 22.000
SELECT calcular_salario_liquido('99999-SP', 3, 2025); -- Médico inativo

INSERT INTO nascimento (id_mae, id_medico, nome, data_nascimento, peso, altura) VALUES 
(1, 5, 'Ricardo Ferreira', '2025-03-05', 3.2, 50), -- Mesmo local do médico
(2, 5, 'Maria Luiza', '2025-03-10', 3.1, 48); -- Médico viajou
SELECT calcular_salario_liquido('77889-BA', 3, 2025); -- 20.500

---------------------------------------------------------------------------------------------------

-- Questão 4 – De acordo com o banco de dados criado na Questão 1, efetue a criação dos
-- seguintes gatilhos:

-- 1. (1 ponto) Crie uma função de gatilho que, ao inserir um registro na tabela
-- “nascimento”, valide se o médico está ativo. Caso estiver inativo lançar uma
-- mensagem de exceção: “médico inativo”. Apresente uma instrução para o teste
-- do gatilho. Insira dados necessários para o teste do gatilho.
CREATE OR REPLACE FUNCTION verificar_medico_ativo()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT status FROM Medico WHERE id = NEW.id_medico) <> 1 THEN
        RAISE EXCEPTION 'Médico inativo';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_verificar_medico_ativo
BEFORE INSERT ON Nascimento
FOR EACH ROW
EXECUTE FUNCTION verificar_medico_ativo();

-- Tentar inserir um nascimento com o médico inativo
INSERT INTO nascimento (id_mae, id_medico, nome, data_nascimento, peso, altura) 
VALUES (1, 6, 'Rosane da Silva', '2025-03-29', 3.0, 50); -- Médico inativo

-- Tentar inserir um nascimento com o médico ativo
INSERT INTO nascimento (id_mae, id_medico, nome, data_nascimento, peso, altura) 
VALUES (1, 1, 'Rosane da Silva', '2025-03-29', 3.0, 50); -- Sucesso
SELECT * FROM Nascimento; -- Rosane da Silva é encontrada na tabela.

---------------------------------------------------------------------------------------------------

-- 2. (1 ponto) Crie uma função de gatilho para não permitir valor nulo nas colunas nome,
-- data_nascimento, peso e altura da tabela “nascimento”, ao atualizar um registro.
-- Deve-se lançar uma exceção customizada para cada coluna. Apresente uma
-- instrução para o teste do gatilho. Insira dados necessários para o teste do gatilho.
CREATE OR REPLACE FUNCTION validar_nascimento_nao_nulo()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.nome IS NULL THEN
        RAISE EXCEPTION 'O nome do recém-nascido não pode ser nulo.';
    END IF;
	
    IF NEW.data_nascimento IS NULL THEN
        RAISE EXCEPTION 'A data de nascimento não pode ser nula.';
    END IF;
	
    IF NEW.peso IS NULL THEN
        RAISE EXCEPTION 'O peso do recém-nascido não pode ser nulo.';
    END IF;
	
    IF NEW.altura IS NULL THEN
        RAISE EXCEPTION 'A altura do recém-nascido não pode ser nula.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_nascimento_nao_nulo
BEFORE UPDATE ON Nascimento
FOR EACH ROW
EXECUTE FUNCTION validar_nascimento_nao_nulo();

-- Inseri um último registro pra facilitar nos tests, ai era só pegar o último que foi criado.
INSERT INTO nascimento (id_mae, id_medico, nome, data_nascimento, peso, altura) 
VALUES (1, 1, 'Francisco Araldi', '2025-03-29', 3.2, 50);

-- Tentar atualizar com valores nulos
UPDATE nascimento 
SET nome = NULL 
WHERE id = (SELECT MAX(id) FROM nascimento); -- Erro "O nome do recém-nascido não pode ser nulo."

UPDATE nascimento 
SET data_nascimento = NULL 
WHERE id = (SELECT MAX(id) FROM nascimento); -- Erro "A data de nascimento não pode ser nula."

UPDATE nascimento 
SET peso = NULL 
WHERE id = (SELECT MAX(id) FROM nascimento); -- Erro "O peso do recém-nascido não pode ser nulo."

UPDATE nascimento 
SET altura = NULL 
WHERE id = (SELECT MAX(id) FROM nascimento); -- Erro "A altura do recém-nascido não pode ser nula."

---------------------------------------------------------------------------------------------------

-- 3. (2 pontos) Crie uma função de gatilho para não permitir agendamentos fora do
-- expediente do hospital. Lance uma mensagem de exceção. Leve em
-- consideração as seguintes regras de negócio:
-- a. Expediente: 08:00 até 12:00; 13:30 até 17:30;
-- b. Não há expediente no sábado e no domingo;
-- c. Não é permitido que um agendamento ultrapasse o horário do expediente
-- (exemplo: o agendamento que inicia às 11:50 e finaliza às 12:10 não é válido).
-- Apresente mensagem de acordo com a restrição de horário identificada.
-- Apresente uma instrução para o teste do gatilho. Insira dados necessários para o
-- teste do procedimento.

-- OBS: Tive que adicionar o CAST de novo
CREATE OR REPLACE FUNCTION validar_horario_agendamento()
RETURNS TRIGGER AS $$
DECLARE
    inicio_hora TIME = CAST(NEW.inicio AS TIME);
    fim_hora TIME = CAST(NEW.fim AS TIME);
    dia_semana INT = EXTRACT(DOW FROM NEW.inicio);
BEGIN
    IF dia_semana = 0 OR dia_semana = 6 THEN
        RAISE EXCEPTION 'Não há expediente no sábado e no domingo.';
    END IF;
	
    IF NOT (
        (inicio_hora >= '08:00' AND fim_hora <= '12:00') OR
        (inicio_hora >= '13:30' AND fim_hora <= '17:30')
    ) THEN
        RAISE EXCEPTION 'Agendamento fora do horário permitido.';
    END IF;

    IF (inicio_hora < '12:00' AND fim_hora > '12:00') OR
       (inicio_hora < '17:30' AND fim_hora > '17:30') THEN
        RAISE EXCEPTION 'O agendamento não pode ultrapassar o horário do expediente.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_validar_horario_agendamento
BEFORE INSERT OR UPDATE ON Agendamento
FOR EACH ROW
EXECUTE FUNCTION validar_horario_agendamento();

INSERT INTO agendamento (id_nascimento, inicio, fim) 
VALUES (1, '2025-03-28 08:30:00', '2025-03-28 09:30:00'); -- Adiciona um agendamento válido.
SELECT * FROM Agendamento; -- Deve parecer na tabela.

-- Agendamento no sábado (deve falhar)
INSERT INTO agendamento (id_nascimento, inicio, fim) 
VALUES (2, '2025-03-29 10:00:00', '2025-03-29 11:00:00'); -- Não deve adicionar, pois dia 29/03/2025 é sábado.
SELECT * FROM Agendamento; -- Não deve parecer na tabela.

-- Agendamento no domingo (deve falhar)
INSERT INTO agendamento (id_nascimento, inicio, fim) 
VALUES (3, '2025-03-30 14:00:00', '2025-03-30 15:00:00'); -- Não deve adicionar, pois dia 30/03/2025 é domingo.
SELECT * FROM Agendamento; -- Não deve parecer na tabela.

-- Agendamento ultrapassando o horário do almoço (deve falhar)
INSERT INTO agendamento (id_nascimento, inicio, fim)
VALUES (4, '2025-03-28 11:50:00', '2025-03-28 12:10:00'); -- Não deve adicionar porque é no horário do almoço.
SELECT * FROM Agendamento; -- Não deve parecer na tabela.

-- Agendamento ultrapassando o final do expediente (deve falhar)
INSERT INTO agendamento (id_nascimento, inicio, fim) 
VALUES (5, '2025-03-28 16:50:00', '2025-03-28 17:40:00'); -- Não deve adicionar porque é fora do expediente.
SELECT * FROM Agendamento; -- Não deve parecer na tabela.
