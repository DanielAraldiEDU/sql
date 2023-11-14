CREATE SCHEMA IF NOT EXISTS Mundo;
USE Mundo;

CREATE TABLE Continente (
	id INT AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Pais (
	id INT AUTO_INCREMENT,
	id_continente INT NOT NULL, 
    nome VARCHAR(50) NOT NULL,
    populacao DECIMAL(6,3) NOT NULL,
    pib DECIMAL(6,3) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id_continente) REFERENCES Continente(id)
);

CREATE TABLE Estado (
	id INT AUTO_INCREMENT,
    id_pais INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id_pais) REFERENCES Pais(id)
);

CREATE TABLE Cidade (
	id INT AUTO_INCREMENT,
    id_estado INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    populacao DECIMAL(6,3) NOT NULL,
    capital_nacional TINYINT(1) NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(id_estado) REFERENCES Estado(id)
);

INSERT INTO Continente (nome) VALUES ('América do Norte');
INSERT INTO Continente (nome) VALUES ('América do Sul');

INSERT INTO Pais (id_continente, nome, populacao, pib) VALUES (1, 'Canadá', 38250, 1.991);
INSERT INTO Pais (id_continente, nome, populacao, pib) VALUES (1, 'Estados Unidos da América', 331900, 23.885);
INSERT INTO Pais (id_continente, nome, populacao, pib) VALUES (2, 'Brasil', 214010, 1.609);
INSERT INTO Pais (id_continente, nome, populacao, pib) VALUES (2, 'Argentina', 45810, 0.491);

INSERT INTO Estado (id_pais, nome) VALUES (1, 'Ontário');
INSERT INTO Estado (id_pais, nome) VALUES (1, 'Colúmbia Britânica');
INSERT INTO Estado (id_pais, nome) VALUES (2, 'Distrito de Colúmbia');
INSERT INTO Estado (id_pais, nome) VALUES (2, 'Califórnia');
INSERT INTO Estado (id_pais, nome) VALUES (3, 'Distrito Federal');
INSERT INTO Estado (id_pais, nome) VALUES (3, 'São Paulo');
INSERT INTO Estado (id_pais, nome) VALUES (4, 'Buenos Aires');
INSERT INTO Estado (id_pais, nome) VALUES (4, 'Río Negro');

INSERT INTO Cidade (id_estado, nome, populacao, capital_nacional) VALUES (1, 'Ottawa', 0.994, 1);
INSERT INTO Cidade (id_estado, nome, populacao, capital_nacional) VALUES (2, 'Vancouver', 0.675, 0);
INSERT INTO Cidade (id_estado, nome, populacao, capital_nacional) VALUES (3, 'Washington, D.C.', 0.712, 1);
INSERT INTO Cidade (id_estado, nome, populacao, capital_nacional) VALUES (4, 'Los Angeles', 3.849, 0);
INSERT INTO Cidade (id_estado, nome, populacao, capital_nacional) VALUES (5, 'Brasília', 3.094, 1);
INSERT INTO Cidade (id_estado, nome, populacao, capital_nacional) VALUES (6, 'São Paulo', 12.330, 0);
INSERT INTO Cidade (id_estado, nome, populacao, capital_nacional) VALUES (7, 'Buenos Aires', 16.529, 1);
INSERT INTO Cidade (id_estado, nome, populacao, capital_nacional) VALUES (8, 'Bariloche', 0.110, 0);

SELECT p.nome AS nome_pais, e.nome AS nome_estado
FROM Estado AS e 
INNER JOIN Pais AS p 
ON e.id_pais = p.id;

SELECT p.nome AS nome_pais, c.nome AS nome_cidade_capital
FROM Cidade AS c 
INNER JOIN Estado AS e 
ON c.id_estado = e.id
INNER JOIN Pais AS p 
ON e.id_pais = p.id 
WHERE capital_nacional = 1;

SELECT c.nome AS nome_cidade_capital, c.populacao
FROM Cidade AS c 
INNER JOIN Estado AS e 
ON c.id_estado = e.id
INNER JOIN Pais AS p 
ON e.id_pais = p.id 
WHERE capital_nacional = 1 AND p.pib >= 1;

SELECT AVG(c.populacao) AS media_populacao
FROM Cidade AS c 
INNER JOIN Estado AS e 
ON c.id_estado = e.id
WHERE capital_nacional = 0;

SELECT c.nome AS nome_continente, AVG(p.pib) AS media_pib_paises
FROM Pais AS p
INNER JOIN Continente AS c
ON p.id_continente = c.id
GROUP BY c.nome;

SELECT p.nome AS nome_pais, p.pib AS pib_pais 
FROM Pais AS p
WHERE p.pib > (
	SELECT Pais.pib
	FROM Pais
	WHERE Pais.id = 1
);
