<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%Response.Write("<center>")
Response.Write("<font color=red size=5 face=arial>")
Response.Write("<br><br>")
Response.Write("<br><br>")
Response.Write("<br><b>")
Response.Write("GRABANDO Y VERIFICANDO DATOS")
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
TEL			= TRIM(Request.Form("TELA"))
OPC			= TRIM(Request.Form("OPC"))
FECHA		= "{ fn NOW() }"
' BORRA DATOS ANTRERIORES DE LA FICHA TEJE DETALLE
Bad = "delete FROM FICHATEJELIGA  WHERE TELA = '"&TEL&"'"
'*************************************************************
' INSERT, siempre!!!!!, primero se borra y 
' luego se insertan las puntadas de plato y cilindro
'*************************************************************
'       CAPTURA LAS IMAGENES DEL DISEÑO DE LA LIGADURA
'*************************************************************

dim aUbi(36,12)		' LETRA + NUMERO
dim aCod(36,12)		' VALUE DE: "PL"+LETRA+NUMERO
LETAS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
' columnas, filas	
for k =  0 to 35 'COLUMNAS
	for i=0 to 11	'FILAS
		A = Request.Form("LP"&(mid(letas,I+1,1))&(K+1)) 'COD
		B = (mid(letas,I+1,1))&(K+1)	'UBI
		aUbi(k,i)= B
		aCod(k,i)= A
	next
next
'for k =  0 to 35 'COLUMNAS
'	for i=0 to 11	'FILAS
'	Response.Write(aUbi(K,I))
'	Response.Write(" - ")
'	Response.Write(aCod(K,I))
'	Response.Write("<br>")
'	NEXT
'next
'Response.end
' INSERT PARA DATOS DE LIGADURA
for k =  0 to 35 'COLUMNAS
	for i=0 to 11	'FILAS
		if aCod(k,i) <> "0" then
		bad = bad + " INSERT INTO FICHATEJELIGA 					" & _
					" (TELA, UBI, LIGADURA,							" & _
					"  USUARIO, FECHA, ESTADO )  VALUES				" & _  
					" ('"&tel&"','"&aUbi(k,i)&"','"&aCod(k,i)&"',	" & _
					"  '"&USUARIO&"', "&fecha&", 'A');				" 
		END IF			
	next
next
FOTO = REQUEST.Form("foton")
BAD = bad + "UPDATE TELAS SET FOTO=left('"&FOTO&"',10), OPCION='"&OPC&"' WHERE TELA ='"&TEL&"' "
    
'Response.Write(BAD)
'Response.END



CNN.BEGINTRANS
CNN.EXECUTE (BAD)

if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos solicitados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if
'Response.Write(bAD)
'Response.END		
Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
%>
<script>
tel ='<%=trim(tel)%>'
window.location.replace('../fichaligadura.asp?tel='+tel)
</script>
</BODY>
</HTML>
