/*
 Consulta 2 - Cursos na área de computação com ingressantes ou concluintes com deficiência
 Esta consulta lista os cursos na área de computação que tiveram ingressantes ou concluintes com deficiência, detalhando o ano, a instituição de ensino superior (IES), o curso, e as quantidades de ingressantes e concluintes com deficiência.
 */
SELECT ac.id_ano AS Ano,
    ies.id_ies,
    ies.nome_ies,
    cur.id_curso,
    cur.nome_curso,
    COALESCE(SUM(ia.qt_ing_deficiente), 0) AS ingressantes_com_deficiencia,
    COALESCE(SUM(ca.qt_conc_deficiente), 0) AS concluintes_com_deficiencia
FROM inep.Ano_Censo ac
    JOIN inep.Curso cur ON 1 = 1
    JOIN inep.IES ies ON cur.id_ies = ies.id_ies
    JOIN inep.Cine_Area_Detalhada cad ON cad.id_cine_area_detalhada = cur.id_cine_area_detalhada
    LEFT JOIN inep.Ingressante_Ano ia ON ia.id_curso = cur.id_curso
    AND ia.id_ano = ac.id_ano
    LEFT JOIN inep.Concluinte_Ano ca ON ca.id_curso = cur.id_curso
    AND ca.id_ano = ac.id_ano
WHERE LOWER(cad.nome_area_detalhada) LIKE '%comput%'
GROUP BY ac.id_ano,
    ies.id_ies,
    ies.nome_ies,
    cur.id_curso,
    cur.nome_curso
HAVING COALESCE(SUM(ia.qt_ing_deficiente), 0) > 0
    OR COALESCE(SUM(ca.qt_conc_deficiente), 0) > 0
ORDER BY ac.id_ano DESC,
    ingressantes_com_deficiencia DESC,
    concluintes_com_deficiencia DESC,
    ies.nome_ies,
    cur.nome_curso;