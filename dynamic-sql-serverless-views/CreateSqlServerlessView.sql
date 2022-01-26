USE <database-name>
GO

CREATE OR ALTER PROC CreateSQLServerlessView @Name nvarchar(50) 
AS
BEGIN

DECLARE @statement VARCHAR(MAX)
SET @statement = N'CREATE OR ALTER VIEW ' + @Name + ' AS
        SELECT *
        FROM
        OPENROWSET(
            BULK ''https://<datalake-name>.dfs.core.windows.net/<path>/' + @Name + '/*.csv'',
            FORMAT=''CSV'',
            PARSER_VERSION = ''2.0'',
            HEADER_ROW = TRUE
        ) AS [result]
'

EXEC (@statement)

END
GO