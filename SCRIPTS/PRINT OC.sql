/****************************************************************************
 DATOS PARA IMPRIMIR UNA OC DE IMPORTACION
*****************************************************************************/
Select * From RSFACCAR..ALCIAS Where AC_CCIA='0001'

Select * From RSFACCAR..CO0001MOVC LEFT OUTER JOIN RSCONCAR..CP0001MAES on AC_CVANEXO='P' AND AC_CCODIGO=OC_CCODPRO Where OC_CNUMORD='0000022964'

Select * From RSFACCAR..CO0001MOVD Where OC_CNUMORD='0000022964          '

/****************************************************************************
 DATOS PARA IMPRIMIR UNA OC NACIONAL
*****************************************************************************/
Select * From RSFACCAR..CO0001MOVC LEFT OUTER JOIN RSCONCAR..CP0001MAES on AC_CVANEXO='P' AND AC_CCODIGO=OC_CCODPRO Where OC_CNUMORD='0000023088' or oc_ccopais <> ''

Select * From RSFACCAR..ALCIAS Where AC_CCIA='0001'

Select * From RSFACCAR..CO0001MOVD Where OC_CNUMORD='0000022464          '
go
/****************************************************************************
 DATOS PARA IMPRIMIR UNA OC DE SERVICIOS
*****************************************************************************/
Select  * From RSFACCAR..CO0001MOVC LEFT OUTER JOIN RSCONCAR..CP0001MAES on AC_CVANEXO='P' AND AC_CCODIGO=OC_CCODPRO Where OC_CNUMORD='0000023030'
OR OC_Cforpa1 <> ''

Select TG_CCLAVE,TG_CDESCRI From RSFACCAR..AL0001TABL Where TG_CCOD='81' Order by TG_CCLAVE


go
Select * From RSFACCAR..ALCIAS Where AC_CCIA='0001'
GO
Select * From RSFACCAR..CO0001MOVD Where OC_CNUMORD='0000023041'
go
Select SUM(OC_NIGV) AS IGV, SUM((OC_NCANORD*OC_NPREUN2)-ISNULL(OC_NDESCTO,0)) From RSFACCAR..CO0001MOVD Where OC_CNUMORD='0000023041'

Select aC_CCODIGO as Cod ,AC_CNOMBRE as Razon_Social ,* From RSCONCAR..CP0001MAES Where AC_CVANEXO='P' And AC_CCODIGO='20536849981'