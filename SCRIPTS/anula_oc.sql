-- actualiza la cabecera de la Orden de compra y la pone ANULADA
Update RSFACCAR..CO0001MOVC Set OC_CSITORD='7' Where OC_CNUMORD='0000023084'
go

Delete From RSFACCAR..CO0001MOVD Where OC_CNUMORD='0000023084'
go
-- busca si tiene requerimiento
SELECT * FROM RSFACCAR..AL0001REQF WHERE RF_CNUMORD='0000023084' ORDER BY RF_CNUMREQ,RF_CITEREQ 
go
-- actualiza el estado del requerimiento a anulado
UPDATE RSFACCAR..AL0001REQF SET RF_CESTADO='A'  WHERE RF_CNUMORD='0000023084'
go
-- busca el numero de orden en la tabla de cabecera de requerimiento
Select RC_CNROREQ From RSFACCAR..AL0001REQC Where RC_CNUMORD='0000023084'
go
-- pone en blanco la oc de compra de referencia igual al # de req de la tabla anterior
UPDATE RSFACCAR..AL0001REQC  SET RC_CNUMORD='' WHERE RC_CNROREQ=''
