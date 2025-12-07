/*
 Consulta 1 - Rank de Instituições de Ensino Superior (IES) no Distrito Federal (DF) com base no número total de docentes.
 Esta consulta gera um ranking das IES localizadas no DF, ordenadas pelo número total de docentes. Ela agrega os dados de docentes por IES, junta essas informações com detalhes da IES, município, UF e mantenedora, e então filtra para mostrar apenas as IES do DF, ordenadas pelo total de docentes em ordem decrescente.
 */
WITH docentes_por_ies AS (
    SELECT doc_ano.id_ies,
        SUM(doc_ano.qt_doc_total) AS total_docentes
    FROM inep.Docente_Ano doc_ano
    GROUP BY doc_ano.id_ies
),
info_ies AS (
    SELECT ies.id_ies,
        ies.nome_ies,
        ies.sigla_ies,
        muni.nome_municipio,
        uf.sigla_uf,
        man.nome_mantenedora,
        doc.total_docentes,
        RANK() OVER (
            PARTITION BY uf.sigla_uf
            ORDER BY doc.total_docentes DESC
        ) AS rank_docentes
    FROM inep.IES ies
        JOIN inep.Endereco ende ON ende.id_endereco = ies.id_endereco
        JOIN inep.Municipio muni ON muni.id_municipio = ende.id_municipio
        JOIN inep.UF uf ON uf.id_uf = muni.id_uf
        JOIN inep.Mantenedora man ON man.id_mantenedora = ies.id_mantenedora
        LEFT JOIN docentes_por_ies doc ON doc.id_ies = ies.id_ies
)
SELECT *
FROM info_ies
WHERE sigla_uf = 'DF'
ORDER BY rank_docentes;