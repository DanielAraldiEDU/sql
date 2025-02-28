-- 7.5. Especifique as seguintes consultas no banco de dados da Figura 5.5 em
-- SQL. Mostre os resultados da consulta se cada uma for aplicada ao banco de
-- dados da Figura 5.6.

-- A. Para cada departamento cujo salário médio do funcionário seja maior que
-- R$ 30.000,00, recupere o nome do departamento e o número de funcionários
-- que trabalham nele.
SELECT d.nome_departamento, COUNT(f.numero_departamento) as numero_funcionarios
FROM DEPARTAMENTO d
JOIN FUNCIONARIO f ON d.numero_departamento = f.numero_departamento
WHERE f.salario > 30000
GROUP BY d.numero_departamento, d.nome_departamento;

-- B. Suponha que queiramos o número de funcionários do sexo masculino em
-- cada departamento que ganhe mais de R$ 30.000,00, em vez de todos os
-- funcionários (como no Exercício 7.5a). Podemos especificar essa consulta
-- em SQL? Por quê? 

-- RESPOSTA: Podemos especificar sim, basta adicionar um AND
-- no WHERE da query, com isso, iremos filtar somente funcionários do
-- sexo masculino. Quanto a resto da query, pode permacer inalterada.
SELECT d.nome_departamento, COUNT(f.numero_departamento) as numero_funcionarios
FROM DEPARTAMENTO d
JOIN FUNCIONARIO f ON d.numero_departamento = f.numero_departamento
WHERE f.salario > 30000 AND f.sexo = 'M'
GROUP BY d.numero_departamento, d.nome_departamento;
