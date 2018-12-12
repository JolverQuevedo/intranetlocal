-- estados de la orden de compra  DEL GRID DE INICIOOOO
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='31' Order by TG_CCLAVE
go
-- combo de tipo de orden de compra DEL GRID DE INICIOOOO
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='63' Order by TG_CCLAVE
go
-- no devuelve nada
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='21' And TG_CCLAVE='OC'
go
-- devuelve CAJ01
Select TC_CDESCRI From RSFACCAR..FT0001TCAJ Where TC_CCOD='20' And TC_CCLAVE='sist '
-- PESUMO QU ECON EL RESULTADO DEL SELECT ANTIOR BUSCA EN TC_CCOD LA NUEVA TC_CCLAVE
-- DEVUELVE 000
Select TC_CDESCRI From RSFACCAR..FT0001TCAJ Where TC_CCOD='28' And TC_CCLAVE='CAJ01'
go
-- COMBO DE FORMAS DEPAGO
Select * From RSCONCAR..CP0001TAGE Where TG_INDICE='51' Order By TG_DESCRI
go
-- COMBO DE TIPO DE OC
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='63' Order by TG_CCLAVE
go
-- COMBO DE DOCUMENTO DE REFERENCIA
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='04' Order by TG_CCLAVE
go
-- COMBO DE RESPONSABLE AL PIE DE LA OC
Select TG_CCLAVE,TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='80' Order by TG_CCLAVE
go
-- COMBO DE PAISES 
Select RTrim(Left(TG_CDESCRI, 40)) as Cad,* From RSFACCAR..AL0001TABL Where TG_CCOD='27' Order by RTrim(Left(TG_CDESCRI, 40))
go
-- COMBO DE TIPOS DE MONEDA
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='03' Order by TG_CCLAVE
go
-- COMBO DE CENTROS DE COSTO
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='10' Order by TG_CCLAVE
go
-- COMBO DE ALMACEN DE ENTREGA
Select * From RSFACCAR..AL0001ALMA Order by A1_CALMA
go
-- VALOR DEL TIPO DE CAMBIO
Select XMEIMP2 From RSCONCAR..CTCAMB Where  XCODMON='US' AND Convert(datetime,XFECCAM2,103)=Convert(datetime,'14/12/2012 00:00:00',103)
go
-- DIRECCION DEL ALMACEN SELECCIONADO (POR DEFECTO VA EL ALMACEN NO APLICA)
Select A1_CALMA,A1_CDIRECC,A1_CDISTRI,A1_CPROV From RSFACCAR..AL0001ALMA Where A1_CALMA='0001'
go
-- devuelve CAJ01 Y PROBABLEMENTE SE USA CON EL TC_CCOD 28
Select TC_CDESCRI From RSFACCAR..FT0001TCAJ Where TC_CCOD='20' And TC_CCLAVE='sist '
go
-- DEVUELVE 000 SE USA COMO TC_CCLAVE EL VALOR DEVUELTO POR EL SELECT ANTERIOR
Select TC_CDESCRI From RSFACCAR..FT0001TCAJ Where TC_CCOD='28' And TC_CCLAVE='CAJ01'
go
-- DETALLE COMPLETO DE LA EMPRESA
Select * From RSFACCAR..ALCIAS  WHERE AC_CCIA ='0001'
go
--  TIPO DE CAMBIO DEL DIA
Select XMEIMP2 From RSCONCAR..CTCAMB Where  XCODMON='US' AND Convert(datetime,XFECCAM2,103)=Convert(datetime,'14/12/2012 00:00:00',103)

-- HELP DE PROVEEDORES...
Select AC_CVANEXO,AC_CCODIGO,AC_CNOMBRE From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' Order by AC_CCODIGO
--*****************************************************************************
-- DEVUELTE UNO A UNO LOS DATOS DEL PROVEEDOR SELECIONADO 
--*****************************************************************************
Select AC_CNOMBRE From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='20536849981       '
go
Select AC_CDIRECC From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='20536849981       '
go
Select AC_CRUC From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='20536849981       '
go
Select AC_CFAXACR From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='20536849981       '
go
Select AC_CCOPAIS From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='20536849981       '
go
Select AC_CFORPA1 From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='20536849981       '
go
Select TG_DESCRI From RSCONCAR..CP0001TAGE Where TG_INDICE='51' And TG_CODIGO='   '
go
Select AC_CCODIGO From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='20536849981       '
go
--*****************************************************************************
--*****************************************************************************
-- moneda en lA	QUE SE EMITIRA LA OC
Select TG_CCLAVE From RSFACCAR..AL0001TABL Where TG_CCOD='03' And TG_CCLAVE='US'
go
-- CENTROS DE COSTO
Select * From RSFACCAR..AL0001TABL Where TG_CCOD='10' Order by TG_CCLAVE
go
-- devuelve el detalle del codigo de producto seleccionado
Select * From RSFACCAR..AL0001ARTI Where AR_CCODIGO='SIST000010'
go
-- COMO NO SE HA SELECCIONADO PAIS .... AV_CCODPAI=''
-- Y ESTE SELECT NO DEVUELVE NADA
Select AV_CPARARA From RSFACCAR..AL0001AADV Where AV_CCODART='SIST000010' And AV_CCODPAI=''
go
-- SI TG_CCLAVE = AL RESULTADO DEL SELECT ANTERIOR... TG_CCLAVE=''
-- TAMPOCO DEVUELVE DATOS
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='78' AND TG_CCLAVE=''

go
-- BUSCA EL ULTIMO VALOR AL QUE SE EMITIO UNA OC Y POR QUIEN
 Select Top 1 * From RSFACCAR..AL0001APRO Where PM_CCODMAT='SIST000010' And PM_CCODPRO='20536849981' Order By PM_DFECDOC Desc, PM_CHORA Desc
go
-- en el mmaestro de articulos busca la linea a la que pertenece
-- ESTO SE MANEJA EN EL CASO DE PRODUCTOS EN PROCESO Y TERMINADOS
Select AR_CLINEA From RSFACCAR..AL0001ARTI Where AR_CCODIGO='SIST000010'
go
-- BUSCA SI TIENE DESCUENTO PARA FACTURACION DEPENDIENDO DE LA LINEA
-- NO APLICAAAAAAAAAAAAA
Select  * From RSFACCAR..FT0001DESC Where DC_CLINEA='    ' 
Select Top 1 DC_CNUMTAB From RSFACCAR..FT0001DESC Where DC_CLINEA='    ' And Convert(datetime,'14/12/2012',103) >= Convert(DateTime,DC_DFECINI,103) And Convert(datetime,'14/12/2012',103) <= 
Convert(DateTime,DC_DFECFIN,103) Order by Datediff(day,dc_dfecini,dc_dfecfin) 
go
-- CODIGO DEL ARTICULO DE LA TABLA DE ARTCULOS ¿VALIDA QUE EXISTA????
Select AR_CCODIGO From RSFACCAR..AL0001ARTI Where AR_CCODIGO='SIST000010'
go
-- CUENTA DE LA TABLA DE ARTICULOS LOS QUE ESTAN VIGENTES, DE TIPO NACIONAL, TY CUYA DESCRIPCION SEA MENOR A 'SIST....'
-- PARA EL HELP???
Select COUNT(*) as 'POSICION' From RSFACCAR..AL0001ARTI Where AR_CESTADO='V'  And AR_CTIPO='N' AND AR_CDESCRI<='SIST'
go
--*********************************************************************************************************
--*********************************************************************************************************
-- F I N ................................    INSERT DE LA OC
--*********************************************************************************************************
--*********************************************************************************************************

--*****************************************************************************************
-- aca jala el ultimo numero correlativo para la OC EMITIDOOO
--*****************************************************************************************
Select * From RSFACCAR..FT0001NUME Where TN_CCODIGO='OC' And TN_CNUMSER='000'
go
-- VERIFICA		QUE EXISTA EN LA CABECERA DE OC
Select OC_CNUMORD From RSFACCAR..CO0001MOVC Where OC_CNUMORD='0000023088'
go

-- ACTUALIZA EL CORRELATIVO
Update RSFACCAR..FT0001NUME Set TN_NNUMERO=23088 Where TN_CCODIGO='OC' And TN_CNUMSER='000'
go

-- BORRA LOS MOVIMIENTOS DE DETALLE SI EXISTIERAN
Delete From RSFACCAR..CO0001MOVD Where OC_CNUMORD='0000023088'
go
--*********************************************************************************************************
-- se repite para cada item de la OC
--*********************************************************************************************************
-- Hce el insert del detalle de movientos OC
Insert 
RSFACCAR..CO0001MOVD(OC_CTIPORD,OC_CNUMORD,OC_DFECDOC,OC_CCODPRO,OC_CESTADO,OC_CITEM,OC_CCODIGO,OC_CCODREF,OC_CDESREF,OC_CUNIDAD,OC_NCANORD,OC_NPREUN2,OC_NDESCAD,OC_NDSCPAD,OC_NIGV,OC_NIGVPOR,OC_NISC,OC_NISCPOR,OC_NCANSAL,OC_NTOTUS,OC_NTOTMN,OC_NTOTMO,OC_NPREUNI,OC_COMENTA,OC_NDSCPFI,OC_NDESCFI,OC_NDSCPIT,OC_NDESCIT, 
OC_NDSCPOR,OC_NDESCTO,OC_CCENCOS,OC_CSOLICI,OC_CNUMREQ,OC_DFECENT,OC_CITMPOR,OC_CDSCPOR,OC_CIGVPOR, OC_CISCPOR,OC_CUNIPRO, OC_CDEUNPR, OC_NCANTEN, OC_FUNICOM, OC_NCANREF, OC_CSERIE, 
OC_NANCHO, OC_NCORTE, OC_CITEREQ, OC_CREFCOD, OC_CPEDINT, OC_CITEINT, OC_CREFCOM, OC_CNOMFAB, OC_NCANEMB  ) Values('N','0000023088',Convert(datetime,'14/12/2012',103),'20536849981       
','1','0002','SIST000012','','Computadora VS 5047','UND',1,360,0,0,64.8,18,0,0,1,424.8,1089.612,0,424.8,', procesador AMD Athlon™ II X3 440 (3.0GHz, Cache L1 = 128KB x 3,L2 = 512KB x 3), 
memoria 2GB DDR3, disco duro 500GB SATA, DVD SuperMulti, vídeo integrado GEFORCE 6150SE, LAN 10/100Mbps, regulador de voltaje, parlantes estéreo, teclado y mouse. Sistema operativo Windows 7 
Starter 32-bit en Español',0,0,0,0,0,0,'','','',Convert(datetime,'14/12/2012',103),'N','N','N','N' ,'','',0,'',0,'',0,0,'','','','','','',0)
go
-- hace un insert en la tabla de Almacenes APRO 
-- indica, fecha, oc, costo, moneda, fecha de compra.....
Insert RSFACCAR..AL0001APRO(PM_CCODMAT,PM_CCODPRO,PM_DFECDOC,PM_CTIPMON,PM_NVALOR,PM_CCOTIZA,PM_CORDCOM,PM_DFECCRE,PM_CHORA,PM_CUSER)Values('SIST000012               ','20536849981       
',Convert(datetime,'14/12/2012',103),'US',360,'','0000023088',Convert(datetime,'14/12/2012',103),'02:09','sist ')
go
--*********************************************************************************************************
-- se repite para cada item de la OC
--*********************************************************************************************************
Insert 
RSFACCAR..CO0001MOVD(OC_CTIPORD,OC_CNUMORD,OC_DFECDOC,OC_CCODPRO,OC_CESTADO,OC_CITEM,OC_CCODIGO,OC_CCODREF,OC_CDESREF,OC_CUNIDAD,OC_NCANORD,OC_NPREUN2,OC_NDESCAD,OC_NDSCPAD,OC_NIGV,OC_NIGVPOR,OC_NISC,OC_NISCPOR,OC_NCANSAL,OC_NTOTUS,OC_NTOTMN,OC_NTOTMO,OC_NPREUNI,OC_COMENTA,OC_NDSCPFI,OC_NDESCFI,OC_NDSCPIT,OC_NDESCIT, 
OC_NDSCPOR,OC_NDESCTO,OC_CCENCOS,OC_CSOLICI,OC_CNUMREQ,OC_DFECENT,OC_CITMPOR,OC_CDSCPOR,OC_CIGVPOR, OC_CISCPOR,OC_CUNIPRO, OC_CDEUNPR, OC_NCANTEN, OC_FUNICOM, OC_NCANREF, OC_CSERIE, 
OC_NANCHO, OC_NCORTE, OC_CITEREQ, OC_CREFCOD, OC_CPEDINT, OC_CITEINT, OC_CREFCOM, OC_CNOMFAB, OC_NCANEMB  ) Values('N','0000023088',Convert(datetime,'14/12/2012',103),'20536849981       
','1','0003','SIST000012','','MONITOR','UND',1,87.6,0,0,15.768,18,0,0,1,103.368,265.139,0,103.368,'MOV16BQ615HDPL Monitor BENQ LED 15.6 G615HDPL, tamaño 15.6", WideScreen LED Backlight, 
resol. 1366x768, brillo 200cd/m2, contraste estático 500:1, contraste dinámico 1000000:1, interfax VGA.',0,0,0,0,0,0,'','','',Convert(datetime,'14/12/2012',103),'N','N','N','N' 
,'','',0,'',0,'',0,0,'','','','','','',0)
go

Insert RSFACCAR..AL0001APRO(PM_CCODMAT,PM_CCODPRO,PM_DFECDOC,PM_CTIPMON,PM_NVALOR,PM_CCOTIZA,PM_CORDCOM,PM_DFECCRE,PM_CHORA,PM_CUSER)Values('SIST000012               ','20536849981       
',Convert(datetime,'14/12/2012',103),'US',87.6,'','0000023088',Convert(datetime,'14/12/2012',103),'02:09','sist ')
go
--*********************************************************************************************************
-- se repite para cada item de la OC
--*********************************************************************************************************
Insert 
RSFACCAR..CO0001MOVD(OC_CTIPORD,OC_CNUMORD,OC_DFECDOC,OC_CCODPRO,OC_CESTADO,OC_CITEM,OC_CCODIGO,OC_CCODREF,OC_CDESREF,OC_CUNIDAD,OC_NCANORD,OC_NPREUN2,OC_NDESCAD,OC_NDSCPAD,OC_NIGV,OC_NIGVPOR,OC_NISC,OC_NISCPOR,OC_NCANSAL,OC_NTOTUS,OC_NTOTMN,OC_NTOTMO,OC_NPREUNI,OC_COMENTA,OC_NDSCPFI,OC_NDESCFI,OC_NDSCPIT,OC_NDESCIT, 
OC_NDSCPOR,OC_NDESCTO,OC_CCENCOS,OC_CSOLICI,OC_CNUMREQ,OC_DFECENT,OC_CITMPOR,OC_CDSCPOR,OC_CIGVPOR, OC_CISCPOR,OC_CUNIPRO, OC_CDEUNPR, OC_NCANTEN, OC_FUNICOM, OC_NCANREF, OC_CSERIE, 
OC_NANCHO, OC_NCORTE, OC_CITEREQ, OC_CREFCOD, OC_CPEDINT, OC_CITEINT, OC_CREFCOM, OC_CNOMFAB, OC_NCANEMB  ) Values('N','0000023088',Convert(datetime,'14/12/2012',103),'20536849981       
','1','0004','SIST000013','','IMPRESORA MATRICIAL','UND',1,220,0,0,39.6,18,0,0,1,259.6,665.874,0,259.6,'matriz Epson LX-300+II, velocidad máxima hasta 300 cps, interfaz DB-25 Paralelo/DB-9 
Serial/USB.',0,0,0,0,0,0,'','','',Convert(datetime,'14/12/2012',103),'N','N','N','N' ,'','',0,'',0,'',0,0,'','','','','','',0)
go
Insert RSFACCAR..AL0001APRO(PM_CCODMAT,PM_CCODPRO,PM_DFECDOC,PM_CTIPMON,PM_NVALOR,PM_CCOTIZA,PM_CORDCOM,PM_DFECCRE,PM_CHORA,PM_CUSER)Values('SIST000013               ','20536849981       
',Convert(datetime,'14/12/2012',103),'US',220,'','0000023088',Convert(datetime,'14/12/2012',103),'02:09','sist ')
go

--*********************************************************************************************************
-- se repite para cada item de la OC
--*********************************************************************************************************
Insert 
RSFACCAR..CO0001MOVD(OC_CTIPORD,OC_CNUMORD,OC_DFECDOC,OC_CCODPRO,OC_CESTADO,OC_CITEM,OC_CCODIGO,OC_CCODREF,OC_CDESREF,OC_CUNIDAD,OC_NCANORD,OC_NPREUN2,OC_NDESCAD,OC_NDSCPAD,OC_NIGV,OC_NIGVPOR,OC_NISC,OC_NISCPOR,OC_NCANSAL,OC_NTOTUS,OC_NTOTMN,OC_NTOTMO,OC_NPREUNI,OC_COMENTA,OC_NDSCPFI,OC_NDESCFI,OC_NDSCPIT,OC_NDESCIT, 
OC_NDSCPOR,OC_NDESCTO,OC_CCENCOS,OC_CSOLICI,OC_CNUMREQ,OC_DFECENT,OC_CITMPOR,OC_CDSCPOR,OC_CIGVPOR, OC_CISCPOR,OC_CUNIPRO, OC_CDEUNPR, OC_NCANTEN, OC_FUNICOM, OC_NCANREF, OC_CSERIE, 
OC_NANCHO, OC_NCORTE, OC_CITEREQ, OC_CREFCOD, OC_CPEDINT, OC_CITEINT, OC_CREFCOM, OC_CNOMFAB, OC_NCANEMB  ) Values('N','0000023088',Convert(datetime,'14/12/2012',103),'20536849981       
','1','0005','SIST000014','','LECTOR COD.BARRAS','UND',1,120,0,0,21.6,18,0,0,1,141.6,363.204,0,141.6,'Motorola LS1203 PC CQ5105LA 
A64X',0,0,0,0,0,0,'','','',Convert(datetime,'14/12/2012',103),'N','N','N','N' ,'','',0,'',0,'',0,0,'','','','','','',0)
go
Insert RSFACCAR..AL0001APRO(PM_CCODMAT,PM_CCODPRO,PM_DFECDOC,PM_CTIPMON,PM_NVALOR,PM_CCOTIZA,PM_CORDCOM,PM_DFECCRE,PM_CHORA,PM_CUSER)Values('SIST000014               ','20536849981       
',Convert(datetime,'14/12/2012',103),'US',120,'','0000023088',Convert(datetime,'14/12/2012',103),'02:09','sist ')
go

--*********************************************************************************************************
-- INSERT DE LA CABECERA DE LA OC
--*********************************************************************************************************
Insert 
RSFACCAR..CO0001MOVC(OC_CNUMORD,OC_CSITORD,OC_CCODPRO,OC_CRAZSOC,OC_CDIRPRO,OC_CCOTIZA,OC_DFECDOC,OC_CFORPA1,OC_CCODMON,OC_NTIPCAM,OC_DFECENT,OC_CCODSOL,OC_CSOLICT,OC_CLUGENT,OC_CLUGFAC,OC_CDETENT,OC_CTIPENV,OC_CUSUARI,OC_CTIPORD,OC_DFECACT,OC_CHORA,OC_NIMPUS,OC_NIMPMN,OC_CRESPER1,OC_CRESPER2,OC_CRESPER3,OC_CRESCARG1,OC_CRESCARG2,OC_CRESCARG3,OC_CCOPAIS,OC_CREMITE,OC_CPERATE,OC_CCONTA1,OC_CCONTA2,OC_CCONTA3,OC_CUNIORD,OC_CTIPDOC,OC_CTIPDSP,OC_CNUMREF,OC_CALMDES,OC_CDISTOC,OC_CPROVOC,OC_CCOSTOC,OC_CDOCPAG,OC_DFECPAG,OC_DFECVEN,OC_CESTPAG,OC_CMONPAG,OC_NIMPPAG,OC_CGLOPAG)Values('0000023088','1','20536849981       
','SECURITY & COMMUNICATION TECHNOLOGIES S. A. C.','CAL. CAMINO REAL NRO. 1801 INT. C 10 Z.I. PARQUE I','',Convert(datetime,'14/12/2012',103),'                              
','US',2.565,Convert(datetime,'14/12/2012',103),'','                                                  ','CLL SALVADOR CARMONA No 280 -LIMA 03','CLL  CAP. SALVADOR CARMONA 280 - LIMA 
03','','','sist ','N',Convert(datetime,'17/12/2012',103),'02:09:',929.37,2383.834,'','','','','','','','','', '', '', '','','','','','0001','','','','',Null,Null,'','',0,'')
go
IF @@TRANCOUNT > 0 COMMIT TRAN
go
--*********************************************************************************************************
--*********************************************************************************************************
-- F I N ................................    INSERT DE LA OC
--*********************************************************************************************************
--*********************************************************************************************************
-- SELECTS DE VERIFICACION DE ESTADO DE LA OC
Select OC_CSITORD,OC_CTIPORD From RSFACCAR..CO0001MOVC Where OC_CNUMORD='0000023088'
go
-- DEVUELVE "COMIMP02"
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='94' And TG_CCLAVE='COM'
go
-- VERIFICA QUE CON "COMI" DEVUELVE LO MISMO QUE EL ANTERIOR
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='94' And TG_CCLAVE='COMI'
go
-- VERIFICA QUE CON "COMS" DEVUELVE LO MISMO QUE EL ANTERIOR
Select TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='94' And TG_CCLAVE='COMS'
go
-- DATOS DEL PROVEEDOR DEL RSFACCAR VS RSCONCAR
Select * From RSFACCAR..CO0001MOVC LEFT OUTER JOIN RSCONCAR..CP0001MAES on AC_CVANEXO='P' AND AC_CCODIGO=OC_CCODPRO Where OC_CNUMORD='0000023088' And OC_CTIPORD='N'
-- CAPTURA EL NUMERO DE FAX DEL MODELADOR
Select AC_CFAX From RSFACCAR..ALCIAS Where AC_CCIA='0001'
go
-- CAPTURA EL NUMERO DE TELEFONO DEL MODELADOR
Select AC_CTELEF1 From RSFACCAR..ALCIAS Where AC_CCIA='0001'
go
-- CAPTURA LS LINEAS DE DETALLE DE LA OC PARA LA IMPRESION???
Select * From RSFACCAR..CO0001MOVD Where OC_CNUMORD='0000023088'
