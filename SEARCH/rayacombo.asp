<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	response.Cookies("usuario")("tela")=  Request.QueryString("pos")
	response.Cookies("usuario")("directorio")= "rayas/"%>
<style type="text/css" media="all">
#graba { background:url('imagenes/disk.gif') no-repeat; border:3; width:25px; height:25px; }
</style>	
<script type="text/jscript" language="jscript">
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES idENTITY
var auto=1;
var url = '../RAYACOMBO.asp?'
var alias = 'RAYADOS'
var TBL = 'RAYADOS'
var PK  = 'COLOR'
var DS  = 'DESCRIPCION'
var largo = 8  // es el largo del PK (se usa en el dataentry)
var largo2 = 100  // es el largo del descriptor
var oldrow =1
var olddata =''
var chk = ''
</script>
<%
'****************************************
' Definir el tamaño de la pagina
Dim pagesize 
if nivel = 1 then	pagesize = 10 else pagesize =20
'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "RAYADOS"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "COLOR"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "RAYADOS.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "COLOR"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "DESCRIPCION"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
Dim TITULO
TITULO = "DETALLE DE COMBOS"
%>
<script type="text/jscript" language="jscript">
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
var funcionalidad = 'comun/INSERRAYAS2.asp?'

function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

</head>
<html xmlns="http://www.w3.org/1999/xhtml">
<body>
<form name="thisForm" id="thisForm" method="post" action="RAYAcombo.asp">

<%
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then	pos = ""

des = Request.QueryString("des")
if des = "" or isnull(des)  or des = " " then	des = ""

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT  C1.COLOR,          " & _
        " C1.COMBIN as COM,                          " & _
        " C1.DESCRIPCION  AS DES, " & _
		" c1.FOTO FROM RAYADOS AS C1               	 " & _
		" INNER JOIN COLORES AS C2 ON C2.CODIGO =    " & _
		" C1.COLOR                                   " & _
		" INNER JOIN CLIENTE ON C2.CLIENTE =         " & _
		" CLIENTE.CODIGO	                         " & _
		" WHERE C1.ESTADO = 'A' and (TENIDO = '99')	 " & _
		" AND (TONO = '99')	AND	c1.combin > '00' and "
        if len(TRIM(DES))>0 then
            cad = cad + " "&DS&" >= '"&DES&"' " & _
            "  ORDER BY "& ds &"  " 
        else
            cad = cad+  " C1.COLOR = '"& POS &"'" & _
            " ORDER BY C1.COLOR  " 
        end if
      '  response.write(cad)
%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<!--#include file="COMUN/COMUNRAYAS2.ASP"-->
<%
    RS.Open CAD, Cnn
' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
cont=1
'*********************************************************************%>

<table id="TABLA" align="center" bgcolor="<%=application("borde")%>"  cellpadding="2"  cellspacing="1"  border="0">

<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%LIMITE =  rs.fields.count - 1%>
<%for I=0 to LIMITE %>
	<td align="center" ><font face="arial" color="<%=APPLICATION("COLOR2")%>" size="1"><b><%=TRIM(RS.FIELDS(I).NAME)%></b></font></td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>

<%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >       
		<td width="6%">
   	        <input type="text" id="COD<%=CONT%>" name="COD<%=CONT%>" class="datos" value="<%=rs("color")%>" readonly="readonly" /></td>
	    <td  width="2%">
	        <input type="text" id="COM<%=CONT%>" name="COM<%=CONT%>" class="datos" value="<%=rs("com")%>" readonly="readonly" /></td>
        <td width="80%"><input type="text" id="DES<%=CONT%>" name="DES<%=CONT%>" value="<%=rs("des")%>" class="datos" /></td>
        <td  width="5%" height="20">
        <img src="rayas/<%=trim(rs("foto"))%>" alt="" id="FOT<%=CONT%>" name="FOT<%=CONT%>" style="cursor:pointer;" onclick="Help('subefoto.asp?usr='+pos+'&opp=',516,328,this,'<%=cont%>')"  onmouseover="fMuestra(this.src);" onmouseout="fOculta(this.src);" height="20"/></td>
		<%RS.MOVENEXT%>
		<%CONT = CONT + 1%>
  </tr>
	<%loop%>
<%END IF %>	
 <tr id="fila<%=Trim(Cstr(cont))%>"  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>">            
   	<td  width="6%">
   	    <input type="text" id="COD<%=CONT%>" name="COD<%=CONT%>" class="datos" value="<%=pos%>" readonly="readonly" /></td>
	<td width="2%">
	    <input type="text" id="COM<%=CONT%>" name="COM<%=CONT%>" class="datos" value="<%=right("00"&cont,2)%>" readonly="readonly" /></td>
    <td width="80%"><input type="text" id="DES<%=CONT%>" name="DES<%=CONT%>" class="datos"  /></td>
    <td width="5%" height="20">
    <img src="imagenes/blanco.gif" alt="" id="FOT<%=CONT%>" name="FOT<%=CONT%>" class="datos" style="cursor:pointer;" onclick="Help('subefoto.asp?usr='+pos+'&opp=',516,328,this,'<%=cont%>')"  onmouseover="fMuestra(this.src);" onmouseout="fOculta(this.src);"/></td>
 </tr>
 <tr align="right" bgcolor="<%=application("color2")%>">
    <td colspan="4"><input type="button" id="graba" style="display:none; cursor:pointer" onclick="veri(oldrow)" /></td>
 </tr>
</table>

<div id="nombre" name="nombre" style="LEFT:0px; WIDTH:500px; POSITION:absolute; TOP:0px; HEIGHT:300px;visibility:hidden">
	<img id="img1" height="300"></img>
	</div>
<input id="foton" style="display:none; "/>

<iframe frameborder="1" style="visibility:hidden" height="1" width="1" id="ACTIV" name="ACTIV"></iframe>


<script type="text/jscript" language="jscript">
var help= null
var pos= '<%=pos%>'
var valor
var _obj
var _tb
var _f
var _ci
var _n
rec = parseInt('<%=rs.recordcount%>',10)

if (rec > 0 )
dd2('1');
function Help(pag,h,w,obj,op)
{	obj.src=''
	CierraHelp()
	if(h==null) h=80
	if(w==null) w=400
	document.all.foton.value=''
	var opc = "height=180,width="+w+",channelmode=0,dependent=0,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,scrollbars=1,status=1,toolbar=0"
	opp = Right('00'+ trim(op),2)
	pag += opp 
	help=window.open(pag,'help',opc)
	poto = '<%=pos%>'+opp+'.jpg'
	trim(eval("document.all.FOT"+op+".value=poto"))
	document.all.foton.value=poto
}
function CierraHelp()
{	if (help != null)
	{	help.close()
		help=null
	}
}
function VeFoto(nfoto)
{   //return true
    fot = Left(nfoto,nfoto.indexOf('.'))
    fot = parseInt(Right(fot,2),10)
    eval("document.all.FOT"+fot+".src='RAYAS/'+nfoto")
    CierraHelp()
}
function fMuestra(_x)
{
document.getElementById('nombre').style.top = document.body.scrollTop;
	document.getElementById('nombre').style.visibility= 'visible';
	document.getElementById('img1').src=_x;
}
function fOculta()
{
document.getElementById('nombre').style.visibility= 'hidden';
}
</script>    
<%IF txtPerfil = 1 THEN%>
	<script type="text/jscript" language="jscript"> 
		eval("document.all.graba.style.display='block'"); 
	</script>
<%END IF %>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</body>
</html>
