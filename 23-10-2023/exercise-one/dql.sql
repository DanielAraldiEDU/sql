-- CONSULTAS

-- pag 08
-- seleciona todos os pets em todas as colunas
SELECT * FROM pet;
--
SELECT * FROM responsavel;

-- pag 09 
-- seleção de LINHAS
SELECT * FROM pet
	WHERE raca != 'pincher' AND data_nasc > '2019-01-01';

-- seleciona apenas valores maiores que o ano de 2019
SELECT * FROM pet
	WHERE raca != 'pincher' AND YEAR(data_nasc) > '2019';

-- pag 10
-- seleção de COLUNAS
-- seleciona nome, raça e peso para todos os pets
SELECT nome, raca, peso FROM pet;

-- pag 11
-- distinct 
-- seleciona raças de pets que são diferentes uma das outras
SELECT DISTINCT raca FROM pet;

-- pag 12
-- ORDER BY ASC (padrão) ou DESC 
SELECT nome, raca, peso FROM pet ORDER BY nome, raca DESC;
-- pag 13
-- ORDER BY ASC (padrão)
SELECT nome, cpf FROM responsavel ORDER BY nome;

-- pag 14
-- LIMIT
-- utilizado quando você deseja limitar o tamanho da pesquisa
-- o primeiro número corresponde ao index de início da pesquisa
-- o segundo número corresponde a quantidade de itens a serem selecionados levando em consideração o index de início
SELECT uf, cidade FROM endereco LIMIT 0,3;
SELECT uf, cidade FROM endereco LIMIT 5,3;
SELECT uf, cidade, cep FROM endereco ORDER BY uf LIMIT 3,6;

-- pag 16
-- UNION
-- não existe a repetição de valores na busca
SELECT * FROM pet WHERE raca = 'pincher' UNION
SELECT * FROM pet WHERE peso > 10;

-- pag 17
-- UNION ALL
-- existe a repetição de valores da busca
SELECT * FROM pet WHERE raca = 'pincher' UNION ALL
SELECT * FROM pet WHERE peso > 10;

-- pag 19
-- Junção usando where
SELECT p.nome, p.raca, c.dt, c.horario FROM pet p, consulta c WHERE p.cod = c.cod_pet;

-- pag 22
-- Junção usando INNER JOIN
SELECT p.nome, p.raca, c.dt, c.horario FROM pet p INNER JOIN consulta c ON (c.cod_pet = p.cod);

-- pag 23
-- Junção usando LEFT JOIN
SELECT p.nome, p.raca, c.dt, c.horario FROM pet p LEFT JOIN consulta c ON (c.cod_pet = p.cod);
-- Junção usando RIGHT JOIN
SELECT p.nome, p.raca, c.dt, c.horario FROM pet p RIGHT JOIN consulta c ON (c.cod_pet = p.cod);
-- Junção usando CROSS JOIN
-- usado quando duas tabelas não possuem uma chave estrageira se referenciando
SELECT p.nome, p.raca, c.dt, c.horario FROM pet p CROSS JOIN consulta c ON (c.cod_pet = p.cod);

-- pag 24
-- Funções de agregação
-- MAX
SELECT MAX(peso) FROM pet;
-- MIN
SELECT MIN(peso) FROM pet;
-- SUM
SELECT SUM(peso) FROM pet;

-- pag 25
-- Funções de agregação
-- AVG
SELECT AVG(peso) FROM pet;
-- COUNT
SELECT COUNT(raca) FROM pet
	WHERE raca = 'pincher';

--  pag 26
-- GroupBy
SELECT COUNT(raca) FROM pet GROUP BY raca;

-- pag 28
-- Funções com String
SELECT CHAR_LENGTH('Joaquim');
SELECT CONCAT('Joaquim', ' ','Silva');
-- coloca o primeiro caracter entre todos os próximos itens
SELECT CONCAT_WS('/', '04', '02', '2023');

-- pag 29
-- Funções com String
-- ache o index aonde aquele valor existe na string, caso não ache retorna 0
SELECT INSTR('Joaquim Silva 28 anos', '29');
SELECT INSTR('Joaquim Silva 29 anos', '29');

-- pag 30
-- Funções com String
-- LCASE ou LOWER:
SELECT LCASE('JOAQUIM');
SELECT LOWER('JOAQUIM');
-- LEFT
SELECT LEFT('JOAQUIM', 4);

-- pag 31
-- Funções com String
-- adiciona string '0' à esquerda da string
SELECT LPAD('51', 6, '0');
-- adiciona string '0' à direita da string
SELECT RPAD('51', 6, '0');

-- pag 32
-- Funções com String
SELECT LTRIM('                                Joaquim');
SELECT RTRIM('Joaquim                    ');
SELECT CONCAT('[', TRIM('          Joaquim                    '), '] ');

-- pag 33
-- Funções com String
SELECT REPLACE('www.dlweb.com', '.com', '.com.br');
-- pega as primeiras string à direita
SELECT RIGHT('ALEXANDRE', 5);

-- pag 34
-- Funções com String
-- UCASE/UPPER
SELECT UCASE('joaquim');
SELECT UPPER('joaquim');
-- REVERSE
SELECT REVERSE('1234');
