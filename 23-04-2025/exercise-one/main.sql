-- 1. Listar o nome e o CPF de todos os funcionários do sexo feminino.
SELECT DISTINCT primeiro_nome, nome_meio, ultimo_nome, cpf 
FROM FUNCIONARIO
WHERE sexo = 'F'

-- 2. Obter os nomes dos projetos que ocorrem em São Paulo.
SELECT DISTINCT nome_projeto
FROM PROJETO
WHERE local_projeto = 'São Paulo'

-- 3. Recuperar os nomes e endereços dos funcionários que trabalham no departamento de ‘Administração’.
SELECT DISTINCT F.primeiro_nome, F.nome_meio, F.ultimo_nome, F.endereco
FROM FUNCIONARIO as F
JOIN DEPARTAMENTO as D 
ON D.numero_departamento = F.numero_departamento AND D.nome_departamento = 'Administração'

-- 4. Obter o nome de cada funcionário e o total de horas que ele trabalha em projetos.
SELECT DISTINCT F.primeiro_nome, F.nome_meio, F.ultimo_nome, T.horas, P.nome_projeto
FROM FUNCIONARIO AS F, PROJETO AS P
JOIN TRABALHA_EM AS T
ON F.cpf = T.cpf_funcionario AND T.numero_projeto = P.numero_projeto

-- 5. Listar o nome dos projetos nos quais ‘Alice’ trabalha.
SELECT DISTINCT P.nome_projeto
FROM PROJETO AS P
JOIN FUNCIONARIO AS F
ON F.primeiro_nome = 'Alice' AND F.numero_departamento = P.numero_departamento

-- 6. Obter o nome dos funcionários que têm dependentes do sexo feminino.
SELECT DISTINCT F.primeiro_nome, F.nome_meio, F.ultimo_nome
FROM FUNCIONARIO AS F
JOIN DEPENDENTE AS D
ON F.cpf = D.cpf_funcionario

-- 7. Listar os nomes dos funcionários que trabalham em todos os projetos localizados em ‘São Paulo’.
SELECT DISTINCT F.primeiro_nome, F.nome_meio, F.ultimo_nome
FROM FUNCIONARIO AS F
JOIN PROJETO AS P
ON F.numero_departamento = P.numero_departamento AND P.local_projeto = 'São Paulo'

-- 8. Mostrar o nome dos funcionários e o nome de seus supervisores.
SELECT DISTINCT F.primeiro_nome, F.nome_meio, F.ultimo_nome, F2.primeiro_nome, F2.nome_meio, F2.ultimo_nome
FROM FUNCIONARIO AS F, FUNCIONARIO AS F2
WHERE F.cpf_supervisor = F2.cpf

-- 9. Para cada departamento, listar o nome do gerente e a data de início da gerência.
SELECT DISTINCT F.primeiro_nome, F.nome_meio, F.ultimo_nome, D.data_inicio_gerente
FROM DEPARTAMENTO AS D
JOIN FUNCIONARIO AS F
ON D.cpf_gerente = F.cpf

-- 10. Exibir o número do projeto e a média de horas trabalhadas por projeto.
SELECT DISTINCT T.numero_projeto, AVG(T.horas) AS media_horas
FROM TRABALHA_EM AS T
GROUP BY T.numero_projeto
