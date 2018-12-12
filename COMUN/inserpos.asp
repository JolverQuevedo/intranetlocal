<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<%Response.Buffer = TRUE %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body>
<% 
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
CHK = Request.QueryString("chk")
po = ucase(TRIM(Request.QueryString("PO")))
poS = ucase(TRIM(Request.QueryString("PO")))
cot = ucase(TRIM(Request.QueryString("COT")))
cli = ucase(TRIM(Request.QueryString("CLI")))
EST = ucase(TRIM(Request.QueryString("EST")))
EMB = ucase(TRIM(Request.QueryString("fec")))
tip = ucase(TRIM(Request.QueryString("TIP")))
pro = ucase(TRIM(Request.QueryString("pro")))
des = ucase(TRIM(Request.QueryString("des")))
emb = day(emb)&"/"& month(emb)&"/"&year(emb)
fob = ucase(TRIM(Request.QueryString("fob")))
col = ucase(TRIM(Request.QueryString("col")))
cn0 = ucase(TRIM(Request.QueryString("cn0")))
cn1 = ucase(TRIM(Request.QueryString("cn1")))
cn2 = ucase(TRIM(Request.QueryString("cn2")))
cn3 = ucase(TRIM(Request.QueryString("cn3")))
cn4 = ucase(TRIM(Request.QueryString("cn4")))
cn5 = ucase(TRIM(Request.QueryString("cn5")))
cn6 = ucase(TRIM(Request.QueryString("cn6")))
cn7 = ucase(TRIM(Request.QueryString("cn7")))
cn8 = ucase(TRIM(Request.QueryString("cn8")))
cn9 = ucase(TRIM(Request.QueryString("cn9")))
TAL = ucase(TRIM(Request.QueryString("TAL")))
TTT = ucase(TRIM(Request.QueryString("TTT")))
ofi = ucase(TRIM(Request.QueryString("ofi")))

hou = replace(ucase(TRIM(Request.QueryString("hou"))),",",".") 
LOP = TRIM(Request.QueryString("lle"))
XX = CDATE(EMB)-45
RESPONSE.WRITE(XX)

RESPONSE.WRITE("<BR>")
RESPONSE.WRITE(col)
RESPONSE.WRITE("<BR>")
RESPONSE.WRITE("<BR>")
 IF LEN(LOP) = 0  THEN LLE = EMB ELSE lle = formatdatetime(ucase(LOP),2)

Xbig = replace(ucase(TRIM(Request.QueryString("Xbig"))),",",".")
big = replace(ucase(TRIM(Request.QueryString("big"))),",",".")
obs = left(ucase(TRIM(Request.QueryString("obs"))),150)


acol = split(col,",")
aTal = split(tal,",")
afob = split(fob,",")
aCn0 = split(cn0,",")
aCn1 = split(cn1,",")
aCn2 = split(cn2,",")
aCn3 = split(cn3,",")
aCn4 = split(cn4,",")
aCn5 = split(cn5,",")
aCn6 = split(cn6,",")
aCn7 = split(cn7,",")
aCn8 = split(cn8,",")
aCn9 = split(cn9,",")

Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 

FECHA ="{ fn NOW() }"

Yad = "select po from pos where po = '"&po&"'"
rs.open Yad,cnn
CAD = " set dateformat dmy; "
'*********************************
' IF # 1
'*********************************
if rs.recordcount > 0 and chk <> "0" then
    ' es UPDATE  DE PO ....
    if chk = "1" then ' IF DEL TIPO DE GRABACION
		CAD =cad +	" UPDATE  pos set           " & _
				    " COTIZACION = '"&COt&"',       " & _
				    " TIPOEMB   = '"&TIP&"',        " & _
				    " FECEMB = '"&EMB&"',           " & _
                    " destino = '"&des&"',          " & _
                    " codest = '"&est&"',           " & _
                    " CLIENTE = '"&CLI&"',          " & _
                    " CANTIDAD = "&TTT&",           " & _
                    " ESTADO = 'A',                 " & _
				    " USUARIO = '"&USUARIO&"',      " & _
                    " HOUSE = "&HOU&"  ,            " & _
                    " LLEGAPO =  Convert(datetime,'"&LLE&"',103), " & _
                    " BIG = "&BIG&",                " & _
                    " XBIG = "&XBIG&",              " & _
                    " OBSERVA = '"&OBS&"' ,         " & _ 
				    " FECHA = "&fecha&"             "
        IF LEN(TRIM(OFI)) > 0 THEN CAD = CAD + " , OFI = '"&OFI&"' "

        CAD = CAD + " WHERE  PO = '"&PO&"';         "
	else
		CAD = cad + " UPDATE POS                    " & _
				    " SET  USUARIO = '"&USUARIO&"', " & _
				    " FECHA = "&fecha&" ,           " & _
				    " ESTADO = 'E'	                " & _ 
				    " WHERE  PO = '"&PO&"';         "
				
	end if	 ' FIN IF TIPO GRABAION
ELSE ' IF # 1

	CAD = cad +	" insert into POS              	    " & _
			    " (PO, COTIZACION,CLIENTE,  CODEST, " & _
                " FECEMB, TIPOEMB, destino,ESTADO,  " & _
                " usuario, fecha, CANTIDAD, house,  " & _
                " llegapo, big, observa,XBIG) values(" & _
                " '"&PO&"', '"&COT&"',	'"&CLI&"',  " & _
                " '"&EST&"',                        " & _
			    " '"&EMB&"', '"&tip&"', '"&des&"',  " & _
                " 'A','"&USUARIO&"', "&fecha&",     " & _
                " "&TTT&", "&hou&",                 " & _
                " Convert(datetime,'"&LLE&"',103),  " & _
                " "&big&", '"&obs&"', '"&XBIG&"');    " 
	
END IF  
'***********************************************
' IF # 1 --> DEL UPDETE / INSERT DE LA PO
'***********************************************
' BORRO TODO EL DETALLE Y LO VUELVO A CREAR (SI EXISTE...)
' PARA QUE TODOS LOS DATOS QUEDEN EXACTOS
CAD = CAD + "DELETE [PO-DETA] WHERE PO  = '"&PO&"' ; "

FOR I = 1 TO UBOUND(aCol) 
    if trim(acol(i)) <> "" then
        cad = cad + " INSERT INTO [PO-DETA] (PO, COLOR, UBI,        " & _
                    " FOB, CAN0, CAN1, CAN2,CAN3, CAN4, CAN5,       " &_
                    " CAN6,CAN7,CAN8,CAN9, T0, T1, T2, T3,T4,       " & _
                    " T5,T6,T7,T8,T9, USUARIO,FECHA, ESTADO)        " & _
                    " VALUES ('"&PO&"', '"&AcOL(I)&"', '"&I&"',     " & _
                    " "&aFob(I)&",   '"&aCn0(I)&"', '"&aCn1(I)&"',  " & _ 
                    " '"&aCn2(I)&"', '"&aCn3(I)&"', '"&aCn4(I)&"',  " & _
                    " '"&aCn5(I)&"', '"&aCn6(I)&"',                 " & _
                    " '"&aCn7(I)&"', '"&aCn8(I)&"', '"&aCn9(I)&"',  " & _
                    " '"&aTal(0)&"', '"&aTal(1)&"', '"&aTal(2)&"',  " & _
                    " '"&aTal(3)&"', '"&aTal(4)&"', '"&aTal(5)&"',  " & _
                    " '"&aTal(6)&"', '"&aTal(7)&"', '"&aTal(8)&"',  " & _
                    " '"&aTal(9)&"', '"&usuario&"', "&fecha&",'A'); "
    end if ' IF DENTRO DEL FOR DE COLORES
next

' Inicia transacción , para que los datos no queden a medias
RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)
' RESPONSE.END
Cnn.BeginTrans	
Cnn.Execute(CAD)
RESPONSE.WRITE("<br>")
RESPONSE.WRITE("<br>")
Cnn.CommitTrans	
cnn.begintrans
mad = "select sum(can0 + can1+can2+can3+can4+can5+can6+can7+can8+can9) as tota from [po-deta] where po  = '"&PO&"'; "
rs2.open mad, cnn
if rs2.recordcount >0 then 
    TTT = cdbl(rs2("tota"))
    response.write(ttt)
    poto =  " UPDATE POS                   " & _
			" SET CANTIDAD = "&TTT&"       " & _
			" WHERE  PO = '"&PO&"';        "
     response.write(poto)                				
    cnn.execute( poto)
end if
rs2.close
cad = ""
rs.close
ficha = "FICHApos '"&po&"' , '"&cli&"' "
RESPONSE.WRITE(FICHA )
 rs.open ficha, cnn
 rs.movefirst

'*********************************
' IF # 2 --> SI YA TIENE OFI
'*********************************
if len(trim(rs("ofi"))) > 0 then
    response.write(rs("ofi"))
    ofi = rs("ofi")
    ' tiene OFI y está editando la PO
    ' hay que desvincular la po, y re-vincular a la ofi

    CAD = cad + " UPDATE POS                    " & _
		    " SET  USUARIO = '"&USUARIO&"', " & _
		    " FECHA = "&fecha&" ,           " & _
		    " ESTADO = 'A' 	                " & _ 
		    " WHERE  PO = '"&PO&"'          " & _
            " and cliente = '"&cli&"' ;     "
           ' " OFI   = NULL                  " & _
    cad = cad + " delete ofi_pos where ofi = '"&ofi&"' and po = '"&po&"'      ;            "

    cad = cad + " update ofis  set cantidad = "&TTT&", codest = '"&est&"' where ofis.codigo = '"&OFI&"' ;            "

    CAD = CAD + " INSERT INTO ofi_pos (OFI, PO, USUARIO, FECHA,ESTADO)  VALUES  (          " & _
                " '"&OFI&"', '"&PO&"',  '"&usuario&"', "&fecha&",'A');                     "

    DD = "SELECT DO_CGRUPO  FROM DBPROD..COMdetOP WHERE DO_CCODIGO = '"&OFI&"' AND DO_CDESCOL1 = '"&PO&"' " 
    rs.close
    RS.OPEN DD, CNN

    IF RS.RECORDCOUNT> 0 THEN
        RS.MOVEFIRST
        GRUPO = RS("DO_CGRUPO")
        cAD = cAD + " DELETE DBPROD..COMdetOP WHERE DO_CCODIGO = '"&OFI&"'  " & _
                    " AND DO_CGRUPO = '"&GRUPO&"'; "
    END IF
    Cnn.Execute(CAD)
    response.write("<br>")
    response.WRITE("<BR>")
    response.WRITE("<BR>")
    response.write(cad)
    ' HAY QUE VINCULAR LA PO A LA OFI PRE-EXISTENTE !!!!

    ' ****************************************************************************************'
    '     DATOS PARA EL DBPROD
    ' ****************************************************************************************'
    ' DEBE GRABAR CABECERA Y DETALLE DE LAS POS
    ' EL CODIGO DE ARTICULO Y EL ESTILO YA ESTAN ACTUALIZADOS EN EL DBPROD DESDE LA
    ' CREACION DEL ESTILO

    RAD = "SELECT * FROM MODELADOR..VIEW_OFIS_dbprod WHERE OFI = '"&OFI&"' "
    response.WRITE("<BR>")
    response.WRITE("<BR>")
    response.WRITE("<BR>")
    response.WRITE(RAD)
    RS.CLOSE
    RS.OPEN RAD, CNN
        IF RS.RECORDCOUNT > 0 THEN ' IF DEL VIEW OFIS_DBPROD
            RS.MOVEFIRST
            NOME = rs("NOM")
            DPRE = LEFT(RS("DPRE"),30)
            DTEL= LEFT(RS("DTEL"),50)
            CART = RS("CART")
            DTEMP = LEFT(RS("DTEMP"),30)
            MM = RIGHT("00"+TRIM(CSTR(MONTH(DATE()))),2)
            DD = RIGHT("00"+ TRIM(CSTR(DAY(DATE()))),2)
            FOB = RS("FOB")
            DFEC = TRIM(CSTR(YEAR(DATE())))+MM+DD
        ELSE
            RS.CLOSE
            DAD = "SELECT * FROM MODELADOR..VIEW_OFIS WHERE OFI = '"&OFI&"' "
            RS.OPEN DAD, CNN
                IF RS.RECORDCOUNT > 0 THEN
                    RS.MOVEFIRST
                    NOME = rs("NOM")
                    DPRE = LEFT(RS("DPRE"),30)
                    CART = RS("CART")
                    IF LEN(TRIM(RS("FOB"))) = 0 THEN FOB = 0 ELSE FOB = RS("FOB")
                ELSE
                    NOME = ""
                    DPRE = ""
                    CART =""
                END IF
            DTEL= ""   
            DTEMP = ""
            MM = RIGHT("00"+TRIM(CSTR(MONTH(DATE()))),2)
            DD = RIGHT("00"+ TRIM(CSTR(DAY(DATE()))),2)
    
            DFEC = TRIM(CSTR(YEAR(DATE())))+MM+DD
        END IF ' DEL VIEW OFI_DBPROD

    if len(trim(fob)) = 0 or isnull(fob) then fob = 0

    RS.CLOSE
    rs.open "select estcli from estilos where cliente = '"&cli&"' and codest = '"&est&"'", cnn
    DEST = LEFT(RS("estcli"),50)
    rs.close
    ss =    " select top 1 isnull(t0,'') as t0, isnull(t1,'') as t1, isnull(t2,'') as t2, isnull(t3 ,'') as t3, isnull(t4,'') as t4, isnull( t5,'')as t5," & _
            " isnull( t6,'')as t6, isnull( t7,'')as t7, isnull( t8,'')as t8, isnull( t9,'') as t9 from [po-deta] where po = '"&pos&"'"
    rs.open ss,cnn
    RESPONSE.WRITE(SS)
    rs.movefirst
    ATAL = ""
    for v = 0 to 9
        if len(trim(rs("t"&v))) > 0 then  
            atal = atal + rs("t"&v)+ ","
        END IF
    next
    rs.close

    MAD =  MAD +    " DELETE DBPROD..COMCABOP WHERE CO_CCODIGO = '"&OFI&"' ; "
    mad =  mad +    " INSERT INTO DBPROD..COMCABOP (CO_CCODIGO, CO_CCODCLI, CO_CCLIENTE, CO_CCODSTY, CO_CNROSTY,        " & _
                    " CO_CDESSTY, CO_CPRENDA,CO_CTEJIDO,CO_CCODTAL,CO_CTALLER,CO_CCODART,  CO_CTEMPO, CO_NPRECIO,       " & _
                    " CO_DFECING,CO_CTIPO,CO_CTRANS,CO_CUSER,CO_NESTADO,CO_CTALLAS,CO_NLIMITE,CO_NADICION)              " & _
                    " VALUES ('"&ofi&"','"&cli&"','"&NOME&"','"&dEST&"', '"&dEST&"', '"&dpre&"','"&DPRE&"','"&DTEL&"',    " & _
                    " '0001','EL MODELADOR S.A.', '"&CART&"','"&DTEMP&"', '"&FOB&"','"&DFEC&"','PL','SEA',              " & _
                    " '"&USUARIO&"',1,'"&atal&"',50,2) ;                                                                 " 


    grupo = right("000"&(t+1),3)
    '********************************************************************************************
    ' borra las PO's porque no se si las editaron fuera de la OFI
    ' la CABECERA Y DETALLE DE LAS PO'S/COLORES DE UNA OFI SE AMARRAN POR EL !!!!!! GRUPO !!!!!
    '********************************************************************************************
     MAD = MAD + " DELETE DBPROD..COMdetOP WHERE DO_CCODIGO = '"&OFI&"' and DO_CGRUPO = '"&GRUPO&"' ; "
    '********************************************************************************************
    ' DESTINO / PO (TIPO C)
    '********************************************************************************************
    TAD = "SELECT dd.NOMBRE FROM POS SS inner join destinos dd on ss.destino = dd.codigo "
    RS.OPEN TAD,CNN
    RS.MOVEFIRST
    DESTIN 	= LEFT(RS("NOMBRE"),30)
    RS.CLOSE
    '********************************************************************************************
    ' REGISTRO DE CABECERA DE LA PO EN EL DETALLE DE LA OFI DEL DBPROD --> TIPO "C"
    '********************************************************************************************
    mad = mad + " INSERT INTO DBPROD..COMDETOP (DO_CCODIGO,DO_CGRUPO,DO_CTIPO,DO_CCODCOL1,DO_CDESCOL1,DO_NMERMA1,       " & _
                " DO_CCODCOL2,DO_CDESCOL2,DO_NMERMA2,DO_CCODCOL3,DO_CDESCOL3,DO_NMERMA3,DO_CCODCOL4,DO_CDESCOL4," & _
                " DO_NMERMA4,DO_CCODCOL5,DO_CDESCOL5,DO_NMERMA5,DO_NT1,DO_NT2,DO_NT3,DO_NT4,DO_NT5,DO_NT6,      " & _
                " DO_NT7, DO_NT8, DO_NT9 , DO_NT10) VALUES('"&ofi&"','"&grupo&"','C','    ', '"&pos&"', 0,  " & _
                " '', '"&DESTIN&"', 0, '','',0, '','',0,'','', 0,0,0,0,0,0,0,0,0,0,0) ;                          "

    '********************************************************************************************
    ' jalar el codigo de color y cantidades para el DBPROD 
    ' aca HAY QUE PONER UN DO WHILE PARA QUE CARGUE TOOOODOS LOS COLORES DE LA PO
    '********************************************************************************************
    Fad =   " SELECT		pp.po, PP.color ,	PP.UBI, CAN0, CAN1, CAN2,  fob,     " & _
			" CAN3, CAN4, CAN5, CAN6, CAN7, CAN8, CAN9 FROM  [PO-DETA] AS PP        " & _
	        "  where pp.po = '"&pos&"'	ORDER BY PP.PO, UBI    ;                "
    rs.open Fad, cnn
    newfob = 0
    '*********************************
    ' IF  # 3
    '*********************************
    if rs.recordcount >0 then 
        rs.movefirst
        newfob = rs("fob")
        do while not rs.eof
             descol = left(trim(rs("color")),50)
            '********************************************************************************************
            ' buscar el codigo de color en el REAL !!!!!!!!!!!!!!!
            '********************************************************************************************
            dad = " SELECT TG_CCLAVE FROM RSFACCAR..AL0001TABL WHERE TG_CCOD='D2' AND TG_CDESCRI = '"&descol&"' "
            rs2.open dad, cnn
            ' si no existe el codigo de color, lo insertamos en el Real ARBITRARIAMENTE
                if rs2.recordcount <= 0 then
                    codcol = right(ofi,1) & right(cart,2)
                    mad = mad + " insert into RSFACCAR..AL0001TABL (TG_CCOD, TG_CCLAVE, TG_CDESCRI, tg_cusucre, tg_dfeccre) " & _
                                " values('D2', '"&codcol&"', '"&DESCOL&"', '"&CODUSR&"', GETDATE() )                ;    "
                else
                    codcol = rs2("tg_cclave")
                end if ' DEL RS2.RECCORDCOUNT
            rs2.close
            '********************************************************************************************
            ' REGISTRO DE DETALLE - COLOR / CANTIDADES DE LA OFI DEL DBPROD --> TIPO "C"
            '********************************************************************************************
            acol(0) = rs("can0")
            acol(1) = rs("can1")
            acol(2) = rs("can2")
            acol(3) = rs("can3")
            acol(4) = rs("can4")
            acol(5) = rs("can5")
            acol(6) = rs("can6")
            acol(7) = rs("can7")
            acol(8) = rs("can8")
            acol(9) = rs("can9")
            MAD = MAD + " INSERT INTO DBPROD..COMDETOP (DO_CCODIGO,DO_CGRUPO,DO_CTIPO,DO_CCODCOL1,DO_CDESCOL1,DO_NMERMA1,   " & _
                        " DO_CCODCOL2,DO_CDESCOL2,DO_NMERMA2,DO_CCODCOL3, DO_CDESCOL3,DO_NMERMA3,DO_CCODCOL4,               " & _                                                   
                        " DO_CDESCOL4,DO_NMERMA4,DO_CCODCOL5,DO_CDESCOL5,DO_NMERMA5,DO_NT1,DO_NT2,DO_NT3,DO_NT4,            " & _
                        " DO_NT5, DO_NT6, DO_NT7, DO_NT8, DO_NT9 ,DO_NT10) VALUES('"&ofi&"','"&grupo&"','D',                " & _
                        " '"&CODCOL&"','"&DESCOL&"',5,'','',0,'', '',0,'','',0,'','', 0,                                    " & _
                        " '"&acol(0)&"','"&ACOL(1)&"','"&ACOL(2)&"', '"&ACOL(3)&"', '"&ACOL(4)&"', '"&ACOL(5)&"',           " & _
                        " '"&ACOL(6)&"', '"&ACOL(7)&"', '"&ACOL(8)&"', '"&ACOL(9)&"');                                      " 
            rs.movenext
        loop
    end if 
    '*********************************
    ' FIN IF # 3
    '********************************* 
    rs.close

    mad =  mad + "update DBPROD..COMCABOP set CO_NPRECIO = "&newfob&" WHERE CO_CCODIGO = '"&OFI&"' "

    response.WRITE("<BR>")
    response.WRITE("<BR>")
    response.WRITE("<BR>")
    response.WRITE(MAD)

    Cnn.Execute(mad)

end if 
'*********************************
' FIN IF #2
'*********************************
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if ' DEL ERR.NUMBER

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
%>
<script language="jscript" type="text/jscript">
alert("Actualizacion OK")
   top.window.location.replace='../fichapos.asp?po=' + '<%=pos %>' + '&cli=' + '<%=cli%>' 
</script>  
</BODY>
</HTML>
