/*
 View - vw_Cursos_Analitica - Visão Analítica dos Cursos oferecidos pelas IES no Brasil
 A view agrega informações detalhadas sobre os cursos oferecidos pelas Instituições de Ensino Superior (IES) no Brasil, incluindo dados geográficos e demográficos. A view combina dados das tabelas Curso, IES, Endereço, Município, UF, CINE (Classificação Internacional Normalizada da Educação) e Matrícula por Ano, proporcionando uma visão abrangente dos cursos, suas localizações e a distribuição de matrículas por gênero ao longo dos anos.
 */
CREATE VIEW inep.vw_Cursos_Analitica AS
SELECT cur.id_curso,
    cur.nome_curso,
    ies.nome_ies,
    uf.sigla_uf,
    cg.nome_area_geral AS area_cine,
    ma.id_ano,
    ma.qt_mat,
    ma.qt_mat_fem,
    ma.qt_mat_masc
FROM inep.Curso cur
    JOIN inep.IES ies ON ies.id_ies = cur.id_ies
    JOIN inep.Endereco ende ON ende.id_endereco = ies.id_endereco
    JOIN inep.Municipio mun ON mun.id_municipio = ende.id_municipio
    JOIN inep.UF uf ON uf.id_uf = mun.id_uf
    JOIN inep.Cine_Area_Detalhada cd ON cd.id_cine_area_detalhada = cur.id_cine_area_detalhada
    JOIN inep.Cine_Area_Especifica ce ON ce.id_cine_area_especifica = cd.id_cine_area_especifica
    JOIN inep.Cine_Area_Geral cg ON cg.id_cine_area_geral = ce.id_cine_area_geral
    LEFT JOIN inep.Matricula_Ano ma ON ma.id_curso = cur.id_curso;
GO -- Exemplos
SELECT *
FROM inep.vw_Cursos_Analitica;
GO