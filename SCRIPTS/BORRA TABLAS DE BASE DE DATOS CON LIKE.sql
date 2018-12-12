
DECLARE @spSQL AS NVARCHAR(MAX)
DECLARE @fnSQL AS NVARCHAR(MAX)
DECLARE @vwSQL AS NVARCHAR(MAX)
DECLARE @fkSQL AS NVARCHAR(MAX)
DECLARE @tblSQL AS NVARCHAR(MAX)

SET @spSQL = ''
SET @fnSQL = ''
SET @vwSQL = ''
SET @fkSQL = ''
SET @tblSQL = ''
SELECT @tblSQL = @tblSQL + 'DROP TABLE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name)
FROM sys.tables
WHERE is_ms_shipped = 0
AND name NOT LIKE 'sys%' AND name LIKE '%0012%'


print @tblSQL


--EXEC (@tblSQL)