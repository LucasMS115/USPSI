--------------------- BAIXAS ATUAL ---------------------
--FUNCAO
CREATE OR REPLACE FUNCTION baixas_grupo_atual()
RETURNS TRIGGER AS $$

DECLARE
	total INTEGER := SUM(num_baixas) FROM divisao WHERE cod_grupo = NEW.cod_grupo;
	
BEGIN

RAISE NOTICE 'INICIO baixas_grupo_atual() OPERACAO: % ', TG_OP;
RAISE NOTICE 'OLD?: % ', OLD.cod_grupo;
RAISE NOTICE 'GRUPO % ',  NEW.cod_grupo;
RAISE NOTICE 'BAIXAS DA DIVISAO: % ', NEW.num_baixas;
RAISE NOTICE 'TOTAL DE BAIXAS %' , total;

-- ATUALIZA BAIXAS DO GRUPO NOVO
UPDATE grupo_armado
SET num_baixas = total
WHERE cod_grupo = NEW.cod_grupo;

--FIM
return NEW;
END
$$ LANGUAGE plpgsql;
--FUNCAO /

--TRIGGER
CREATE TRIGGER update_baixas_atual
AFTER INSERT OR UPDATE
ON divisao
FOR EACH ROW
EXECUTE PROCEDURE baixas_grupo_atual();
--TRIGGER /

--------------------- BAIXAS ATUAL --------------------- /



--------------------- BAIXAS ANTIGO --------------------- 
--FUNCAO
CREATE OR REPLACE FUNCTION baixas_grupo_antigo()
RETURNS TRIGGER AS $$

DECLARE
	total_baixas_old INTEGER := SUM(num_baixas) FROM divisao WHERE cod_grupo = OLD.cod_grupo;

BEGIN

RAISE NOTICE 'INICIO baixas_grupo_antigo() OPERACAO: % ', TG_OP;
RAISE NOTICE 'GRUPO OLD: % ', OLD.cod_grupo;
RAISE NOTICE 'GRUPO NEW?: % ',  NEW.cod_grupo;
RAISE NOTICE 'Total OLD: % ', total_baixas_old ;

--ATUALIZA BAIXAS DO GRUPO ANTIGO
UPDATE grupo_armado
SET num_baixas = total_baixas_old
WHERE cod_grupo = OLD.cod_grupo;

--FIM
return NEW;
END
$$ LANGUAGE plpgsql;
--FUNCAO /

--TRIGGER
CREATE TRIGGER update_baixas_antigo
AFTER UPDATE OR DELETE
ON divisao
FOR EACH ROW
EXECUTE PROCEDURE baixas_grupo_antigo();
--TRIGGER /
--------------------- BAIXAS ANTIGO --------------------- /

--------------------- NUM DIV ---------------------
--FUNCAO
CREATE OR REPLACE FUNCTION set_num_div_func()
RETURNS TRIGGER AS $$

DECLARE
	max_num_div INTEGER := MAX(num_divisao) FROM divisao WHERE cod_grupo = NEW.cod_grupo;
	
BEGIN

RAISE NOTICE 'INICIO set_num_div() OPERACAO: % ', TG_OP;
RAISE NOTICE 'NEW GRUPO: % ', NEW.cod_grupo;
RAISE NOTICE 'OLD GRUPO?: % ', OLD.cod_grupo;
RAISE NOTICE 'MAX DA DIVISAO: % ', max_num_div;

-- ATUALIZA BAIXAS DO GRUPO NOVO
IF max_num_div IS NULL 
	THEN
		RAISE NOTICE 'NEW = 1';
		NEW.num_divisao = 1;
	ELSE 
		RAISE NOTICE 'NEW = MAX + 1';
		NEW.num_divisao = max_num_div + 1;
END IF;

--FIM
return NEW;
END
$$ LANGUAGE plpgsql;
--FUNCAO /

--DROP TRIGGER IF EXISTS set_num_div ON divisao;

--TRIGGER
CREATE TRIGGER set_num_div
BEFORE INSERT OR UPDATE
ON divisao
FOR EACH ROW
EXECUTE PROCEDURE set_num_div_func();
--TRIGGER /

--------------------- NUM DIV --------------------- /



--------------------------------------- TESTES -------------------------------------------- 
INSERT INTO grupo_armado (cod_grupo, nome)
VALUES (1, 'MILICIA'), (2, 'PCC'), (3, 'TURMA DO BAIRRO');

INSERT INTO divisao (cod_grupo, num_baixas)
VALUES (1, 10), (1,20), (1, 30),
		(2,10), (2,30), (2, 60),
		(3,40), (3,100),(3, 60);
		
SELECT * FROM grupo_armado;
SELECT * FROM divisao;

INSERT INTO divisao (cod_grupo, num_baixas)
VALUES (1, 33);
	
UPDATE divisao
SET cod_grupo = 2
WHERE num_divisao = 10 AND cod_grupo = 1;

SELECT * FROM grupo_armado;
SELECT * FROM divisao;

DELETE FROM divisao WHERE num_divisao = 10 AND cod_grupo = 2;

SELECT * FROM divisao WHERE num_divisao > 1 AND cod_grupo = 1;

SELECT MAX(num_divisao) FROM divisao WHERE cod_grupo = 2;

--RESET
DELETE FROM grupo_armado;
DELETE FROM divisao;
ALTER SEQUENCE divisao_num_divisao_seq RESTART WITH 1;

