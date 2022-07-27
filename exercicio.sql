-- Programe o código SQL necessário para gerar a estrutura do banco de dados criado
-- no módulo Normalização de Dados (Formas Normais).
-- 
-- Observação: Não é necessário criar o código que popula as tabelas, pois este é o 
-- tema do próximo módulo.
--
-- Cria o banco de dados e acessa o mesmo
--
CREATE DATABASE SOFTBLUE DEFAULT CHARSET = latin1;

USE SOFTBLUE;

--
-- Cria a tabela TIPO
--
CREATE TABLE TIPO (
    CODIGO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    -- Código interno (PK)
    TIPO VARCHAR(32) NOT NULL,
    -- Descrição
    PRIMARY KEY(CODIGO) -- Define o campo CODIGO como PK (Primary Key)
);

--
-- Cria a tabela INSTRUTOR
--
CREATE TABLE INSTRUTOR (
    CODIGO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    -- Código interno (PK)
    INSTRUTOR VARCHAR(64) NOT NULL,
    -- Nome com até 64 caracteres
    TELEFONE VARCHAR(9) NULL,
    -- Telefone, podendo ser nulo caso não tenha
    PRIMARY KEY(CODIGO) -- Define o campo CODIGO como PK (Primary Key)
);

--
-- Cria a tabela CURSO
--
CREATE TABLE CURSO (
    CODIGO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    -- Código interno (PK)
    CURSO VARCHAR(64) NOT NULL,
    -- Título com até 64 caracteres
    TIPO INTEGER UNSIGNED NOT NULL,
    -- Código do tipo de curso (idêntico a PK em CURSO)
    INSTRUTOR INTEGER UNSIGNED NOT NULL,
    -- Código do instrutor (idêntico a PK em INSTRUTOR)
    VALOR DOUBLE NOT NULL,
    -- Valor do curso
    PRIMARY KEY(CODIGO),
    -- Define o campo CODIGO como PK (Primary Key)
    INDEX FK_TIPO(TIPO),
    -- Define o campo TIPO como um índice
    INDEX FK_INSTRUTOR(INSTRUTOR),
    -- Define o campo INSTRUTOR como um índice
    FOREIGN KEY(TIPO) REFERENCES TIPO(CODIGO),
    -- Cria o relacionamento (FK) com a tabela TIPO
    FOREIGN KEY(INSTRUTOR) REFERENCES INSTRUTOR(CODIGO) -- Cria o relacionamento (FK) com a tabela INSTRUTOR
);

--
-- Cria a tabela ALUNO
--
CREATE TABLE ALUNO (
    CODIGO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    -- Código interno (PK)
    ALUNO VARCHAR(64) NOT NULL,
    -- Nome com até 64 caracteres
    ENDERECO VARCHAR(230) NOT NULL,
    -- Endereço com até 230 caracteres
    EMAIL VARCHAR(128) NOT NULL,
    -- E-mail com até 128 caracteres
    PRIMARY KEY(CODIGO) -- Define o campo CODIGO como PK (Primary Key)
);

--
-- Cria a tabela PEDIDO
--
CREATE TABLE PEDIDO (
    CODIGO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    -- Código interno (PK)
    ALUNO INTEGER UNSIGNED NOT NULL,
    -- Código do aluno (idêntico a PK em ALUNO)
    DATAHORA DATETIME NOT NULL,
    -- Armazena data e hora em uma única coluna
    PRIMARY KEY(CODIGO),
    -- Define o campo CODIGO como PK (Primary Key)
    INDEX FK_ALUNO(ALUNO),
    -- Define o campo ALUNO como um índice
    FOREIGN KEY(ALUNO) REFERENCES ALUNO(CODIGO) -- Cria o relacionamento (FK) com a tabela ALUNO
);

--
-- Cria a tabela PEDIDO_DETALHE
--
CREATE TABLE PEDIDO_DETALHE (
    PEDIDO INTEGER UNSIGNED NOT NULL,
    CURSO INTEGER UNSIGNED NOT NULL,
    VALOR DOUBLE NOT NULL,
    INDEX FK_PEDIDO (PEDIDO),
    INDEX FK_CURSO (CURSO),
    PRIMARY KEY (PEDIDO, CURSO),
    FOREIGN KEY (PEDIDO) REFERENCES PEDIDO (CODIGO),
    FOREIGN KEY (CURSO) REFERENCES CURSO (CODIGO)
);

-- Inclua a coluna DATA_NASCIMENTO na tabela ALUNO do tipo string, de tamanho 10 caracteres
--
ALTER TABLE
    ALUNO
ADD
    DATA_NASCIMENTO VARCHAR(10);

--
-- Altere a coluna DATA_NASCIMENTO para NASCIMENTO e seu tipo de dado para DATE
--
ALTER TABLE
    ALUNO CHANGE DATA_NASCIMENTO NASCIMENTO DATE NULL;

--
-- Crie um novo índice na tabela ALUNO, para o campo ALUNO
--
ALTER TABLE
    ALUNO
ADD
    INDEX INDEX_ALUNO(ALUNO);

--
-- Inclua o campo EMAIL na tabela INSTRUTOR, com tamanho de 100 caracteres
--
ALTER TABLE
    INSTRUTOR
ADD
    EMAIL VARCHAR(100);

--
-- Crie um novo índice na tabela CURSO, para o campo INSTRUTOR
--
ALTER TABLE
    CURSO
ADD
    INDEX INDEX_INSTRUTOR(INSTRUTOR);

--
-- Remova o campo EMAIL da tabela INSTRUTOR
--
ALTER TABLE
    INSTRUTOR DROP EMAIL;

insert into
    tipo
values
    (default, 'Banco de dados'),
    (default, 'Programação'),
    (default, 'Modelagem de dados');

insert into
    instrutor
values
    (default, 'André Milani', '1111-1111'),
    (default, 'Carlos Tosin', '1212-1212');

insert into
    curso
values
    (default, 'Java Fundamentos', 2, 2, 270),
    (default, 'Java Avançado', 2, 2, 330),
    (default, 'SQL Completo', 1, 1, 170),
    (default, 'Php Básico', 2, 1, 270);

insert into
    aluno (codigo, aluno, endereco, email)
values
    (
        default,
        'José',
        'Rua XV de Novembro 72',
        'jose@softblue.com.br'
    ),
    (
        default,
        'Wagner',
        'Av. Paulista',
        'wagner@softblue.com.br'
    ),
    (
        default,
        'Emílio',
        'Rua Lajes 103, ap: 701',
        'emilio@softblue.com.br'
    ),
    (
        default,
        'Cris',
        'Rua Tauney 22',
        'cris@softblue.com.br'
    ),
    (
        default,
        'Regina',
        'Rua Salles 305',
        'regina@softblue.com.br'
    ),
    (
        default,
        'Fernando',
        'Av. Central 30',
        'fernando@softblue.com.br'
    );

insert into
    pedido
values
    (default, 2, '2010-04-15 11:23:32'),
    (default, 2, '2010-04-15 14:36:21'),
    (default, 3, '2010-04-16 11:17:45'),
    (default, 4, '2010-04-17 14:27:22'),
    (default, 5, '2010-04-18 11:18:19'),
    (default, 6, '2010-04-19 13:47:35'),
    (default, 6, '2010-04-20 18:13:44');

insert into
    pedido_detalhe
values
    (1, 1, 270),
    (1, 2, 330),
    (2, 1, 270),
    (2, 2, 330),
    (2, 3, 170),
    (3, 4, 270),
    (4, 2, 330),
    (4, 4, 270),
    (5, 3, 170),
    (6, 3, 170),
    (7, 4, 270);

select
    *
from
    aluno;

select
    curso
from
    curso;

SELECT
    curso,
    valor
FROM
    curso
WHERE
    valor > 200;

SELECT
    curso,
    valor
FROM
    curso
WHERE
    valor > 200
    AND valor < 300;

-- ou
SELECT
    curso,
    valor
FROM
    curso
WHERE
    valor BETWEEN 200
    AND 300;

SELECT
    *
FROM
    pedido
WHERE
    datahora BETWEEN '2010-04-15'
    AND '2010-04-18';

-- ou
SELECT
    *
FROM
    pedido
WHERE
    datahora > '2010-04-15'
    AND datahora < '2010-04-18';

SELECT
    *
FROM
    pedido
WHERE
    DATE(datahora) = '2010-04-15';

-- ATENÇÃO EM DATE
-- Altere o endereço do aluno JOSÉ para 'Av. Brasil 778'
UPDATE
    aluno
SET
    endereco = 'Av. Brasil 778'
WHERE
    aluno = 'José';

-- Altere o e-mail do aluno CRIS para 'cristiano@softblue.com.br'
UPDATE
    aluno
SET
    email = 'cristiano@softblue.com.br'
WHERE
    aluno = 'Cris';

-- Aumente em 10% o valor dos cursos abaixo de 300    
UPDATE
    curso
SET
    valor = ROUND(valor * 1.1, 2)
where
    valor > 300;

-- Altere o nome do curso de Php Básico para Php Fundamentos    
update
    curso
set
    curso = 'Php Fundamentos'
where
    curso = 'Php Básico';

select
    *
from
    tipo;

select
    *
from
    instrutor;

select
    *
from
    curso;

select
    *
from
    aluno;

select
    *
from
    pedido;

select
    *
from
    pedido_detalhe;

-- drop database softblue;


-- Exiba uma lista com os títulos dos cursos da Softblue e o tipo de curso ao lado;
SELECT 
    curso.curso, tipo.tipo
FROM
    curso
        INNER JOIN
    tipo ON curso.tipo = tipo.codigo;

-- Exiba uma lista com os títulos dos cursos da Softblue, tipo do curso, nome do instrutor responsável pelo mesmo e telefone;
SELECT 
    curso.curso,
    tipo.tipo,
    instrutor.instrutor,
    instrutor.telefone
FROM
    curso
        INNER JOIN
    tipo ON curso.tipo = tipo.codigo
        INNER JOIN
    instrutor ON curso.instrutor = instrutor.codigo;

-- Exiba uma lista com o código e data e hora dos pedidos e os códigos dos cursos de cada pedido;
SELECT 
    pedido.codigo, pedido.datahora, pedido_detalhe.curso
FROM
    pedido
        INNER JOIN
    pedido_detalhe ON pedido.codigo = pedido_detalhe.pedido;

-- Exiba uma lista com o código e data e hora dos pedidos e os títulos dos cursos de cada pedido;
SELECT 
    pedido.codigo, pedido.datahora, curso.curso
FROM
    pedido
        INNER JOIN
    pedido_detalhe ON pedido.codigo = pedido_detalhe.pedido
        INNER JOIN
    curso ON curso.codigo = pedido_detalhe.CURSO;

-- Exiba uma lista com o código e data e hora dos pedidos, nome do aluno e os títulos dos cursos de cada pedido;
SELECT 
    pedido.codigo, pedido.datahora, aluno.aluno, curso.curso
FROM
    curso
        INNER JOIN
    pedido_detalhe ON pedido_detalhe.curso = curso.codigo
        INNER JOIN
    pedido ON pedido.codigo = pedido_detalhe.pedido
        INNER JOIN
    aluno ON aluno.codigo = pedido.aluno;
    
-- Crie uma visão que traga o título e preço somente dos cursos de programação da Softblue;
CREATE VIEW cursos_programação AS
    SELECT 
        curso, valor
    FROM
        curso
            INNER JOIN
        tipo ON tipo.codigo = curso.tipo
    WHERE
        tipo.tipo = 'Programação';
                
    SELECT 
    *
FROM
    cursos_programação;
    
	-- drop view cursos_programação;


-- Crie uma visão que traga os títulos dos cursos, tipo do curso e nome do instrutor;
CREATE VIEW curso_instrutor AS
    SELECT 
        curso.curso, tipo.tipo, instrutor.instrutor
    FROM
        curso
            INNER JOIN
        instrutor ON instrutor.codigo = curso.instrutor
            INNER JOIN
        tipo ON tipo.codigo = curso.tipo;
        
    select * from curso_instrutor;    

-- Crie uma visão que exiba os pedidos realizados, informando o nome do aluno, data e código do pedido;
CREATE VIEW pedido_aluno AS
    SELECT 
        pedido.codigo, aluno.aluno, pedido.datahora
    FROM
        pedido
            INNER JOIN
        aluno ON pedido.aluno = aluno.codigo;
    
    select * from pedido_aluno;