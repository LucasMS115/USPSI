--------------------------------------------------------------- A --------------------------------------------------------------- 

--- Exclusividade da hierarquia de conflitos. (INSERT)
CREATE OR REPLACE RULE territorial_restrito_insert AS 
ON INSERT TO territorial
WHERE (SELECT count(*) 
       FROM religioso 
       WHERE religioso.cod_conflito = NEW.cod_conflito) > 0
       OR
      (SELECT count(*) 
       FROM racial 
       WHERE racial.cod_conflito = NEW.cod_conflito) > 0
       OR
       (SELECT count(*) 
       FROM economico 
       WHERE economico.cod_conflito = NEW.cod_conflito) > 0    
DO INSTEAD NOTHING;

CREATE OR REPLACE RULE racial_restrito_insert AS 
ON INSERT TO racial
WHERE (SELECT count(*) 
       FROM religioso 
       WHERE religioso.cod_conflito = NEW.cod_conflito) > 0
       OR
      (SELECT count(*) 
       FROM territorial 
       WHERE territorial.cod_conflito = NEW.cod_conflito) > 0
       OR
       (SELECT count(*) 
       FROM economico 
       WHERE economico.cod_conflito = NEW.cod_conflito) > 0    
DO INSTEAD NOTHING;

CREATE OR REPLACE RULE religioso_restrito_insert AS 
ON INSERT TO religioso
WHERE (SELECT count(*) 
       FROM racial 
       WHERE racial.cod_conflito = NEW.cod_conflito) > 0
       OR
      (SELECT count(*) 
       FROM territorial 
       WHERE territorial.cod_conflito = NEW.cod_conflito) > 0
       OR
       (SELECT count(*) 
       FROM economico 
       WHERE economico.cod_conflito = NEW.cod_conflito) > 0    
DO INSTEAD NOTHING;

CREATE OR REPLACE RULE economico_restrito_insert AS 
ON INSERT TO economico
WHERE (SELECT count(*) 
       FROM racial 
       WHERE racial.cod_conflito = NEW.cod_conflito) > 0
       OR
      (SELECT count(*) 
       FROM territorial 
       WHERE territorial.cod_conflito = NEW.cod_conflito) > 0
       OR
       (SELECT count(*) 
       FROM religioso 
       WHERE religioso.cod_conflito = NEW.cod_conflito) > 0    
DO INSTEAD NOTHING;

--- Exclusividade da hierarquia de conflitos. (INSERT) / -----------------------------------------------

--- Exclusividade da hierarquia de conflitos. (UPDATE)

CREATE OR REPLACE RULE territorial_restrito_update AS 
ON UPDATE TO territorial
WHERE (SELECT count(*) 
       FROM religioso 
       WHERE religioso.cod_conflito = NEW.cod_conflito) > 0
       OR
      (SELECT count(*) 
       FROM racial 
       WHERE racial.cod_conflito = NEW.cod_conflito) > 0
       OR
       (SELECT count(*) 
       FROM economico 
       WHERE economico.cod_conflito = NEW.cod_conflito) > 0    
DO INSTEAD NOTHING;

CREATE OR REPLACE RULE racial_restrito_update AS 
ON UPDATE TO racial
WHERE (SELECT count(*) 
       FROM religioso 
       WHERE religioso.cod_conflito = NEW.cod_conflito) > 0
       OR
      (SELECT count(*) 
       FROM territorial 
       WHERE territorial.cod_conflito = NEW.cod_conflito) > 0
       OR
       (SELECT count(*) 
       FROM economico 
       WHERE economico.cod_conflito = NEW.cod_conflito) > 0    
DO INSTEAD NOTHING;

CREATE OR REPLACE RULE religioso_restrito_update AS 
ON UPDATE TO religioso
WHERE (SELECT count(*) 
       FROM racial 
       WHERE racial.cod_conflito = NEW.cod_conflito) > 0
       OR
      (SELECT count(*) 
       FROM territorial 
       WHERE territorial.cod_conflito = NEW.cod_conflito) > 0
       OR
       (SELECT count(*) 
       FROM economico 
       WHERE economico.cod_conflito = NEW.cod_conflito) > 0    
DO INSTEAD NOTHING;

CREATE OR REPLACE RULE economico_restrito_update AS 
ON UPDATE TO economico
WHERE (SELECT count(*) 
       FROM racial 
       WHERE racial.cod_conflito = NEW.cod_conflito) > 0
       OR
      (SELECT count(*) 
       FROM territorial 
       WHERE territorial.cod_conflito = NEW.cod_conflito) > 0
       OR
       (SELECT count(*) 
       FROM religioso 
       WHERE religioso.cod_conflito = NEW.cod_conflito) > 0    
DO INSTEAD NOTHING;

--- Exclusividade da hierarquia de conflitos. (UPDATE) / 

--------------------------------------------------------------- A --------------------------------------------------------------- /


--------------------------------------------------------------- B ---------------------------------------------------------------

ALTER TABLE chefe_militar
ALTER COLUMN cod_grupo_lider
SET NOT NULL;

ALTER TABLE chefe_militar
ALTER COLUMN nome_lider
SET NOT NULL;

--------------------------------------------------------------- B --------------------------------------------------------------- /


--------------------------------------------------------------- C,D --------------------------------------------------------------- 

-- Uma divisão é dirigida por três chefes militares como máximo.
CREATE OR REPLACE RULE chefemilitar_lider_insert AS 
ON INSERT TO chefe_militar
WHERE (SELECT count(*) FROM chefe_militar WHERE num_divisao = NEW.num_divisao) >= 3
DO INSTEAD NOTHING; 

-- Uma divisão é dirigida pelo menos por um chefe militar.
CREATE OR REPLACE RULE chefemilitar_lider_delete AS 
ON DELETE TO chefe_militar
WHERE (SELECT count(*) FROM chefe_militar WHERE num_divisao = OLD.num_divisao) <= 1 
DO INSTEAD NOTHING; 

-- Uma divisão é dirigida por três chefes militares como máximo.
-- Uma divisão é dirigida pelo menos por um chefe militar.
CREATE OR REPLACE RULE chefemilitar_lider_update AS 
ON UPDATE TO chefe_militar
WHERE (SELECT count(*) FROM chefe_militar WHERE num_divisao = OLD.num_divisao) <= 1  
OR (SELECT count(*) FROM chefe_militar WHERE num_divisao = NEW.num_divisao) >= 3
DO INSTEAD NOTHING; 

--------------------------------------------------------------- C,D --------------------------------------------------------------/


--------------------------------------------------------------- E --------------------------------------------------------------

-- Todo grupo armado dispõe de no mínimo uma divisão.
CREATE OR REPLACE RULE grupoarmado_divisao_delete AS 
ON DELETE TO divisao
WHERE (SELECT count(*) FROM divisao WHERE cod_grupo = OLD.cod_grupo) <= 1 
DO INSTEAD NOTHING; 

-- Todo grupo armado dispõe de no mínimo uma divisão.
CREATE OR REPLACE RULE grupoarmado_divisao_update AS 
ON UPDATE TO divisao
WHERE (SELECT count(*) FROM divisao WHERE cod_grupo = OLD.cod_grupo) <= 1 
DO INSTEAD NOTHING; 

--------------------------------------------------------------- E -------------------------------------------------------------- /


--------------------------------------------------------------- F -------------------------------------------------------------- 

-- Em um conflito armado participam como mínimo dois grupos armados.
CREATE OR REPLACE RULE participam_grupoarmado_delete AS 
ON DELETE TO participam
WHERE (SELECT count(*) FROM participam
	   	WHERE cod_conflito = OLD.cod_conflito AND data_saida IS null) <= 2 AND OLD.data_saida IS null
DO INSTEAD NOTHING; 

-- Em um conflito armado participam como mínimo dois grupos armados.
CREATE OR REPLACE RULE participam_grupoarmado_update AS 
ON UPDATE TO participam
WHERE (SELECT count(*) FROM participam
	   		WHERE cod_conflito = OLD.cod_conflito AND data_saida IS null) <= 2 AND OLD.data_saida IS null
DO INSTEAD NOTHING;

--------------------------------------------------------------- F -------------------------------------------------------------- /

--------------------------------------------------------------- G -------------------------------------------------------------- 

-- Qualquer conflito afeta pelo menos um país.
CREATE OR REPLACE RULE pais_conflito_delete AS 
ON DELETE TO pais_conflito
WHERE (SELECT count(*) FROM pais_conflito WHERE cod_conflito = OLD.cod_conflito) <= 1 
DO INSTEAD NOTHING; 

-- Qualquer conflito afeta pelo menos um país.
CREATE OR REPLACE RULE pais_conflito_update AS 
ON UPDATE TO pais_conflito
WHERE (SELECT count(*) FROM pais_conflito WHERE cod_conflito = OLD.cod_conflito) <= 1 
DO INSTEAD NOTHING; 

--------------------------------------------------------------- G -------------------------------------------------------------- /


--------------------------------------------------------------- H -------------------------------------------------------------- 
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

--------------------------------------------------------------- H -------------------------------------------------------------- /