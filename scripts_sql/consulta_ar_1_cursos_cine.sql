/*
Consulta AR 1 - Cursos de Computação e Informática categorizados por Área Geral do CINE
A consulta unem os cursos relacionados à área de Computação e Informática oferecidos por Instituições de Ensino Superior (IES) no Brasil, categorizando-os conforme a área geral do CINE. Os resultados incluem o ID do curso, nome do curso, nome da IES e a categoria (Computação ou Informática). Cursos Computação ∪ Cursos Informática

Álgebra Relacional:
CursosJoin = Curso ⨝ Cad ⨝ Cae ⨝ Cag ⨝ IES

Comp = π(id_curso, nome_curso, nome_ies, categoria='Computação')
       (σ Cag.nome_area_geral LIKE '%Computação%' (CursosJoin))

Info = π(id_curso, nome_curso, nome_ies, categoria='Informática')
       (σ Cag.nome_area_geral LIKE '%Informática%' (CursosJoin))

Resultado1 = Comp ∪ Info
 */
SELECT cur.id_curso,
    cur.nome_curso,
    ies.nome_ies,
    'Computação' AS categoria
FROM inep.Curso cur
    JOIN inep.Cine_Area_Detalhada cad ON cad.id_cine_area_detalhada = cur.id_cine_area_detalhada
    JOIN inep.Cine_Area_Especifica cae ON cae.id_cine_area_especifica = cad.id_cine_area_especifica
    JOIN inep.Cine_Area_Geral cag ON cag.id_cine_area_geral = cae.id_cine_area_geral
    JOIN inep.IES ies ON ies.id_ies = cur.id_ies
WHERE cag.nome_area_geral LIKE '%Computação%'
UNION
SELECT cur.id_curso,
    cur.nome_curso,
    ies.nome_ies,
    'Informática' AS categoria
FROM inep.Curso cur
    JOIN inep.Cine_Area_Detalhada cad ON cad.id_cine_area_detalhada = cur.id_cine_area_detalhada
    JOIN inep.Cine_Area_Especifica cae ON cae.id_cine_area_especifica = cad.id_cine_area_especifica
    JOIN inep.Cine_Area_Geral cag ON cag.id_cine_area_geral = cae.id_cine_area_geral
    JOIN inep.IES ies ON ies.id_ies = cur.id_ies
WHERE cag.nome_area_geral LIKE '%Informática%';