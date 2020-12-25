CREATE TABLE conflito (
	cod_conflito SERIAL PRIMARY KEY,
	nome VARCHAR(128) NOT NULL,
	num_feridos INT DEFAULT 0,
	num_mortos INT DEFAULT 0,
	CHECK (num_feridos >= 0),
	CHECK (num_mortos >= 0)
);

CREATE TABLE pais_conflito (
	cod_conflito INT,
	nome VARCHAR(64),
	PRIMARY KEY (cod_conflito, nome),
	FOREIGN KEY (cod_conflito) REFERENCES conflito(cod_conflito)
);

CREATE TABLE territorial (
	cod_conflito INT,
	regiao_atingida VARCHAR(128),
	PRIMARY KEY (cod_conflito, regiao_atingida),
	FOREIGN KEY (cod_conflito) REFERENCES conflito(cod_conflito)
);

CREATE TABLE religioso (
	cod_conflito INT,
	religiao_atingida VARCHAR(128),
	PRIMARY KEY (cod_conflito, religiao_atingida),
	FOREIGN KEY (cod_conflito) REFERENCES conflito(cod_conflito)
);

CREATE TABLE economico (
	cod_conflito INT,
	materia_prima VARCHAR(128),
	PRIMARY KEY (cod_conflito, materia_prima),
	FOREIGN KEY (cod_conflito) REFERENCES conflito(cod_conflito)
);

CREATE TABLE racial (
	cod_conflito INT,
	raca_atingida VARCHAR(128),
	PRIMARY KEY (cod_conflito, raca_atingida),
	FOREIGN KEY (cod_conflito) REFERENCES conflito(cod_conflito)
);

CREATE TABLE traficante (
	nome VARCHAR(128) PRIMARY KEY
);

CREATE TABLE tipo_arma (
	nome VARCHAR(128) PRIMARY KEY,
	indicador INT NOT NULL
);

CREATE TABLE pode_fornecer (
	nome_trafica VARCHAR(128),
	nome_arma VARCHAR(128),
	quantidade INT NOT NULL,
	CHECK(quantidade >= 0),
	PRIMARY KEY (nome_trafica, nome_arma),
	FOREIGN KEY (nome_trafica)
	REFERENCES traficante(nome)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (nome_arma)
	REFERENCES tipo_arma(nome)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE organizacao_mediadora (
	cod_organizacao SERIAL PRIMARY KEY,
	depende INT,
	nome VARCHAR(128) NOT NULL,
	tipo_org VARCHAR(128) NOT NULL,
	tipo_ajuda VARCHAR(128) NOT NULL,
	num_pessoas INT DEFAULT 0,
	CHECK(num_pessoas >= 0),
	FOREIGN KEY (depende) 
	REFERENCES organizacao_mediadora(cod_organizacao)
	ON DELETE SET NULL
	ON UPDATE CASCADE
);

CREATE TABLE media (
	cod_conflito INT,
	cod_organizacao INT,
	data_entrada DATE NOT NULL,
	data_saida DATE,
	PRIMARY KEY (cod_conflito, cod_organizacao),
	FOREIGN KEY (cod_conflito)
	REFERENCES conflito(cod_conflito)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (cod_organizacao)
	REFERENCES organizacao_mediadora(cod_organizacao)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE grupo_armado (
	cod_grupo SERIAL PRIMARY KEY,
	nome VARCHAR(128) NOT NULL,
	num_baixas INT DEFAULT 0,
	CHECK(num_baixas >= 0)
);

CREATE TABLE fornece (
	cod_grupo INT,
	nome_trafica VARCHAR(128),
	nome_arma VARCHAR(128),
	num_armas INT NOT NULL,
	CHECK(num_armas >= 0),
	PRIMARY KEY (cod_grupo, nome_trafica, nome_arma),
	FOREIGN KEY (cod_grupo)
	REFERENCES grupo_armado(cod_grupo)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (nome_trafica)
	REFERENCES traficante(nome)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (nome_arma)
	REFERENCES tipo_arma(nome)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE divisao (
	num_divisao SERIAL,
	cod_grupo INT,
	num_barcos INT DEFAULT 0,
	num_avioes INT DEFAULT 0,
	num_tanques INT DEFAULT 0,
	num_homens INT DEFAULT 0,
	num_baixas INT DEFAULT 0,
	PRIMARY KEY (num_divisao, cod_grupo),
	CHECK(num_barcos >= 0),
	CHECK(num_avioes >= 0),
	CHECK(num_tanques >= 0),
	CHECK(num_homens >= 0),
	CHECK(num_baixas >= 0),
	FOREIGN KEY (cod_grupo)
	REFERENCES grupo_armado(cod_grupo)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE participam (
	cod_conflito INT,
	cod_grupo INT,
	data_entrada DATE NOT NULL,
	data_saida DATE,
	PRIMARY KEY (cod_conflito, cod_grupo),
	FOREIGN KEY (cod_conflito)
	REFERENCES conflito(cod_conflito)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (cod_grupo)
	REFERENCES grupo_armado(cod_grupo)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE lider_politico (
	cod_grupo INT,
	nome VARCHAR(128) NOT NULL,
	apoios VARCHAR(128),
	PRIMARY KEY (cod_grupo, nome),
	FOREIGN KEY (cod_grupo)
	REFERENCES grupo_armado(cod_grupo)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE chefe_militar (
	cod_chefe SERIAL PRIMARY KEY,
	cod_grupo_lider INT,
	nome_lider VARCHAR(128),
	cod_grupo_divisao INT,
	num_divisao INT,
	faixa VARCHAR(64),
	FOREIGN KEY (cod_grupo_lider, nome_lider)
	REFERENCES lider_politico(cod_grupo, nome)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (num_divisao, cod_grupo_divisao)
	REFERENCES divisao(num_divisao, cod_grupo)
	ON DELETE SET NULL
	ON UPDATE CASCADE
);

CREATE TABLE dialoga (
	cod_organizacao INT,
	cod_grupo INT,
	nome_lider VARCHAR(128),
	PRIMARY KEY (cod_organizacao, cod_grupo, nome_lider),
	FOREIGN KEY (cod_grupo, nome_lider)
	REFERENCES lider_politico(cod_grupo, nome)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

