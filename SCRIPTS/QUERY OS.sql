/*SELECT * FROM --DELETE 
SERVICAB where numord = 'APR-2018-0003' 
SELECT * FROM --DELETE 
SERVIDET 
where numord = 'APR-2018-0003' */
exec SP_SERVI_HEAD 'ctl-2018-0001'
select codest, temporada, * from view_pos where po = (select top 1 po from servidet where numord= 'ctl-2018-0001')

 