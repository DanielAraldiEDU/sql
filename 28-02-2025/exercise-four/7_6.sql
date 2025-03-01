-- 7.6. Especifique as seguintes consultas em SQL sobre o esquema de banco de
-- dados da Figura 1.2. Efetue a criação das tabelas e inserção dos dados
-- apresentados na Figura 1.2.
DROP SCHEMA IF EXISTS Escola CASCADE;

CREATE SCHEMA IF NOT EXISTS Escola;
SET search_path TO Escola;
SHOW search_path;

DROP TABLE IF EXISTS ALUNO;
CREATE TABLE IF NOT EXISTS ALUNO (
    Numero_aluno INT PRIMARY KEY,
    Nome VARCHAR(256),
    Tipo_aluno INT,
    Curso VARCHAR(64)
);
INSERT INTO ALUNO (Numero_aluno, Nome, Tipo_aluno, Curso) VALUES
(17, 'Silva', 1, 'CC'),
(8, 'Braga', 2, 'CC');

DROP TABLE IF EXISTS DISCIPLINA;
CREATE TABLE IF NOT EXISTS DISCIPLINA (
    Numero_disciplina VARCHAR(64) PRIMARY KEY,
    Nome_disciplina VARCHAR(256),
    Creditos INT,
    Departamento VARCHAR(64)
);
INSERT INTO DISCIPLINA (Numero_disciplina, Nome_disciplina, Creditos, Departamento) VALUES
('CC1310', 'Introdução à ciência da computação', 4, 'CC'),
('CC3320', 'Estruturas de dados', 4, 'CC'),
('MAT2410', 'Matemática discreta', 3, 'MAT'),
('CC3380', 'Banco de dados', 3, 'CC');

DROP TABLE IF EXISTS PRE_REQUISITO;
CREATE TABLE IF NOT EXISTS PRE_REQUISITO (
    Numero_disciplina VARCHAR(64),
    Numero_pre_requisito VARCHAR(64),
    PRIMARY KEY (Numero_disciplina, Numero_pre_requisito),
    FOREIGN KEY (Numero_disciplina) REFERENCES DISCIPLINA(Numero_disciplina),
    FOREIGN KEY (Numero_pre_requisito) REFERENCES DISCIPLINA(Numero_disciplina)
);
INSERT INTO PRE_REQUISITO (Numero_disciplina, Numero_pre_requisito) VALUES
('CC3380', 'CC3320'),
('CC3380', 'MAT2410'),
('CC3320', 'CC1310');

DROP TABLE IF EXISTS TURMA;
CREATE TABLE IF NOT EXISTS TURMA (
    Identificador_turma INT PRIMARY KEY,
    Numero_disciplina VARCHAR(64),
    Semestre VARCHAR(64),
    Ano INT,
    Professor VARCHAR(64),
    FOREIGN KEY (Numero_disciplina) REFERENCES DISCIPLINA(Numero_disciplina)
);
INSERT INTO TURMA (Identificador_turma, Numero_disciplina, Semestre, Ano, Professor) VALUES
(85, 'MAT2410', 'Segundo', 07, 'Kleber'),
(92, 'CC1310', 'Segundo', 07, 'Anderson'),
(102, 'CC3320', 'Primeiro', 08, 'Carlos'),
(112, 'MAT2410', 'Segundo', 08, 'Chang'),
(119, 'CC1310', 'Segundo', 08, 'Anderson'),
(135, 'CC3380', 'Segundo', 08, 'Santos');

DROP TABLE IF EXISTS REGISTRO_NOTA;
CREATE TABLE IF NOT EXISTS REGISTRO_NOTA (
    Numero_aluno INT,
    Identificador_turma INT,
    Nota CHAR(1),
    PRIMARY KEY (Numero_aluno, Identificador_turma),
    FOREIGN KEY (Numero_aluno) REFERENCES ALUNO(Numero_aluno),
    FOREIGN KEY (Identificador_turma) REFERENCES TURMA(Identificador_turma)
);
INSERT INTO REGISTRO_NOTA (Numero_aluno, Identificador_turma, Nota) VALUES
(17, 112, 'B'),
(17, 119, 'C'),
(8, 85, 'A'),
(8, 92, 'A'),
(8, 102, 'B'),
(8, 135, 'A');

-- A. Recupere os nomes e cursos de todos os alunos com notas A (alunos que
-- têm uma nota A em todas as disciplinas).
SELECT a.Nome, a.Curso
FROM ALUNO AS a
JOIN REGISTRO_NOTA AS r ON a.Numero_aluno = r.Numero_aluno
JOIN TURMA AS t ON r.Identificador_turma = t.Identificador_turma
WHERE r.Nota = 'A'
GROUP BY a.Numero_aluno, a.Nome, a.Curso
HAVING COUNT(DISTINCT t.Numero_disciplina) = (
    SELECT COUNT(DISTINCT t2.Numero_disciplina)
    FROM TURMA AS t2
    WHERE t2.Identificador_turma IN (
        SELECT r2.Identificador_turma
        FROM REGISTRO_NOTA AS r2
        WHERE r2.Numero_aluno = a.Numero_aluno
    )
);

-- B. Recupere os nomes e cursos de todos os alunos que não têm uma nota A em
-- qualquer uma das disciplinas.
SELECT a.Nome, a.Curso
FROM ALUNO AS a
JOIN REGISTRO_NOTA AS r ON a.Numero_aluno = r.Numero_aluno
JOIN TURMA AS t ON r.Identificador_turma = t.Identificador_turma
WHERE r.Nota != 'A'
GROUP BY a.Numero_aluno, a.Nome, a.Curso
HAVING COUNT(DISTINCT t.Numero_disciplina) = (
    SELECT COUNT(DISTINCT t2.Numero_disciplina)
    FROM TURMA AS t2
    WHERE t2.Identificador_turma IN (
        SELECT r2.Identificador_turma
        FROM REGISTRO_NOTA AS r2
        WHERE r2.Numero_aluno = a.Numero_aluno
    )
);
