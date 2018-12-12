USE MODELADOR
GO
SELECT * FROM  ESTILOS where codest = '00500'
select * from temporadas where cliente  = '00001' and codigo = '026'

select distinct pp.estilo, EE.CODEST, ESTCLI 
from protos pp 
inner join ESTILOS EE  on pp.cliente =EE.cliente  AND EE.CODEST = PP.ESTILO
where temporada = '026' and PP.cliente = '00001'

select * from view_pos

select * from [PO-DETA]


/* ********************************************
	HAY QUE MOSTRAR TODAS LAS TALLAS USADAS EN 
	CUALQUIER PO DE ESA TEMPORADA
 ********************************************** */

SELECT   distinct    VP.CLI, VP.CODEST, VP.TEMPORADA, VP.ESTCLI, PD.T0, PD.T1, PD.T2, PD.T3, PD.T4, PD.T5, PD.T6, PD.T7, PD.T8, PD.T9
FROM            dbo.VIEW_POS AS VP INNER JOIN
                         dbo.[PO-DETA] AS PD ON VP.PO = PD.PO
WHERE        (PD.UBI = 1) AND VP.TEMPORADA = '026' AND VP.CLI= '00001' -- and codest = '00131'
order by codest








