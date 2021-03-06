USE [MODELADOR]
GO
/****** Object:  StoredProcedure [dbo].[NEWPOSOFIS]    Script Date: 12/14/2012 21:51:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER procedure  [dbo].[NEWPOSOFIS]  
@p0 CHAR(10),	@p1 CHAR(10),	@p2 char(10),	@p3 char(10),
@p4 CHAR(10),	@p5 char(10),	@p6 char(10),	@p7 CHAR(10),
@p8 char(10),	@p9 char(10),	@p10 CHAR(10),	
@p11 CHAR(10),	@p12 char(10),	@p13 char(10),
@p14 CHAR(10),	@p15 char(10),	@p16 char(10),
@p17 CHAR(10),	@p18 char(10),	@p19 char(10)

 as

-- =======================================================================
-- Author:		MABEL MOLINA
-- Create date: 16-dic-2012
-- Description:	Devuelve el detalle de las PO's selecionadas para una OFI
-- =======================================================================
	SELECT		pp.po, PP.color ,	PP.UBI,		PP.FOB, 
				T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, CAN0, CAN1, CAN2,
				CAN3, CAN4, CAN5, CAN6, CAN7, CAN8, CAN9
	FROM  [PO-DETA] AS PP
	WHERE PP.PO in (@P0, @P1, @P2,@P3,@P4, @P5, @P6, @P7, @P8, @P9, @p10, @p11, @p12, @p13, @p14, @p15, @p16, @p17, @p18, @p19)
	and estado = 'A'
	ORDER BY PP.PO, UBI
      





