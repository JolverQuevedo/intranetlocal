ALTER VIEW view_cliente_temporada_estilo_po_color
AS
     SELECT vte.CLIENTE, 
            vte.CODIGO AS CODTEM, 
            vte.DESTEM, 
            po.PO, 
            vte.ESTILO, 
            vte.ESTCLI, 
            REPLACE(pd.COLOR, ' ', '') AS color, 
            pd.ubi, po.estado,
            CEILING((pd.CAN0 + pd.CAN1 + pd.CAN2 + pd.CAN3 + pd.CAN4 + pd.CAN5 + pd.CAN6 + pd.CAN7 + pd.CAN8 + pd.CAN9) * 1.05) AS tot105
     FROM dbo.View_Temporada_Cliente_Estilo AS vte
          INNER JOIN dbo.POS AS po ON vte.ESTILO = po.CODEST
                                      AND vte.CLIENTE = po.CLIENTE
                                      AND vte.COTIZACION = po.COTIZACION
          INNER JOIN dbo.[PO-DETA] AS pd ON po.PO = pd.PO
	where po.estado ='a'
GO