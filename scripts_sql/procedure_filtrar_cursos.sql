/*
 Procedure - Filtrar_Cursos - Filtragem de Cursos por Ano, UF e Nome
 Esta procedure permite filtrar cursos oferecidos pelas Instituições de Ensino Superior (IES) com base em critérios opcionais, incluindo o ano de matrícula, a unidade federativa (UF) e o nome do curso. Os resultados retornam detalhes do curso, da IES, da localização e das matrículas correspondentes, ordenados por ano e nome do curso.
 */
CREATE PROCEDURE inep.Filtrar_Cursos (
    @Ano INT = NULL,
    @UF CHAR(2) = NULL,
    @Curso VARCHAR(255) = NULL
) AS BEGIN
SET NOCOUNT ON;
SELECT cur.id_curso,
    cur.nome_curso,
    ies.nome_ies,
    uf.sigla_uf,
    ma.id_ano,
    ma.qt_mat
FROM inep.Curso cur
    JOIN inep.IES ies ON ies.id_ies = cur.id_ies
    JOIN inep.Endereco ende ON ende.id_endereco = ies.id_endereco
    JOIN inep.Municipio mun ON mun.id_municipio = ende.id_municipio
    JOIN inep.UF uf ON uf.id_uf = mun.id_uf
    LEFT JOIN inep.Matricula_Ano ma ON ma.id_curso = cur.id_curso
WHERE (
        @Ano IS NULL
        OR ma.id_ano = @Ano
    )
    AND (
        @UF IS NULL
        OR uf.sigla_uf = @UF
    )
    AND (
        @Curso IS NULL
        OR cur.nome_curso LIKE '%' + @Curso + '%'
    )
ORDER BY ma.id_ano,
    cur.nome_curso;
END;
GO -- Exemplos
    EXEC inep.Filtrar_Cursos @Ano = 2023,
    @UF = 'DF',
    @Curso = 'Computa';
GO EXEC inep.Filtrar_Cursos @UF = 'RJ';
GO EXEC inep.Filtrar_Cursos;
GO