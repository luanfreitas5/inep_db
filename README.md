# Trabalho de Banco de Dados — INEP (2020–2024)

**Visão geral**

-   **Propósito:** Repositório que acompanha o trabalho de banco de dados do mestrado, contendo carga, organização e consultas sobre dados de Instituições de Ensino Superior (IES) e cursos do INEP para o período 2020–2024.
-   **Escopo:** Modelagem relacional, rotinas ETL, scripts SQL para criação/população, views e procedimentos para análises de vagas, ingressantes, matrículas e conclusão.

**Conteúdo**

-   **Dados:** Conjunto de microdados e tabelas derivadas com informações de IES, cursos, vagas, ingressantes, matrículas e desfechos (2020–2024).
-   **Notebooks:** `etl_inep.ipynb` — notebook para limpeza, transformação e inserção dos dados.
-   **Scripts SQL:** Pasta `scripts_sql/` contém scripts para criar banco e tabelas, procedures, triggers e consultas para análises.
-   **Imagens** Pasta `imagens_resultados/` contém prints de resultados das consultas SQL e `diagrama_er_inep.png` diagrama ER.

**Estrutura do repositório (resumo)**

-   `scripts_sql/` : scripts para criar database e tabelas (`criar_database.sql`, `criar_tabelas.sql`), procedures e triggers.
-   `etl_inep.ipynb`: notebook para ETL e carregamento.
-   `imagens_resultados/` : prints de resultados das consultas.
-   `diagrama_er_inep.png` : diagrama ER do banco de dados exportado pelo software DBeaver.

**Como reproduzir (passos rápidos)**

-   Pré-requisitos: ter SQL Server (ou compatível) disponível e Python 3.x com Jupyter/nbformat se usar notebooks.
-   Passos básicos:
    1. Criar a base de dados executando o script de criação (usar SSMS ou similar):

        ```sql
        -- Criar database
        scripts_sql/criar_database.sql

        -- Criar tabelas
        scripts_sql/criar_tabelas.sql
        ```

1. Criar e popular as tabelas: executar script SQL `scripts_sql/criar_tabelas.sql` para criar as tabelas. O notebook `etl_inep.ipynb` é usado para limpeza, transformação e inserção dos dados.
2. Criar views e procedures adicionais (se aplicável) com os arquivos em `scripts_sql/` como `view_cursos_analitica.sql`, `procedure_filtrar_cursos.sql`.
3. Executar consultas em scripts_sql para reproduzir as análises do trabalho.

**Observações sobre os dados**

-   Período coberto: 2020–2024.
-   Fontes: microdados e tabelas do INEP da pagina oficial disponibilizada pelo INEP no portal gov.br.
-   Tratamento: os notebooks implementam limpeza (normalização de nomes, correção de códigos, deduplicação) e transformações necessárias para a modelagem relacional.
-   Filtros: os dados são filtrados para incluir apenas cursos ativos em 2024, conforme detalhado nos notebooks.
