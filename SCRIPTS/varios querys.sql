select * from --delete 
SERVICAB
select * from ---delete 
SERVIDET
select * from VIEW_POS where po = '218-525-a'


SELECT SUM(isnull(cant,0)) as qty from View_Cliente_Temporada_Estilo_PO_color as dd 
full outer join servidet as ss on ss.po = dd.po 
WHERE CLIENTE = '00001' and codtem = '033' and estilo = '00006' and color = 'antracita19'
and ss.po = '218-560'

select * FROM MULTI..VIEW_DETA_PO where po = (select top 1 po from servidet where numord= 'CTL-2018-0001') AND UBI =(select top 1 UBI from servidet where numord= 'CTL-2018-0001') 

SELECT SUM(isnull(cant,0)) as qty from View_Cliente_Temporada_Estilo_PO_color as dd full outer join servidet as ss on ss.po = dd.po WHERE CLIENTE = '00001' and codtem = '033' and estilo = '00006' and color = 'ANTRACITA19' and numord = 'CTL-2018-AUTO' 