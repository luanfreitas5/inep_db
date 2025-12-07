/*
Consulta AR 3 - Cursos com Vagas Oferecidas mas sem Ingressantes por Ano
A consulta retorna a lista de cursos que tiveram vagas oferecidas em determinado ano, mas não tiveram ingressantes nesse mesmo ano. Os resultados incluem o ID e nome do curso, bem como o ano em que as vagas foram oferecidas sem ingressantes.

 Algebra relacional:
A = π(id_curso, id_ano) (σ qt_vg_nova > 0 (Curso_Ano))

B = π(id_curso, id_ano) (σ qt_ing > 0 (Ingressante_Ano))

Diff = A − B

Resultado3 = π(cur.id_curso, cur.nome_curso, ca.id_ano)
              ((Diff ⨝ Curso) ⨝ Curso_Ano)
 */
SELECT cur.id_curso,
    cur.nome_curso,
    ca.id_ano
FROM (
        SELECT id_curso,
            id_ano
        FROM inep.Curso_Ano
        WHERE qt_vg_nova > 0
        EXCEPT
        SELECT id_curso,
            id_ano
        FROM inep.Ingressante_Ano
        WHERE qt_ing > 0
    ) diff
    JOIN inep.Curso cur ON cur.id_curso = diff.id_curso
    JOIN inep.Curso_Ano ca ON ca.id_curso = diff.id_curso
    AND ca.id_ano = diff.id_ano;