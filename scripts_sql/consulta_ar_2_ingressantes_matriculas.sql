/*
Consulta AR 2 - Cursos com Ingressantes e Matrículas no Mesmo Ano
A consulta retorna a lista de cursos que tiveram tanto ingressantes quanto matrículas no mesmo ano. Os resultados incluem o ID e nome do curso, bem como o ano em que ambos ocorreram.

Algebra relacional:
Inter = (π id_curso, id_ano (Ingressante_Ano))
        ∩
        (π id_curso, id_ano (Matricula_Ano))

InterFiltrado = σ id_ano = 2024 (Inter)

Resultado2 = π(cur.id_curso, cur.nome_curso, id_ano)
             (InterFiltrado ⨝ Curso)
 */
SELECT cur.id_curso,
    cur.nome_curso,
    inter.id_ano
FROM (
        SELECT id_curso,
            id_ano
        FROM inep.Ingressante_Ano
        INTERSECT
        SELECT id_curso,
            id_ano
        FROM inep.Matricula_Ano
    ) inter
    JOIN inep.Curso cur ON cur.id_curso = inter.id_curso
WHERE inter.id_ano = 2024;