-- PARA ESTA ATIVIDADE, EFETUE AS SEGUINTES ETAPAS:
--	1. EFETUE A CRIAÇÃO DAS TABELAS, LINHAS 6 A 64
-- 	2. EFETUE A INSERÇÃO DOS REGISTROS, LINAS 67 A 115
-- 	3. EFETUE A CRIAÇÃO DE FUNÇÕES PARA CADA UM DOS EXERCICIOS A PARTIR DA LINHA 118

/* clinica veterinaria */
SELECT schema_name FROM information_schema.schemata;
SHOW search_path;
CREATE SCHEMA clinica_vet;
SET search_path = clinica_vet;

CREATE TABLE Endereco (
    cod serial PRIMARY KEY,
    logradouro varchar(100),
    numero integer,
    complemento varchar(50),
    cep varchar(12),
    cidade varchar(50),
    uf varchar(2)
);

CREATE TABLE Responsavel (
    cod serial PRIMARY KEY,
    nome varchar(100) NOT NULL,
    cpf varchar(12) NOT NULL,
    fone varchar(50) NOT NULL,
    email varchar(100) NOT NULL,
    cod_end integer,
    UNIQUE (cpf, email),
    FOREIGN KEY (cod_end) REFERENCES Endereco (cod) 
);

CREATE TABLE Pet (
    cod serial PRIMARY KEY,
    nome varchar(100),
    raca varchar(50),
    peso decimal(5,2),
    data_nasc date,
    cod_resp integer,
    FOREIGN KEY (cod_resp) REFERENCES Responsavel (cod) 
);

CREATE TABLE Veterinario (
    cod serial PRIMARY KEY,
    nome varchar(100),
    crmv numeric(10),
    especialidade varchar(50),
    fone varchar(50),
    email varchar(100),
    cod_end integer,
	FOREIGN KEY (cod_end) REFERENCES Endereco (cod) 
);

CREATE TABLE Consulta (
    cod serial PRIMARY KEY,
    dt date,
    horario time,
    cod_vet integer,
    cod_pet integer,
    FOREIGN KEY (cod_vet) REFERENCES Veterinario (cod), 
    FOREIGN KEY (cod_pet) REFERENCES Pet (cod) 
);

-- inserindo enderecos
INSERT INTO endereco(logradouro,numero,complemento,cep,cidade,uf) 
	VALUES 	('Rua Tenente-Coronel Cardoso', '501', 'ap 1001','28035042','Campos dos Goytacazes','RJ'),
			('Rua Serra de Bragança', '980', null,'03318000','São Paulo','SP'),
			('Rua Barão de Vitória', '50', 'loja A','09961660','Diadema','SP'),
			('Rua Pereira Estéfano', '700', 'ap 202 a','04144070','São Paulo','SP'),
			('Avenida Afonso Pena', '60', null,'30130005','São Paulo','SP'),
			('Rua das Fiandeiras', '123', 'Sala 501','04545005','São Paulo','SP'),
			('Rua Cristiano Olsen', '2549', 'ap 506','16015244','Araçatuba','SP'),
			('Avenida Desembargador Moreira', '908', 'Ap 405','60170001','Fortaleza','CE'),
			('Avenida Almirante Maximiano Fonseca', '362', null,'88113350','Rio Grande','RS'),
			('Rua Arlindo Nogueira', '219', 'ap 104','64000290','Teresina','PI');

-- inserindo responsaveis
INSERT INTO responsavel(nome,cpf,email,fone,cod_end) 
	VALUES 	('Márcia Luna Duarte', '1111111111', 'marcia.luna.duarte@deere.com','(63) 2980-8765',1),
			('Benício Meyer Azevedo','23101771056', 'beniciomeyer@gmail.com.br','(63) 99931-8289',2),
			('Ana Beatriz Albergaria Bochimpani Trindade','61426227400','anabeatriz@ohms.com.br', '(87) 2743-5198',3),
			('Thiago Edson das Neves','31716341124','thiago_edson_dasneves@paulistadovale.org.br','(85) 3635-5560',4),
			('Luna Cecília Alves','79107398','luna_alves@orthoi.com.br','(67) 2738-7166',5);

-- inserindo veterinarios
INSERT INTO veterinario(nome,crmv,especialidade,email,fone,cod_end) 
	VALUES 	('Renan Bruno Diego Oliveira','35062','clinico geral','renanbrunooliveira@edu.uniso.br','(67) 99203-9967',6),
			('Clara Bárbara da Cruz','64121','dermatologista','clarabarbaradacruz@band.com.br','(63) 3973-7873',7),
			('Heloise Cristiane Emilly Moreira','80079','clinico geral','heloisemoreira@igoralcantara.com.br','(69) 2799-7715',8),
			('Laís Elaine Catarina Costa','62025','animais selvagens','lais-costa84@campanati.com.br','(79) 98607-4656',9),
			('Juliana Andrea Cardoso','00491','dermatologista','juliana_cardoso@br.ibn.com','(87) 98439-9604',10);

-- inserindo animais
INSERT INTO pet(cod_resp,nome,peso,raca,data_nasc) 
	VALUES 	(1, 'Mike', 12, 'pincher', '2010-12-20'),
			(1, 'Nike', 20, 'pincher', '2010-12-20'),
			(2, 'Bombom', 10, 'shitzu', '2022-07-15'),
 			(3, 'Niro', 70, 'pastor alemao', '2018-10-12'),
			(4, 'Milorde', 5, 'doberman', '2019-11-16'),
 			(4, 'Laide', 4, 'coker spaniel','2018-02-27'),
 			(4, 'Lorde', 3, 'dogue alemão', '2019-05-15'),
			(5, 'Joe', 50, 'indefinido', '2020-01-01'),
			(5, 'Felicia', 5, 'indefinido', '2017-06-07');

-- inserindo consultas
INSERT INTO consulta(cod_pet, cod_vet, horario, dt) 
	VALUES 	(2,1,'14:30','2023-10-05'),
			(4,1,'15:00','2023-10-05'),
			(5,5,'16:30','2023-10-15'),
			(3,4,'14:30','2023-10-12'),
			(2,3,'18:00','2023-10-17'),
			(5,3,'14:10','2023-10-20'),
			(5,3,'10:30','2023-10-28');
			
			
-- EXERCÍCIOS:

-- 1. Crie uma função que insira um novo registro na tabela Endereco e 
--   retorne o código do endereço inserido.
-- Obs.: RETURNING cod; no final de um select retorna o cod criado (auto gerado).
CREATE OR REPLACE FUNCTION addAddress(logradouro varchar(100), numero integer, complemento varchar(50), cep varchar(12), cidade varchar(50), uf varchar(2))
RETURNS INTEGER AS
$$
INSERT INTO endereco(logradouro, numero, complemento, cep, cidade, uf) values ($1, $2, $3, $4, $5, $6)
RETURNING cod;
$$
LANGUAGE SQL;

SELECT addAddress('Osmar Lang', 170, 'Casa', '88356-315', 'Brusque', 'SC');

-- 2. Crie um procedimento que atualize o email de um responsável com base no seu código.
CREATE OR REPLACE PROCEDURE updateEmail(userId integer, email varchar(100))
LANGUAGE SQL AS
$$
	UPDATE Responsavel SET email = $2 WHERE cod = $1;
$$;

CALL updateEmail(1, 'new@new.com');

SELECT * FROM Responsavel;

-- 3. Faça um procedumento para excluir um responsável. 
--	  Excluir seus pets e endereços. Sem a utilização do CASCADE na definição da tabela.
CREATE OR REPLACE PROCEDURE deleteUser(userId integer)
LANGUAGE SQL AS
$$
	DELETE FROM Pet WHERE cod_resp IN (SELECT cod_resp FROM Consulta WHERE cod_pet = $1);
	DELETE FROM Endereco WHERE cod = $1;
	DELETE FROM Responsavel WHERE cod = $1;
$$;

CALL deleteUser(1);

SELECT * FROM Responsavel;
SELECT * FROM Pet;
SELECT * FROM Endereco;

-- 4. Crie uma função que liste todas as consultas agendadas em um determinado periodo (entre duas datas)
--   Deve retornar uma tabela com os campos data da consulta, nome do responsavel,
--   nome do pet, telefone do responsavel e nome do veterinario.

CREATE OR REPLACE FUNCTION listSchedule(startDate date, endDate date, out scheduleDate date, out respName varchar(100), out petName varchar(100), out respPhone varchar(50), out vetName varchar(100))
RETURNS record AS
$$
	
$$;

SELECT listSchedule('2023-10-15', '2023-10-20');

-- 5. Crie uma função que receba os dados do veterinario por parâmetro, armazene na tabela “veterinario” e 
--   retorne todos os veterinários com a mesma especialidade.

-- 6. Crie um procedimento para adicionar um novo pet, associando-o a um responsável existente.

-- 7. Escreva uma função que conte quantos pets um determinado responsável possui.

-- 8. Faça uma função que calcule a idade atual de um pet com base na sua data de nascimento.

-- 9. Função que retorna todas as consultas agendadas de um determinado veterinário
--     em uma data especifica.

-- 10. Procedimento que retorna o nome e telefone do responsável de um determinado pet
-- 	   Faça uso do OUT para retornar os valores solicitados.

-- 11. Função que retorna o nome do responsável pelo CPF ou uma mensagem caso não encontrado.

--> COALESCE retornar o primeiro valor não nulo
-- Evita valores NULL inesperados, substituindo-os por valores padrões.
-- Melhora relatórios e consultas, evitando exibir campos vazios.
-- Garante compatibilidade em cálculos, evitando problemas de NULL em operações matemáticas.
SELECT COALESCE(null, 'Responsável não encontrado');

-- 12. Crie uma função que receba um código de veterinário e retorne o total de consultas realizadas por ele.
