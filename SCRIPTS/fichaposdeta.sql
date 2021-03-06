USE [MODELADOR]
GO
/****** Object:  StoredProcedure [dbo].[FICHAPOSdeta]    Script Date: 12/14/2012 11:50:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER procedure  [dbo].[FICHAPOSdeta]  
@po CHAR(10)
 as

-- =======================================================================
-- Author:		MABEL MOLINA
-- Create date: 06-dic-2012
-- Description:	Devuelve los campos de detalle de la Ficha de PO
-- =======================================================================
IF @PO = 'AUTO' OR @PO =''
	SELECT  '' as po, '' AS COLOR, 1 AS UBI, 0 AS FOB, '' AS T0, '' AS T1, '' AS T2, '' AS T3,
			'' AS T4, '' AS T5, '' AS T6, '' AS T7, '' AS T8, '' AS T9, 0 AS CAN0,
			0 AS CAN1, 0 AS CAN2, 0 AS CAN3, 0 AS CAN4, 0 AS CAN5, 0 AS CAN6,
			0 AS CAN7, 0 AS CAN8, 0 AS CAN9
ELSE
	SELECT		pp.po, PP.color ,	PP.UBI,		PP.FOB, 
				T0, T1, T2, T3, T4, T5, T6, T7, T8, T9, CAN0, CAN1, CAN2,
				CAN3, CAN4, CAN5, CAN6, CAN7, CAN8, CAN9
	FROM  [PO-DETA] AS PP
	WHERE PP.PO = @PO 
	ORDER BY UBI
      





