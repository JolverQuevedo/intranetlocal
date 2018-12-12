select * from POS where PO = '218-387-B'
select * from ofi_pos where OFI = '00010542'
select * from ofis where codigo = '00010542'


delete OFI_POS where PO= '215-203' and OFI = '00005486'
update POS set OFI = null where PO = '215-203'



/***********************************************************
		asigna ofi a PO que se quedo en blanco
***********************************************************/
-- agregar el detalle de ofi_po
insert into  OFI_POS select  '00010542', '218-387-B', 'sistemas', getdate(), 'a'
-- actualizas la cabecera de la po para darle el # de Ofi
update pos set ofi = '00010542' where po = '218-387-B'
-- actualizas la cantidad total en la ofi
update ofis set cantidad = 700 where CODIGO = '00010542'