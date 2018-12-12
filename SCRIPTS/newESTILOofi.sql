select codest, * from ofis    WHERE CODIGO = '00008052' 
select codest, * from pos     WHERE ofi = (select codigo from ofis where codigo = '00008052')  
SELECT estilo, * FROM PROTOS  WHERE cotizacion = (select cotizacion from pos where ofi = '00008052' )  
SELECT CODEST,* FROM estilos WHERE CODEST = (select CODEST from ofis WHERE CODIGO = '00008052' ) AND CLIENTE = (select CLIENTE from ofis WHERE CODIGO = '00008052')

update ofis    SET CODEST = '00090' WHERE CODIGO = '00008052' 
update pos     SET CODEST = '00090'	WHERE ofi = (select codigo from ofis where codigo = '00008052')  
update PROTOS  SET ESTILO = '00090'	WHERE cotizacion = (select cotizacion from pos where ofi = '00008052' )  

select codest, * from ofis    WHERE CODIGO = '00008052' 
select codest, * from pos     WHERE ofi = (select codigo from ofis where codigo = '00008052')  
SELECT estilo, * FROM PROTOS  WHERE cotizacion = (select cotizacion from pos where ofi = '00008052' )  
SELECT CODEST,* FROM estilos WHERE CODEST = (select CODEST from ofis WHERE CODIGO = '00008052' ) AND CLIENTE = (select CLIENTE from ofis WHERE CODIGO = '00008052')
