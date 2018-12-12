use modelador
go


delete cotihilado where cotizacion = '0000001331'
delete cotiruta where cotizacion = '0000001331'
delete [coti-tenido] where cotizacion = '0000001331'

delete cotizacion where cotizacion = '0000001331'
select * from cotizacion where cotizacion = '0000001331'
select * from protos where cotizacion = '0000001331'
select * from [proto-detalles]

update protos set cotizacion = null where cotizacion = '0000001331'