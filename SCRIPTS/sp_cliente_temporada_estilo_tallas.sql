-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE <sp_cliente_temporada_estilo_tallas> 
	-- Add the parameters for the stored procedure here
	@cli char(5),
	@tem char(4),
	@est char(59)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT PP.TALLA, '' AS ORDEN into #tmp FROM (	  
	SELECT DISTINCT T0 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = @cli and codtem=@tem and estcli = est 
UNION SELECT DISTINCT T1 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = @cli and codtem=@tem and estcli = est      
UNION SELECT DISTINCT T2 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = @cli and codtem=@tem and estcli = est      
UNION SELECT DISTINCT T3 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = @cli and codtem=@tem and estcli = est      
UNION SELECT DISTINCT T4 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = @cli and codtem=@tem and estcli = est      
UNION SELECT DISTINCT T5 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = @cli and codtem=@tem and estcli = est      
UNION SELECT DISTINCT T6 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = @cli and codtem=@tem and estcli = est      
UNION SELECT DISTINCT T7 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = @cli and codtem=@tem and estcli = est     
UNION SELECT DISTINCT T8 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = @cli and codtem=@tem and estcli = est      
UNION SELECT DISTINCT T9 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = @cli and codtem=@tem and estcli = est  )PP
WHERE PP.TALLA <> ''

select * from #tmp
pivot talla

END
GO
