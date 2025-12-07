/*
 Consulta 4 - Consulta dos 10 cursos com maior número de ingressantes via ENEM, categorizados por áreas CINE
 Esta consulta retorna os 10 cursos com o maior número de ingressantes que entraram via ENEM, agrupados pelas áreas CINE (Geral, Específica e Detalhada). A consulta utiliza junções entre as tabelas Ingressante_Ano, Curso e as tabelas de áreas CINE para agregar os dados e calcular o total de ingressantes por área. O resultado é ordenado pelo número total de ingressantes em ordem decrescente, exibindo também a classificação (rank) de cada área com base no número de ingressantes.
 */
WITH totals AS (
    SELECT cg.nome_area_geral AS Area_CINE_Geral,
        ce.nome_area_especifica AS Area_CINE_Especifica,
        cd.nome_area_detalhada AS Area_CINE_Detalhada,
        SUM(ing.qt_ing_enem) AS Total_Ingressantes_ENEM
    FROM inep.Ingressante_Ano ing
        INNER JOIN inep.Curso c ON ing.id_curso = c.id_curso
        INNER JOIN inep.Cine_Area_Detalhada cd ON c.id_cine_area_detalhada = cd.id_cine_area_detalhada
        INNER JOIN inep.Cine_Area_Especifica ce ON cd.id_cine_area_especifica = ce.id_cine_area_especifica
        INNER JOIN inep.Cine_Area_Geral cg ON ce.id_cine_area_geral = cg.id_cine_area_geral
    GROUP BY cg.nome_area_geral,
        ce.nome_area_especifica,
        cd.nome_area_detalhada
)
SELECT TOP 10 Area_CINE_Geral,
    Area_CINE_Especifica,
    Area_CINE_Detalhada,
    Total_Ingressantes_ENEM,
    RANK() OVER (
        ORDER BY Total_Ingressantes_ENEM DESC
    ) AS rank_ingressantes
FROM totals
ORDER BY Total_Ingressantes_ENEM DESC;