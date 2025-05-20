SET search_path TO clinica_medica;

-- (1) Mostre o nome, em ordem alfabética, e a quantidade consultas que 
-- cada médico irá realizar.
SELECT 
    (SELECT nome FROM medico WHERE medico.id = c.id_medico) AS nome_medico,
    COUNT(*) AS total_consultas
FROM 
    (SELECT * FROM consulta) AS c
WHERE 
    c.id_medico IN (
        SELECT id FROM medico WHERE id IS NOT NULL
    )
    AND EXISTS (
        SELECT 1 
        FROM paciente p 
        WHERE p.id = c.id_paciente
    )
GROUP BY 
    (SELECT nome FROM medico WHERE medico.id = c.id_medico)
HAVING 
    COUNT(*) >= 0
ORDER BY 
    UPPER(LOWER((SELECT nome FROM medico WHERE medico.id = c.id_medico)));

-- (1 Otimizada)
CREATE INDEX IF NOT EXISTS idx_consulta_id_medico ON consulta(id_medico);
CREATE INDEX IF NOT EXISTS idx_medico_nome ON medico(nome);

SELECT m.id, m.nome, COUNT(c.id) AS total_consultas
FROM medico m
LEFT JOIN consulta c ON m.id = c.id_medico
GROUP BY m.id, m.nome
ORDER BY m.nome;

-- (2) Mostre o nome e a quantidade de consultas de cada especialidade.
SELECT e.nome, COUNT(c.id) AS total_consultas
FROM especialidade e
JOIN medico m ON m.id_especialidade = e.id
JOIN consulta c ON c.id_medico = m.id
GROUP BY e.nome;

-- (2 Otimizada)
CREATE INDEX IF NOT EXISTS idx_medico_especialidade ON medico(id_especialidade);
CREATE INDEX IF NOT EXISTS idx_consulta_medico ON consulta(id_medico);

SELECT e.nome, COUNT(c.id) AS total_consultas
FROM especialidade e
INNER JOIN medico m ON m.id_especialidade = e.id
INNER JOIN consulta c ON c.id_medico = m.id
GROUP BY e.id, e.nome
ORDER BY total_consultas DESC;

-- (3) Mostre o dia e o mês (formato DD/MM), e a maior duração (diferença 
-- entre início e fim) nas consultas de cada dia. 
SELECT 
    TO_CHAR(data_hora_inicio, 'DD/MM') AS dia_mes,
    MAX(EXTRACT(EPOCH FROM (data_hora_fim - data_hora_inicio)) / 60) AS maior_duracao_min
FROM consulta
GROUP BY dia_mes
ORDER BY dia_mes;

-- (3 Otimizada)
CREATE INDEX IF NOT EXISTS idx_consulta_data_inicio ON consulta(data_hora_inicio);

SELECT 
    TO_CHAR(data_hora_inicio, 'DD/MM/YYYY') AS dia_mes,
    MAX(EXTRACT(EPOCH FROM (data_hora_fim - data_hora_inicio)) / 60) AS maior_duracao_min,
    AVG(EXTRACT(EPOCH FROM (data_hora_fim - data_hora_inicio)) / 60) AS media_duracao_min,
    COUNT(*) AS total_consultas
FROM consulta
WHERE data_hora_inicio IS NOT NULL 
  AND data_hora_fim IS NOT NULL
  AND data_hora_fim > data_hora_inicio
GROUP BY DATE_TRUNC('day', data_hora_inicio), dia_mes
ORDER BY DATE_TRUNC('day', data_hora_inicio);

-- (4) Mostre a quantidade, o nome da especialidade e o nome do médico que 
-- mais realizou consultas. 
SELECT 
    COUNT(c.id) AS total_consultas,
    e.nome AS especialidade,
    m.nome AS medico
FROM consulta c
JOIN medico m ON c.id_medico = m.id
JOIN especialidade e ON m.id_especialidade = e.id
GROUP BY m.id, m.nome, e.nome
ORDER BY total_consultas DESC
LIMIT 1;

-- (4 Otimizada)
CREATE INDEX IF NOT EXISTS idx_consulta_medico ON consulta(id_medico);
CREATE INDEX IF NOT EXISTS idx_medico_especialidade ON medico(id_especialidade);

SELECT 
    COUNT(c.id) AS total_consultas,
    e.nome AS especialidade,
    m.nome AS medico
FROM consulta c
INNER JOIN medico m ON c.id_medico = m.id
INNER JOIN especialidade e ON m.id_especialidade = e.id
GROUP BY m.id, e.id, m.nome, e.nome
ORDER BY total_consultas DESC
LIMIT 1;

-- (5) Mostre o nome do paciente, o nome do médico, o nome da especialidade e 
-- o dia e hora do início de todas as consultas. Ordenar pela data e hora de 
-- início. Apelidar todas as colunas da seguinte forma: paciente, médico, 
-- especialidade e data.
SELECT 
    p.nome AS paciente,
    m.nome AS medico,
    e.nome AS especialidade,
    c.data_hora_inicio AS data
FROM consulta c
JOIN paciente p ON c.id_paciente = p.id
JOIN medico m ON c.id_medico = m.id
JOIN especialidade e ON m.id_especialidade = e.id
ORDER BY c.data_hora_inicio;

-- (5 Otimizada)
CREATE INDEX IF NOT EXISTS idx_consulta_data_inicio ON consulta(data_hora_inicio);
CREATE INDEX IF NOT EXISTS idx_consulta_paciente ON consulta(id_paciente);
CREATE INDEX IF NOT EXISTS idx_consulta_medico ON consulta(id_medico);
CREATE INDEX IF NOT EXISTS idx_medico_especialidade ON medico(id_especialidade);

SELECT 
    p.nome AS paciente,
    m.nome AS medico,
    e.nome AS especialidade,
    c.data_hora_inicio AS data
FROM consulta c
INNER JOIN paciente p ON c.id_paciente = p.id
INNER JOIN medico m ON c.id_medico = m.id
INNER JOIN especialidade e ON m.id_especialidade = e.id
WHERE c.data_hora_inicio IS NOT NULL
ORDER BY c.data_hora_inicio;
