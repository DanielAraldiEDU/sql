-- Define o esquema antes das inserções
SET search_path TO empresa;

-- Inserir dados na tabela FUNCIONARIO
INSERT INTO FUNCIONARIO (Primeiro_nome, Nome_meio, Ultimo_nome, Cpf, Data_nascimento, Endereco, Sexo, Salario, Cpf_supervisor, Numero_departamento) 
VALUES 
    ('João', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000.00, '33344555587', 5),
    ('Fernando', 'T', 'Wong', '33344555587', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000.00, '88866555576', 5),
    ('Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000.00, '98765432168', 4),
    ('Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av. Arthur de Lima, 54, Santo André, SP', 'F', 43000.00, '88866555576', 4),
    ('Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000.00, '33344555587', 5),
    ('Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000.00, '33344555587', 5),
    ('André', 'V', 'Pereira', '98798798733', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000.00, '98765432168', 4),
    ('Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000.00, NULL, 1);

-- Inserir dados na tabela DEPARTAMENTO
INSERT INTO DEPARTAMENTO (Nome_departamento, Numero_departamento, Cpf_gerente, Data_inicio_gerente) 
VALUES 
    ('Pesquisa', 5, '33344555587', '1988-05-22'),
    ('Administração', 4, '98765432168', '1995-01-01'),
    ('Matriz', 1, '88866555576', '1981-06-19');

-- Inserir dados na tabela LOCALIZACOES_DEPARTAMENTO
INSERT INTO LOCALIZACOES_DEPARTAMENTO (Numero_departamento, Local) 
VALUES 
    (1, 'São Paulo'),
    (4, 'Mauá'),
    (5, 'Santo André'),
    (5, 'Itu'),
    (5, 'São Paulo');

-- Inserir dados na tabela PROJETO
INSERT INTO PROJETO (Nome_projeto, Numero_projeto, Local_projeto, Numero_departamento) 
VALUES 
    ('ProdutoX', 1, 'Santo André', 5),
    ('ProdutoY', 2, 'Itu', 5),
    ('ProdutoZ', 3, 'São Paulo', 5),
    ('Informatização', 10, 'Mauá', 4),
    ('Reorganização', 20, 'São Paulo', 1),
    ('Novos Benefícios', 30, 'Mauá', 4);

-- Inserir dados na tabela TRABALHA_EM
INSERT INTO TRABALHA_EM (Cpf_funcionario, Numero_projeto, Horas) 
VALUES 
    ('12345678966', 1, 32.5),
    ('12345678966', 2, 7.5),
    ('66688444476', 3, 40.0),
    ('45345345376', 1, 20.0),
    ('45345345376', 2, 20.0),
    ('33344555587', 3, 10.0),
    ('33344555587', 10, 10.0),
    ('33344555587', 20, 10.0),
    ('99988777767', 30, 30.0),
    ('99988777767', 3, 10.0),
    ('98798798733', 10, 35.0),
    ('98798798733', 30, 5.0),
    ('98765432168', 30, 20.0),
    ('98765432168', 20, 15.0),
    ('88866555576', 20, 0.0);

-- Inserir dados na tabela DEPENDENTE
INSERT INTO DEPENDENTE (Cpf_funcionario, Nome_dependente, Sexo, Data_nascimento, Parentesco) 
VALUES 
    ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha'),
    ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filho'),
    ('33344555587', 'Janaína', 'F', '1958-03-05', 'Esposa'),
    ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido'),
    ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho'),
    ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha'),
    ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');
