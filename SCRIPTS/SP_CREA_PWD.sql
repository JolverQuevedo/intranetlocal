CREATE PROCEDURE SP_CREA_PWD
@len CHAR(3)
AS

DECLARE @exclude varchar(50) 
    SET @exclude = '0:;<=>?@O[]`^\/'
    DECLARE @char char
    --DECLARE @len char(2)
    DECLARE @output varchar(50)
    set @output = ''
    --set @len = 30

    while @len > 0 begin
       select @char = char(round(rand() * 74 + 48, 0))
       if charindex(@char, @exclude) = 0 begin
           set @output = @output + @char
           set @len = @len - 1
       end
    end

   SELECT UPPER(@output)


   -- SP_CREA_PWD '30'