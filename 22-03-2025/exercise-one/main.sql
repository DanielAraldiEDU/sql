SELECT schema_name FROM information_schema.schemata;
SHOW hospedar;
CREATE SCHEMA hospedar;
SET hospedar = hospedar;

-- Criação da tabela de Usuários
CREATE TYPE TIPO_USUARIO AS ENUM('Anfitrião', 'Hóspede');
CREATE TABLE Usuario (
 id SERIAL PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 email VARCHAR(100) NOT NULL UNIQUE,
 senha VARCHAR(100) NOT NULL,
 data_nascimento DATE NOT NULL,
 tipo_usuario TIPO_USUARIO NOT NULL,
 telefone VARCHAR(15)
);

-- Criação da tabela de Propriedades
CREATE TABLE Propriedade (
 id SERIAL PRIMARY KEY,
 nome VARCHAR(100) NOT NULL,
 endereco VARCHAR(255) NOT NULL,
 descricao TEXT,
 num_quartos INT NOT NULL,
 capacidade INT NOT NULL,
 preco_diaria DECIMAL(10, 2) NOT NULL,
 usuario_id INT NOT NULL,
 FOREIGN KEY (usuario_id) REFERENCES Usuario(id) ON UPDATE CASCADE ON
DELETE CASCADE
);

-- Criação da tabela de Reservas
CREATE TYPE STATUS_RESERVA AS ENUM('Pendente', 'Confirmada', 'Cancelada');
CREATE TABLE Reserva (
 id SERIAL PRIMARY KEY,
 data_inicio DATE NOT NULL,
 data_termino DATE NOT NULL,
 status STATUS_RESERVA NOT NULL,
 propriedade_id INT NOT NULL,
 usuario_id INT NOT NULL,
 FOREIGN KEY (propriedade_id) REFERENCES Propriedade(id) ON UPDATE
CASCADE ON DELETE CASCADE,
 FOREIGN KEY (usuario_id) REFERENCES Usuario(id) ON UPDATE CASCADE ON
DELETE CASCADE
);

-- Criação da tabela de Avaliações
CREATE TABLE Avaliacao (
 id SERIAL PRIMARY KEY,
 nota INT CHECK(nota BETWEEN 1 AND 5),
 comentario TEXT,
 usuario_id INT NOT NULL,
 propriedade_id INT NOT NULL,
 FOREIGN KEY (usuario_id) REFERENCES Usuario(id) ON UPDATE CASCADE ON
DELETE CASCADE,
 FOREIGN KEY (propriedade_id) REFERENCES Propriedade(id) ON UPDATE
CASCADE ON DELETE CASCADE
);

-- Criação da tabela de Mensagens
CREATE TABLE Mensagem (
 id SERIAL PRIMARY KEY,
 data_hora TIMESTAMP NOT NULL,
 conteudo TEXT NOT NULL,
 remetente_id INT NOT NULL,
 destinatario_id INT NOT NULL,
 FOREIGN KEY (remetente_id) REFERENCES Usuario(id) ON UPDATE CASCADE
ON DELETE CASCADE,
 FOREIGN KEY (destinatario_id) REFERENCES Usuario(id) ON UPDATE CASCADE
ON DELETE CASCADE
);

-- Populando a tabela de Usuários
INSERT INTO Usuario (nome, email, senha, data_nascimento, tipo_usuario, telefone) 
VALUES ('Ana Silva', 'ana.silva@example.com', 'senha123', '1990-01-01', 'Anfitrião', '1111111111'),
('Bruno Souza', 'bruno.souza@example.com', 'senha123', '1985-02-14', 'Hóspede', '2222222222'),
('Carlos Oliveira', 'carlos.oliveira@example.com', 'senha123', '1978-03-23', 'Anfitrião', '3333333333'),
('Daniela Lima', 'daniela.lima@example.com', 'senha123', '1995-04-04', 'Hóspede','4444444444'),
('Eduardo Santos', 'eduardo.santos@example.com', 'senha123', '1980-05-15', 'Anfitrião', '5555555555'),
('Fernanda Costa', 'fernanda.costa@example.com', 'senha123', '1992-06-30', 'Hóspede', '6666666666'),
('Gustavo Almeida', 'gustavo.almeida@example.com', 'senha123', '1987-07-21', 'Anfitrião', '7777777777'),
('Helena Rocha', 'helena.rocha@example.com', 'senha123', '1993-08-11', 'Hóspede', '8888888888'),
('Igor Ferreira', 'igor.ferreira@example.com', 'senha123', '1981-09-09', 'Anfitrião', '9999999999'),
('Juliana Mendes', 'juliana.mendes@example.com', 'senha123', '1989-10-10', 'Hóspede', '1010101010');

-- Populando a tabela de Propriedades
INSERT INTO Propriedade (nome, endereco, descricao, num_quartos, capacidade, preco_diaria, usuario_id) 
VALUES ('Casa de Praia', 'Rua A, 123, Praia', 'Casa confortável perto do mar', 3, 6, 500.00, 1),
('Apartamento Centro', 'Av. Central, 456, Centro', 'Apartamento moderno no centro da cidade', 2, 4, 300.00, 3),
('Sítio da Montanha', 'Estrada B, 789, Montanha', 'Sítio tranquilo com vista para a montanha', 5, 10, 800.00, 5),
('Chalé da Serra', 'Rua C, 101, Serra', 'Chalé aconchegante na serra', 2, 4, 350.00, 7),
('Flat da Cidade', 'Av. D, 202, Cidade', 'Flat bem localizado na cidade', 1, 2, 250.00, 9),
('Casa de Campo', 'Estrada E, 303, Campo', 'Casa espaçosa no campo', 4, 8, 600.00, 1),
('Apartamento Luxo', 'Rua F, 404, Bairro Nobre', 'Apartamento de luxo com todas as comodidades', 3, 6, 1000.00, 3),
('Quarto Simples', 'Av. G, 505, Bairro Simples', 'Quarto simples para estadias curtas', 1, 2, 150.00, 5),
('Pousada do Sol', 'Rua H, 606, Praia', 'Pousada charmosa perto da praia', 5, 10, 700.00, 7),
('Cabana do Lago', 'Estrada I, 707, Lago', 'Cabana rústica à beira do lago', 2, 4, 400.00, 9);

-- Populando a tabela de Reservas
INSERT INTO Reserva (data_inicio, data_termino, status, propriedade_id, usuario_id) 
VALUES ('2024-07-01', '2024-07-10', 'Confirmada', 1, 2),
('2024-07-15', '2024-07-20', 'Pendente', 2, 4),
('2024-08-01', '2024-08-05', 'Confirmada', 3, 6),
('2024-09-01', '2024-09-07', 'Cancelada', 4, 8),
('2024-10-10', '2024-10-15', 'Confirmada', 5, 10),
('2024-07-05', '2024-07-12', 'Pendente', 6, 2),
('2024-07-20', '2024-07-25', 'Confirmada', 7, 4),
('2024-08-10', '2024-08-15', 'Cancelada', 8, 6),
('2024-09-05', '2024-09-10', 'Confirmada', 9, 8),
('2024-10-15', '2024-10-20', 'Pendente', 10, 10);

-- Populando a tabela de Avaliações
INSERT INTO Avaliacao (nota, comentario, usuario_id, propriedade_id) 
VALUES (5, 'Excelente estadia!', 2, 1),
(4, 'Muito bom, recomendo!', 4, 2),
(3, 'Satisfatório, mas pode melhorar.', 6, 3),
(5, 'Lugar maravilhoso!', 8, 4),
(4, 'Boa experiência.', 10, 5),
(2, 'Não gostei muito.', 2, 6),
(5, 'Perfeito!', 4, 7),
(3, 'Foi ok.', 6, 8),
(4, 'Gostei bastante.', 8, 9),
(5, 'Fantástico!', 10, 10);

-- Populando a tabela de Mensagens
INSERT INTO Mensagem (data_hora, conteudo, remetente_id, destinatario_id)
VALUES ('2024-06-20 10:00:00', 'Olá, gostaria de mais informações sobre a casa de praia.', 2, 1),
('2024-06-21 11:00:00', 'Claro, o que você gostaria de saber?', 1, 2),
('2024-06-22 12:00:00', 'Qual a distância até a praia?', 2, 1),
('2024-06-23 13:00:00', 'Apenas 5 minutos a pé.', 1, 2),
('2024-06-24 14:00:00', 'Obrigado!', 2, 1),
('2024-06-25 15:00:00', 'De nada, estou à disposição.', 1, 2),
('2024-06-26 16:00:00', 'Olá, o apartamento no centro está disponível?', 4, 3),
('2024-06-27 17:00:00', 'Sim, está disponível nas datas que você solicitou.', 3, 4),
('2024-06-28 18:00:00', 'Perfeito, vou reservar agora.', 4, 3),
('2024-06-29 19:00:00', 'Ótimo, qualquer dúvida me avise.', 3, 4);

-- 1. Crie um procedimento armazenado (função ou procedimento) para inserir
-- um novo usuário. Caso o e-mail já esteja cadastrado, lance uma exceção.
CREATE OR REPLACE FUNCTION inserir_usuario(p_nome VARCHAR, p_email VARCHAR, p_senha VARCHAR, p_data_nascimento DATE, p_tipo_usuario TIPO_USUARIO, p_telefone VARCHAR)
RETURNS VOID AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM usuario WHERE email = p_email) THEN
        RAISE EXCEPTION 'EMAIL JÁ EXISTE: %', p_email;
    ELSE
        INSERT INTO usuario(nome, email, senha, data_nascimento , tipo_usuario, telefone) 
        VALUES (p_nome, p_email, p_senha, p_data_nascimento, p_tipo_usuario, p_telefone);
        RAISE NOTICE 'Usuario % inserido com sucesso', p_nome;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT inserir_usuario('João Silva', 'joao@email.com', 'senha123', '1990-01-01', 'Anfitrião', '4799999999');
SELECT * FROM Usuario;

-- 2. Crie um procedimento armazenado (função ou procedimento) para atualizar 
-- o telefone de um usuário pelo ID. Se o ID não existir, lance uma exceção.
CREATE OR REPLACE PROCEDURE atualizar_telefone_usuario(p_id INT, p_telefone VARCHAR(15))
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verifica se o usuário existe
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id = p_id) THEN
        RAISE EXCEPTION 'Usuário com ID % não encontrado.', p_id;
    ELSE
        -- Atualiza o telefone
        UPDATE Usuario
        SET telefone = p_telefone
        WHERE id = p_id;
        
        RAISE NOTICE 'Telefone do usuário com ID % atualizado para %.', p_id, p_telefone;
    END IF;
END;
$$;

CALL atualizar_telefone_usuario(1, '47999999999');

-- 3. Crie um procedimento armazenado (função ou procedimento) para excluir
-- uma propriedade pelo ID. Se houver reservas confirmadas, a exclusão deve
-- ser bloqueada.
CREATE OR REPLACE PROCEDURE excluir_propriedade(p_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Reserva
        WHERE propriedade_id = p_id AND status = 'Confirmada'
    ) THEN
        RAISE EXCEPTION 'Não é possível excluir a propriedade com ID % pois há reservas confirmadas.', p_id;
    ELSE
        IF NOT EXISTS (SELECT 1 FROM Propriedade WHERE id = p_id) THEN
            RAISE EXCEPTION 'Propriedade com ID % não encontrada.', p_id;
        ELSE
            DELETE FROM Propriedade WHERE id = p_id;
            RAISE NOTICE 'Propriedade com ID % excluída com sucesso.', p_id;
        END IF;
    END IF;
END;
$$;

CALL excluir_propriedade(2);

-- 4. Crie um procedimento armazenado (função ou procedimento) para listar
-- todas as reservas feitas por um usuário, ordenadas pela data de início.
CREATE OR REPLACE FUNCTION listar_reservas_usuario(p_usuario_id INT)
RETURNS TABLE (reserva_id INT, propriedade_id INT, data_inicio DATE, data_termino DATE, status STATUS_RESERVA) AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Usuario WHERE id = p_usuario_id) THEN
        RAISE EXCEPTION 'Usuário com ID % não encontrado.', p_usuario_id;
    END IF;

    RETURN QUERY
    SELECT 
        r.id AS reserva_id,
        r.propriedade_id,
        r.data_inicio,
        r.data_termino,
        r.status  
    FROM 
        Reserva r
    WHERE 
        r.usuario_id = p_usuario_id
    ORDER BY 
        r.data_inicio;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM listar_reservas_usuario(2);

-- Crie um procedimento armazenado (função ou procedimento) para
-- registrar uma nova reserva. Antes da inserção, verifique se o usuário já tem
-- outra reserva no período ou se a propriedade já está reservada.
CREATE OR REPLACE FUNCTION registrar_reserva(p_usuario_id INT, p_propriedade_id INT, p_data_inicio DATE, p_data_termino DATE) 
RETURNS VOID AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Reserva r
        WHERE r.usuario_id = p_usuario_id
        AND (r.data_inicio <= p_data_termino AND r.data_termino >= p_data_inicio)
    ) THEN
        RAISE EXCEPTION 'O usuário com ID % já tem uma reserva neste período.', p_usuario_id;
    END IF;

    IF EXISTS (
        SELECT 1
        FROM Reserva r
        WHERE r.propriedade_id = p_propriedade_id
        AND (r.data_inicio <= p_data_termino AND r.data_termino >= p_data_inicio)
    ) THEN
        RAISE EXCEPTION 'A propriedade com ID % já está reservada neste período.', p_propriedade_id;
    END IF;

    INSERT INTO Reserva (usuario_id, propriedade_id, data_inicio, data_termino, status)
    VALUES (p_usuario_id, p_propriedade_id, p_data_inicio, p_data_termino, 'Pendente');

    RAISE NOTICE 'Reserva realizada com sucesso para o usuário % na propriedade % de % até %.',
        p_usuario_id, p_propriedade_id, p_data_inicio, p_data_termino;
END;
$$ LANGUAGE plpgsql;

SELECT registrar_reserva(1, 5, '2025-04-01', '2025-04-07');
SELECT * FROM reserva;

-- 6. Crie um procedimento armazenado (função ou procedimento) para contar
-- o número de avaliações de uma propriedade.
CREATE OR REPLACE FUNCTION contar_avaliacoes_propriedade(p_propriedade_id INT)
RETURNS INT AS $$
DECLARE
    total_avaliacoes INT;
BEGIN
    SELECT COUNT(*) INTO total_avaliacoes
    FROM Avaliacao
    WHERE propriedade_id = p_propriedade_id;
    
    RETURN total_avaliacoes;
END;
$$ LANGUAGE plpgsql;

SELECT contar_avaliacoes_propriedade(1);

-- 7. Crie um procedimento armazenado (função ou procedimento) para listar as
-- mensagens trocadas entre dois usuários, ordenadas por data/hora.
CREATE OR REPLACE FUNCTION listar_mensagens_entre_usuarios(p_usuario1 INT, p_usuario2 INT)
RETURNS TABLE(msg_id INT, data_hora TIMESTAMP, conteudo TEXT, remetente_id INT, destinatario_id INT) AS $$
BEGIN
    RETURN QUERY
    SELECT m.id, m.data_hora, m.conteudo, m.remetente_id, m.destinatario_id
    FROM Mensagem AS m
    WHERE (m.remetente_id = p_usuario1 AND m.destinatario_id = p_usuario2)
       OR (m.remetente_id = p_usuario2 AND m.destinatario_id = p_usuario1)
    ORDER BY m.data_hora;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM listar_mensagens_entre_usuarios(1, 2);

-- 8. Crie um procedimento armazenado (função ou procedimento) para
-- atualizar o status de uma reserva pelo ID. Não permita alteração de
-- reservas já finalizadas
CREATE OR REPLACE FUNCTION atualizar_status_reserva(p_reserva_id INT, p_novo_status STATUS_RESERVA)
RETURNS VOID AS $$
DECLARE
    reserva_data_termino DATE;
BEGIN
	IF NOT EXISTS (SELECT 1 FROM Reserva WHERE id = p_reserva_id) THEN
        RAISE EXCEPTION 'Reserva com ID % não encontrado.', p_reserva_id;
	ELSE 
	    SELECT data_termino INTO reserva_data_termino
	    FROM Reserva
	    WHERE id = p_reserva_id;
	    
	    IF reserva_data_termino < CURRENT_DATE THEN
	        RAISE EXCEPTION 'Não é permitido alterar reservas já finalizadas.';
	    END IF;
	    
	    UPDATE Reserva
	    SET status = p_novo_status
	    WHERE id = p_reserva_id;
	END IF;
END;
$$ LANGUAGE plpgsql;

SELECT atualizar_status_reserva(11, 'Pendente');
SELECT * FROM Reserva;

-- 9. Crie um procedimento armazenado (função ou procedimento) para
-- calcular a receita total de um anfitrião, considerando todas as reservas
-- confirmadas em suas propriedades.
CREATE OR REPLACE FUNCTION calcular_receita_anfitriao(p_anfitriao_id INT)
RETURNS DECIMAL(10,2) AS $$
DECLARE
    receita_total DECIMAL(10,2);
BEGIN
    SELECT COALESCE(SUM(p.preco_diaria * (r.data_termino - r.data_inicio)), 0) INTO receita_total
    FROM Propriedade p
    JOIN Reserva r ON p.id = r.propriedade_id
    WHERE p.usuario_id = p_anfitriao_id AND r.status = 'Confirmada';
    
    RETURN receita_total;
END;
$$ LANGUAGE plpgsql;

SELECT calcular_receita_anfitriao(1);

-- 10. Crie um procedimento armazenado (função ou procedimento) para
-- calcular a média de avaliações de uma propriedade. Se não houver
-- avaliações, retorne NULL.
CREATE OR REPLACE FUNCTION calcular_media_avaliacoes_propriedade(p_propriedade_id INT)
RETURNS DECIMAL(3,2) AS $$
DECLARE
    media_avaliacoes DECIMAL(3, 2);
BEGIN
    SELECT AVG(nota) INTO media_avaliacoes
    FROM Avaliacao
    WHERE propriedade_id = p_propriedade_id;
    
    RETURN media_avaliacoes;
END;
$$ LANGUAGE plpgsql;

SELECT calcular_media_avaliacoes_propriedade(1); -- 5.0
SELECT calcular_media_avaliacoes_propriedade(2); -- NULL
