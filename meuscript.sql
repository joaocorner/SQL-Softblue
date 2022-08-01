-- CRIANDO BANCO DE DADOS

CREATE DATABASE curso_sql;

USE curso_sql;

CREATE TABLE funcionarios 
(
	id int unsigned not null auto_increment,
    nome varchar(45) not null,
    salario double not null default '0',
    departamento varchar(45) not null,
    PRIMARY KEY (id)
);

CREATE TABLE veiculos
(
	id int unsigned not null auto_increment,
    funcionario_id int unsigned default null,
    veiculo varchar(45) not null default '',
    placa varchar(10) not null default '',
    PRIMARY KEY (id),
    CONSTRAINT fk_veiculos_funcionarios FOREIGN KEY (funcionario_id) REFERENCES funcionarios (id)
);

CREATE TABLE salarios
(
	faixa varchar(45) not null,
    inicio double not null,
    fim double not null,
    PRIMARY KEY (faixa)
);

ALTER TABLE funcionarios CHANGE COLUMN nome nome_func varchar(45) not null;
ALTER TABLE funcionarios CHANGE COLUMN nome_func nome varchar(45) not null;

-- DROP TABLE salarios;

CREATE INDEX departamentos ON funcionarios (departamento);
CREATE INDEX nomes ON funcionarios (nome(6));


-- MANIPULANDO DADOS:


USE curso_sql;

INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (1, 'Fernando', 1400, 'TI');
INSERT INTO funcionarios (id, nome, salario, departamento) VALUES (2, 'Guilherme', 2500, 'Jurídico');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('Fábio', 1700, 'TI');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('José', 1800, 'Marketing');
INSERT INTO funcionarios (nome, salario, departamento) VALUES ('Isabela', 2200, 'Jurídico');

SELECT * FROM funcionarios;
SELECT * FROM funcionarios WHERE salario > 2000;
SELECT * FROM funcionarios WHERE nome = 'José';
SELECT * FROM funcionarios WHERE id = 3;

UPDATE funcionarios SET salario = salario * 1.1 WHERE id = 1;

SET SQL_SAFE_UPDATES = 0;
/* SET SQL_SAFE_UPDATES = 1; */
UPDATE funcionarios SET salario = salario * 1.1;

UPDATE funcionarios SET salario = ROUND(salario * 1.1, 2);

DELETE FROM funcionarios WHERE id = 4;

INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (1, 'Carro', 'SB-0001');
INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (1, 'Carro', 'SB-0002');

UPDATE veiculos SET funcionario_id = 5 WHERE id = 2;

SELECT * FROM veiculos;

INSERT INTO salarios (faixa, inicio, fim) VALUES ('Analista Jr', 1000, 2000);
INSERT INTO salarios (faixa, inicio, fim) VALUES ('Analista Pleno', 2000, 4000);

SELECT * FROM salarios;

SELECT nome AS 'Funcionário', salario FROM funcionarios f WHERE f.salario > 2000;

SELECT * FROM funcionarios WHERE nome = 'Guilherme'
UNION
SELECT * FROM funcionarios WHERE id = 5;

SELECT * FROM funcionarios WHERE nome = 'Guilherme'
UNION ALL
SELECT * FROM funcionarios WHERE nome = 'Guilherme';


-- RELACIONAMENTO E VISÕES:


USE curso_sql;

SELECT * FROM funcionarios;
SELECT * FROM veiculos;

SELECT * FROM funcionarios INNER JOIN veiculos ON veiculos.funcionario_id = funcionarios.id;

SELECT * FROM funcionarios f INNER JOIN veiculos v ON v.funcionario_id = f.id;
SELECT * FROM funcionarios f LEFT JOIN veiculos v ON v.funcionario_id = f.id;
SELECT * FROM funcionarios f RIGHT JOIN veiculos v ON v.funcionario_id = f.id;
SELECT * FROM funcionarios f RIGHT JOIN veiculos v ON f.id = v.funcionario_id;

SELECT * FROM funcionarios f LEFT JOIN veiculos v ON v.funcionario_id = f.id
UNION
SELECT * FROM funcionarios f RIGHT JOIN veiculos v ON v.funcionario_id = f.id;

SELECT * FROM funcionarios f LEFT JOIN veiculos v ON v.funcionario_id = f.id
UNION ALL
SELECT * FROM funcionarios f RIGHT JOIN veiculos v ON v.funcionario_id = f.id;

INSERT INTO veiculos (funcionario_id, veiculo, placa) VALUES (null, "Moto", "SB-0003");

CREATE TABLE cpfs
(
	id int unsigned not null,
    cpf varchar(14) not null,
    PRIMARY KEY (id),
    CONSTRAINT fk_cpf FOREIGN KEY (id) REFERENCES funcionarios (id)
);

INSERT INTO cpfs (id, cpf) VALUES (1, '111.111.111-11');
INSERT INTO cpfs (id, cpf) VALUES (2, '222.222.222-22');
INSERT INTO cpfs (id, cpf) VALUES (3, '333.333.333-33');
INSERT INTO cpfs (id, cpf) VALUES (5, '555.555.555-55');

SELECT * FROM cpfs;

SELECT * FROM funcionarios INNER JOIN cpfs ON funcionarios.id = cpfs.id;
SELECT * FROM funcionarios INNER JOIN cpfs USING(id);

CREATE TABLE clientes
(
	id int unsigned not null auto_increment,
    nome varchar(45) not null,
    quem_indicou int unsigned,
    PRIMARY KEY (id),
    CONSTRAINT fk_quem_indicou FOREIGN KEY (quem_indicou) REFERENCES clientes (id)
);

INSERT INTO clientes (id, nome, quem_indicou) VALUES (1, 'André', NULL);
INSERT INTO clientes (id, nome, quem_indicou) VALUES (2, 'Samuel', 1);
INSERT INTO clientes (id, nome, quem_indicou) VALUES (3, 'Carlos', 2);
INSERT INTO clientes (id, nome, quem_indicou) VALUES (4, 'Rafael', 1);

SELECT * FROM clientes;

SELECT a.nome AS CLIENTE, b.nome AS "QUEM INDICOU" 
FROM clientes a join clientes b ON a.quem_indicou = b.id;

SELECT * FROM funcionarios 
INNER JOIN veiculos ON veiculos.funcionario_id = funcionarios.id 
INNER JOIN cpfs ON cpfs.id = funcionarios.id;

CREATE VIEW funcionarios_a AS SELECT * FROM funcionarios WHERE salario >= 1700;

SELECT * FROM funcionarios_a;
UPDATE funcionarios SET salario = 1500 WHERE id = 3;

DROP VIEW funcionarios_a;
CREATE VIEW funcionarios_a AS SELECT * FROM funcionarios WHERE salario >= 2000;


-- FUNÇÕES ESPECIAIS E SUBQUERIES:

select count(*) from funcionarios;
select count(*) from funcionarios where salario > 2000;
select count(*) from funcionarios where salario > 1600 and departamento = "juridico";

select * from funcionarios where salario > 1600 and departamento = "juridico";

select sum(salario) from funcionarios;
select sum(salario) from funcionarios where departamento = 'ti';

select  avg(salario) from funcionarios;
select  avg(salario) from funcionarios where departamento = 'ti';

select max(salario) from funcionarios;
select  max(salario) from funcionarios where departamento = 'ti';
select  min(salario) from funcionarios where departamento = 'ti';
select min(salario) from funcionarios;

select * from funcionarios order by nome;
select * from funcionarios order by salario desc;
select * from funcionarios order by departamento desc, salario desc;

-- pode usar os 2 comandos, dão o mesmo resultado
select * from funcionarios limit 2 offset 1;
select * from funcionarios limit 1, 2;

select avg(salario) from funcionarios;
select avg(salario) from funcionarios where departamento = 'ti';
select avg(salario) from funcionarios where departamento = 'juridico';
-- pra unir os 2 selects anteriores, usa a seguinte função:
select departamento, avg(salario) from funcionarios group by departamento;
-- e ainda como serâo salário acima de 2000:
select departamento, avg(salario) from funcionarios group by departamento having avg(salario) > 2000;
-- saber quantos funcionarios tem por departamento: 
select departamento, count(*) from funcionarios group by departamento;

select departamento, avg(salario) from funcionarios group by departamento;
select nome from funcionarios where departamento = 'juridico';
-- juntando as duas expressões anteriores, retorna lista de funcionarios do departamento com média acima de 2000:
select nome from funcionarios where departamento in (select departamento from funcionarios group by departamento having avg(salario) > 2000);



create user 'jao'@'192.168.0.1' identified by '123456'; -- o computador só consegue se conectar através do ip específico
create user 'jao'@'%' identified by '123456'; -- pode se conectar a partir de qualquer endereço de ip

create user 'jao'@'localhost' identified by '123456'; -- só o próprio computador pode conectar;
grant all on curso_sql.* to 'jao'@'localhost';

create user 'jao'@'%' identified by 'jaoviagem';
grant select on curso_sql.* to 'jao'@'%'; -- acesso liberado se estiver viajando por exemplo, aí só consegue ler se alguém pegar a senha
grant insert on curso_sql.funcionarios to 'jao'@'%'; -- libera acesso pra inserir dados de qq IP só na tabela funcionarios

revoke insert on curso_sql.funcionarios from 'jao'@'%'; -- revoga acesso pra inserir dados na tabela funcionarios;
revoke select on curso_sql.salarios from 'jao'@'%'; -- não pode tirar só de um se deu acesso pra todos, tem que colocar um por um
revoke select on curso_sql.* from 'jao'@'%';

grant insert on curso_sql.funcionarios to 'jao'@'%';
grant select on curso_sql.veiculos to 'jao'@'%';

revoke select on curso_sql.veiculos from 'jao'@'%';
revoke insert on curso_sql.funcionarios from 'jao'@'%';

revoke all on curso_sql.* from 'jao'@'localhost';

drop user 'jao'@'%';
drop user 'jao'@'localhost';

select user from mysql.user; -- checar a partir do usuario root todos os usuarios criados

show grants for 'jao'@'%'; -- consultando o que o usuario tem acesso

grant * to curso_sql.* from 'jao'@'%';
