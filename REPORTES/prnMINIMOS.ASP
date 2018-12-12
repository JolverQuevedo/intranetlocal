 <%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	usr     = Request.Cookies("multi")("USR")
	nombre  = Request.Cookies("multi")("usrname")
	cia     = Request.Cookies("multi")("cia") 
    cianame = Request.Cookies("multi")("cianame")%>
<link href="../estilos1.css" rel="stylesheet" type="text/css">
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->

<%'****************************************************
xls = request.QueryString("xls")
if xls = "E" then 
    archivo = "MINIMOS_excel.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
end if
'****************************************************

ALM= request.QueryString("ALM")
MES= request.QueryString("MES")
xls = request.QueryString("xls")
'response.write(gui)



 cad =  " exec S_RS_FT_S_REP_StockMinimos '"&ALM&"' , "&MES&" " 

 'response.Write(cad)
    rs.open cad,cnn
	CONT = 1
'response.end    
    'RESPONSE.WRITE(RS.RECORDCOUNT)

	IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = RS.Fields.Count%>

<script language="jscript" type="text/jscript">
    oldrow = 1
function llena(t, pos) {
    return true
}

</script>
<title>Detalle OC <%=oc%></title>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<form name="thisForm" METHOD="post" ><HTML>
<head>
<meta NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body style="margin-top:0; margin-left:0; margin-right:0;" >
<%'*********************************************************************%>
        <table id="TABLA" align="center"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" >
        <%'**************************%>
        <%'LINEA DE CABECERA STANDAR %>
        <%'**************************%>
        <%LIMITE =  RS.fields.count - 1	%>
        <tr bgcolor=#006699 >
            <%for I=0 to LIMITE %>
	            <td align="center" style="FONT-SIZE:10px;COLOR: white;FONT-FAMILY: Arial;"><%=RS.FIELDS(I).NAME%></td>
            <%next%>	
        </tr>
        <%IF  RS.EOF THEN response.end%>
        <%DO WHILE NOT RS.EOF%>
	        <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"    >
	            <%FOR i=0 TO 1%>
		            <td   style="FONT-SIZE: 10px;COLOR: black;FONT-FAMILY: Arial;"><%=trim(UCASE(RS.FIELDS.ITEM(I)))%>&nbsp;</td>
	            <%NEXT%>
                <%FOR I= 2 TO LIMITE%>
		            <td  style="FONT-SIZE: 106px;COLOR: black;FONT-FAMILY: Arial;text-align:right; padding-right:5px;"><%=FORMATNUMBER(CDBL(RS.FIELDS.ITEM(I)),0,,TRUE)%></td>
	            <%NEXT%>
                 
	        </tr>
	        <%RS.MOVENEXT%>
	        <%CONT = CONT + 1%>
	        <%LOOP%>
        </table>

    </td>
</tr>
</table>

</form>

</BODY>
</HTML>
