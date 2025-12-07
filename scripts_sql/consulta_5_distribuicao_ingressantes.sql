/* 
 Consulta 5 - Distribuição dos ingressantes por raça/cor e unidade federativa ao longo dos anos
 Esta consulta retorna a distribuição dos ingressantes em cursos superiores no Brasil por raça/cor e unidade federativa (UF) ao longo dos anos. Os dados são agregados por UF e ano, mostrando a quantidade total de ingressantes e a porcentagem de cada categoria racial.
 */
SELECT uf.sigla_uf,
    ano_c.id_ano,
    SUM(ia.qt_ing_branca) AS branca,
    SUM(ia.qt_ing_preta) AS preta,
    SUM(ia.qt_ing_parda) AS parda,
    SUM(ia.qt_ing_amarela) AS amarela,
    SUM(ia.qt_ing_indigena) AS indigena,
    SUM(ia.qt_ing_cornd) AS nao_declarado,
    SUM(ia.qt_ing) AS total,
    CAST(
        (SUM(ia.qt_ing_branca) * 1.0 / SUM(ia.qt_ing)) AS DECIMAL(10, 2)
    ) AS perc_branca,
    CAST(
        (SUM(ia.qt_ing_preta) * 1.0 / SUM(ia.qt_ing)) AS DECIMAL(10, 2)
    ) AS perc_preta,
    CAST(
        (SUM(ia.qt_ing_parda) * 1.0 / SUM(ia.qt_ing)) AS DECIMAL(10, 2)
    ) AS perc_parda,
    CAST(
        (SUM(ia.qt_ing_amarela) * 1.0 / SUM(ia.qt_ing)) AS DECIMAL(10, 2)
    ) AS perc_amarela,
    CAST(
        (SUM(ia.qt_ing_indigena) * 1.0 / SUM(ia.qt_ing)) AS DECIMAL(10, 2)
    ) AS perc_indigena
FROM inep.Ingressante_Ano ia
    JOIN inep.Curso c ON ia.id_curso = c.id_curso
    JOIN inep.IES i ON c.id_ies = i.id_ies
    JOIN inep.Endereco e ON i.id_endereco = e.id_endereco
    JOIN inep.Municipio m ON e.id_municipio = m.id_municipio
    JOIN inep.UF uf ON m.id_uf = uf.id_uf
    JOIN inep.Ano_Censo ano_c ON ia.id_ano = ano_c.id_ano
GROUP BY uf.sigla_uf,
    ano_c.id_ano
ORDER BY ano_c.id_ano DESC,
    uf.sigla_uf;