SET search_path TO Empresa;

-- CAPITULO 6
-- especificação de restrição em sql
-- Especificando restrições de atributo e defaults de atributo.
--> SQL usa os termos tabela, linha e coluna 
-- para os termos do modelo relacional formal relação, tupla e atributo, respectivamente.

-->  O principal comando SQL para a definição de  dados é o CREATE, 
-- que pode ser usado para criar esquemas, tabelas (relações), tipos
-- e domínios, bem como outras construções, como views, stored procedures e triggers.

--> 6.1
--> Criação de dominio
CREATE DOMAIN TIPO_CPF AS CHAR(12); 

-- 6.2.1 Especificando restrições de atributo e defaults de atributo 
-- Restrição NOT NULL e definição de valor DEFAULT
Numero_departamento INT NOT NULL DEFAULT 1
Cpf_gerente CHAR(11) NOT NULL DEFAULT '88866555576'

-- 6.2.4. Especificando restrições sobre tuplas usando CHECK 
-- Outro tipo de restrição pode limitar valores de atributo ou domínio usando a  
-- cláusula CHECK após uma definição de atributo ou domínio.
Numero_departamento INT NOT NULL 
	CHECK (Numero_departamento > 0 AND Numero_departamento < 21)

-- Restição de chave primparia PRIMARY KEY
Numero_departamento INT PRIMARY KEY,
-- ou
Numero_departamento INT
PRIMARY KEY (Numero_departamento),

-- Restrição de Unicidade - UNIQUE
Nome_departamento VARCHAR(15) UNIQUE,
-- ou
Nome_departamento VARCHAR(15),
UNIQUE(Nome_departamento),

-- Restrição de chave estrangeira - FOREIGN KEY
CREATE TABLE LOCALIZACOES_DEPARTAMENTO
(..., 
PRIMARY KEY (Numero_departamento, Local),
FOREIGN KEY (Numero.departamento) 
	REFERENCES DEPARTAMENTO(Numero.departamento)
	ON DELETE CASCADE ON UPDATE CASCADE
);

-- Ação de disparo referencial
-- cláusula de ação de disparo referencial a qualquer restrição de chave estrangeira
-- qualificadores
ON DELETE /ou / ON UPDATE
--opções
SET NULL, CASCADE e SET DEFAULT

-- CREATE DOMAIN
CREATE DOMAIN D_CPF AS VARCHAR(12)
CHECK (VALUE ~ '^[0-9]{8}-[0-9]{2}$');

CREATE DOMAIN D_NUM AS INTEGER
CHECK (VALUE > 0 AND VALUE < 21);

-- NOMEANDO RESTRIÇÕES
CONSTRAINT CHAVEPRIMDEPARTAMENTO
	PRIMARY KEY(Numero_departamento),
	
CONSTRAINT CHAVEUNICADEPARTAMENTO
	UNIQUE (Nome_departamento),
	
CONSTRAINT CHAVEESTRDEPARTAMENTO_FUNC
	FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(Cpf)
		ON DELETE SET DEFAULT ON UPDATE CASCADE);

-- Restrições baseadas em tupla
-- 6.3.1 A estrutura SELECT-FROM-WHERE das consultas SQL básicas 
-- A estrutura SELECT-FROM-WHERE das consultas SQL básicas

SELECT <lista atributos> 
FROM <lista tabelas>
WHERE <condição>;

--> SELECT da SQL especifica os atributos cujos valores devem ser 
-- recuperados, chamados *atributos de projeção* na álgebra relacional
--> WHERE especifica a condição booleana que deve ser verdadeira para  
-- qualquer tupla recuperada, que é conhecida como *condição de seleção* na álgebra  relacional.

-- C0
-- OBJETIVO:  Recuperar a data de nascimento e o endereço do(s) 
-- funcionário(s)  cujo nome seja 'João B. Silva'. 
SELECT Data_nascimento, Endereco
	FROM FUNCIONARIO
	WHERE Primeiro_nome='João' AND Nome_meio='B' AND
		Ultimo_nome='Silva';

-- C1
-- OBJETIVO: Recuperar o nome e o endereço de todos os 
-- funcionários que trabalham para o departamento 'Pesquisa'. 
SELECT Primeiro_nome, Ultimo_nome, Endereco
	FROM FUNCIONARIO, DEPARTAMENTO
	WHERE Nome_departamento ='Pesquisa' AND 
		DEPARTAMENTO.Numero_departamento = FUNCIONARIO.Numero_departamento;

-- C2
-- OBJETIVO: Para cada projeto localizado em 'Mauá', liste o 
-- número do projeto, o número do departamento que o controla e 
-- sobrenome, endereço e data de nascimento do gerente do departamento. 
SELECT Numero_projeto, DEPARTAMENTO.Numero_departamento, Ultimo_nome, 
		Endereco, Data_nascimento  
	FROM PROJETO, DEPARTAMENTO, FUNCIONARIO  
	WHERE PROJETO.Numero_departamento = DEPARTAMENTO.Numero_departamento 
		AND Cpf_gerente = Cpf AND Local_projeto = 'Mauá'; 
		
-- Uma consulta que envolve apenas condições de seleção e junção mais atributos  
-- de projeção é conhecida como uma consulta seleção-projeção-junção.

-- 6.3.2 Nomes de atributos ambíguos (qualificação de atributos)
--> Em SQL, o mesmo nome pode ser usado para dois (ou mais) 
-- atributos, desde que estes estejam em relações diferentes.
--> Se isso acontecer, e uma consulta em  múltiplas relações se referir a dois 
-- ou mais atributos com o mesmo nome, é preciso  qualificar o nome do atributo 
-- com o nome da relação para evitar ambiguidade. 
--> Isso é feito prefixando o nome da relação ao nome do atributo e separando os  dois por um ponto.

-- C1A: havendo ambiguidade
SELECT Primeiro_nome, FUNCIONARIO.Nome, Endereco  
	FROM FUNCIONARIO, DEPARTAMENTO  
	WHERE DEPARTAMENTO.Nome = 'Pesquisa' AND 
		DEPARTAMENTO.Numero_departamento = FUNCIONARIO.Numero_departamento; 

-- C1’: 
-- Nomes de atributo totalmente qualificados podem ser usados por clareza 
-- mesmo  que não haja ambiguidade nos nomes de atributo. 
SELECT FUNCIONARIO.Primeiro_nome, FUNCIONARIO.Ultimo_nome, FUNCIONARIO.Endereco  
	FROM FUNCIONARIO, DEPARTAMENTO  
	WHERE DEPARTAMENTO.Nome_departamento = 'Pesquisa' 
		AND  DEPARTAMENTO.Numero_departamento =  FUNCIONARIO.Numero_departamento;


-- C1B: prática recomendada 
SELECT F.Primeiro_nome, F.Ultimo_nome, F.Endereco  
	FROM FUNCIONARIO AS F, DEPARTAMENTO AS D  
	WHERE D.Nome_departamento = 'Pesquisa' AND  D.Numero_departamento=F.Numero_departamento; 
-- usar esse mecanismo de nomeação de apelidos em qualquer consulta  SQL 
-- para especificar variáveis de tupla para cada tabela na cláusula WHERE, 
-- não importando se a mesma relação precisa ser referenciada mais de uma vez.


-- C8: ambiguidade em uma mesma relação referenciada duas vezes
-- OBJETIVO: Para cada funcionário, recupere o primeiro e o último nome 
-- do funcionário e o primeiro e o último nome de seu supervisor imediato. 
SELECT F.Primeiro_nome, F.Ultimo_nome, S.Primeiro_nome, S.Ultimo_nome  
	FROM FUNCIONARIO AS F, FUNCIONARIO AS S.
	WHERE F.Cpf_supervisor=S.Cpf; 

--> Renomear atributos da relação dentro da consulta SQL
SELECT * FROM FUNCIONARIO AS F(Pn, Nm, Un, Cpf, Dn, Ende, Sexo, Sal, Cpfs, Nd);

-- 6.3.3 Cláusula WHERE não especificada e uso do asterisco 
-- C9:
-- OBJETIVO:  Selecionar todos os Cpfs de FUNCIONARIO
SELECT Cpf FROM FUNCIONARIO;  
--> É extremamente importante especificar cada condição de seleção e junção na  cláusula WHERE.

-- C10: 
-- OBJETIVO: selecionar todos os funcionparios e seus respectivos departamentos.
SELECT Cpf, Nome_departamento
	FROM FUNCIONARIO, DEPARTAMENTO; 
-- OBJETIVO ALCANÇADO: seleciona todas as combinações de um Cpf de FUNCIONARIO
-- e um Nome_departamento de DEPARTAMENTO, independentemente de o funcionário 
-- trabalhar ou não para o departamento.
-- Faltou uma condição de junção para um resultado coerente.
WHERE FUNCIONARIO.Numero_departamento = DEPARTAMENTO.Numero_departamento;
--> Se alguma condição desse tipo for esquecida, o resultado poderá ser 
-- relações incorretas e muito grandes.
-- Produto cartesiano seguido de uma projeção.

-- 6.3.4. TABELAS COMO CONJUNTOS EM SQL
--> SQL normalmente trata uma tabela como um MULTICONJUNTO 
-- (tuplas duplicadas podem aparecer mais de uma vez)
--> SQL não elimina automaticamente linhas duplicadas
-- *A eliminação de duplicatas é uma operação dispendiosa.
-- *O usuário pode querer ver as tuplas duplicadas no resultado de uma consulta. 
-- *Quando uma função agregada é aplicada às tuplas, na maioria  dos casos não queremos eliminar duplicatas. 

-- C11:
-- OBJETIVO: Recuperar o salário de cada funcionário
SELECT ALL Salario FROM FUNCIONARIO;  
-- C11A:
-- OBJETIVO: selecionar todos os valores de salário distintos
SELECT DISTINCT Salario  FROM FUNCIONARIO;

--> A SQL incorporou diretamente algumas das operações de conjunto da teoria de 
-- conjuntos da matemática, que também fazem parte da álgebra relacional
--> Operações de união de conjunto (UNION)
UNION
--> diferença de conjunto (EXCEPT)
EXCEPT
--> e interseção de conjunto (INTERSECT).
INTERSECT
--> Para estas operações as tuplas duplicadas são eliminadas do resultado.
-- Estas operações de conjunto aplicadas apenas a 
-- RELAÇÕES COMPATÍVEIS EM TIPO: ambas relações precisam ter os mesmos atributos
-- e que os atributos apareçam na mesma ordem nas duas relações.

-- C4A: 
-- OBJETIVO: Fazer uma lista de todos os números de projeto para aqueles que  
-- envolvam um funcionário cujo último nome é 'Silva', seja como um trabalhador,  
-- seja como um gerente do departamento que controla o projeto.
(SELECT DISTINCT Numero_projeto  -- trabalha como gerente
	FROM PROJETO P, DEPARTAMENTO D, FUNCIONARIO F  
	WHERE P.Numero_departamento = D.Numero_departamento 
		AND D.Cpf_gerente = F.Cpf  AND F.Ultimo_nome = 'Silva')  
UNION  
(SELECT DISTINCT P.Numero_projeto  -- trabalha como trabalhador
	FROM PROJETO P, TRABALHA_EM T, FUNCIONARIO F  
	WHERE P.Numero_projeto = T.Numero_projeto  
		AND T.Cpf_funcionario = F.Cpf AND F.Ultimo_nome = 'Silva'); 

--> Para resultados multiconjuntos destas operações
-- A SQL também possui operações multiconjunto correspondentes, que são acompanhadas 
-- da palavra-chave ALL (UNION ALL, EXCEPT ALL, INTERSECT ALL).

-- 6.3.5 Combinação de padrão de subcadeias e operadores aritméticos 
-- C12: 
-- OBJETIVO: Recuperar todos os funcionários cujo endereço esteja em Curitiba, PR. 
SELECT Primeiro_nome, Ultimo_nome  
	FROM FUNCIONARIO  
	WHERE Endereco LIKE '%PR%'; 

-- C12A: 
-- OBJETIVO: Encontrar todos os funcionários que nasceram durante a década  de 1950. 
SELECT Primeiro_nome, Ultimo_nome
	FROM FUNCIONARIO
	WHERE TO_CHAR(Data_nascimento, 'DD-MM-YYYY') LIKE '________5_';
--> Se um sublinhado ou % for necessário como um caractere literal 
-- na cadeia, este  deve ser precedido por um caractere de escape.


-- Operadores aritmeticos na consulta
-- Os operadores aritméticos padrão para adição (+), subtração (–), 
-- multiplicação (*) e divisão (/) podem ser  aplicados a valores ou 
-- atributos numéricos com domínios numéricos.
-- C13: 
-- OBJETIVO: Mostrar os salários resultantes se cada funcionário que 
-- trabalha no  projeto 'ProdutoX' receber um aumento de 10%. 
SELECT F.Primeiro_nome, F.Ultimo_nome, F.Salario, 1.1 * F.Salario AS Aumento_salario  
	FROM FUNCIONARIO AS F, TRABALHA_EM AS T, PROJETO AS P  
	WHERE F.Cpf = T.Cpf_funcionario AND T.Numero_projeto = P.Numero_projeto  
		AND P.Nome_projeto = 'ProdutoX'; 

--USO DO BETWEEN
-- C14:
-- OBJETIVO: Recuperar todos os funcionários no departamento 5 cujo salário  
-- esteja entre R$30.000 e R$40.000. 
FROM FUNCIONARIO  
	WHERE (Salario BETWEEN 30000 AND 40000) AND Numero_departamento = 5;  
-- A condição (Salario BETWEEN 30000 AND 40000)
-- equivale a ((Salario >= 30000) AND (Salario <= 40000)).


-- 6.3.6 Ordenação no resultado de pesquisas
-- ORDER BY: permite ordenar as tuplas no resultado de uma consulta  
-- pelos valores de um ou mais dos atributos que aparecem no resultado da consulta, 
-- C15: 
-- Objetivo: Recuperar uma lista dos funcionários e dos projetos em que estão
-- 			trabalhando, ordenada por departamento e, dentro de cada departamento, 
--			ordenada  alfabeticamente pelo último nome e depois pelo primeiro nome. 
SELECT D.Nome_departamento, F.Ultimo_nome, F.Primeiro_nome,  P.Nome_projeto
	FROM DEPARTAMENTO AS D, FUNCIONARIO AS F, TRABALHA_EM AS T, PROJETO AS P
	WHERE D.Numero_departamento = F.Numero_departamento
		AND F.Cpf= T.Cpf_funcionario AND T.Numero_projeto = P.Numero_projeto
	ORDER BY D.Nome_departamento, F.Ultimo_nome, F.Primeiro_nome;
-- ORDER BY D.Nome_departamento DESC, F.Ultimo_nome ASC, F.Primeiro_nome ASC 
-- ASC é definido implicitamente, para usar ordenação decrescente usa-se DESC.



-- 6.3.7. CONSULTAS E RECUPERAÇÃO SQL BÁSICAS
-- Uma consulta de recuperação simples em SQL pode consistir em até quatro cláusulas
-- mas apenas as duas primeiras — SELECT e FROM — são obrigatórias.
SELECT <lista atributos>  
	FROM <lista tabelas>  
	[WHERE <condição>]  
	[ORDER BY <lista atributos>]; 
-- SELECT lista os atributos a serem recuperados (projeção)
-- FROM especifica todas as relações necessárias na consulta simples.
-- WHERE identifica as condições para selecionar as tuplas dessas relações (seleção)
-- ORDER BY especifica uma ordem para exibir os resultados da pesquisa


-- 6.4 Instruções INSERT, DELETE e UPDATE em SQL 
-- 6.4.1. O COMANDO INSERT
--U1: 
INSERT INTO FUNCIONARIO  
	VALUES ('Ricardo', 'K', 'Marini', '65329865388', '30-12-1962', 
		'Rua Itapira, 44, Santos, SP', 'M', 37000, '65329865388', 4); 
-- Ordem não especificada, os valores devem ser listados na mesma ordem 
-- em que  os atributos correspondentes foram especificados no comando CREATE TABLE


-- U1A: 
INSERT INTO FUNCIONARIO (Primeiro_nome, Ultimo_nome, 
								Numero_departamento, Cpf)  
	VALUES ('Ricardo', 'Marini', 4, '65329865388'); 
-- Define a ordem com que os atributos serão informados na inserção.
-- Atributos que permitem nulos e com valores default podem ser omitidos.

--U2: 
INSERT INTO FUNCIONARIO (Primeiro_nome, Ultimo_nome, Cpf, 
										Numero_departamento)  
	VALUES ('Roberto', 'Gomes', '98076054011', 2);  
-- (U2 é rejeitado se a verificação da integridade referencial 
--  for oferecida pelo SGBD.)  
-- Não necessita seguir uma ordem específica.

--U2A: 
INSERT INTO FUNCIONARIO (Primeiro_nome, Ultimo_nome, 
										Numero_departamento)  
	VALUES ('Roberto', 'Gomes', 5);  
-- (U2A é rejeitado se a verificação de NOT NULL for oferecida pelo SGBD.) 


-- Uma variação do comando INSERT inclui várias tuplas em uma relação 
-- em conjunto com a criação da relação e sua carga com o resultado de uma consulta.
--U3A: criacao tabela temporária
DROP TABLE IF EXISTS INFORMACOES_TRABALHA_EM;
CREATE TEMPORARY TABLE INFORMACOES_TRABALHA_EM(
	Nome_funcionario VARCHAR(30),  
	Nome_projeto VARCHAR(30),  
	Horas_semanal DECIMAL(3,1));  
	
-- U3B: inserção de dados na tabela temporária a partir do select em outra
INSERT INTO INFORMACOES_TRABALHA_EM (Nome_funcionario, Nome_projeto, Horas_semanal)  
	SELECT F.Ultimo_nome, P.Nome_projeto, T.Horas  
	FROM PROJETO P, TRABALHA_EM T, FUNCIONARIO F  
	WHERE P.Numero_projeto = T.Numero_projeto AND T.Cpf_funcionario = F.Cpf; 

SELECT * FROM INFORMACOES_TRABALHA_EM;

-- Pode feito em uma única instrução 
-- Criacao tabela e inserção dos dados
DROP TABLE IF EXISTS INFORMACOES_TRABALHA_EM;
CREATE TEMPORARY TABLE INFORMACOES_TRABALHA_EM AS
SELECT 
    F.Ultimo_nome AS Nome_funcionario,  
    P.Nome_projeto,  
    T.Horas AS Horas_semanal
FROM PROJETO P, TRABALHA_EM T, FUNCIONARIO F
WHERE P.Numero_projeto = T.Numero_projeto 
AND T.Cpf_funcionario = F.Cpf;

SELECT * FROM INFORMACOES_TRABALHA_EM;
-- Observe que a tabela INFORMACOES_TRABALHA_EM pode não estar atualizada; 
-- ou seja, se atualizarmos qualquer uma das relações PROJETO, TRABALHA_EM ou 
-- FUNCIONARIO depois de emitir U3B, a informação em INFORMACOES_TRABALHA_EM pode ficar desatualizada. 
-- Temos de criar uma  visão, ou view, para manter essa tabela atualizada. 

-- LIKE - Outra forma de carregar dados é criar uma nova tabela TNOVA que tenha  
-- os mesmos atributos da tabela T existente e carregar alguns dos dados atualmente em T para TNOVA.
DROP TABLE IF EXISTS TNOVA;
CREATE TABLE TNOVA LIKE FUNCIONARIO  
	(SELECT F.*  FROM FUNCIONARIO AS F  WHERE F.Numero_departamento = 5) WITH DATA; 
-- NÃO EXISTE NO POSTGRESQL DEVE-SE USAR O AS.

-- Consulta equivalente no PostgerSQL
DROP TABLE IF EXISTS TNOVA;
CREATE TABLE TNOVA AS 
	SELECT * FROM FUNCIONARIO 
	WHERE Numero_departamento = 5;
SELECT * FROM TNOVA;


-- 6.4.2. COMANDO DELETE
-- U4A: 
DELETE FROM FUNCIONARIO  
	WHERE Ultimo_nome = 'Braga';  

-- U4B: 
DELETE FROM FUNCIONARIO  
	WHERE Cpf = '12345678966';  

-- U4C: 
DELETE FROM FUNCIONARIO  
	WHERE Numero_departamento = 5;  
	
-- U4D: CUIDADO
DELETE FROM FUNCIONARIO; 


-- 6.4.3. COMANDO UPDATE
--U5: 
-- OBJETIVO: alterar o local e o número de  departamento que controla 
-- o número de projeto 10 para ‘Santo André’ e 5, respectivamente,
UPDATE PROJETO  
	SET Local_projeto = 'Santo André', Numero_departamento = 5
	WHERE Numero_projeto = 10;
	
-- U6:
-- OBJETIVO: Conceder a todos os funcionários no departamento 
-- 'Pesquisa' um aumento de 10%  no salário.
 UPDATE FUNCIONARIO  
 	SET Salario = Salario * 1.1  
	WHERE Numero_departamento = 5; 

-- U6A
 UPDATE FUNCIONARIO  
 	SET Salario = Salario * 1.1;



-- *** CAPITULO 7 ***
-- 7.1.1. Comparações envolvendo NULL e lógica de três valores.
-- Considere os seguintes exemplos para ilustrar cada um  dos significados de NULL. 
-- *Valor desconhecido: ex. não se conhece a data de nascimento de uma pessoa.
-- *Valor indisponível ou retido: ex. pessoa tem um telefone residencial, mas não deseja aque ele ser listado.
-- *Atributo não aplicável: ex. numero da carteira de motorista seria nulo caso a pessoa não a possui.
-- Apresentar trababalho do conectivos

-- Quando um registro com NULL em um de seus atributos está envolvido em 
-- uma operação de comparação, o resultado  é considerado UNKNOWN, 
-- ou desconhecido (ele pode ser TRUE ou FALSE).
SELECT 
    NULL = NULL AS resultado_igual,
    NULL <> NULL AS resultado_diferente,
    NULL OR TRUE AS resultado_or,
    NULL AND FALSE AS resultado_and;
--> TRUE significa que a condição foi satisfeita.
--> FALSE significa que a condição não foi satisfeita.
--> NULL representa um valor desconhecido, o que na prática 
-- pode ser interpretado como UNKNOWN em expressões booleanas.

-- C18: 
-- OBJETIVO:Recuperar os nomes de todos os funcionários 
-- que não possuem  supervisores.
SELECT Primeiro_nome, Ultimo_nome  
	FROM FUNCIONARIO  
	WHERE Cpf_supervisor IS NULL; -- ou IS NOT NULL;


-- CONSULTAS ANINHADAS, TUPLAS E COMPARAÇÃO DE CONJUNTO/MULTICONJUNTO
--> Algumas consultas precisam que os valores existentes no banco de dados 
-- sejam  buscados e depois usados em uma condição de comparação.
--> Essas consultas podem  ser formuladas convenientemente com o 
-- uso de *consultas aninhadas*, que são blocos select-from-where 
-- completos dentro de outra consulta SQL.
--> Essas consultas aninhadas também podem aparecer na cláusula WHERE, 
-- ou na cláusula FROM, ou na cláusula SELECT, ou em outras cláusulas SQL, como for preciso.

-- C4A: 
--> OBJETIVO: selecionar numero dos projetos onde 'Silva' trabalha como 
-- funcionário ou como cordenador.
SELECT DISTINCT Numero_projeto  
	FROM PROJETO  -- tupla de projeto incluida no resultado se
	WHERE Numero_projeto IN  
	(SELECT Numero_projeto  -- como coordenador
		FROM PROJETO P, DEPARTAMENTO D, FUNCIONARIO F  
		WHERE P.Numero_departamento =  D.Numero_departamento  
			AND D.Cpf_gerente = F.Cpf AND F.Ultimo_nome = 'Silva')  
	OR  Numero_projeto IN  
	(SELECT Numero_projeto  -- como trabalhador
		FROM TRABALHA_EM T, FUNCIONARIO F  
		WHERE T.Cpf_funcionario = F.Cpf AND F.Ultimo_nome = 'Silva');		
-- A C4A introduz o operador de comparação IN, que compara  um valor v com um conjunto 
-- (ou multiconjunto) de valores V e avalia como TRUE  se v for um dos elementos em V. 


-- Tuplas de valores em comparações
-- OBJETIVO: selecionará os Cpfs de todos os funcionários que 
-- trabalham na  mesma combinação (projeto, horas) em algum projeto 
-- no qual o funcionário ‘João Silva’ (cujo Cpf = ‘12345678966’) trabalha.
SELECT DISTINCT Cpf_funcionario  
	FROM TRABALHA_EM  
	WHERE (Numero_projeto, Horas) 
	IN 
	(SELECT Numero_projeto, Horas  
	 FROM TRABALHA_EM  
	 WHERE Cpf_funcionario = '1234567896'); 


-- OBJETIVO: retornar os nomes dos funcionários cujo salário é maior 
-- que o salário de todos os funcionários no departamento 5.
SELECT Ultimo_nome, Primeiro_nome  
	FROM FUNCIONARIO  
	WHERE Salario > ALL 
		(SELECT Salario  FROM FUNCIONARIO  WHERE Numero_departamento = 5); 

-- instrução equivalente
SELECT Ultimo_nome, Primeiro_nome
	FROM FUNCIONARIO
	WHERE Salario > 
	(SELECT MAX(Salario) FROM FUNCIONARIO WHERE Numero_departamento = 5);

-- C16
-- OBJETIVO: Recuperar o nome de cada funcionário que tem 
-- um dependente com o mesmo nome e o mesmo sexo do funcionário. 
SELECT F.Primeiro_nome, F.Ultimo_nome  
	FROM FUNCIONARIO AS F  
	WHERE F.Cpf IN 
	(SELECT D.Cpf_funcionario -- dependente nome e sexo igual ao funcionario
		FROM DEPENDENTE AS D  
		WHERE F.Primeiro_nome = D.Nome_dependente AND F.Sexo = D.Sexo); 

-- C16A: C16 consulta aninhada, expressa como uma única consultla de bloco em C16A.
-- OBJETIVO: Recuperar o nome de cada funcionário que tem um dependente  
-- com o mesmo nome e o mesmo sexo do funcionário. 
-- C16A:
SELECT F.Primeiro_nome, F.Ultimo_nome  
	FROM UNCIONARIO AS F, DEPENDENTE AS D  
	WHERE F.Cpf = D.Cpf_funcionario 
		AND F.Sexo = D.Sexo AND F.Primeiro_nome = D.Nome_dependente; 
		
-- 7.1.3 Consultas aninhadas correlacionadas
--> Sempre que uma condição na cláusula WHERE de uma consulta aninhada  
-- referencia algum atributo de uma relação declarada na consulta externa, 
-- as duas consultas são consideradas CORRELACIONADAS.
--> A consulta aninhada é avaliada uma vez para cada tupla (ou combinação de tuplas) na consulta externa.
--> Uma consulta escrita com blocos aninhados select-from-where e usando  os operadores de 
-- comparação = ou IN sempre pode ser expressa como uma única consulta em bloco.



-- 7.1.4 As funções EXISTS e UNIQUE em SQL 
--> EXISTS e UNIQUE são funções booleanas que retornam TRUE ou FALSE; 
-- logo, elas  podem ser usadas em uma condição da cláusula WHERE.
--> A função EXISTS em SQL é usada para verificar se o resultado 
-- de uma consulta aninhada correlacionada é vazio (não contém tuplas) ou não.
--C16B: 
-- OBJETIVO: Recuperar o nome de cada funcionário que tem 
-- um dependente com o mesmo nome e o mesmo sexo do funcionário. 
SELECT F.Primeiro_nome, F.Ultimo_nome  
	FROM FUNCIONARIO AS F  
	WHERE EXISTS 
		(SELECT *  FROM DEPENDENTE AS D  
			WHERE F.Cpf = D.Cpf_funcionario 
				AND F.Sexo = D.Sexo 
				AND F.Primeiro_nome = D.Nome_dependente); 
--> EXISTS e NOT EXISTS costumam ser usados em conjunto com uma consulta aninhada correlacionada.
--> EXISTS(C) retorna TRUE se existe pelo menos uma tupla no resultado da 
-- consulta aninhada C, e retorna FALSE em caso contrário.
--> NOT EXISTS(C) retorna TRUE se não houver tuplas no resultado da consulta  
-- aninhada C, e retorna FALSE em caso contrário.

-- C6:
-- OBJETIVO: Recuperar os nomes de funcionários que não possuem dependentes.  
SELECT Primeiro_nome, Ultimo_nome  
	FROM FUNCIONARIO  
	WHERE NOT EXISTS 
		(SELECT *  FROM DEPENDENTE  WHERE Cpf = Cpf_funcionario); 

-- C7:
-- OBJETIVO: Listar os nomes dos gerentes que possuem pelo menos um dependente. 
SELECT Primeiro_nome, Ultimo_nome  
	FROM FUNCIONARIO 
	WHERE EXISTS 
		(SELECT *  FROM DEPENDENTE  WHERE Cpf = Cpf_funcionario)  
	AND EXISTS 
		(SELECT *  FROM DEPARTAMENTO  WHERE Cpf = Cpf_gerente);

-- C3A
-- OBJETIVO: recuperar o nome de cada funcionário que trabalha em todos os  
-- projetos controlados pelo departamento número 5.
SELECT Primeiro_nome, Ultimo_nome  
	FROM FUNCIONARIO  
	WHERE NOT EXISTS 
		((SELECT Numero_projeto  FROM PROJETO  WHERE Numero_departamento = 5)  
	EXCEPT 
		(SELECT Numero_projeto  FROM TRABALHA_EM  WHERE Cpf = Cpf_funcionario)); 

--C3B: 
-- OBJETIVO: recuperar o nome de cada funcionário que trabalha em todos os  
-- projetos controlados pelo departamento número 5.
SELECT Ultimo_nome, Primeiro_nome  
	FROM FUNCIONARIO  
	WHERE 
		NOT EXISTS 
		(SELECT * FROM TRABALHA_EM AS B  
			WHERE (B.Numero_projeto IN 
									(SELECT Numero_projeto  
										FROM PROJETO  
										WHERE Numero_departamento = 5) 
		AND NOT EXISTS 
		(SELECT *  FROM TRABALHA_EM AS C  
			WHERE C.Cpf_funcionario = Cpf  
				AND C.Numero_projeto = B.Numero_projeto))); 

--> Existe outra função em SQL, UNIQUE(C), que retorna TRUE se não houver tuplas  
-- duplicadas no resultado da consulta C; caso contrário, ela retorna FALSE. 
-- Isso pode  ser usado para testar se o resultado de uma consulta aninhada 
-- é um conjunto (sem  duplicatas) ou um multiconjunto (existem duplicatas). 

-- 7.1.5 Conjuntos explícitos e renomeação de atributos em SQL 
-- C17:
-- OBJETIVO: Recuperar os números do CPF de todos os 
-- funcionários que trabalham nos projetos de números 1, 2 ou 3.  
SELECT DISTINCT Cpf_funcionario  
	FROM TRABALHA_EM  
	WHERE Numero_projeto IN (1, 2, 3); 

-- Em SQL, é possível renomear qualquer atributo que apareça no resultado de uma  
-- consulta acrescentando o qualificador AS, seguido pelo novo nome desejado.
-- C8A: 
SELECT F.Ultimo_nome AS Nome_funcionario,S.Ultimo_nome AS Nome_supervisor  
	FROM FUNCIONARIO AS F, FUNCIONARIO AS S  
	WHERE F.Cpf_supervisor = S.Cpf; 

-- 7.1.6 Tabelas de junção em SQL e junções externas (outer joins) 
--> O conceito de uma tabela de junção (ou relação de junção) 
-- foi incorporado na  SQL para permitir aos usuários especificar 
-- uma tabela resultante de uma operação  de junção na cláusula FROM de uma consulta.
-- C1A:
-- OBJETIVO: recuperaro nome e o endereço de  todos os  
-- funcionários que trabalham para o departamento ‘Pesquisa’.
SELECT Primeiro_nome, Ultimo_nome, Endereco  
	FROM (FUNCIONARIO JOIN DEPARTAMENTO 
		ON FUNCIONARIO.Numero_departamento = DEPARTAMENTO.Numero_departamento)  
	WHERE Nome_departamento = 'Pesquisa'; 

--> Natural Join
SELECT Primeiro_nome, Ultimo_nome, Endereco
	FROM FUNCIONARIO 
	NATURAL JOIN DEPENDENTE
	WHERE Nome_departamento = 'Pesquisa';

--> Inner Join - neste caso equivalente a consulta anterior (Natural Join)
SELECT Primeiro_nome, Ultimo_nome, Endereco
	FROM FUNCIONARIO 
	INNER JOIN DEPARTAMENTO 
		ON (FUNCIONARIO.Numero_departamento = DEPARTAMENTO.Numero_departamento)
	WHERE Nome_departamento = 'Pesquisa';

-- C8B: 
-- OBJETIVO: Para cada funcionário, recupere o primeiro e o último nome 
-- do funcionário e o primeiro e o último nome de seu supervisor imediato.
SELECT F.Ultimo_nome AS Nome_funcionario, S.Ultimo_nome AS Nome_supervisor  
	FROM (FUNCIONARIO AS F 
		  LEFT OUTER JOIN FUNCIONARIO AS S  
		  ON F.Cpf_supervisor = S.Cpf); V
		  

-- C1B: não compatível postgresql
SELECT Primeiro_nome, Ultimo_nome, Endereco  
	FROM (FUNCIONARIO NATURAL JOIN  
		(DEPARTAMENTO AS DEP(Nome_dep, Numero_departamento,  
		 Gerente_dep, Inicio_gerente_dep)))  
	WHERE Nome_dep = 'Pesquisa'; 

-- C1B Postgresql
SELECT Primeiro_nome, Ultimo_nome, Endereco
FROM FUNCIONARIO NATURAL JOIN 
	(SELECT Nome_dep AS Nome_departamento, Numero_departamento, 
           Gerente_dep AS Gerente_departamento, 
           Inicio_gerente_dep AS Inicio_gerente_departamento
    FROM DEPARTAMENTO) AS DEP
WHERE Nome_departamento = 'Pesquisa';


-- OBJETIVO: apresentar todos os funcionários e seus dependentes, se houver.
SELECT CONCAT_WS(' ',F.Primeiro_nome, F.Ultimo_nome) AS Nome_funcionario,
		D.Nome_dependente, D.Parentesco, D.Data_nascimento
	FROM (FUNCIONARIO AS F 
		  LEFT JOIN DEPENDENTE AS D  
		  ON F.Cpf = D.Cpf_funcionario); 
	

--> Junção de Multiplas tabelas  	
-- C2A: 
-- É um modo diferente de  especificar a consulta C2, 
-- usando o conceito de uma tabela de junção: 
SELECT Numero_projeto, PROJETO.Numero_departamento, Ultimo_nome,  Endereco, Data_nascimento  
	FROM ((PROJETO 
		   INNER JOIN DEPARTAMENTO ON PROJETO.Numero_departamento = DEPARTAMENTO.Numero_departamento)  
		   JOIN FUNCIONARIO ON Cpf_gerente = Cpf)  
	WHERE Local_projeto = 'Mauá';


--> postgresql não implementa a sintagem de junções usando operadores:
-- +=, =+ e +=+, para respectivamente junção externa esquerda, 
-- direta e completa, respectivamente, ao especificar a condição de junção.
-- C8C: 
SELECT F.Ultimo_nome, S.Ultimo_nome  
	FROM FUNCIONARIO F, FUNCIONARIO S  
	WHERE F.Cpf_supervisor += S.Cpf;


-- 7.1.7 Funções de agregação em SQL
-- As funções de agregação são usadas para resumir informações de várias tuplas em  uma síntese de tupla única.
-- O agrupamento é usado para criar subgrupos de tuplas  antes do resumo.
--> funções de agregação embutidas: COUNT, SUM, MAX, MIN e AVG.

-- C19
-- OBJETIVO: Achar a soma dos salários de todos os funcionários, o salário  
-- máximo, o salário mínimo e a média dos salários.  
SELECT SUM (Salario), MAX (Salario), MIN (Salario), AVG (Salario), COUNT(*)  
	FROM FUNCIONARIO; 

-- C19A
SELECT SUM (Salario) AS Total_Salario, 
	   MAX (Salario) AS Maior_Salario,  
	   MIN (Salario) AS Menor_Salario, 
	   AVG (Salario) AS Media_Salario,
	   COUNT(*) 	 AS Numero_Funcionarios
	FROM FUNCIONARIO; 
-- Pode-se usar AS para renomear os nomes de coluna 
-- na tabela de  única linha resultante;

-- C20
-- OBJETIVO: Achar a soma dos salários de todos os funcionários 
-- do departamento 'Pesquisa', bem como o salário máximo, o salário mínimo 
-- e a média dos salários  nesse departamento.  
SELECT SUM (Salario), MAX (Salario), MIN (Salario), AVG (Salario)  
	FROM (FUNCIONARIO JOIN DEPARTAMENTO 
	ON FUNCIONARIO.Numero_departamento = DEPARTAMENTO.Numero_departamento)  
	WHERE Nome_departamento = 'Pesquisa'; 


-- C21:
-- OBJETIVO:  Recuperar o número total de funcionários na empresa
SELECT COUNT (*)  FROM FUNCIONARIO;

-- C22: 
-- OBJETIVO: Recuperar o número total de funcionários na empresa
-- e o número de funcionários no departamento ‘Pesquisa’
SELECT COUNT (*)  FROM FUNCIONARIO, DEPARTAMENTO  
	WHERE FUNCIONARIO.Numero_departamento = DEPARTAMENTO.Numero_departamento 
	AND  Nome_departamento = 'Pesquisa';
-- o asterisco (*) refere-se às linhas (tuplas), de modo que COUNT (*) 
-- retorna o  número de linhas no resultado da consulta.

-- C23:
-- OBJETIVO: Contar o número de valores de salário distintos no banco de dados.  
SELECT COUNT (DISTINCT Salario)  
	FROM FUNCIONARIO;
-- caso escreva COUNT(SALARIO) em vez de COUNT (DISTINCT SALARIO) na C23,  
-- então os valores duplicados não serão eliminados.

--! Em geral, valores NULL são descartados quando as funções de agregação 
-- são aplicadas a determinada coluna (atributo).  
-- A única exceção é para COUNT(*), pois são contadas tuplas, e não valores.

--> Essas funções também podem ser usadas nas condições de seleção  envolvendo consultas aninhadas.
-- Podemos especificar uma consulta aninhada correlacionada com uma função de agregação, 
-- e depois usar a consulta aninhada na cláusula WHERE de uma consulta externa.

-- C5: 
-- OBJETIVO: para recuperar  os nomes de todos os 
-- funcionários que têm dois ou mais dependentes
SELECT Ultimo_nome, Primeiro_nome  
	FROM FUNCIONARIO  
	WHERE (SELECT COUNT (*) FROM DEPENDENTE  
		   WHERE Cpf = Cpf_funcionario) >= 2;


-- 7.1.8 Agrupamento: as cláusulas GROUP BY e HAVING 
-- C24:
-- OBJETIVO: Para cada departamento, recuperar o número do departamento, 
-- o número de funcionários no departamento e seu salário médio.  
SELECT Numero_departamento, COUNT (*), AVG (Salario)  
	FROM FUNCIONARIO
	GROUP BY Numero_departamento;


-- C25:
-- OBJETIVO: Para cada projeto, recuperar o número e o nome do projeto e o  
-- número de funcionários que trabalham nesse projeto.  
SELECT PROJETO.Numero_projeto, Nome_projeto, COUNT (*)  
	FROM PROJETO, TRABALHA_EM  
	WHERE PROJETO.Numero_projeto = TRABALHA_EM.Numero_projeto  
	GROUP BY PROJETO.Numero_projeto, Nome_projeto;

-- C26:
-- OBJETIVO: Para cada projeto, recuperar o número e o nome do projeto e o  
-- número de funcionários que trabalham nesse projeto.
-- E que apenas projetos com mais de dois funcionários apareçam  no resultado.
SELECT PROJETO.Numero_projeto, Nome_projeto, COUNT (*)  
	FROM PROJETO, TRABALHA_EM  
	WHERE PROJETO.Numero_projeto = TRABALHA_EM.Numero_projeto  
	GROUP BY PROJETO.Numero_projeto, Nome_projeto  HAVING COUNT (*) > 2; 

-- C27:
-- OBJETIVO: Para cada projeto, recupere o número e o nome do projeto e 
-- o número de funcionários do departamento 5 que trabalham no projeto.  
SELECT PROJETO.Numero_projeto, Nome_projeto, COUNT (*)  
	FROM PROJETO, TRABALHA_EM, FUNCIONARIO  
	WHERE PROJETO.Numero_projeto = TRABALHA_EM.Numero_projeto  
		AND Cpf = Cpf_funcionario 
		AND FUNCIONARIO.Numero_departamento = 5  
	GROUP BY PROJETO.Numero_projeto, Nome_projeto;

-- Quer-se contar o número total de funcionários cujos salários são superiores 
-- a R$ 40.000 em cada departamento, mas somente para os departamentos em que 
-- há mais de dois funcionários trabalhando.
SELECT Numero_departamento, COUNT (*)  
	FROM FUNCIONARIO  
	WHERE Salario>40000  
	GROUP BY Numero_departamento HAVING COUNT (*) > 2;  
-- Esta query ESTA INCORRETA porque selecionará somente departamentos que tenham  
-- mais de dois funcionários que ganham cada um mais de R$ 40.000.

-- C28: versão correta para o objetivo definido.
-- OBJETIVO: contar o número total de funcionários cujos salários são superiores 
-- a R$ 40.000 em cada departamento, mas somente para os departamentos em que 
-- há mais de dois funcionários trabalhando.
SELECT Numero_departamento, COUNT (*)  
	FROM FUNCIONARIO  
	WHERE Salario>40000 
		AND Numero_departamento IN  
					(SELECT Numero_departamento  
						FROM FUNCIONARIO  
						GROUP BY Numero_departamento  
						HAVING COUNT (*) > 2)  
	GROUP BY Numero_departamento;  
	

--7.1.9 Outras construções SQL: WITH e CASE 

--C28': C28 reescrita
-- OBJETIVO: contar o número total de funcionários cujos salários são superiores 
-- a R$ 40.000 em cada departamento, mas somente para os departamentos em que 
-- há mais de cinco funcionários trabalhando.
-- WITH
WITH DEPARTAMENTO_GRANDE (Numero_departamento) AS  
	(SELECT Numero_departamento  
	 FROM FUNCIONARIO  
	 GROUP BY Numero_departamento  
	 HAVING COUNT (*) > 2)  
 SELECT Numero_departamento, COUNT (*)  
 	FROM FUNCIONARIO  
	WHERE Salario>40000 AND Numero_departamento 
	IN  DEPARTAMENTO_GRANDE --postgreSQL não vai aceitar desta forma
	GROUP BY Numero_departamento; 

--C28': C28 reescrita
-- OBJETIVO: contar o número total de funcionários cujos salários são superiores 
-- a R$ 40.000 em cada departamento, mas somente para os departamentos em que 
-- há mais de dois funcionários trabalhando.
WITH DEPARTAMENTO_GRANDE AS (
    SELECT Numero_departamento
    FROM FUNCIONARIO
    GROUP BY Numero_departamento
    HAVING COUNT(*) > 2
)
SELECT Numero_departamento, COUNT(*)
FROM FUNCIONARIO
WHERE Salario > 40000 
AND Numero_departamento IN (SELECT Numero_departamento FROM DEPARTAMENTO_GRANDE)
GROUP BY Numero_departamento;

-- C29:
-- OBJETIVO: dar aos funcionários diferentes aumentos de salário, 
-- dependendo do departamento para o qual eles trabalham; 
-- Ex.: os funcionários no departamento 5 recebem um aumento de R$ 2.000, 
-- aqueles no departamento 4 recebem R$ 1.500, 
-- e aqueles no departamento 1 recebem R$ 3.000.
-- U6': 
UPDATE FUNCIONARIO  SET Salario =  
	CASE WHEN Numero_departamento = 5 THEN Salario + 2000  
		 WHEN Numero_departamento = 4 THEN Salario + 1500  
		 WHEN Numero_departamento = 1 THEN Salario + 3000  
		 ELSE Salario + 0
	END;


-- 7.1.10 Consultas recursivas em SQL
--C29:
/*L1*/WITH RECURSIVE SUPERVISIONA_SUPERVISIONADO (Cpf_supervisiona, Cpf_supervisionado)AS  
/*L2*/	(SELECT Cpf_supervisor, Cpf  
/*L3*/	 FROM FUNCIONARIO  
/*L4*/	 UNION  
/*L5*/	 SELECT F.Cpf, S.Cpf_supervisiona  
/*L6*/	 FROM FUNCIONARIO AS F, 
/*L7*/			SUPERVISIONA_SUPERVISIONADO AS S  
/*L8*/	 WHERE F.Cpf_supervisor = S.Cpf_supervisionado)  
/*L9*/	SELECT * FROM SUPERVISIONA_SUPERVISIONADO;
-- Um exemplo de um relacionamento recursivo entre as tuplas 
-- do mesmo tipo é a relação entre um empregado e um  supervisor.

-- 7.1.11 Discussão e resumo das consultas em SQL 

SELECT <lista de atributos e funções>  
FROM <lista de tabelas>  
[WHERE <condição>]  
[GROUP BY <atributo(s) de agrupamento>]  
[HAVING <condição de grupo>]  
[ORDER BY <lista de atributos>];  

--> Uma consulta de recuperação em SQL pode consistir em até 
-- seis cláusulas, mas somente as duas primeiras 
-- — SELECT e FROM — são obrigatórias.
--> A cláusula SELECT lista os atributos ou funções a serem recuperadas.
--> A cláusula  FROM especifica todas as relações (tabelas) necessárias 
-- na consulta, incluindo as  relações de junção, mas não aquelas nas 
-- consultas aninhadas.
--> A cláusula WHERE especifica as condições para selecionar 
-- as tuplas dessas relações, incluindo as condições  de junção, se necessário.
--> GROUP BY especifica atributos de agrupamento, enquanto  
-- HAVING especifica uma condição sobre os grupos selecionados, em vez das tuplas individuais.
--> As funções de agregação embutidas COUNT, SUM, MIN, MAX e AVG são 
-- usadas em conjunto com o agrupamento, mas também podem ser aplicadas a todas  
-- as tuplas selecionadas em uma consulta sem uma cláusula GROUP BY.
-- ORDER BY especifica uma ordem para exibir os resultados da pesquisa.


-- 7.3 Visões (views) — tabelas virtuais em SQL 
--> Uma visão em terminologia SQL é uma única tabela que é derivada de outras tabelas.
-- Essas outras tabelas podem ser tabelas básicas ou visões previamente definidas.
--> Uma visão não necessariamente existe em forma física; ela é considerada  
-- uma tabela virtual, ao contrário das tabelas básicas, cujas tuplas sempre estão
-- armazenadas fisicamente no banco de dados.
--> Isso limita as possíveis operações de  atualização que podem ser aplicadas às visões, 
-- mas não oferece quaisquer limitações  sobre a consulta de uma visão. 
--> Pensamos em uma visão como um modo de especificar uma tabela que precisamos  
-- referenciar com frequência, embora ela possa não existir fisicamente.
--> As visões também são usadas como  um mecanismo de segurança e autorização.
--> ** As views também são conhecidas como tabelas virtuais ou tabelas derivadas.
-- V1: 
-- OBJETIVO: apresentar funcionarios e horas trabalhadas em projetos (não sumarizado)
CREATE VIEW TRABALHA_EM1 AS 
	SELECT Primeiro_nome, Ultimo_nome, Nome_projeto, Horas  
	FROM FUNCIONARIO, PROJETO, TRABALHA_EM  
	WHERE Cpf = Cpf_funcionario AND TRABALHA_EM.Numero_projeto = PROJETO.Numero_projeto; 

SELECT * FROM TRABALHA_EM1;
-- Em V1, não especificamos quaisquer novos nomes de atributo para a visão TRABALHA_EM1.
-- Neste caso, TRABALHA_EM1 herda  os nomes dos atributos de visão das tabelas de 
-- definição FUNCIONARIO, PROJETO e TRABALHA_EM.
-- CV1:
-- OBJETIVO: para recuperar o primeiro e o último nome de todos os funcionários que 
-- trabalham  no projeto 'ProdutoX', podemos utilizar a visão TRABALHA_EM1.
SELECT Primeiro_nome, Ultimo_nome  
	FROM TRABALHA_EM1  
	WHERE Nome_projeto = 'ProdutoX'; 
-- drop
DROP VIEW TRABALHA_EM1;

-- V2: 
-- OBJETIVO: apresentar departamentos, a respectiva quantidade de funcionário
-- e a soma total de salários.
CREATE VIEW INFORMACAO_DEP(Nome_departamento, Quant_func, Total_sal) AS 
	SELECT Nome_departamento, COUNT (*), SUM (Salario)  
	FROM DEPARTAMENTO, FUNCIONARIO  
	WHERE DEPARTAMENTO.Numero_departamento = FUNCIONARIO.Numero_departamento  
	GROUP BY Nome_departamento; 

SELECT * FROM INFORMACAO_DEP;
-- A visão V2 especifica explicitamente novos nomes de atributo para a  visão 
-- INFORMACAO_DEP, usando uma correspondência um para um entre os atributos  
-- especificados na cláusula CREATE VIEW e aqueles especificados na cláusula 
-- SELECT da consulta que define a visão. 
-- drop
DROP VIEW INFORMACAO_DEP;

--> Supõe-se que uma visão esteja sempre atualizada; se modificarmos as tuplas 
-- nas tabelas básicas sobre as quais a visão é definida, esta precisa refletir 
-- automaticamente essas mudanças.
--> A visão não é realizada ou materializada no momento de sua definição, 
-- mas quando especificamos uma consulta na visão.


-- 7.4.1 O comando DROP 
-- O comando DROP pode ser usado para remover elementos nomeados do  esquema, 
-- como tabelas, domínios, tipos ou restrições.
--> Existem duas opções de comportamento de drop: CASCADE e RESTRICT.
-- CASCADE: elimina o elemtento e elementos relacionados.
-- RESTRICT: elimina o elemento apenas, se não houverem elementos relacionados.

-- OBJETIVO: remover o esquema EMPRESA e todas 
-- as suas tabelas, domínios e outros elementos.
DROP SCHEMA EMPRESA CASCADE; 
-- Para usar a opção RESTRICT, o usuário deve primeiro remover individualmente  
-- cada elemento no esquema e depois remover o próprio esquema. 

-- OBJETIVO: Remover os dependentes dos funcionários 
-- no banco de dados  EMPRESA
DROP TABLE DEPENDENTE CASCADE; 

-- OBJETIVO: Remover os funcionários e todas as
-- tabelas que possuem dependência com Funcionário.  
-- no banco de dados  EMPRESA
DROP TABLE FUNCIONARIO CASCADE; 

-- 7.4.2 O comando ALTER 
--> A definição de uma tabela básica ou de outros elementos de esquema nomeados  
-- pode ser alterada usando o comando ALTER.

-- OBJETIVO: para incluir um atributo que mantém as tarefas dos 
-- funcionários na relação básica FUNCIONARIO no esquema EMPRESA
ALTER TABLE EMPRESA.FUNCIONARIO ADD COLUMN Tarefa VARCHAR(12); 
-- Para inserir valores a esta coluna, isso pode ser feito especificando 
-- uma cláusula default  ou usando o comando UPDATE individualmente sobre cada tupla

--OBJETIVO: remover o atributo Endereco da tabela básica FUNCIONARIO.
-- Para remover uma coluna, temos de escolher CASCADE ou RESTRICT para o comportamento de remoção.
ALTER TABLE EMPRESA.FUNCIONARIO DROP COLUMN Endereco CASCADE;
