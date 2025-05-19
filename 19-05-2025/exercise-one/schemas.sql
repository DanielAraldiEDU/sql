CREATE SCHEMA IF NOT EXISTS clinica_medica;
SET search_path TO clinica_medica;

CREATE TABLE especialidade (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

CREATE TABLE medico (
    id SERIAL PRIMARY KEY,
    id_especialidade INT REFERENCES especialidade(id),
    nome VARCHAR(100) NOT NULL,
    celular VARCHAR(15)
);

CREATE TABLE paciente (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    celular VARCHAR(15)
);

CREATE TABLE consulta (
    id SERIAL PRIMARY KEY,
    id_medico INT REFERENCES medico(id),
    id_paciente INT REFERENCES paciente(id),
    data_hora_inicio TIMESTAMP,
    data_hora_fim TIMESTAMP
);

-- Populando dados com DO block (Apenas para simular um banco cheio)
DO $$
DECLARE
    i INT := 1;
    x_especialidades INT := 30;
    y_medicos INT := 200;
    k_pacientes INT := 50000;
    z_consultas INT := 3000;
BEGIN
    -- Especialidades
    FOR i IN 1..x_especialidades LOOP
        INSERT INTO especialidade (nome)
        VALUES ('Especialidade ' || i);
    END LOOP;

    -- Médicos
    FOR i IN 1..y_medicos LOOP
        INSERT INTO medico (nome, celular, id_especialidade)
        VALUES (
            'Medico ' || i,
            '99999-' || LPAD(i::text, 4, '0'),
            FLOOR(1 + RANDOM() * x_especialidades)::INT
        );
    END LOOP;

    -- Pacientes
    FOR i IN 1..k_pacientes LOOP
        INSERT INTO paciente (nome, celular)
        VALUES (
            'Paciente ' || i,
            '98888-' || LPAD(i::text, 4, '0')
        );
    END LOOP;

    -- Consultas
    FOR i IN 1..z_consultas LOOP
        INSERT INTO consulta (id_medico, id_paciente, data_hora_inicio, data_hora_fim)
        VALUES (
            FLOOR(1 + RANDOM() * y_medicos)::INT,
            FLOOR(1 + RANDOM() * k_pacientes)::INT,
            NOW() + (FLOOR(RANDOM() * 30) || ' days')::INTERVAL,
            NOW() + (FLOOR(RANDOM() * 30) || ' days')::INTERVAL + INTERVAL '1 hour'
        );
    END LOOP;
END $$;

-- Selects para comprovar que as tabelas estão populadas
SELECT * FROM especialidade;
SELECT * FROM medico;
SELECT * FROM paciente;
SELECT * FROM consulta;
