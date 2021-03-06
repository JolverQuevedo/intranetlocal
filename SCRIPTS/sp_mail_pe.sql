USE [MODELADOR]
GO
/****** Object:  StoredProcedure [dbo].[SEND_MAIL_OFI]    Script Date: 02/08/2018 10:23:06 a.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mabel Molina
-- Create date: 2-8-2018
-- Description:	Envia mail a Marisa para generar 
-- la clave de linea del PE que tiene exceso
-- =============================================
create PROCEDURE [dbo].[SEND_MAIL_PE]
	-- Add the parameters for the stored procedure here
	@oc	char(10),
	@AL	CHAR(4) ,
	@PE	CHAR(11),
	@IT	CHAR(4) ,
	@QT	NUMERIC ,
	@pw	CHAR(30),
	@us char(10) 
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @tableHTML  NVARCHAR(MAX);





SET @tableHTML =
N'<table border="1" cellpadding="5" cellspacing="0">'+
N'<thead>'+
N'<tr style=''background: gainsboro;    color: black;font-weight: bold;''>'+
N'<th>O/C</th>'+
N'<th>ALM</th>'+
N'<th>PE</th>'+
N'<th>ITM</th>'+
N'<th>QTY</th>'+
N'<th>CLAVE</th>'+
N'</tr>'+
N'</thead>'+
N'<tbody>'+

CAST ( ( SELECT td = @oc, '',
                td = @al, '',
				td = @pe, '',
				td = @it, '',
				td = @qt, '',
				td = @pw, ''
              FOR XML PATH('tr'), TYPE
    ) AS NVARCHAR(MAX) ) +
N'</tbody>'+
N'</tr>'+
N'</table>'+
N'<P>Solicitante : '+@us+
N'</p>'




declare @datos as NVARCHAR(MAX);
set @datos =  @tableHTML 

-- Insert statements for procedure here
	EXEC msdb.dbo.sp_send_dbmail
--  @profile_name	= 'DBMailProfile',--Perfil de correo configurado.
	@profile_name	= 'DBMail',--Perfil de correo configurado en la pc de mi CASA
	@recipients		= 'mmolina@elmodelador.com.pe;mhinojo@elmodelador.com.pe', -- a quienes va el mail
--	@recipients		= 'mmolina@elmodelador.com.pe;', -- a quienes va el mail
    @body_format	= 'HTML',
    @importance		= 'High',
	@subject		= 'Clave para PE',
	@body			= @datos
    
END

--exec SEND_MAIL_PE '0000032890','00M0', '00018500330', '0003', 86, 'FJXD1J3WQFLAX9RIUBXEYANNFXUT2_','sist'