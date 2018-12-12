create FUNCTION getLetras(@str varchar(100))
    RETURNS VARCHAR(100)
AS
begin
	return (select REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE
				(REPLACE (@str, '0', ''),'1', ''),'2', ''),'3', ''),'4', ''),
				'5', ''),'6', ''),'7', ''),'8', ''),'9', '')
		)


end

--select replace(dbo.getletras ('abscd 45 67 doiuoi'),' ' ,'')