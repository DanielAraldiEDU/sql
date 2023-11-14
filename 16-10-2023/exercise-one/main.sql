/* clinica veterinaria lógico */

-- DROP TABLE Endereco;

CREATE TABLE Endereco (
    cod integer PRIMARY KEY,
    logradouro varchar(100),
    numero integer,
    complemento varchar(50),
    cep varchar(12),
    cidade varchar(50),
    uf varchar(2)
);

INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) VALUES (1, 'Rua Tenente-Coronel Cardoso', '501', 'ap 1001','28035042','Campos dos Goytacazes','RJ');
INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) VALUES (2, 'Rua Serra de Bragança', '980', null,'03318000','São Paulo','SP');
INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) VALUES (3, 'Rua Barão de Vitória', '50', 'loja A','09961660','Diadema','SP');
INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) VALUES (4, 'Rua Pereira Estéfano', '700', 'ap 202 a','04144070','São Paulo','SP');
INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) VALUES (5, 'Avenida Afonso Pena', '60', null,'30130005','São Paulo','SP');
INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) VALUES (6, 'Rua das Fiandeiras', '123', 'Sala 501','04545005','São Paulo','SP');
INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) VALUES (7, 'Rua Cristiano Olsen', '2549', 'ap 506','16015244','Araçatuba','SP');
INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) VALUES (8, 'Avenida Desembargador Moreira', '908', 'Ap 405','60170001','Fortaleza','CE');
INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) VALUES (9, 'Avenida Almirante Maximiano Fonseca', '362', null,'88113350','Rio Grande','RS');
INSERT INTO endereco(cod,logradouro,numero,complemento,cep,cidade,uf) VALUES (10, 'Rua Arlindo Nogueira', '219', 'ap 104','64000290','Teresina','PI');

CREATE TABLE Responsavel (
    cod integer PRIMARY KEY,
    nome varchar(100) NOT NULL,
    cpf varchar(12) NOT NULL,
    fone varchar(50) NOT NULL,
    email varchar(100) NOT NULL,
    cod_end integer,
    UNIQUE (cpf, email),
    FOREIGN KEY (cod_end) REFERENCES Endereco (cod) 
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

INSERT INTO responsavel(cod,nome,cpf,email,fone,cod_end) VALUES (1, 'Márcia Luna Duarte', '1111111111', 'marcia.luna.duarte@deere.com','(63) 2980-8765',1);
INSERT INTO responsavel(cod,nome,cpf,email,fone,cod_end) VALUES (2, 'Benício Meyer Azevedo','23101771056', 'beniciomeyer@gmail.com.br','(63) 99931-8289',2);
INSERT INTO responsavel(cod,nome,cpf,email,fone,cod_end) VALUES (3, 'Ana Beatriz Albergaria Bochimpani Trindade','61426227400','anabeatriz@ohms.com.br', '(87) 2743-5198',3);
INSERT INTO responsavel(cod,nome,cpf,email,fone,cod_end) VALUES (4, 'Thiago Edson das Neves','31716341124','thiago_edson_dasneves@paulistadovale.org.br','(85) 3635-5560',4);
INSERT INTO responsavel(cod,nome,cpf,email,fone,cod_end) VALUES (5, 'Luna Cecília Alves','79107398','luna_alves@orthoi.com.br','(67) 2738-7166',5);

CREATE TABLE Pet (
    cod integer PRIMARY KEY,
    nome varchar(100),
    raca varchar(50),
    peso decimal(5,2),
    data_nasc date,
    cod_resp integer,
    FOREIGN KEY (cod_resp) REFERENCES Responsavel (cod) 
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc) VALUES (1, 1, 'Mike', 12, 'pincher', '2010-12-20');
INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc) VALUES (2, 1, 'Nike', 20, 'pincher', '2010-12-20');
INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc) VALUES (3, 2, 'Bombom', 10, 'shitzu', '2022-07-15');
INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc) VALUES (4, 3, 'Niro', 70, 'pastor alemao', '2018-10-12');
INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc) VALUES (5, 4, 'Milorde', 5, 'doberman', '2019-11-16');
INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc) VALUES (6, 4, 'Laide', 4, 'coker spaniel','2018-02-27');
INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc) VALUES (7, 4, 'Lorde', 3, 'dogue alemão', '2019-05-15');
INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc) VALUES (8, 5, 'Joe', 50, 'indefinido', '2020-01-01');
INSERT INTO pet(cod,cod_resp,nome,peso,raca,data_nasc) VALUES (9, 5, 'Felicia', 5, 'indefinido', '2017-06-07');

CREATE TABLE Veterinario (
    cod integer PRIMARY KEY,
    nome varchar(100),
    crmv numeric(10),
    especialidade varchar(50),
    fone varchar(50),
    email varchar(100),
    cod_end integer,
    FOREIGN KEY (cod_end) REFERENCES Endereco (cod) 
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

INSERT INTO veterinario(cod,nome,crmv,especialidade,email,fone,cod_end) VALUES (1, 'Renan Bruno Diego Oliveira','35062','clinico geral','renanbrunooliveira@edu.uniso.br','(67) 99203-9967',6);
INSERT INTO veterinario(cod,nome,crmv,especialidade,email,fone,cod_end) VALUES (2, 'Clara Bárbara da Cruz','64121','dermatologista','clarabarbaradacruz@band.com.br','(63) 3973-7873',7);
INSERT INTO veterinario(cod,nome,crmv,especialidade,email,fone,cod_end) VALUES (3, 'Heloise Cristiane Emilly Moreira','80079','clinico geral','heloisemoreira@igoralcantara.com.br','(69) 2799-7715',8);
INSERT INTO veterinario(cod,nome,crmv,especialidade,email,fone,cod_end) VALUES (4, 'Laís Elaine Catarina Costa','62025','animais selvagens','lais-costa84@campanati.com.br','(79) 98607-4656',9);
INSERT INTO veterinario(cod,nome,crmv,especialidade,email,fone,cod_end) VALUES (5, 'Juliana Andrea Cardoso','00491','dermatologista','juliana_cardoso@br.ibn.com','(87) 98439-9604',10);

CREATE TABLE Consulta (
    cod integer PRIMARY KEY,
    dt date,
    horario time,
    cod_vet integer,
    cod_pet integer,
    FOREIGN KEY (cod_vet) REFERENCES Veterinario (cod), 
    FOREIGN KEY (cod_pet) REFERENCES Pet (cod) 
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- ALTER TABLE Consulta ADD CONSTRAINT FK_Consulta_2
--     FOREIGN KEY (cod_vet)
--     REFERENCES Veterinario (cod);
--  
-- ALTER TABLE Consulta ADD CONSTRAINT FK_Consulta_3
--     FOREIGN KEY (cod_pet)
--     REFERENCES Pet (cod);

INSERT INTO consulta(cod,cod_pet, cod_vet, horario, dt) VALUES (1,2,1,'14:30','2023-10-05');
INSERT INTO consulta(cod,cod_pet, cod_vet, horario, dt) VALUES (2,4,1,'15:00','2023-10-05');
INSERT INTO consulta(cod,cod_pet, cod_vet, horario, dt) VALUES (3,5,5,'16:30','2023-10-15');
INSERT INTO consulta(cod,cod_pet, cod_vet, horario, dt) VALUES (4,3,4,'14:30','2023-10-12');
INSERT INTO consulta(cod,cod_pet, cod_vet, horario, dt) VALUES (5,2,3,'18:00','2023-10-17');
INSERT INTO consulta(cod,cod_pet, cod_vet, horario, dt) VALUES (6,5,3,'14:10','2023-10-20');
INSERT INTO consulta(cod,cod_pet, cod_vet, horario, dt) VALUES (7,5,3,'10:30','2023-10-28');

SELECT * FROM responsavel AS r, pet AS p WHERE r.cod = p.cod_resp;

SELECT * FROM veterinario AS v, endereco AS e WHERE v.cod_end = e.cod;

SELECT * FROM consulta;
