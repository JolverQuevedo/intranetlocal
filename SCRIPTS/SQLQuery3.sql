 
-- AL LIQUIDAR ACTUALIZA EL PRECIO FOB / COSTO DEL MAESTRO DE ARTICULOS 
-- PERO DEL SERVICIO ......................

Update RSFACCAR..AL0001ARTI Set AR_CMONCOM='US',AR_NPRECOM=0.9,AR_DFECCOM=Convert(datetime,'19/03/2018 00:00:00',103),AR_CMONFOB='US',AR_NPREFOB=0.9,AR_CMONCOS='US',AR_NPRECOS=0.9,AR_CCODPRO='20100174759       ' Where AR_CCODIGO='ST006                    '
go

-- DICE RECEPCION PARCIAL
Update RSFACCAR..CO0001MOVC Set OC_CSITORD='4' Where OC_CNUMORD='0000031653          '
go

-- LIBERA LA OC PARA QUE LA PUEDAN TRABAJAR LOS DEMAS
Update RSFACCAR..CO0001MOVC Set OC_CUNIORD='' Where OC_CNUMORD='0000031653          '