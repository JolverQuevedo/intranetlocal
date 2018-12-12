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
CHK = Request.QueryString("chk")
COD = TRIM(Request.QueryString("COD"))
t0	= trim(Request.QueryString("t0"))
t1	= trim(Request.QueryString("t1"))
t2	= trim(Request.QueryString("t2"))
t3	= trim(Request.QueryString("t3"))
t4	= trim(Request.QueryString("t4"))
t5	= trim(Request.QueryString("t5"))
t6	= trim(Request.QueryString("t6"))
t7	= trim(Request.QueryString("t7"))
t8	= trim(Request.QueryString("t8"))
t9	= trim(Request.QueryString("t9"))
URL = TRIM(Request.QueryString("URL"))
FECHA ="{ fn NOW() }"
'	busca si encuentra un código duplicado
	CAD =   " SELECT PROPORCION FROM PROPORCIONES " & _
			" WHERE  PROPORCION = '"&COD&"' "
	
	RS.Open CAD, CNN

IF RS.RecordCount > 0 THEN	
	RS.Close
	if chk = "" then
		CAD =	" UPDATE  PROPORCIONES set " & _
				" PROP0 = '"&T0&"',  " & _
				" PROP1 = '"&T1&"',  " & _  
				" PROP2 = '"&T2&"',  " & _ 
				" PROP3 = '"&T3&"',  " & _
				" PROP4 = '"&T4&"',  " & _ 
				" PROP5 = '"&T5&"',  " & _ 
				" PROP6 = '"&T6&"',  " & _ 
				" PROP7 = '"&T7&"',  " & _  
				" PROP8 = '"&T8&"',  " & _ 
				" PROP9 = '"&T9&"',  " & _ 
				" ESTADO = 'A',  " & _
				" USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&"  " & _
				" WHERE  PROPORCION = '"&COD&"';"
	else
		CAD =	" UPDATE PROPORCIONES " & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" , " & _
				" ESTADO = 'E'	" & _ 
				" WHERE PROPORCIONES = '"&COD&"' ;"
	end if		
		
else

	CAD =   " SELECT PROPORCION FROM PROPORCIONES " & _
			" order by  PROPORCION desc ;"
	RS.CLOSE
	RS.Open CAD, CNN	
	if RS.RecordCount > 0 THEN	
		codigo = cint(rs("PROPORCION"))+1
		codigo = right("000" + TRIM(codigo),3)
	ELSE
		CODIGO = "000"
	END IF 	
	cod = right("000" + TRIM(codigo),3)
	
	CAD =	" insert into PROPORCIONES  " & _
				" (PROPORCION, PROP0, PROP1,  PROP2, PROP3, " & _
				" PROP4, PROP5, PROP6, PROP7, PROP8, PROP9," & _
				" ESTADO," & _
				" usuario, fecha )" & _
				" values('"&COD&"','"&t0&"', '" & t1 & "', '" & t2 & "'," & _
				" '"&t3&"','"&t4&"','"&t5&"','"&t6&"','"&t7&"', " & _
				" '"&t8&"','"&t9&"','A', '"&USUARIO&"', "&fecha&" ) ; " 
				
	URL = "../PROPORCIONES.asp?pos="&cod
End if
Response.Write(CAD)
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
'regresa a la página de donde fué llamado, para que vea que agregó el registro
'RESPONSE.WRITE(URL)
'RESPONSE.END
'Response.Write(url+cod)
'Response.End
'Response.Redirect("PROPORCIONES.asp?pos="+COD )
RESPONSE.Redirect(URL)
%>
</BODY>
</HTML>
