-- 7.7. Em SQL, especifique as seguintes consultas sobre o banco de dados da
-- Figura 5.5 usando o conceito de consultas aninhadas e conceitos descritos
-- neste capítulo.

-- A. Recupere os nomes de todos os funcionários que trabalham no
-- departamento que tem aquele com o maior salário entre todos os
-- funcionários.
SELECT d.nome_departamento, f.primeiro_nome, f.nome_meio, f.ultimo_nome
FROM DEPARTAMENTO as d
JOIN FUNCIONARIO as f ON d.numero_departamento = f.numero_departamento
WHERE f.salario = (
	SELECT salario 
	FROM FUNCIONARIO
	WHERE salario = (
		SELECT MAX(salario) 
		FROM FUNCIONARIO
	)
)
ORDER BY d.nome_departamento, f.primeiro_nome, f.nome_meio, f.ultimo_nome;

-- B. Recupere os nomes de todos os funcionários cujo supervisor do supervisor
-- tenha como CPF o número ‘88866555576’.
SELECT f.primeiro_nome, f.nome_meio, f.ultimo_nome
FROM FUNCIONARIO as f
WHERE f.cpf_supervisor IN (
	SELECT cpf_supervisor 
	FROM FUNCIONARIO
	WHERE cpf_supervisor = '88866555576'
)
ORDER BY f.primeiro_nome, f.nome_meio, f.ultimo_nome;

-- C. Recupere os nomes dos funcionários que ganham pelo menos R$ 10.000,00
-- a mais que o funcionário que recebe menos na empresa.
SELECT f.primeiro_nome, f.nome_meio, f.ultimo_nome
FROM FUNCIONARIO AS f
WHERE f.salario >= (
	SELECT MIN(salario)
	FROM FUNCIONARIO
) + 10000
ORDER BY f.primeiro_nome, f.nome_meio, f.ultimo_nome;
