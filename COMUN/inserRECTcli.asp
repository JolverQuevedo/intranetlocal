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
CHK		= Request.QueryString("chk")
cli		= TRIM(Request.QueryString("cli"))
TEL		= TRIM(Request.QueryString("TEL"))
COD		= TRIM(Request.QueryString("COD"))
cab		= TRIM(Request.QueryString("Cab"))
fac		= TRIM(Request.QueryString("fac"))
alt		= TRIM(Request.QueryString("alt"))
ADI		= ucase(TRIM(Request.QueryString("aDI")))
pas		= TRIM(Request.QueryString("pas"))
dek		= TRIM(Request.QueryString("dek"))
uni		= TRIM(Request.QueryString("uni"))

response.Write(chk)
FECHA ="{ fn NOW() }"
'	busca el código a actualizar
	CAD =   " SELECT * FROM RECTILINEOS  	" & _
			" WHERE codigo = '"&cod&"'      "
	rs.open cad,cnn
if rs.recordcount <= 0 then 
    insert= true
	rs.close
	cad=    " SELECT *   FROM rectilineos		" 
	rs.open cad,cnn		
	
	cod =rs.recordcount+1
	response.write(cod)	
	cod = right("0000000000"& cod,10)
end if


			
if insert=true then
    CAD =	" insert into rectilineos   (   	" & _
			" codigo, TELA, CLIENTE, FACTOR,	" & _
			" UNIDAD, CABOS, PASADAS, ALTO,		" & _
			"  usuario, fecha, estado, 			" & _
			" descripcion  )					" & _
			" values('"&COD&"', '"&tEl&"',		" & _
			" '"&CLI&"', "&FAC&", '"&uni&"', 	" & _
			"  "&CAB&", "&PAS&", '"&ALT&"',		" & _
			" '"&USUARIO&"', "&fecha&", 'A' ,	" & _
			" '"&adi&"');						" 
else 
	SELECT CASE CHK
			CASE "1"    ' DELETE
				CAD =	" UPDATE rectilineos SET		    " & _
						" USUARIO			= '"&USUARIO&"'," & _
						" FECHA				= "&fecha&" ,	" & _
						" ESTADO			= 'E'			" & _ 
						" WHERE codfigo     = '"&cod&"'     " 
						cod = ""
			CASE ELSE   ' UPDATE
				CAD =	" UPDATE rectilineos set	        " & _
						" DESCRIPCION	   = '"&adi&"',		" & _
	      		        " FACTOR     	   = "&FAC&",	    " & _ 
						" UNIDAD		   = '"&UNI&"',		" & _
						" CABOS			   = "&CAB&",		" & _
						" PASADAS          = "&PAS&",		" & _
						" ALTO             = '"&ALT&"',		" & _
				        " ESTADO		   = 'A',			" & _
				        " USUARIO		   = '"&USUARIO&"', " & _
				        " FECHA			   = "&fecha&"		" & _
				        " WHERE CODIGO	   = '"&COD&"'      " 
			
		END SELECT
end if	
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
'Response.Write(CAD)
'Response.END


Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
'response.end
%>
<script>
CAD = '../RECTILCLI.ASP?pos='+'<%=TRIM(COD)%>'
CAD +='&CLI='+'<%=TRIM(CLI)%>'
CAD += '&TEL='+'<%=TRIM(TEL)%>'
CAD += '&DEK='+ '<%=TRIM(DEK)%>'
window.parent.location.replace(CAD)
</script>
</BODY>
</HTML>
