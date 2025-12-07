GO USE INEP_DB;
/*
 TABELAS GEOGRÁFICAS
 */
CREATE TABLE inep.Regiao (
    id_regiao INT PRIMARY KEY,
    nome_regiao VARCHAR(100) NOT NULL
);
CREATE TABLE inep.UF (
    id_uf INT PRIMARY KEY,
    sigla_uf CHAR(2) NOT NULL,
    nome_uf VARCHAR(100) NOT NULL,
    id_regiao INT NOT NULL,
    FOREIGN KEY (id_regiao) REFERENCES inep.Regiao(id_regiao)
);
CREATE TABLE inep.Municipio (
    id_municipio INT PRIMARY KEY,
    nome_municipio VARCHAR(150) NOT NULL,
    id_uf INT NOT NULL,
    FOREIGN KEY (id_uf) REFERENCES inep.UF(id_uf)
);
CREATE TABLE inep.Endereco (
    id_endereco INT IDENTITY(1, 1) PRIMARY KEY,
    endereco VARCHAR(255) NOT NULL,
    numero_endereco VARCHAR(20) NOT NULL,
    complemento VARCHAR(255) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    id_municipio INT NOT NULL,
    FOREIGN KEY (id_municipio) REFERENCES inep.Municipio(id_municipio)
);
/*
 TABELAS INSTITUCIONAIS
 */
CREATE TABLE inep.Mantenedora (
    id_mantenedora INT PRIMARY KEY,
    nome_mantenedora VARCHAR(255) NOT NULL,
    categoria_administrativa VARCHAR(100) NOT NULL,
    natureza_juridica_comunitaria BIT NOT NULL,
    natureza_juridica_confessional BIT NOT NULL,
);
CREATE TABLE inep.IES (
    id_ies INT IDENTITY PRIMARY KEY,
    nome_ies VARCHAR(255) NOT NULL,
    sigla_ies VARCHAR(50),
    organizacao_academica VARCHAR(100) NOT NULL,
    rede_ensino VARCHAR(100) NOT NULL,
    sede_capital BIT,
    acesso_portal_capes BIT,
    acesso_outras_bases BIT,
    assina_outra_base BIT,
    repositorio_institucional BIT,
    busca_integrada BIT,
    servico_internet BIT,
    participa_rede_social BIT,
    catalogo_online BIT,
    id_mantenedora INT NOT NULL,
    id_endereco INT NOT NULL,
    FOREIGN KEY (id_mantenedora) REFERENCES inep.Mantenedora(id_mantenedora),
    FOREIGN KEY (id_endereco) REFERENCES inep.Endereco(id_endereco)
);
/*
 TABELAS DE ÁREAS DO CINE
 */
CREATE TABLE inep.Cine_Area_Geral (
    id_cine_area_geral INT PRIMARY KEY,
    nome_area_geral VARCHAR(255) NOT NULL
);
CREATE TABLE inep.Cine_Area_Especifica (
    id_cine_area_especifica INT PRIMARY KEY,
    nome_area_especifica VARCHAR(255) NOT NULL,
    id_cine_area_geral INT NOT NULL,
    FOREIGN KEY (id_cine_area_geral) REFERENCES inep.cine_area_geral(id_cine_area_geral)
);
CREATE TABLE inep.Cine_Area_Detalhada (
    id_cine_area_detalhada INT PRIMARY KEY,
    nome_area_detalhada VARCHAR(255) NOT NULL,
    id_cine_area_especifica INT NOT NULL,
    FOREIGN KEY (id_cine_area_especifica) REFERENCES inep.cine_area_especifica(id_cine_area_especifica)
);
/*
 TABELAS DE CURSOS
 */
CREATE TABLE inep.Curso (
    id_curso INT PRIMARY KEY,
    nome_curso VARCHAR(255) NOT NULL,
    grau_academico VARCHAR(100),
    gratuito BIT NOT NULL,
    modalidade_ensino VARCHAR(50) NOT NULL,
    nivel_academico VARCHAR(50) NOT NULL,
    oferta VARCHAR(255) NOT NULL,
    id_ies INT NOT NULL,
    id_cine_area_detalhada INT NOT NULL,
    FOREIGN KEY (id_ies) REFERENCES inep.ies(id_ies),
    FOREIGN KEY (id_cine_area_detalhada) REFERENCES inep.cine_area_detalhada(id_cine_area_detalhada)
);
/*
 TABELAS DE ANOS E DADOS TEMPORAIS
 */
CREATE TABLE inep.Ano_Censo (id_ano INT PRIMARY KEY);
INSERT INTO inep.Ano_Censo (id_ano)
VALUES (2020),
    (2021),
    (2022),
    (2023),
    (2024);
GO CREATE TABLE inep.IES_Ano (
        id_ies_ano INT IDENTITY(1, 1) PRIMARY KEY,
        id_ies INT NOT NULL,
        id_ano INT NOT NULL,
        qt_periodico_eletronico INT,
        qt_livro_eletronico INT,
        FOREIGN KEY (id_ies) REFERENCES inep.ies(id_ies),
        FOREIGN KEY (id_ano) REFERENCES inep.ano_censo(id_ano)
    );
CREATE TABLE inep.Tecnico_Adm_Ano (
    id_tecnico_adm_ano INT IDENTITY(1, 1) PRIMARY KEY,
    id_ies INT NOT NULL,
    id_ano INT NOT NULL,
    qt_tec_total INT,
    qt_tec_fundamental_incomp_fem INT,
    qt_tec_fundamental_incomp_masc INT,
    qt_tec_fundamental_comp_fem INT,
    qt_tec_fundamental_comp_masc INT,
    qt_tec_medio_fem INT,
    qt_tec_medio_masc INT,
    qt_tec_superior_fem INT,
    qt_tec_superior_masc INT,
    qt_tec_especializacao_fem INT,
    qt_tec_especializacao_masc INT,
    qt_tec_mestrado_fem INT,
    qt_tec_mestrado_masc INT,
    qt_tec_doutorado_fem INT,
    qt_tec_doutorado_masc INT,
    FOREIGN KEY (id_ies) REFERENCES inep.ies(id_ies),
    FOREIGN KEY (id_ano) REFERENCES inep.ano_censo(id_ano)
);
CREATE TABLE inep.Docente_Ano (
    id_docente_ano INT IDENTITY(1, 1) PRIMARY KEY,
    id_ies INT NOT NULL,
    id_ano INT NOT NULL,
    qt_doc_total INT,
    qt_doc_exe INT,
    qt_doc_ex_femi INT,
    qt_doc_ex_masc INT,
    qt_doc_ex_sem_grad INT,
    qt_doc_ex_grad INT,
    qt_doc_ex_esp INT,
    qt_doc_ex_mest INT,
    qt_doc_ex_dout INT,
    qt_doc_ex_int INT,
    qt_doc_ex_int_de INT,
    qt_doc_ex_int_sem_de INT,
    qt_doc_ex_parc INT,
    qt_doc_ex_hor INT,
    qt_doc_ex_0_29 INT,
    qt_doc_ex_30_34 INT,
    qt_doc_ex_35_39 INT,
    qt_doc_ex_40_44 INT,
    qt_doc_ex_45_49 INT,
    qt_doc_ex_50_54 INT,
    qt_doc_ex_55_59 INT,
    qt_doc_ex_60_mais INT,
    qt_doc_ex_branca INT,
    qt_doc_ex_preta INT,
    qt_doc_ex_parda INT,
    qt_doc_ex_amarela INT,
    qt_doc_ex_indigena INT,
    qt_doc_ex_cor_nd INT,
    qt_doc_ex_bra INT,
    qt_doc_ex_est INT,
    qt_doc_ex_com_deficiencia INT,
    FOREIGN KEY (id_ies) REFERENCES inep.ies(id_ies),
    FOREIGN KEY (id_ano) REFERENCES inep.ano_censo(id_ano)
);
CREATE TABLE inep.Curso_Ano (
    id_curso_ano INT IDENTITY(1, 1) PRIMARY KEY,
    id_curso INT NOT NULL,
    id_ano INT NOT NULL,
    qt_curso INT,
    qt_vg_total INT,
    qt_vg_total_diurno INT,
    qt_vg_total_noturno INT,
    qt_vg_total_ead INT,
    qt_vg_nova INT,
    qt_vg_proc_seletivo INT,
    qt_vg_remanesc INT,
    qt_vg_prog_especial INT,
    qt_inscrito_total INT,
    qt_inscrito_total_diurno INT,
    qt_inscrito_total_noturno INT,
    qt_inscrito_total_ead INT,
    qt_insc_vg_nova INT,
    qt_insc_proc_seletivo INT,
    qt_insc_vg_remanesc INT,
    qt_insc_vg_prog_especial INT,
    qt_aluno_deficiente INT,
    FOREIGN KEY (id_curso) REFERENCES inep.curso(id_curso),
    FOREIGN KEY (id_ano) REFERENCES inep.ano_censo(id_ano)
);
CREATE TABLE inep.Ingressante_Ano(
    id_ingressante_ano INT IDENTITY(1, 1) PRIMARY KEY,
    id_curso INT NOT NULL,
    id_ano INT NOT NULL,
    qt_ing INT,
    qt_ing_fem INT,
    qt_ing_masc INT,
    qt_ing_diurno INT,
    qt_ing_noturno INT,
    qt_ing_vg_nova INT,
    qt_ing_vestibular INT,
    qt_ing_enem INT,
    qt_ing_avaliacao_seriada INT,
    qt_ing_selecao_simplifica INT,
    qt_ing_egr INT,
    qt_ing_outro_tipo_selecao INT,
    qt_ing_proc_seletivo INT,
    qt_ing_vg_remanesc INT,
    qt_ing_vg_prog_especial INT,
    qt_ing_outra_forma INT,
    qt_ing_0_17 INT,
    qt_ing_18_24 INT,
    qt_ing_25_29 INT,
    qt_ing_30_34 INT,
    qt_ing_35_39 INT,
    qt_ing_40_49 INT,
    qt_ing_50_59 INT,
    qt_ing_60_mais INT,
    qt_ing_branca INT,
    qt_ing_preta INT,
    qt_ing_parda INT,
    qt_ing_amarela INT,
    qt_ing_indigena INT,
    qt_ing_cornd INT,
    qt_ing_nacbras INT,
    qt_ing_nacestrang INT,
    qt_ing_deficiente INT,
    FOREIGN KEY (id_curso) REFERENCES inep.curso(id_curso),
    FOREIGN KEY (id_ano) REFERENCES inep.ano_censo(id_ano)
);
CREATE TABLE inep.Matricula_Ano(
    id_matricula_ano INT IDENTITY(1, 1) PRIMARY KEY,
    id_curso INT NOT NULL,
    id_ano INT NOT NULL,
    qt_mat INT,
    qt_mat_fem INT,
    qt_mat_masc INT,
    qt_mat_diurno INT,
    qt_mat_noturno INT,
    qt_mat_0_17 INT,
    qt_mat_18_24 INT,
    qt_mat_25_29 INT,
    qt_mat_30_34 INT,
    qt_mat_35_39 INT,
    qt_mat_40_49 INT,
    qt_mat_50_59 INT,
    qt_mat_60_mais INT,
    qt_mat_branca INT,
    qt_mat_preta INT,
    qt_mat_parda INT,
    qt_mat_amarela INT,
    qt_mat_indigena INT,
    qt_mat_cornd INT,
    FOREIGN KEY (id_curso) REFERENCES inep.curso(id_curso),
    FOREIGN KEY (id_ano) REFERENCES inep.ano_censo(id_ano)
);
CREATE TABLE inep.Concluinte_Ano(
    id_concluinte_ano INT IDENTITY(1, 1) PRIMARY KEY,
    id_curso INT NOT NULL,
    id_ano INT NOT NULL,
    qt_conc INT,
    qt_conc_fem INT,
    qt_conc_masc INT,
    qt_conc_diurno INT,
    qt_conc_noturno INT,
    qt_conc_0_17 INT,
    qt_conc_18_24 INT,
    qt_conc_25_29 INT,
    qt_conc_30_34 INT,
    qt_conc_35_39 INT,
    qt_conc_40_49 INT,
    qt_conc_50_59 INT,
    qt_conc_60_mais INT,
    qt_conc_branca INT,
    qt_conc_preta INT,
    qt_conc_parda INT,
    qt_conc_amarela INT,
    qt_conc_indigena INT,
    qt_conc_cornd INT,
    qt_conc_nacbras INT,
    qt_conc_nacestrang INT,
    qt_conc_deficiente INT,
    FOREIGN KEY (id_curso) REFERENCES inep.curso(id_curso),
    FOREIGN KEY (id_ano) REFERENCES inep.ano_censo(id_ano)
);