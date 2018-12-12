/*select * from PROCABCOR

select * from PRODETCOR
where cd_cnrocorte='80506'
*/
declare @ofi varchar(8)
declare @corte varchar(5)
declare @npqte numeric(4)
declare @CD_CSECUEN varchar(3)
declare @CD_CTALLA	varchar(3)
declare @CD_NCANT	numeric(4)
declare @CD_CNROCORTE varchar(5)
declare @DESDE numeric(4)
declare @HASTA numeric(4)
declare @intermedio numeric(4)
DECLARE @CT_CLIENTE VARCHAR(200)
DECLARE @CT_FECHA	VARCHAR(10)
DECLARE @CT_CDESTEL VARCHAR(200)
DECLARE @CT_CDESCOL	VARCHAR(100)
DECLARE @CT_PARTIDA	VARCHAR(20)

declare @paquete table (CD_CNROCORTE varchar(5), CD_CSECUEN varchar(3), CD_CTALLA varchar(3), CD_NCANT numeric(4), DESDE numeric(4), HASTA numeric(4))

set @ofi='00008429'
set @corte = '80506'
set @DESDE = 0
set @HASTA = 0

select @npqte = ct_npqte, @CT_CLIENTE = CT_CCLIENTE, @CT_FECHA = CONVERT(VARCHAR,CT_DFECHA,103), 
@CT_CDESTEL = CT_CDESTEL, @CT_CDESCOL = CT_CDESCOL, @CT_PARTIDA = CT_CPARTIDA 
from PROCABCOR  where ct_cnroofi = @ofi and ct_cnrocorte=@corte

DECLARE corte CURSOR FOR  
	select CD_CNROCORTE, CD_CSECUEN, CD_CTALLA, CD_NCANT from PRODETCOR
	where cd_cnroofi='00008429' and cd_cnrocorte = '80506'
	ORDER BY CD_CSECUEN
OPEN corte  

FETCH NEXT FROM corte INTO @CD_CNROCORTE, @CD_CSECUEN, @CD_CTALLA, @CD_NCANT 

WHILE @@FETCH_STATUS = 0  
BEGIN
	
	IF @CD_CSECUEN = 1 
		Begin
			set @DESDE = 1 
			set @hasta  = @DESDE+(@CD_NCANT-1)
			set @intermedio = @HASTA+1
		End
	else
		Begin
			set @DESDE     = @intermedio
			set @HASTA      = @DESDE+(@CD_NCANT-1)
			set @intermedio = @HASTA+1
		End
	 
	insert into @paquete values (@CD_CNROCORTE, @CD_CSECUEN, @CD_CTALLA, @CD_NCANT, @DESDE, @HASTA )
	
	FETCH NEXT FROM corte INTO @CD_CNROCORTE, @CD_CSECUEN, @CD_CTALLA, @CD_NCANT 
End
CLOSE corte;  
DEALLOCATE corte;
select @NPQTE AS NPQTE, @CT_CLIENTE AS CT_CLIENTE, @CT_FECHA AS CT_FECHA,  @CT_CDESTEL AS CT_CDESTEL, 
@CT_CDESCOL AS CT_CDESCOL, @CT_PARTIDA AS CT_PARTIDA,
* from   @paquete

