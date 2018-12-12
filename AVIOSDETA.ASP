<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<link rel="stylesheet" type="text/css" href="estilos1.CSS" />

<script>
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
var auto=0;
var url = '../AVIOSDETA.asp?pos='
var alias = 'AVIOSDETA'
var pre=''
var tipo =''
var oldrow =1
var olddata =''
</script>
<%
'****************************************
' Definir el tamaño de la pagina
'****************************************
	pageSize = 100

'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = "AVIOSDETA"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "CODIGO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "AVIOSDETA.asp"

POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
COL =	" SELECT T1.CODCOL, (T2.DESCRIPCION) AS DESCOL          " & _
        " FROM AVIOSDETA AS T1                                  " & _
        " INNER JOIN CODCOL AS T2 ON T1.CODCOL = T2.CODIGO      " & _
        " WHERE AVIO = '"&POS&"' AND T1.ESTADO ='A'             " & _
        " group by t1.CODCOL,  T2.DESCRIPCION                   " & _
        " ORDER BY 1                                            "

TAL =   " SELECT T1.CODTALLA                   " & _
        " FROM AVIOSDETA AS T1                                  " & _
        " WHERE AVIO = '"&POS&"' AND T1.ESTADO='A'              " & _
        " group by t1.CODTALLA                " & _
        " ORDER BY 1                                            " 
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CURSORLOCATION   = 3
	RS2.CursorType       = 3 
	RS2.LockType         = 1 
%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNhlp2.ASP"-->
<%	RS.Open col, Cnn
    RS2.Open tal, Cnn
	CONT = 1
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count%>
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>  
</head>

<body topmargin="0" leftmargin="0" rightmargin="0" border="0" text="#000000">
<iframe  width="100%" src="" id="actu" name="actu"  scrolling="no" frameborder="0" height="1" align="middle"></iframe>
<form id="thisForm" method="post" name="thisForm" action="">

<%DIM ATAL()%>
<table id="TABLA" align="center" cols="2"  cellpadding="2"  cellspacing="1" bordercolor="<%=application("color2") %>" border="1" >
<tr bgcolor="<%=application("RESALTE") %>">
<td align="center" class="AMERICANwhite" >&nbsp;</td>
<%'******************************%>
<%' MUESTRA LAS TALLAS  DEL AVIO %>
<%IF NOT RS2.EOF THEN
cont=0
RS2.MOVEFIRST
RS2.MOVENEXT
IF  RS2.EOF THEN RS2.MOVEFIRST%>
<%DO WHILE NOT RS2.EOF%>

    <td align="center" class="AMERICANwhite"><img src="imagenes/dele.jpg" border=0 width="15" 
        onclick="dele('','<%=trim(rs2.fields.item(0))%>','<%=cont%>')"
        style=<%if trim(rs2.fields.item(0)) = "" then%> "display:none"<%else %>"cursor:hand;" <%end if %> 
        alt="Elimina TALLA"/>&nbsp;&nbsp;<%=RS2.FIELDS.ITEM(0)%>
        <input id="T<%=cont%>" value="<%=RS2.FIELDS.ITEM(0)%>" style="display:none;" />
        <input id="tal<%=cont%>" value="<%=RS2.FIELDS.ITEM(0)%>" style="display:none" />
    </td>
    <%REDIM PRESERVE ATAL(CONT)
    ATAL(CONT) = RS2.FIELDS.ITEM(0) %>
    <%rs2.movenext%>
    <%cont = cont +1 %>
<%loop %>
<%end if %>
</tr>
<%cont=cont - 1 %>
<%'******************************%>
<%' MUESTRA LOS COLORES DEL AVIO %>
<%IF NOT RS.EOF THEN
RS.MOVEFIRST
RS.MOVENEXT
IF RS.EOF THEN RS.MOVEFIRST
conC=0
DIM ACOL()%>
<%DO WHILE NOT RS.EOF%>
    <tr>
        <td align="left" bgcolor="<%=application("RESALTE")%>" class="AMERICANwhite"><img src="imagenes/dele.jpg" border="0" width="15" 
            onclick="dele('<%=trim(rs.fields.item(0))%>','','<%=conC%>')"
            style="<%if trim(rs.fields.item(1)) = "" then%>display:none<%else%>cursor:hand<%end if %>" 
            alt="Elimina COLOR"/>&nbsp;&nbsp;<%=RS.FIELDS.ITEM(1)%>
            <input id="C<%=CONC%>" value="<%=RS.FIELDS.ITEM(0)%>" style="display:none;" />
            <input id="col<%=conC%>" value="<%=RS.FIELDS.ITEM(1)%>" style="display:none" />
        </td>
       
        <%REDIM PRESERVE ACOL(CONC)
        ACOL(CONC) =RS.FIELDS.ITEM(0)  %>
        <%for i=0 to cont %>
            <td class="texto" ><input id="C<%=CONC%>T<%=i%>" value="<%=POS+ACOL(CONC)+ATAL(I)%>" readonly =readonly class="DESCENTER"/></td>
        <%next %>
     </tr>   
    <%rs.movenext%>
    <%conC = conc +1 %>
<%loop %>
<%end if %>
</tr>
<%conC=conC - 1 %>
</table>
</tr></td>
</table>

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<script language="jscript" type="text/jscript">
function dele(col,tal,dat)
{   if (trim(col)=='')
       cad = 'a Talla = ' +trim(eval("thisForm.tal"+parseInt(dat,10)+".value"))
    if (trim(tal)=='')
       cad = 'e Color = ' + trim(eval("thisForm.col"+parseInt(dat,10)+".value"))
    var si
	{si = confirm("¿ Confirma la Eliminación de est"+cad + " ? ");} 
	if (si == false)
	{ return false;}
    document.all.actu.src='comun/deledetavi.asp?pos='+ '<%=trim(pos)%>' + '&col= ' + col + '&tal=' + tal
}

</script>	
</form>
</BODY>
</HTML>
