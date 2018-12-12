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
COD		= TRIM(Request.QueryString("COD"))
FAM		= TRIM(Request.QueryString("FAM"))
DES		= ucase(TRIM(Request.QueryString("DES")))
URL		= TRIM(Request.QueryString("URL"))

FECHA ="{ fn NOW() }"
'******************************************************
'	 busca si encuentra un código duplicado
'    OJO: VER FAMILIA Y DESCRIPTOR DE SUBFAMILIA
'******************************************************
	CAD =   " SELECT descripcion FROM subFAMilias " & _
			" WHERE  famtela = '"&COD&"' and descripcion = '"&des&"'"
	rs.open cad,cnn
	if rs.recordcount > 0 and chk = "0" then
		rs.movefirst
		cod= rs.fields.item(0)
		response.Write(cad)%>
		<script type="text/jscript" language="jscript">
        top.window.alert("Descriptor de Sub-Familia DUPLICADO")
        cad = trim('<%=url%>')+ 'perfil=1&pos='+ '<%=trim(cod)%>'
        top.window.location.replace(cad)
        </script>
		<%response.End
	end if
	rs.close
	'response.End
	
	
CAD = " SELECT FAMTELA FROM SUBFAMILIAS WHERE FAMTELA ='"&FAM&"' AND SUBFAM='"&COD&"'"
'response.Write(cad)

rs.open cad,cnn
'response.Write(rs.recordcount)
'response.end
TOTALREG = rs.recordcount
RS.CLOSE
IF TOTALREG>0 THEN	
	if chk = "" then
		CAD =	" UPDATE  SUBFAMILIAS set       " & _
				" DESCRIPCION = '"&DES&"',      " & _ 
				" ESTADO = 'A',                 " & _
				" USUARIO = '"&USUARIO&"',      " & _
				" FECHA = "&fecha&"             " & _
				" WHERE   FAMTELA = '"&FAM&"'	" & _
				" AND SUBFAM= '"&COD&"';   		"
	elseIF CHK="1" THEN
		CAD =	" UPDATE SUBFAMILIAS               " & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" ,           " & _
				" ESTADO = 'E'	                " & _ 
				" WHERE   FAMTELA = '"&FAM&"'	" & _
				" AND SUBFAM= '"&COD&"';   		"
				cod=""
	end if	
else
    if 	trim(cod) = "AUTO" then
		CAD = "select count(*) AS NN from SUBFAMILIAS WHERE FAMTELA='"&FAM&"' "
		RESPONSE.WRITE(CAD)
        rs.open CAD, cnn
		xx="00"
        if rs.recordcount > 0  then
            cod = xx + trim(cstr(CINT(rs("NN"))+1))    
            cod = right(cod,2)
        ELSE
            cod = xx
        end if    
    end if        

	CAD = 	" insert into SUBFAMILIAS (FAMTELA,	" & _
			" SUBFAM, DESCRIPCION, ESTADO, 	   	" & _
			" usuario, fecha )       			" & _
			" values('"&FAM&"', '" & COD & "',  " & _
			"  '"&DES&"', 'A', 					" & _
			" '"&USUARIO&"', "&fecha&" )  		" 
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
'Response.Write(CAD)
'Response.END


Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
URL =  URL & "POS=" & FAM+COD
%>
<script>
window.parent.location.replace('<%=url%>')
</script>
</BODY>
</HTML>
