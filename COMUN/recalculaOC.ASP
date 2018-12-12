<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<%'=request.QueryString()%>
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
CAM =   trim(REQUEST.QUERYSTRING("CAM"))
'response.write(CAM)
'response.Write("<br>")
'response.write("cam")
'response.Write("<br>")
OC =    TRIM(REQUEST.QUERYSTRING("OC"))

   cad = " Select  sum(ss.oc_npreun2*ss.oc_ncanord) as bruto,   " & _
         " TOTmn = sum(ss.oc_ntotmn), TOTus = sum(ss.oc_ntotus) " & _
	     " From RSFACCAR..CO0001MOVd ss                         " & _
         " inner join RSFACCAR..CO0001MOVC aa on                " & _
         " ss.oc_cnumord = aa.oc_cnumord                        " & _
	     " Where ss.OC_CNUMORD = '"&OC&"'                       "
 
 RS.OPEN CAD, CNN
 IF RS.RECORDCOUNT <= 0 THEN RESPONSE.END

 RS.MOVEFIRST
us = cdbl(rs("totUS"))
MN = cdbl(rs("totmn"))
 CAD =  " UPDATE  RSFACCAR..CO0001MOVc set OC_NIMPMN = "&mn&",  " & _
        " oc_nimpUS = "&us&" where OC_CNUMORD = '"&OC&"'        "



' Inicia transacción , para que los datos no queden a medias
'RESPONSE.WRITE("<br>")
RESPONSE.WRITE(CAD)
'RESPONSE.END
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
%>
</BODY>
</HTML>
