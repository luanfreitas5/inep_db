/*
 Trigger - tr_Log_Matricula_Ano - Registro de Alterações na Tabela Matricula_Ano
 Este trigger registra alterações na tabela Matricula_Ano, especificamente quando o número total de matrículas (qt_mat) é atualizado. Sempre que uma atualização ocorre, o trigger insere um registro na tabela Log_Alteracoes, capturando o nome da tabela, o ID do registro alterado, o campo modificado, o valor antigo e o novo valor. Isso permite rastrear mudanças importantes nos dados de matrícula ao longo do tempo.
 */
CREATE TRIGGER inep.tr_Log_Matricula_Ano ON inep.Matricula_Ano FOR
UPDATE AS BEGIN
SET NOCOUNT ON;
-- Loga apenas se o valor total de matriculados foi alterado
INSERT INTO inep.Log_Alteracoes (
        tabela,
        id_registro,
        campo,
        valor_antigo,
        valor_novo
    )
SELECT 'Matricula_Ano',
    ins.id_matricula_ano,
    'qt_mat',
    del.qt_mat AS valor_antigo,
    ins.qt_mat AS valor_novo
FROM inserted ins
    JOIN deleted del ON del.id_matricula_ano = ins.id_matricula_ano
WHERE ins.qt_mat <> del.qt_mat;
-- condição evitando log inútil
END;
GO -- Exemplos de atualização que acionaria o trigger
UPDATE inep.Matricula_Ano
SET qt_mat = qt_mat + 10
WHERE id_matricula_ano = 1;
UPDATE inep.Matricula_Ano
SET qt_mat = qt_mat - 5
WHERE id_matricula_ano = 2;
UPDATE inep.Matricula_Ano
SET qt_mat = qt_mat
WHERE id_matricula_ano = 3;
-- Este não acionaria o trigger, pois o valor não mudou
UPDATE inep.Matricula_Ano
SET qt_mat = 1000
WHERE id_matricula_ano = 4;
CREATE TABLE inep.Log_Alteracoes (
    id_log INT IDENTITY PRIMARY KEY,
    tabela VARCHAR(100),
    id_registro INT,
    campo VARCHAR(100),
    valor_antigo VARCHAR(255),
    valor_novo VARCHAR(255),
    data_alteracao DATETIME DEFAULT GETDATE()
);