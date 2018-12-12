<%@ Language=VBScript %>
<% Session.LCID = 2058 'Puntos y comas%>
<%  Response.Buffer = true %>
<!--#include file="../includes/rutinas.asp"-->

<%
usr = REQUEST.Cookies("USER")
COD		= TRIM(Request.form("COD"))
DES		= TRIM(Request.form("DES"))
FAM		= TRIM(Request.form("FAM"))
TIPTEL	= TRIM(Request.form("TIPTEL"))
CODTIT	= TRIM(Request.form("CODTIT"))
FINI	= TRIM(Request.FORM("FINI"))
STAT	= TRIM(REQUEST.Form("STAT"))
PC		= TRIM(Request.form("PC"))
CTO		= TRIM(Request.form("CTO"))
IF CTO = "" THEN CTO = 0
FEC		= "GETDATE()"
EDO		= "A"
OBS		= TRIM(Request.form("CONTENIDO"))
DDP		= TRIM(Request.form("DESARROLLO"))
SFAM	= TRIM(Request.form("SFAM"))
%>
<!--#include file="../includes/Cnn.inc"-->
<% cad = ""
'INSERT

IF (TRIM(COD) = "AUTO")	 THEN
        CAD= "SELECT COUNT(*) AS CUENTA FROM CCTELA"
        RS.OPEN CAD, CNN
        IF RS.RECORDCOUNT > 0 THEN
            COD = RIGHT("0000000000" + (CDBL(RS("CUENTA"))+1),10)
        ELSE
            COD = "0000000001"    
        END IF
    	RS.CLOSE
        CAD = " SELECT * FROM TELACOLOR WHERE TELA = '"&TEL&"' AND COLOR='"&COL&"' "
        RS.OPEN CAD, CNN
        IF RS.RECORDCOUNT > 0 THEN
            CAD =   " UPDATE TELACOLOR SET          " & _
                    " FECHA		= "&FEC&",		    " & _
		            " USUARIO	= '"&USR&"',	    " & _
		            " ESTADO	= 'A'	            " & _
		            " WHERE TELA = '"&TEL&"'        " & _
		            " AND COLOR = '"&COL&"';        " & _
		            " AND COMBINACION = '"&COM&"'   "
        ELSE
            CAD = "INSERT INTO TELACOLOR ()"
        END IF
        RS.CLOSE		                 
            
        
CAD = CAD + " insert into CCTELA(  CCT, TELA, PARTIDA, COLOR, CLIENTE,  " & _
			" FECINI, PEDIDO, PESOTOTAL, TOTALROLLOS, OC, PROVEEDOR,    " & _
			" TIPOCCT, PORCENTAJE, VAPLARA, VAPANCA, VAPLARD, VAPANCD,  " & _
			" LAVFALA, LAVFALD, LAVREVA, LAVREVD, VAPLARL, VAPANCL,     " & _
			" LAVFALL, LAVREVL, TONO, MATCHING, DEGRADE, TACTO,         " & _
			" REPROCESO, CALIDAD, CONDICION, ANCHOOBTENIDO, ANCHOVAP,   " & _
			" DENMIN, DENMAX, USUARIO, FECHA, ESTADO, RLLINS) VALUES (  " & _
			"   
			
			
			
			
			
			
			
		cad = cad + " insert into [CCTOBSERVACIONES]		" & _
					" (tela, observacion, COMENTARIO) values	" & _
					" ('"&cod&"', '"&OBS&"', '"&DDP&"');		"		
	'	CAD = CAD + "EXEC RS_AR_I_TELA '"&COD&"', 'N', '"&USR&"'   "			
ELSE
'UPDATE
cad =	cad + " update CCTELA set		" & _
		" FECHA			= "&FEC&",		" & _
		" USUARIO		= '"&USR&"',	" & _
		" ESTADO		= 'A',	        " & _
		" FICHA			= '"&FIC&"'		" & _
		" where CCT = '"&cod&"';		"
	
				
END IF 
rs.open "select * from [tela-obs] where tela = '"&cod&"'",cnn
if rs.recordcount > 0 then
	cad = cad + " update [tela-obs]	 set	" & _
				" observacion = '"&OBS&"',	" & _
				" COMENTARIO = '"&DDP&"'    " & _
				" where tela = '"&cod&"';	"		
else
    cad = cad + " insert into [tela-obs]					" & _
				" (tela, observacion, COMENTARIO) values	" & _
				" ('"&cod&"', '"&OBS&"', '"&DDP&"');		"		
end if	
		
' Inicia transacción , para que los datos no queden a medias
'RESPONSE.WRITE(CAD)
'RESPONSE.END
'*****************************
'		ENVIO DE MENSAJES
'*****************************
cnn.BeginTrans
	'On Error Resume Next
	cnn.Execute(CAD)
	
	If cnn.Errors.Count = 0 Then
		cnn.CommitTrans
		Response.Write(RecargaVentanaMadre())
		Response.Write(cerrar_ventana())
	Else
		cnn.RollbackTrans
		'Muestro el mensaje de que se produjo un error al intentar realizar la operación
		Response.Write(mensaje("Error: No se pudieron grabar los datos, intente mas adelante"))
		Response.Write(NavegaHistory(-1)) ' volvemos al formulario
	End if
	

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing

'RESPONSE.END

Response.Redirect("../fichaCCT.asp?tel="+COD )

%>
