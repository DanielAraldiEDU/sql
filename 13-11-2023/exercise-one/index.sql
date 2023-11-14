SET SQL_SAFE_UPDATES = 0;

CREATE SCHEMA IF NOT EXISTS hospedar_db;
USE hospedar_db;

CREATE TABLE hotel (
	hotel_id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(256) NOT NULL,
	cidade VARCHAR(256) NOT NULL,
	ratting INT NOT NULL
);

CREATE TABLE quarto (
	quarto_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT NOT NULL,
	numero INT NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    preco_diaria DECIMAL(10, 2),
    FOREIGN KEY(hotel_id) REFERENCES hotel(hotel_id)
);

CREATE TABLE cliente (
	cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(256) NOT NULL,
    email VARCHAR(256) NOT NULL UNIQUE,
    telefone VARCHAR(24) NOT NULL,
    cpf VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE hospedagem (
	hospedagem_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    quarto_id INT NOT NULL,
    date_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    valor_total FLOAT NOT NULL, 
    estatus VARCHAR(16) NOT NULL,
    FOREIGN KEY(cliente_id) REFERENCES cliente(cliente_id),
    FOREIGN KEY(quarto_id) REFERENCES quarto(quarto_id)
);

INSERT INTO hotel(hotel_id, nome, cidade, ratting) 
VALUES (1, "Hotel Beira Rio", "Brusque", 3);
INSERT INTO hotel(hotel_id, nome, cidade, ratting) 
VALUES (2, "Hotel Vem Cá", "Itajaí", 5);

INSERT INTO cliente(cliente_id, nome, email, telefone, cpf) 
VALUES (1, 'Jael Cardoso', 'jael_cruel@gmail.com', '47999123329','11356787656');
INSERT INTO cliente(cliente_id, nome, email, telefone, cpf) 
VALUES (2, 'Otavio Maia', 'maia_otavio@gmail.com', '49991233399','61353787626');
INSERT INTO cliente(cliente_id, nome, email, telefone, cpf) 
VALUES (3, 'Rafael Ostogio', 'ostogio_rafa@gmail.com', '59191832391','85353487636');

INSERT INTO quarto(quarto_id, hotel_id, numero, tipo, preco_diaria) 
VALUES (1, 1, 100, "Standard", 149.90);
INSERT INTO quarto(quarto_id, hotel_id, numero, tipo, preco_diaria) 
VALUES (2, 1, 101, "Deluxe", 249.90);
INSERT INTO quarto(quarto_id, hotel_id, numero, tipo, preco_diaria) 
VALUES (3, 1, 102, "Deluxe", 249.90);
INSERT INTO quarto(quarto_id, hotel_id, numero, tipo, preco_diaria) 
VALUES (4, 1, 103, "Suíte", 449.90);
INSERT INTO quarto(quarto_id, hotel_id, numero, tipo, preco_diaria) 
VALUES (5, 1, 104, "Suíte", 449.90);
INSERT INTO quarto(quarto_id, hotel_id, numero, tipo, preco_diaria) 
VALUES (6, 2, 200, "Standard", 199.90);
INSERT INTO quarto(quarto_id, hotel_id, numero, tipo, preco_diaria) 
VALUES (7, 2, 201, "Deluxe", 299.90);
INSERT INTO quarto(quarto_id, hotel_id, numero, tipo, preco_diaria) 
VALUES (8, 2, 202, "Deluxe", 299.90);
INSERT INTO quarto(quarto_id, hotel_id, numero, tipo, preco_diaria) 
VALUES (9, 2, 203, "Suíte", 499.90);
INSERT INTO quarto(quarto_id, hotel_id, numero, tipo, preco_diaria) 
VALUES (10, 2, 204, "Suíte", 499.90);

INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (1, 1, 1, "2023-11-12", "2023-11-13", 149.90, "concluida");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (2, 1, 1, "2023-09-28", "2023-09-30", 299.80, "concluida");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (3, 1, 2, "2023-01-12", "2023-01-13", 249.90, "cancelada");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (4, 1, 2, "2022-10-02", "2022-10-03", 249.90, "concluida");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (5, 1, 6, "2021-08-22", "2021-08-23", 199.90, "reserva");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (6, 1, 7, "2021-01-19", "2023-01-23", 299.90, "finalizada");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (7, 2, 2, "2023-11-12", "2023-11-13", 249.90, "concluida");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (8, 2, 2, "2023-09-28", "2023-09-30", 499.80, "concluida");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (9, 2, 3, "2023-01-12", "2023-01-13", 249.90, "cancelada");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (10, 2, 3, "2022-10-02", "2022-10-03", 249.90, "concluida");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (11, 2, 8, "2021-08-22", "2021-08-23", 299.90, "reserva");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (12, 2, 9, "2021-01-19", "2023-01-23", 1999.60, "finalizada");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (13, 3, 10, "2023-11-12", "2023-11-13", 499.90, "concluida");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (14, 3, 10, "2023-09-28", "2023-09-30", 999.80, "concluida");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (15, 3, 1, "2023-01-12", "2023-01-13", 149.90, "cancelada");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (16, 3, 1, "2022-10-02", "2022-10-03", 149.90, "concluida");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (17, 3, 4, "2021-08-22", "2021-08-23", 449.90, "reserva");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (18, 3, 4, "2021-01-19", "2023-01-23", 1799.60, "finalizada");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (19, 3, 6, "2021-08-22", "2021-08-23", 199.90, "reserva");
INSERT INTO hospedagem(hospedagem_id, cliente_id, quarto_id, date_checkin, data_checkout, valor_total, estatus) 
VALUES (20, 3, 7, "2021-01-19", "2023-01-23", 299.90, "finalizada");

SELECT h.nome, h.cidade, q.tipo, q.preco_diaria 
FROM hotel AS h 
LEFT JOIN quarto AS q 
ON h.hotel_id = q.quarto_id;

SELECT * FROM  hospedagem AS hosp
INNER JOIN cliente AS c
ON hosp.cliente_id = c.cliente_id
INNER JOIN quarto AS q
ON q.quarto_id = hosp.quarto_id
INNER JOIN hotel AS h
ON q.hotel_id = h.hotel_id
WHERE hosp.estatus = "finalizada";

SELECT h.hospedagem_id, h.cliente_id, h.quarto_id, h.date_checkin, h.data_checkout, h.valor_total, h.estatus 
FROM hospedagem as h
INNER JOIN cliente AS c
ON h.cliente_id = 1
ORDER BY h.date_checkin;

SELECT c.cliente_id, c.nome, c.email, c.telefone, c.cpf
FROM hospedagem as h
INNER JOIN cliente AS c
GROUP BY (
	SELECT COUNT(cliente_id) FROM cliente
);

SELECT * FROM  hospedagem AS hosp
INNER JOIN cliente AS c
ON hosp.cliente_id = c.cliente_id
INNER JOIN quarto AS q
ON q.quarto_id = hosp.quarto_id
INNER JOIN hotel AS h
ON q.hotel_id = h.hotel_id
WHERE hosp.estatus = "cancelada";

SELECT h.hotel_id, h.nome, h.cidade, h.ratting, SUM(hosp.valor_total) 
FROM hospedagem AS hosp
INNER JOIN cliente AS c
ON hosp.cliente_id = c.cliente_id
INNER JOIN quarto AS q
ON q.quarto_id = hosp.quarto_id
INNER JOIN hotel AS h
ON q.hotel_id = h.hotel_id
WHERE hosp.estatus = "finalizada"
GROUP BY h.nome
ORDER BY hosp.valor_total DESC;

SELECT c.cliente_id, c.nome, c.email, c.telefone, c.cpf, SUM(hosp.valor_total)
FROM hospedagem AS hosp
INNER JOIN cliente AS c
ON hosp.cliente_id = c.cliente_id
INNER JOIN quarto AS q
ON q.quarto_id = hosp.quarto_id
INNER JOIN hotel AS h
ON q.hotel_id = h.hotel_id
WHERE hosp.estatus = "finalizada"
GROUP BY h.nome
ORDER BY hosp.valor_total DESC;

DELETE FROM hospedagem
WHERE estatus = "cancelada";

SELECT q.*
FROM quarto AS q
LEFT JOIN hospedagem AS h 
ON q.quarto_id = h.quarto_id
WHERE h.quarto_id IS NULL;

ALTER TABLE hospedagem
ADD COLUMN checkin_realizado TINYINT(1) NOT NULL DEFAULT 0;
UPDATE hospedagem 
SET checkin_realizado = (
	hospedagem.estatus = "finalizada" OR hospedagem.estatus = "hospedado"
);

ALTER TABLE hotel RENAME COLUMN ratting TO classificacao;
ALTER TABLE hotel CHANGE ratting classificacao INT;

CREATE OR REPLACE VIEW reservas AS
SELECT h.hotel_id, h.nome AS nome_hotel, h.cidade, h.classificacao, q.quarto_id, q.numero, q.tipo, q.preco_diaria, c.cliente_id, c.nome AS nome_cliente, c.email, c.telefone, c.cpf 
FROM hospedagem AS hosp
INNER JOIN cliente AS c
ON hosp.cliente_id = c.cliente_id
INNER JOIN quarto AS q
ON q.quarto_id = hosp.quarto_id
INNER JOIN hotel AS h
ON q.hotel_id = h.hotel_id
WHERE hosp.estatus = "reserva" AND hosp.date_checkin < NOW()
ORDER BY hosp.date_checkin;
