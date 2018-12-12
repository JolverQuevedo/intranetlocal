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
ORD		= TRIM(Request.QueryString("ORD"))
TAL		= TRIM(Request.QueryString("TAL"))
response.Write(chk)

FECHA ="{ fn NOW() }"
'	busca el código a actualizar
	CAD =   " SELECT * FROM CLIENTE_TALLA  	" & _
			" WHERE codCLIENTE = '"&CLI&"' AND (TALLA= '"&TAL&"'   or orden = '"&ord&"'  ) "
	rs.open cad,cnn
    response.write(cad)
    response.write("<br>")
if rs.recordcount <= 0 then 
    insert= true
end if
		    
if insert=true then
    rs.close
    cad=    " SELECT * FROM CLIENTE_TALLA WHERE  codCLIENTE = '"&CLI&"' AND ORDEN= '"&ORD&"'  		" 
    rs.open cad,cnn		
     response.write(cad)
    response.write("<br>")
    if rs.recordcount < 0 then	
        RS.CLOSE
        cad=    " SELECT * FROM CLIENTE_TALLA WHERE  codCLIENTE = '"&CLI&"' " 
        rs.open cad,cnn		
        IF RS.RECORDCOUNT > 0 THEN     ORD = RS.RECORDCOUNT +1 ELSE ORD = 1
        rs.close
    end if	
    CAD =	" insert into CLIENTE_TALLA   (   	" & _
			" CODCLIENTE, TALLA, ORDEN,		    " & _
			"  usuario, fecha, estado  )		" & _
			" values('"&CLI&"', '"&tAl&"',		" & _
			" '"&ORD&"',                        " &_
			" '"&USUARIO&"', "&fecha&", 'A' );	" 
else 

	if cint(CHK) =  1 then
			 ' DELETE
				CAD =	" UPDATE CLIENTE_TALLA SET		    " & _
						" USUARIO			= '"&USUARIO&"'," & _
						" FECHA				= "&fecha&" ,	" & _
						" ESTADO			= 'E'			" & _ 
						" WHERE codCLIENTE = '"&CLI&"' AND ORDEN= '"&ORD&"'  AND TALLA = '"&TAL&"'	     " 
						cod = ""
    ELSE   ' UPDATE
        rs.close    
        rs.open "SELECT * FROM CLIENTE_TALLA WHERE  codCLIENTE = '"&CLI&"' and talla = '"&tal&"'"
        if rs.recordcount > 0 then
				CAD =	" UPDATE CLIENTE_TALLA set	        " & _
						" ORDEN            = '"&ORD&"',		" & _
				        " ESTADO		   = 'A',			" & _
				        " USUARIO		   = '"&USUARIO&"', " & _
				        " FECHA			   = "&fecha&"		" & _
				       " WHERE codCLIENTE = '"&CLI&"' AND TALLA = '"&TAL&"'	     " 
        else
            		CAD =	" UPDATE CLIENTE_TALLA set	        " & _
						" talla            = '"&tal&"',		" & _
				        " ESTADO		   = 'A',			" & _
				        " USUARIO		   = '"&USUARIO&"', " & _
				        " FECHA			   = "&fecha&"		" & _
				       " WHERE codCLIENTE = '"&CLI&"' AND orden = '"&ord&"'	" 
        end if
			
	END if
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
CAD = '../TALLACLI.ASP?POS='+'<%=TRIM(CLI)%>'

//  window.parent.location.replace(CAD)
</script>
</BODY>
</HTML>
