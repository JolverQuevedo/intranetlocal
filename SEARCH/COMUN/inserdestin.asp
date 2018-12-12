<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->

<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
cli = TRIM(Request.QueryString("cli"))
cod = TRIM(Request.QueryString("cod"))
des = TRIM(Request.QueryString("des"))
dir = TRIM(Request.QueryString("dir"))
zipc = TRIM(Request.QueryString("zipc"))
pais = TRIM(Request.QueryString("pais"))
fecha = "{fn now()}"

'	busca si encuentra un código duplicado
	CAD = "SELECT * FROM destinos WHERE codigo = '"&COD&"'"  	
    
    RS.Open CAD, CNN


IF RS.RecordCount > 0 THEN	
	RS.Close
    if cint(chk) =  0 then
	CAD =	" update destinos set       " & _
            " NOMBRE = '"&DES&"',       " & _
            " DIRECCION = '"&DIR&"',    " & _
	        " ZIPCODE = '"&ZIPC&"',     " & _
            " PAIS = '"&PAIS&"',        " & _
            " USUARIO = '"&USUARIO&"',  " & _
            " FECHA = "&FECHA&",        " & _
            " ESTADO = 'A'              " & _
            " WHERE CODIGO = '"&COD&"'; "  
    else
    CAD =	" update destinos set       " & _
            " USUARIO = '"&USUARIO&"',  " & _
            " FECHA = "&FECHA&",        " & _
            " ESTADO = 'E'              " & _
            " WHERE CODIGO = '"&COD&"'; "  
    end if
else
rs.close
    rs.open "select MAX(CODIGO)  as cc from destinos "	
nume = cDBL(RS("cc"))+1 
    COD = RIGHT("0000"&nume ,4)
    CAD =   " INSERT INTO DESTINOS (CODIGO, " & _
            " NOMBRE, DIRECCION, ZIPCODE,   " & _
            " PAIS, USUARIO, FECHA, ESTADO, " & _
            " cliente)                      " & _
            " VALUES ('"&COD&"', '"&DES&"', " & _
            " '"&DIS&"', '"&ZIPC&"',        " & _
            " '"&PAIS&"', '"&USUARIO&"',    " & _
            " "&FECHA&", 'A', '"&cli&"') ;  "
End if
Response.Write (CAD)
'Response.end
' Inicia transacción , para que los datos no queden a medias
Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	

%>
<script language="jscript" type="text/jscript">

 parent.window.location.replace("../detadestin.asp?cli="+'<%=cli%>'+ '&pos=' + '<%=cod %>')
</script>
</BODY>
</HTML>
