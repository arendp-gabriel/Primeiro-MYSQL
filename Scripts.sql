CREATE DATABASE loja;

USE loja;

DROP DATABASE loja;

-- CREATE TABLE categoria (0
-- 	   idCategoria INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
--     nome VARCHAR(50) NOT NULL 
-- );

CREATE TABLE categoria (
	idCategoria INT NOT NULL AUTO_INCREMENT ,
    nome VARCHAR(50) NOT NULL ,
    PRIMARY KEY (idCategoria)
);

CREATE TABLE produto (
	idProduto INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    nome VARCHAR(50) NOT NULL ,
    preco DOUBLE DEFAULT 10.0 , 
    quantidade DOUBLE ,
    codCategoria INT NOT NULL ,
	FOREIGN KEY (codCategoria) REFERENCES categoria(idCategoria)
);

CREATE TABLE pedido (
	idPedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    horario DATETIME NOT NULL  ,
    endereco VARCHAR(200) 
);





describe pedido;

CREATE TABLE pedido_produto (
    codPedido INT NOT NULL ,
    codProduto INT NOT NULL ,
    preco DOUBLE ,
    quantidade DOUBLE ,
    PRIMARY KEY ( codPedido , codProduto ) ,
    FOREIGN KEY (codPedido) REFERENCES pedido (idPedido)  ,
	FOREIGN KEY (codProduto) REFERENCES produto (idProduto)
);


CREATE TABLE cidade (
	idCidade INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    nome VARCHAR(50) NOT NULL
);



ALTER TABLE pedido ADD COLUMN codCliente INT NOT NULL ;

ALTER TABLE pedido ADD CONSTRAINT 
FOREIGN KEY (codCliente) REFERENCES pessoa (idPessoa) ;



ALTER TABLE pedido ADD COLUMN obs VARCHAR(200) NOT NULL;

ALTER TABLE pedido CHANGE obs observacao VARCHAR(200) NOT NULL;

ALTER TABLE pedido CHANGE observacao observacao TEXT;

DESCRIBE pedido;

DROP TABLE categoria;

SHOW TABLES;

DESCRIBE produto;



INSERT INTO cidade VALUES ( 1 , "Porto Alegre" ) ;
INSERT INTO cidade VALUES ( NULL , "Capão da Canoa" ) ;
INSERT INTO cidade VALUES ( 3 , "Canoas" ) , ( NULL , "Alvorada") ;
INSERT INTO cidade (nome) VALUES ( "Esteio" ) ;
INSERT INTO cidade (nome) VALUES ( "Viamão" ) , ("São Leopoldo") ;


SELECT * FROM cidade;


CREATE TABLE pessoa (
	idPessoa INT NOT NULL AUTO_INCREMENT ,
    nome VARCHAR(50) NOT NULL ,
    nascimento DATE ,
    altura DOUBLE ,
    codCidade INT ,
    PRIMARY KEY ( idPessoa ) ,
    FOREIGN KEY ( codCidade ) REFERENCES cidade ( idCidade )
);


INSERT INTO pessoa VALUES 
( 1 , "Maria", "1985-01-25" , 1.75 , 2 ) ;


INSERT INTO pessoa VALUES 
( NULL , "Júlia", "2008-10-18" , 1.62 , 1 ) ;

INSERT INTO pessoa ( nome, altura , nascimento ) VALUES 
( "Carlos", 1.85 , "1995-05-12"  ) ;

INSERT INTO pessoa VALUES 
( NULL , "Suzy", "1983-11-18" , 1.72 , 2 ) , 
( 10 , "Adalto", "1986-02-05" , 1.80 , 4 )  ;



INSERT INTO pessoa ( nome, altura , nascimento , codCidade ) VALUES 
( "João", 1.58 , "1980-08-17" , 2 ) ,  
( "José", 1.85 , "1975-05-30" , 4  ) ;


SELECT * FROM pessoa;


UPDATE pessoa SET altura = 1.82 WHERE idPessoa = 10 ;

UPDATE pessoa SET 
altura = 1.65 , 
nascimento = "2001-02-01" 
WHERE idPessoa = 3 ;

UPDATE pessoa SET 
altura = 1.8 , 
nascimento = "1994-06-17" 
WHERE idPessoa > 10 ;

UPDATE pessoa SET codCidade = 6 WHERE altura > 1.8 ;


select * FROM cidade;

DELETE FROM cidade WHERE idCidade = 7 ;

DELETE FROM cidade WHERE idCidade = 1 ;

DELETE FROM cidade WHERE nome LIKE "S%" ;

-- 14/10/2022

SELECT nome, nascimento, altura FROM pessoa;

SELECT nome, nascimento, altura 
FROM pessoa
WHERE nascimento < '2000-01-01' AND altura < 1.8 ;

SELECT nome, nascimento, altura 
FROM pessoa
WHERE altura >= 1.7 AND altura < 1.8 ;

SELECT nome, nascimento, altura 
FROM pessoa
WHERE altura < 1.7 OR altura >= 1.8 ;


SELECT nome, nascimento, altura 
FROM pessoa
WHERE altura < 1.7 OR altura >= 1.8
ORDER BY nome DESC ;

SELECT idPessoa, nome, nascimento, altura 
FROM pessoa
WHERE altura < 1.7 OR altura >= 1.8
ORDER BY altura, nome ;



UPDATE pessoa SET 
altura = 1.65 
WHERE idPessoa = 10;


SELECT idPessoa, nome 
FROM pessoa
WHERE nome = " Adalto";

SELECT idPessoa, nome, altura, nascimento 
FROM pessoa
WHERE nome LIKE "%s%"
ORDER BY altura;

SELECT nome, altura, DATE_FORMAT(nascimento , '%d/%m - %u') 
FROM pessoa
ORDER BY altura;

SELECT nome, altura , 
		( altura * 2 ) AS dobro , 
		CONCAT(nome, " - ", altura * 2 ) AS "Informações da Pessoa"
FROM pessoa
WHERE (altura * 2) > 3.3;

SELECT * 
FROM pessoa
WHERE codCidade  IS NOT NULL;





show databases;


CREATE DATABASE lojinha;

USE lojinha;

CREATE TABLE estados ( 
codigo INT NOT NULL PRIMARY KEY AUTO_INCREMENT , 
nome VARCHAR(100) NOT NULL ); 

CREATE TABLE cidades ( 
codigo INT NOT NULL PRIMARY KEY AUTO_INCREMENT , 
nome VARCHAR(100) NOT NULL, 
codEstado INT DEFAULT 1 , 
FOREIGN KEY (codEstado) REFERENCES estados(codigo) );    

CREATE TABLE pessoas ( 
codigo INT NOT NULL PRIMARY KEY AUTO_INCREMENT , 
nome VARCHAR(100) NOT NULL , 
altura DOUBLE , 
nascimento DATE DEFAULT '1970-12-25' , 
codCidade INT , 
FOREIGN KEY (codCidade) REFERENCES cidades(codigo) ); 


INSERT INTO pessoas ( nome, altura, nascimento, codCidade) VALUES 
("Maria", 1.75, "1992-09-28", 3 ) ,
("José", 1.65, "1986-12-05", 1 ) ,
("Júlia", 1.70, "2008-10-18", 1 ) ;

INSERT INTO pessoas ( nome, altura, nascimento, codCidade) VALUES 
("joão", 1.75, "1992-09-28", 2 ) ;


SELECT p.codigo, p.nome, c.nome AS Cidade , e.nome AS UF
FROM pessoas p
INNER JOIN cidades c ON c.codigo = p.codCidade
INNER JOIN estados e ON e.codigo = c.codEstado;




CREATE TABLE pedidos ( 
	codigo INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
	endereco VARCHAR(100) NOT NULL , 
    horario DATETIME  , 
    codCliente INT , 
	FOREIGN KEY (codCliente) REFERENCES pessoas(codigo) 
 );

INSERT INTO pedidos ( endereco, horario, codCliente ) VALUES
("Av. Ipiranga, 1000", "2022-10-27 14:25:10" , 2 ),
("Av. Guilherme Shell, 1515", "2022-10-28 09:10:15" , 1 );

SELECT DATE_FORMAT(pd.horario, "%d/%m/%Y %H:%i:%s") AS Horário ,
		pd.endereco, p.nome , c.nome AS Cidade, e.nome AS UF
FROM pedidos pd
INNER JOIN pessoas p ON p.codigo = pd.codCliente
INNER JOIN cidades c ON c.codigo = p.codCidade
INNER JOIN estados e ON e.codigo = c.codEstado;



INSERT INTO estados (nome) VALUES ("RS") , ("SC") , ("PR"), ("SP");
SELECT * FROM estados;

INSERT INTO cidades ( nome , codEstado ) VALUES 
("Porto Alegre", 1 ) , 
("Florianópolis" , 2 ) , 
("Canoas" , 1 ), 
("Curitiba", 3);

SELECT c.codigo, c.nome, e.codigo AS idEstado, e.nome AS sigla
FROM cidades c 
INNER JOIN Estados e ON e.codigo = c.codEstado
ORDER BY c.nome;





SELECT c.codigo, 
	   c.nome , 
		( 
			SELECT COUNT( p.codigo )  
			FROM pessoas p
			WHERE p.codCidade = c.codigo
			
			) AS moradores   , 
                    
       c.codEstado, e.nome
FROM cidades c
INNER JOIN estados e ON e.codigo = c.codEstado;
-- ---------------------

SELECT e.nome, 

	( SELECT COUNT(c.codigo) 
		FROM cidades c
        WHERE c.codEstado = e.codigo ) AS "Total de Cidades" , 
        
    ( SELECT COUNT(pd.codigo) 
		FROM pedidos pd
        INNER JOIN pessoas p ON p.codigo = pd.codCliente
        INNER JOIN cidades c ON c.codigo = p.codCidade 
        WHERE c.codEstado = e.codigo ) AS "Total de Pedidos" 

FROM estados e;




-- 04/11/2022


SELECT * FROM pessoas;
SELECT * FROM cidades;
-- Pessoas de SC que tem altura acima da média 
-- de todas pessoas
SELECT p.nome, p.altura 
FROM pessoas p
INNER JOIN cidades c ON c.codigo = p.codCidade 
WHERE altura > ( 
				 SELECT AVG(altura) 
				 FROM pessoas 
			   ) AND c.codEstado = 2  ;
               
               
-- Pessoas que tem altura a partir da média 
-- das pessoas de SC
SELECT p.nome, p.altura 
FROM pessoas p 
WHERE altura >= ( 
				 SELECT AVG(p2.altura) 
				 FROM pessoas p2
                 INNER JOIN cidades c ON c.codigo = p2.codCidade
                 WHERE c.codEstado = 2
			   )  ;

-- Pessoas DE SC que tem altura a partir da média 
-- das pessoas de SC
SELECT p.nome, p.altura 
FROM pessoas p 
INNER JOIN cidades c ON c.codigo = p.codCidade
WHERE 	c.codEstado = 2 AND
		p.altura >= ( 
				 SELECT AVG(p2.altura) 
				 FROM pessoas p2
                 INNER JOIN cidades c2 ON c2.codigo = p2.codCidade
                 WHERE c2.codEstado = 2
			   )  ;

select timestampdiff(  YEAR  , nascimento, now() ) 
FROM pessoas;

SELECT nome, nascimento ,
		timestampdiff( YEAR  , nascimento, now() )  as IDADE
FROM pessoas
WHERE timestampdiff(  YEAR  , nascimento, now() )  > 
		(
			SELECT AVG( timestampdiff(YEAR,nascimento,now() ) )  
			FROM pessoas
        );
        
SET @media = ( SELECT AVG( timestampdiff(YEAR,nascimento,now() ) )  
			   FROM pessoas );
SELECT @media;

INSERT INTO pessoas VALUES (NULL, 'Rodrigo' , 1.8, '1971-12-08', 2);
            
SELECT nome, nascimento ,
		timestampdiff( YEAR  , nascimento, now() )  as IDADE
FROM pessoas
WHERE timestampdiff(  YEAR  , nascimento, now() )  > 
		@media;
            











































CREATE DATABASE loja;

USE loja;

DROP DATABASE loja;

-- CREATE TABLE categoria (0
-- 	   idCategoria INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
--     nome VARCHAR(50) NOT NULL 
-- );

CREATE TABLE categoria (
	idCategoria INT NOT NULL AUTO_INCREMENT ,
    nome VARCHAR(50) NOT NULL ,
    PRIMARY KEY (idCategoria)
);

CREATE TABLE produto (
	idProduto INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    nome VARCHAR(50) NOT NULL ,
    preco DOUBLE DEFAULT 10.0 , 
    quantidade DOUBLE ,
    codCategoria INT NOT NULL ,
	FOREIGN KEY (codCategoria) REFERENCES categoria(idCategoria)
);

CREATE TABLE pedido (
	idPedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    horario DATETIME NOT NULL  ,
    endereco VARCHAR(200) 
);





describe pedido;

CREATE TABLE pedido_produto (
    codPedido INT NOT NULL ,
    codProduto INT NOT NULL ,
    preco DOUBLE ,
    quantidade DOUBLE ,
    PRIMARY KEY ( codPedido , codProduto ) ,
    FOREIGN KEY (codPedido) REFERENCES pedido (idPedido)  ,
	FOREIGN KEY (codProduto) REFERENCES produto (idProduto)
);


CREATE TABLE cidade (
	idCidade INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
    nome VARCHAR(50) NOT NULL
);



ALTER TABLE pedido ADD COLUMN codCliente INT NOT NULL ;

ALTER TABLE pedido ADD CONSTRAINT 
FOREIGN KEY (codCliente) REFERENCES pessoa (idPessoa) ;



ALTER TABLE pedido ADD COLUMN obs VARCHAR(200) NOT NULL;

ALTER TABLE pedido CHANGE obs observacao VARCHAR(200) NOT NULL;

ALTER TABLE pedido CHANGE observacao observacao TEXT;

DESCRIBE pedido;

DROP TABLE categoria;

SHOW TABLES;

DESCRIBE produto;



INSERT INTO cidade VALUES ( 1 , "Porto Alegre" ) ;
INSERT INTO cidade VALUES ( NULL , "Capão da Canoa" ) ;
INSERT INTO cidade VALUES ( 3 , "Canoas" ) , ( NULL , "Alvorada") ;
INSERT INTO cidade (nome) VALUES ( "Esteio" ) ;
INSERT INTO cidade (nome) VALUES ( "Viamão" ) , ("São Leopoldo") ;


SELECT * FROM cidade;


CREATE TABLE pessoa (
	idPessoa INT NOT NULL AUTO_INCREMENT ,
    nome VARCHAR(50) NOT NULL ,
    nascimento DATE ,
    altura DOUBLE ,
    codCidade INT ,
    PRIMARY KEY ( idPessoa ) ,
    FOREIGN KEY ( codCidade ) REFERENCES cidade ( idCidade )
);


INSERT INTO pessoa VALUES 
( 1 , "Maria", "1985-01-25" , 1.75 , 2 ) ;


INSERT INTO pessoa VALUES 
( NULL , "Júlia", "2008-10-18" , 1.62 , 1 ) ;

INSERT INTO pessoa ( nome, altura , nascimento ) VALUES 
( "Carlos", 1.85 , "1995-05-12"  ) ;

INSERT INTO pessoa VALUES 
( NULL , "Suzy", "1983-11-18" , 1.72 , 2 ) , 
( 10 , "Adalto", "1986-02-05" , 1.80 , 4 )  ;



INSERT INTO pessoa ( nome, altura , nascimento , codCidade ) VALUES 
( "João", 1.58 , "1980-08-17" , 2 ) ,  
( "José", 1.85 , "1975-05-30" , 4  ) ;


SELECT * FROM pessoa;


UPDATE pessoa SET altura = 1.82 WHERE idPessoa = 10 ;

UPDATE pessoa SET 
altura = 1.65 , 
nascimento = "2001-02-01" 
WHERE idPessoa = 3 ;

UPDATE pessoa SET 
altura = 1.8 , 
nascimento = "1994-06-17" 
WHERE idPessoa > 10 ;

UPDATE pessoa SET codCidade = 6 WHERE altura > 1.8 ;


select * FROM cidade;

DELETE FROM cidade WHERE idCidade = 7 ;

DELETE FROM cidade WHERE idCidade = 1 ;

DELETE FROM cidade WHERE nome LIKE "S%" ;

-- 14/10/2022

SELECT nome, nascimento, altura FROM pessoa;

SELECT nome, nascimento, altura 
FROM pessoa
WHERE nascimento < '2000-01-01' AND altura < 1.8 ;

SELECT nome, nascimento, altura 
FROM pessoa
WHERE altura >= 1.7 AND altura < 1.8 ;

SELECT nome, nascimento, altura 
FROM pessoa
WHERE altura < 1.7 OR altura >= 1.8 ;


SELECT nome, nascimento, altura 
FROM pessoa
WHERE altura < 1.7 OR altura >= 1.8
ORDER BY nome DESC ;

SELECT idPessoa, nome, nascimento, altura 
FROM pessoa
WHERE altura < 1.7 OR altura >= 1.8
ORDER BY altura, nome ;



UPDATE pessoa SET 
altura = 1.65 
WHERE idPessoa = 10;


SELECT idPessoa, nome 
FROM pessoa
WHERE nome = " Adalto";

SELECT idPessoa, nome, altura, nascimento 
FROM pessoa
WHERE nome LIKE "%s%"
ORDER BY altura;

SELECT nome, altura, DATE_FORMAT(nascimento , '%d/%m - %u') 
FROM pessoa
ORDER BY altura;

SELECT nome, altura , 
		( altura * 2 ) AS dobro , 
		CONCAT(nome, " - ", altura * 2 ) AS "Informações da Pessoa"
FROM pessoa
WHERE (altura * 2) > 3.3;

SELECT * 
FROM pessoa
WHERE codCidade  IS NOT NULL;





show databases;


CREATE DATABASE lojinha;

USE lojinha;

CREATE TABLE estados ( 
codigo INT NOT NULL PRIMARY KEY AUTO_INCREMENT , 
nome VARCHAR(100) NOT NULL ); 

CREATE TABLE cidades ( 
codigo INT NOT NULL PRIMARY KEY AUTO_INCREMENT , 
nome VARCHAR(100) NOT NULL, 
codEstado INT DEFAULT 1 , 
FOREIGN KEY (codEstado) REFERENCES estados(codigo) );    

CREATE TABLE pessoas ( 
codigo INT NOT NULL PRIMARY KEY AUTO_INCREMENT , 
nome VARCHAR(100) NOT NULL , 
altura DOUBLE , 
nascimento DATE DEFAULT '1970-12-25' , 
codCidade INT , 
FOREIGN KEY (codCidade) REFERENCES cidades(codigo) ); 


INSERT INTO pessoas ( nome, altura, nascimento, codCidade) VALUES 
("Maria", 1.75, "1992-09-28", 3 ) ,
("José", 1.65, "1986-12-05", 1 ) ,
("Júlia", 1.70, "2008-10-18", 1 ) ;

INSERT INTO pessoas ( nome, altura, nascimento, codCidade) VALUES 
("joão", 1.75, "1992-09-28", 2 ) ;


SELECT p.codigo, p.nome, c.nome AS Cidade , e.nome AS UF
FROM pessoas p
INNER JOIN cidades c ON c.codigo = p.codCidade
INNER JOIN estados e ON e.codigo = c.codEstado;




CREATE TABLE pedidos ( 
	codigo INT NOT NULL PRIMARY KEY AUTO_INCREMENT ,
	endereco VARCHAR(100) NOT NULL , 
    horario DATETIME  , 
    codCliente INT , 
	FOREIGN KEY (codCliente) REFERENCES pessoas(codigo) 
 );

INSERT INTO pedidos ( endereco, horario, codCliente ) VALUES
("Av. Ipiranga, 1000", "2022-10-27 14:25:10" , 2 ),
("Av. Guilherme Shell, 1515", "2022-10-28 09:10:15" , 1 );

SELECT DATE_FORMAT(pd.horario, "%d/%m/%Y %H:%i:%s") AS Horário ,
		pd.endereco, p.nome , c.nome AS Cidade, e.nome AS UF
FROM pedidos pd
INNER JOIN pessoas p ON p.codigo = pd.codCliente
INNER JOIN cidades c ON c.codigo = p.codCidade
INNER JOIN estados e ON e.codigo = c.codEstado;



INSERT INTO estados (nome) VALUES ("RS") , ("SC") , ("PR"), ("SP");
SELECT * FROM estados;

INSERT INTO cidades ( nome , codEstado ) VALUES 
("Porto Alegre", 1 ) , 
("Florianópolis" , 2 ) , 
("Canoas" , 1 ), 
("Curitiba", 3);

SELECT c.codigo, c.nome, e.codigo AS idEstado, e.nome AS sigla
FROM cidades c 
INNER JOIN Estados e ON e.codigo = c.codEstado
ORDER BY c.nome;





SELECT c.codigo, 
	   c.nome , 
		( 
			SELECT COUNT( p.codigo )  
			FROM pessoas p
			WHERE p.codCidade = c.codigo
			
			) AS moradores   , 
                    
       c.codEstado, e.nome
FROM cidades c
INNER JOIN estados e ON e.codigo = c.codEstado;
-- ---------------------

SELECT e.nome, 

	( SELECT COUNT(c.codigo) 
		FROM cidades c
        WHERE c.codEstado = e.codigo ) AS "Total de Cidades" , 
        
    ( SELECT COUNT(pd.codigo) 
		FROM pedidos pd
        INNER JOIN pessoas p ON p.codigo = pd.codCliente
        INNER JOIN cidades c ON c.codigo = p.codCidade 
        WHERE c.codEstado = e.codigo ) AS "Total de Pedidos" 

FROM estados e;




-- --------------------------------------------------------------------------- 04/11/2022


SELECT * FROM pessoas;
SELECT * FROM cidades;
-- Pessoas de SC que tem altura acima da média 
-- de todas pessoas
SELECT p.nome, p.altura 
FROM pessoas p
INNER JOIN cidades c ON c.codigo = p.codCidade 
WHERE altura > ( 
				 SELECT AVG(altura) 
				 FROM pessoas 
			   ) AND c.codEstado = 2  ;
               
               
-- Pessoas que tem altura a partir da média 
-- das pessoas de SC
SELECT p.nome, p.altura 
FROM pessoas p 
WHERE altura >= ( 
				 SELECT AVG(p2.altura) 
				 FROM pessoas p2
                 INNER JOIN cidades c ON c.codigo = p2.codCidade
                 WHERE c.codEstado = 2
			   )  ;

-- Pessoas DE SC que tem altura a partir da média 
-- das pessoas de SC
SELECT p.nome, p.altura 
FROM pessoas p 
INNER JOIN cidades c ON c.codigo = p.codCidade
WHERE 	c.codEstado = 2 AND
		p.altura >= ( 
				 SELECT AVG(p2.altura) 
				 FROM pessoas p2
                 INNER JOIN cidades c2 ON c2.codigo = p2.codCidade
                 WHERE c2.codEstado = 2
			   )  ;

select timestampdiff(  YEAR  , nascimento, now() ) 
FROM pessoas;

SELECT nome, nascimento ,
		timestampdiff( YEAR  , nascimento, now() )  as IDADE
FROM pessoas
WHERE timestampdiff(  YEAR  , nascimento, now() )  > 
		(
			SELECT AVG( timestampdiff(YEAR,nascimento,now() ) )  
			FROM pessoas
        );
        
SET @media = ( SELECT AVG( timestampdiff(YEAR,nascimento,now() ) )  
			   FROM pessoas );
SELECT @media;

INSERT INTO pessoas VALUES (NULL, 'Rodrigo' , 1.8, '1971-12-08', 2);
            
SELECT nome, nascimento ,
		timestampdiff( YEAR  , nascimento, now() )  as IDADE
FROM pessoas
WHERE timestampdiff(  YEAR  , nascimento, now() )  > 
		@media;
            






SELECT c.codigo, c.nome 
FROM cidades c
WHERE EXISTS (
				SELECT * 
                FROM pessoas p
                WHERE p.codCidade = c.codigo
			);
            
SELECT DISTINCT c.codigo, c.nome 
FROM cidades c 
INNER JOIN pessoas p ON p.codCidade = c.codigo;

SELECT c.codigo, c.nome 
FROM cidades c 
WHERE ( 
		SELECT COUNT(*) 
        FROM pessoas p 
        WHERE p.codCidade = c.codigo ) = 0 ;

























