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
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
CHK     = Request.QueryString("chk")
COD     = TRIM(Request.QueryString("pos"))
DES		= TRIM(Request.QueryString("DES"))
cli		= TRIM(Request.QueryString("CLI"))
FECHA   = "{ fn NOW() }"
'	busca si encuentra un código duplicado
	CAD =	" SELECT  *     			" & _
		    " from temporadas where 	" & _
		    " cliente = '"&Cli&"'AND    " & _
		    " DESCRIPCION = '"&DES&"'   "
rs.open cad,cnn	
response.write(cod)	    
if trim(cod) = "" or cod = "AUT" then 
    insert= true
    rs.close
    cad=    " sELECT MAX(CODIGO)AS XX FROM TEMPORADAS	" & _
		    " WHERE cliente = '"&cli&"' and codigo <> '999'  " 
    response.Write("<br>")
    response.Write(cad)
    rs.open cad,cnn	
    if rs.recordcount > 0 then	
        COD=RIGHT("000" + cstr(CINT(rs("xx"))+1),3)
     rs.close
    ELSE
        COD = "001"    
    end if			    
end if
	    
if Insert=true then		    
	CAD =	" insert into temporadas                   	" & _
			" (cliente, CODIGO, DESCRIPCION,		    " & _
			" usuario, fecha, estado )	        	    " & _
			" values('"&CLI&"','"&COD&"', '" & DES & "'," & _
			" '"&USUARIO&"', "&fecha&", 'A' )			" 
		    
else
	SELECT CASE CHK
			CASE "1"    ' delete
				CAD =	" UPDATE  temporadas set        " & _
				        " ESTADO = 'E',                 " & _
				        " USUARIO = '"&USUARIO&"',      " & _
				        " FECHA = "&fecha&"             " & _
				        " WHERE CLIENTE = '"&CLI&"' and " & _
				        " descripcion = '"&des&"'       "
			CASE "0"    'UPDATE
				CAD =	" UPDATE  temporadas set        " & _
				        " ESTADO = 'A',                 " & _
				        " DESCRIPCION = '"&DES&"',      " & _
				        " USUARIO = '"&USUARIO&"',      " & _
				        " FECHA = "&fecha&"             " & _
				        " WHERE CLIENTE = '"&CLI&"' and " & _
				        " descripcion = '"&des&"'       "
				
		END SELECT
End if
' Inicia transacción , para que los datos no queden a medias
response.write(cad)
'response.end
Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
'Response.END


Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	

%>
<script>
CAD = '../DETATEMPORADAS.ASP?pos='+'<%=TRIM(CLI)%>'
window.parent.location.replace(CAD)
</script>
</script>	
</BODY>
</HTML>
