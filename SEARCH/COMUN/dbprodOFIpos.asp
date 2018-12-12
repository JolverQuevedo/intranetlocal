<%@ Language=VBScript %>
<% Response.Buffer = true 
Usuario = Request.Cookies("Usuario")("USUARIO")
Perfil = Request.Cookies("Usuario")("Perfil")
NIVEL = Request.Cookies("Usuario")("Perfil")
	'Response.Write(txtperfil)
%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<%
POS = Request.QueryString("pos")

' response.end
mad = ""
ofi = Request.QueryString("ofi")
cli = Request.QueryString("cli")
est = Request.QueryString("est")
dim acol(10)

Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 


response.write("doble dbprod")
' del nuevo insert OFI

' ****************************************************************************************'
'     DATOS PARA EL DBPROD
' ****************************************************************************************'
' DEBE GRABAR CABECERA Y DETALLE DE LAS POS
' EL CODIGO DE ARTICULO Y EL ESTILO YA ESTAN ACTUALIZADOS EN EL DBPROD DESDE LA
' CREACION DEL ESTILO

DAD = "SELECT * FROM MODELADOR..VIEW_OFIS_dbprod WHERE OFI = '"&OFI&"' "
RS.OPEN DAD, CNN
IF RS.RECORDCOUNT > 0 THEN
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
END IF
if len(trim(fob)) = 0 or isnull(fob) then fob = 0
RS.CLOSE
rs.open "select estcli from estilos where cliente = '"&cli&"' and codest = '"&est&"'", cnn
DEST = LEFT(RS("estcli"),50)
rs.close
ss =    " select top 1 isnull(t0,'') as t0, isnull(t1,'') as t1, isnull(t2,'') as t2, isnull(t3 ,'') as t3, isnull(t4,'') as t4, isnull( t5,'')as t5," & _
        " isnull( t6,'')as t6, isnull( t7,'')as t7, isnull( t8,'')as t8, isnull( t9,'') as t9 from [po-deta] where po = '"&pos&"'"
rs.open ss,cnn
rs.movefirst
for v = 0 to 9
    if len(trim(rs("t"&v))) > 0 then  atal = atal + rs("t"&v)+ ","
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
    CAD = "SELECT dd.NOMBRE FROM POS SS inner join destinos dd on ss.destino = dd.codigo "
    RS.OPEN CAD,CNN
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
    cad =   " SELECT		pp.po, PP.color ,	PP.UBI, CAN0, CAN1, CAN2,  fob,     " & _
			" CAN3, CAN4, CAN5, CAN6, CAN7, CAN8, CAN9 FROM  [PO-DETA] AS PP        " & _
	        "  where pp.po = '"&pos&"'	ORDER BY PP.PO, UBI    ;                "
    rs.open cad, cnn
    newfob = 0
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
            end if
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
    rs.close

mad =  mad + "update DBPROD..COMCABOP set CO_NPRECIO = "&newfob&" WHERE CO_CCODIGO = '"&OFI&"' "

response.WRITE("<BR>")
response.WRITE(MAD)



'response.end
Cnn.BeginTrans	

Cnn.Execute(mad)
if  err.number <> 0 then
    Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
    Cnn.RollbackTrans
    Cnn.Abort
else
    Cnn.CommitTrans	
end if
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

</HEAD>
<BODY topmargin=0 leftmargin=10 rightmargin=10 border=0 text="#000000" >

<%	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<script language="jscript" type="text/jscript">
alert("OFI creada")
    top.window.location.replace='../fichapos.asp?po=' + '<%=pos %>' + '&cli=' + '<%=cli%>' 
</script>  
</BODY>
</HTML>
