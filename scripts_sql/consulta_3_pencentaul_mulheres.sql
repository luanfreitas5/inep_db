/*
 Consulta 3 - Percentual de Mulheres Matriculadas em Cursos de Computação por Ano
 Esta consulta retorna o percentual de mulheres matriculadas em cursos relacionados à área de Computação para cada ano. Os resultados incluem o ano, o número total de mulheres matriculadas, o número total de matrículas e o percentual de mulheres, ordenados pelo percentual em ordem decrescente.
 */
WITH computacao AS (
    SELECT id_curso
    FROM inep.Curso
    WHERE id_cine_area_detalhada IN (
            SELECT id_cine_area_detalhada
            FROM inep.Cine_Area_Detalhada
            WHERE nome_area_detalhada LIKE '%Comput%'
        )
),
matri AS (
    SELECT ma.id_ano,
        SUM(ma.qt_mat_fem) AS mulheres,
        SUM(ma.qt_mat) AS total
    FROM inep.Matricula_Ano ma
    WHERE ma.id_curso IN (
            SELECT id_curso
            FROM computacao
        )
    GROUP BY ma.id_ano
)
SELECT id_ano,
    mulheres,
    total,
    CAST(
        mulheres * 100.0 / NULLIF(total, 0) AS DECIMAL(10, 2)
    ) AS pct_mulheres
FROM matri
ORDER BY pct_mulheres DESC;