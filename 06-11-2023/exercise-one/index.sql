SET SQL_SAFE_UPDATES = 0;

CREATE OR REPLACE VIEW consultas_agendadas AS 
SELECT p.nome AS pet_nome, p.raca AS pet_raca, p.peso AS pet_peso, r.nome AS resp_nome, r.fone AS resp_fone, v.nome AS vet_nome, v.crmv AS vet_crmv, v.especialidade AS vet_especialidade, v.fone AS vet_fone
FROM consulta AS c
INNER JOIN pet AS p
ON c.cod_pet = p.cod
INNER JOIN responsavel AS r
ON p.cod_resp = r.cod
INNER JOIN veterinario AS v
WHERE c.cod_vet = v.cod
ORDER BY c.dt ASC;

CREATE OR REPLACE VIEW enderecoes_responsaveis AS
SELECT r.cod AS resp_codigo, r.nome AS resp_nome, r.cpf AS resp_cpf, r.fone AS resp_fone, r.email AS resp_email, r.cod_end AS resp_cod_endereco, e.cod AS end_cod, e.logradouro AS end_logradouro, e.numero AS end_num, e.complemento AS end_complemento, e.cep AS end_cep
FROM responsavel AS r
INNER JOIN clinica_vet.endereco AS e
ON e.cod = r.cod_end;

CREATE OR REPLACE VIEW historico_consultas AS
SELECT p.nome AS pet_nome, p.raca AS pet_raca, p.peso AS pet_peso, r.nome AS resp_nome, r.fone AS resp_fone, v.nome AS vet_nome, v.crmv AS vet_crmv, v.fone AS vet_fone
FROM consulta AS c
INNER JOIN pet AS p
ON c.cod_pet = p.cod
INNER JOIN responsavel AS r
ON p.cod_resp = r.cod
INNER JOIN veterinario AS v
WHERE c.cod_vet = v.cod
ORDER BY c.dt DESC;

ALTER TABLE pet
ADD COLUMN idade INT;
UPDATE pet 
SET idade = (
	TIMESTAMPDIFF(YEAR, pet.data_nasc, NOW())
);

SELECT r.nome
FROM responsavel AS r
WHERE nome = _utf8 'marçia luna duarte' COLLATE utf8_unicode_ci;

UPDATE pet 
SET pet.peso = 5 
WHERE pet.raca = 'pincher';

SELECT e.cod AS codigo, e.cidade, e.cep, e.complemento, e.logradouro, e.numero, e.uf
FROM endereco AS e
INNER JOIN veterinario AS v
ON e.cod = v.cod_end
WHERE e.complemento IS NULL
UNION
SELECT e.cod AS codigo, e.cidade, e.cep, e.complemento, e.logradouro, e.numero, e.uf 
FROM endereco AS e
INNER JOIN responsavel AS r
ON e.cod = r.cod_end
WHERE e.complemento IS NULL;
