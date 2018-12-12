SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		MABEL MOLINA
-- Create date: 9-2-17
-- Description:	TENGO UN PO Y NECESITO EL PROTO
--				VERSION PARA GENERAR EL AJUSTE
-- =============================================
ALTER PROCEDURE SP_INSERTA_AJUSTE
	@po  varchar(25)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	DECLARE @PRO CHAR(10), @VER  CHAR(3), @USR CHAR(10),@cli char(100), @TIP INT, @COD CHAR(20)
	SET @PRO =	(select PROTO      from pos PP INNER JOIN COTIZACION CC ON PP.COTIZACION = CC.COTIZACION where REPLACE(pp.po,SPACE(1), '') = replace(@po, ' ' , ''))
	SET @VER =	(select [VERSION]  from pos PP INNER JOIN COTIZACION CC ON PP.COTIZACION = CC.COTIZACION where REPLACE(pp.po,SPACE(1), '') = replace(@po, ' ' , ''))
	SET @USR =  (select pp.USUARIO from pos PP                                                           where REPLACE(pp.po,SPACE(1), '') = replace(@po, ' ' , ''))
	SET @cli =  (select cc.nombre  from pos PP INNER JOIN CLIENTE    CC ON PP.CLIENTE    = CC.CODIGO     where REPLACE(pp.po,SPACE(1), '') = replace(@po, ' ' , ''))	
	
	IF NOT EXISTS(SELECT [AJUSTE], [VERSION] FROM [AJUSTES] WHERE [AJUSTE]= @PRO  AND [VERSION] = @VER)
		BEGIN
			INSERT INTO AJUSTES				SELECT *		FROM [PROTOS]			WHERE [PROTO]= @PRO  AND [VERSION] = @VER
			INSERT INTO [AJUSTE-OBS]		SELECT *		FROM [PROTO-OBS]		WHERE [PROTO]= @PRO  AND [VERSION] = @VER
			INSERT INTO [AJUSTE-DETALLES]	SELECT *, NULL	FROM [PROTO-DETALLES]	WHERE [PROTO]= @PRO  AND [VERSION] = @VER
			INSERT INTO [AJUSTE-TALLAS]		SELECT *		FROM [PROTO-TALLAS]		WHERE [PROTO]= @PRO  AND [VERSION] = @VER		
		-- ACTUALIZA EL NOMBRE DEL USUARIO QUE CREÓ LA PO Y REEMPLAZA AL DEL CREADOR DEL PROTO
			UPDATE AJUSTES			 SET USUARIO = @USR, FECHA = GETDATE() WHERE [AJUSTE]= @PRO  AND [VERSION] = @VER
			UPDATE [AJUSTE-OBS]		 SET USUARIO = @USR, FECHA = GETDATE() WHERE [AJUSTE]= @PRO  AND [VERSION] = @VER
			UPDATE [AJUSTE-DETALLES] SET USUARIO = @USR, FECHA = GETDATE() WHERE [AJUSTE]= @PRO  AND [VERSION] = @VER
			UPDATE [AJUSTE-TALLAS]	 SET USUARIO = @USR, FECHA = GETDATE() WHERE [AJUSTE]= @PRO  AND [VERSION] = @VER
			-- hay que buscar inconsistencias de precios 		
			-- **********************************
			--				TELAS
			-- **********************************
			SELECT * INTO #TMP1 FROM [AJUSTE-DETALLES] WHERE AJUSTE = @PRO AND [VERSION]= @VER AND TIPODETALLE='TE' ORDER BY [ID]
			ALTER TABLE #TMP1 ADD CDESCRI VARCHAR(200)
			SELECT * INTO #TMP2 FROM #TMP1
			WHILE (EXISTS(SELECT TIPODETALLE FROM #TMP2 ))
				BEGIN
					SET @TIP = (SELECT TOP 1 [ID]   FROM #TMP2 )
					SET @COD = (SELECT TOP 1 CODIGO FROM #TMP2 )
					UPDATE #TMP1 SET REAL1 = (select TOP 1 C6_NUSPRUN from RSFACCAR..AL0001MOVD where left(c6_ccodigo,6) =  @COD and C6_CCODMON= 'US'),
									CDESCRI = (SELECT LEFT(DESCRIPCION,200) FROM TELAS WHERE @COD = TELA ) WHERE  ID=@TIP
					UPDATE [AJUSTE-DETAllES] SET REAL1 = (select TOP 1 C6_NUSPRUN from RSFACCAR..AL0001MOVD where left(c6_ccodigo,6) =  @COD and C6_CCODMON= 'US'  order by C6_DFECDOC desc)
									 WHERE  ID=@TIP
					DELETE #TMP2 WHERE [ID] = @TIP
				END
			-- **********************************
			--				AVIOS
			-- **********************************			
			INSERT INTO #TMP1 SELECT *, NULL FROM [AJUSTE-DETALLES] WHERE AJUSTE = @PRO AND [VERSION]= @VER AND TIPODETALLE='AV' ORDER BY [ID]
			INSERT INTO #TMP2 SELECT * FROM #TMP1
			WHILE (EXISTS(SELECT TIPODETALLE FROM #TMP2 ))
				BEGIN
					SET @TIP = (SELECT TOP 1 [ID]   FROM #TMP2 )
					SET @COD = (SELECT TOP 1 CODIGO FROM #TMP2 )
					UPDATE #TMP1 SET REAL1 = (select TOP 1 C6_NUSPRUN from RSFACCAR..AL0001MOVD where c6_ccodigo =  @COD and C6_CCODMON= 'US'),
									CDESCRI = (SELECT LEFT(DESCRIPCION,200) FROM AVIOS WHERE @COD = CODIGO ) WHERE  ID=@TIP
					UPDATE [AJUSTE-DETAllES] SET REAL1 = (select TOP 1 C6_NUSPRUN from RSFACCAR..AL0001MOVD where c6_ccodigo =  @COD and C6_CCODMON= 'US' order by C6_DFECDOC desc)
									WHERE  ID=@TIP
					DELETE #TMP2 WHERE [ID] = @TIP
				END			
			--*********************************
			--		mandar correo 1
			--********************************
			DECLARE @clien as NVARCHAR(max);	
			IF EXISTS(SELECT CODIGO FROM #TMP1 WHERE REAL1> COSTO)
				BEGIN          
				SET @clien =
				N'<table border="1" cellpadding="5" cellspacing="0" align="center" width="100%">'+
				N'<TR><TD bgcolor="gainsboro">'+ 'Ajuste_# '+'</TD><td>'+ @PRO+'-'+@VER +'</TD><td bgcolor="gainsboro">'+'Cliente'+'</TD><td>'+ @cli +'</TD></TR>'+
				N'<TR><TD bgcolor="gainsboro">'+ 'PO'+'</TD><td>'+ @po + '</TD><td bgcolor="gainsboro">' + 'Usuario'+'</TD><td>'+@USR + '</td>'+
				N'</TR>' +
				N'<TR><TD bgcolor="gainsboro">Tela</TD><TD bgcolor="gainsboro">Descripcion</TD><TD bgcolor="gainsboro">Coti</TD><TD bgcolor="gainsboro">RealSys</TD></TR>'+
				CAST ( ( SELECT td = CODIGO, ' ',
					td =  CDESCRI, '',
					td =  CAST(COSTO AS NUMERIC(12,2)) , '',
					td =  CAST(REAL1 AS NUMERIC(12,2)) , ''
				  FROM #TMP1 WHERE REAL1 > COSTO 
				  FOR XML PATH('tr'), TYPE
					) AS NVARCHAR(MAX) ) +
					N'</tr>'+
				N'</table>'
				END
			ELSE
				BEGIN
				SET @clien =
				N'<table border="1" cellpadding="5" cellspacing="0" align="center" width="100%">'+
				N'<TR><TD bgcolor="gainsboro">'+ 'Ajuste_# '+'</TD><td>'+ @PRO+'-'+@VER +'</TD><td bgcolor="gainsboro">'+'Cliente'+'</TD><td>'+ @cli +'</TD></TR>'+
				N'<TR><TD bgcolor="gainsboro">'+ 'PO'+'</TD><td>'+ @po + '</TD><td bgcolor="gainsboro">' + 'Usuario'+'</TD><td>'+@USR + '</td>'+
				N'</TR>' +
				N'</table>'
				END
		EXEC msdb.dbo.sp_send_dbmail
			@profile_name = 'DBMailProfile',--Perfil de correo configurado.
			-- A quien se va enviar el correo.
			@recipients = 'mmolina@elmodelador.com.pe;',
			-- @recipients = 'jramos@elmodelador.com.pe;historicos@elmodelador.com.pe; chuarancca@elmodelador.com.pe; JAIMEF@elmodelador.com.pe', 
			@subject = 'AJUSTE CREADO',
			@body = @clien,
			@body_format = 'HTML',
			@importance = 'High'
		SELECT * FROM #TMP1

		drop table #TMP1
		drop table #TMP2
			
		END
 
END
GO

--EXEC SP_INSERTA_AJUSTE '217 - 440'