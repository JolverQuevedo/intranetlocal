Select * From RSFACCAR..AL0001ARTI Where AR_CCODIGO='9000190914000700'
Select * From VIEW_OFIS Where AR_CCODIGO='9000190914000400'
Select AR_CDESCRI From RSFACCAR..AL0001ARTI Where AR_CCODIGO='9000190914000700' 
exec OC_LIN_COD 'AUTO', '0001' , '9000190914000700' 
EXEC OC_LIN_OFI '0000030307', '0001' 


-- reserva de tela
select RR.*, MM.AR_CDESCRI AS DESCRI from rsv_tela RR            
INNER JOIN RSFACCAR..AL0001ARTI MM ON MM.AR_CCODIGO collate      
SQL_Latin1_General_CP1_CI_AI = rr.CODIGO                         
where CODIGO = '9000190914000700' AND TIPO ='t' AND ALM='00md'   
AND OFI = '00009190'                                              

-- requerido sale de la explosion
select * from EXPLOSION_TELA
where  OFI = '00009190' 


