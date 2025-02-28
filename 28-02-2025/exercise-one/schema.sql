DROP SCHEMA IF EXISTS Empresa CASCADE;

CREATE SCHEMA IF NOT EXISTS Empresa;
SET search_path TO Empresa;
SHOW search_path;

-- Impede a remoção do esquema se ele contiver objetos.
--DROP SCHEMA IF EXISTS Empresa RESTRICT;
-- Remove o esquema e todos os objetos dependentes 
-- (tabelas, sequências, funções, etc.).
--DROP SCHEMA IF EXISTS Empresa CASCADE;


DROP TABLE IF EXISTS FUNCIONARIO;

CREATE TABLE IF NOT EXISTS FUNCIONARIO (
	Primeiro_nome VARCHAR(15) NOT NULL,
	Nome_meio CHAR,
	Ultimo_nome VARCHAR(15) NOT NULL,
	Cpf CHAR(11) NOT NULL,
	Data_nascimento DATE,
	Endereco VARCHAR(100),
	Sexo CHAR,
	Salario DECIMAL(10,2),
	Cpf_supervisor CHAR(11),
	Numero_departamento INT NOT NULL,
	CONSTRAINT c_fun_pk PRIMARY KEY (Cpf));


DROP TABLE IF EXISTS DEPARTAMENTO;
CREATE TABLE IF NOT EXISTS DEPARTAMENTO(
	Nome_departamento VARCHAR(15) NOT NULL,  
    Numero_departamento INT NOT NULL,  
    Cpf_gerente CHAR(11) NOT NULL,  
    Data_inicio_gerente DATE,  
    PRIMARY KEY (Numero_departamento),  
    UNIQUE (Nome_departamento), 
    FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(Cpf));  


DROP TABLE IF EXISTS LOCALIZACOES_DEPARTAMENTO;	
CREATE TABLE IF NOT EXISTS LOCALIZACOES_DEPARTAMENTO(
	Numero_departamento INT NOT NULL,  
    Local VARCHAR(15) NOT NULL,  
    CONSTRAINT c_pk_loc_depar PRIMARY KEY (Numero_departamento, Local),  
    CONSTRAINT c_fk_loc_depar_numero_departamento FOREIGN KEY (Numero_departamento) REFERENCES DEPARTAMENTO(Numero_departamento));  


DROP TABLE IF EXISTS PROJETO;
CREATE TABLE IF NOT EXISTS PROJETO(
	Nome_projeto VARCHAR(30) NOT NULL,  
    Numero_projeto INT NOT NULL,  
    Local_projeto VARCHAR(30),  
    Numero_departamento INT NOT NULL,  
    CONSTRAINT c_proje_pk PRIMARY KEY (Numero_projeto),  
    UNIQUE (Nome_projeto),  
    CONSTRAINT c_fk_proje_numero_departamento 
		FOREIGN KEY (Numero_departamento) REFERENCES DEPARTAMENTO(Numero_departamento));  


DROP TABLE IF EXISTS TRABALHA_EM;
CREATE TABLE IF NOT EXISTS TRABALHA_EM(
	Cpf_funcionario CHAR(11) NOT NULL,  
    Numero_projeto INT NOT NULL,  
    Horas DECIMAL(3,1) NOT NULL,  
    CONSTRAINT c_pk_tra_em PRIMARY KEY (Cpf_funcionario, Numero_projeto),  
    CONSTRAINT c_fk_tra_em_cpf_funcionario 
		FOREIGN KEY (Cpf_funcionario) REFERENCES FUNCIONARIO(Cpf) ON DELETE CASCADE ON UPDATE CASCADE,  
    CONSTRAINT c_fk_tra_em_numero_projeto 
		FOREIGN KEY (Numero_projeto) REFERENCES PROJETO(Numero_projeto));  


DROP TABLE IF EXISTS DEPENDENTE;
CREATE TABLE IF NOT EXISTS DEPENDENTE(
	Cpf_funcionario CHAR(11) NOT NULL,  
    Nome_dependente VARCHAR(15) NOT NULL,  
    Sexo CHAR,  
    Data_nascimento DATE,  
    Parentesco VARCHAR(8),  
    CONSTRAINT c_pk_depen PRIMARY KEY (Cpf_funcionario, Nome_dependente),  
    CONSTRAINT c_fk_depen_cpf_funcionario 
		FOREIGN KEY (Cpf_funcionario) REFERENCES FUNCIONARIO(Cpf) ON DELETE CASCADE);
