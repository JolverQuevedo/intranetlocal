<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="HITEPIMA.CSS" >
<html>
<head>
    <title>Untitled Page</title>
</head>
<body topmargin="0" leftmargin="0" rightmargin="0">
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<form name="thisForm" method="post" action="">

<%
 POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = "0"
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
tbl = (Application("owner"))+"."+ "submenu"
CAD =	" SELECT MENU, subMENU as OPC, PROGRAMA ,  " & _
        " DESCRIPCION AS TITULO, ESTADO AS EDO     " & _
		" FROM "&tbl&"  WHERE menu = '"&pos&"'     " & _
		" ORDER BY TITULO       " 
rs.open cad,cnn
'RESPONSE.WRITE(CAD)
if rs.recordcount > 0 then rs.movefirst
cont=1
'*********************************************************************%>
<table id="TABLA" align="CENTER"  width="100%" cellpadding="2"  cellspacing="0"
	  bordercolor="White" bgcolor="lightgrey" border="1">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="<%=application("head")%>" >
<%for I=1 to rs.fields.count-1 %>
	<td align="center"><span  class="titulitowhite"><%=RS.FIELDS(I).NAME%></span> </td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%DO WHILE NOT RS.EOF%>
	<tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			onclick="dd('<%=(cont)%>');"  id="fila<%=Trim(Cstr(cont))%>" onDblClick="parametros('<%=cont%>')" >
    	<TD WIDTH="5%"><INPUT id="COLA<%=CONT%>" VALUE='<%=TRIM(ucase(RS.FIELDS.ITEM(1)))%>' 
    	CLASS= "textocenter" readonly tabindex=-1 ></TD>
    	<TD><INPUT id="COLB<%=CONT%>" VALUE='<%=TRIM(ucase(RS.FIELDS.ITEM(2)))%>' 
    	onchange="CAMBIA(this,'<%=cont %>')" CLASS= "DATOS" maxlength="100"></TD>
    	<TD><INPUT id="COLC<%=CONT%>" VALUE='<%=TRIM(ucase(RS.FIELDS.ITEM(3)))%>' 
    	onchange="CAMBIA(this,'<%=cont %>')" CLASS= "DATOS" maxlength="100"></TD>
    	<TD WIDTH="5%">
    	<select id="COLD<%=CONT%>" CLASS= "DATOS" onChange="CAMBIA(this,'<%=cont %>')" >
    	    <option value = "A" <%IF TRIM(ucase(RS.FIELDS.ITEM(4)))= "A" THEN %> SELECTED <%END IF%>>A</option>
    	    <option value = "E" <%IF TRIM(ucase(RS.FIELDS.ITEM(4)))= "E" THEN %> SELECTED <%END IF%>>E</option>
    	</select></TD>
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
    </TD>
  </tr>
  <tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			onclick="dd('<%=(cont)%>'); habilita('<%=(cont)%>')"  id="fila<%=Trim(Cstr(cont))%>">
    	<TD><INPUT id="COLA<%=CONT%>" VALUE='AUTO' CLASS= amegreen type=button
    	onmouseover= "this.style.backgroundColor ='#EAD0FB'"
    	onmouseout= "this.style.backgroundColor ='#99CC66'" style="display:none"
    	onclick="INSER(this,'<%=cont %>')" ></TD>
    	<TD><INPUT id="COLB<%=CONT%>" VALUE='' CLASS="DATOS"></TD>
    	<TD><INPUT id="COLC<%=CONT%>" VALUE='' CLASS="DATOS"></TD>
    	<TD><select id="COLD<%=CONT%>" CLASS= "DATOS" onChange="CAMBIA(this,'<%=cont %>')" >
    	    <option value = "A" >A</option>
    	    <option value = "E" >E</option>
    	</select></TD>
	</tr>
	<%tope = cont%>
</TABLE>

</form>
<IFRAME FRAMEBORDER=1 SRC='' ID=graba style="display:none"> </IFRAME>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<script>

var oldrow=1
dd('1')
function habilita(opc)
{	eval("thisForm.COLA"+opc+".style.display='block'")	
}
function CAMBIA(obj, opc)
{   Obj = obj.id.substr(0,4)
	menu = '<%=trim(pos)%>'
    submenu = eval("thisForm.COLA"+opc+".value")
    EDO= eval("thisForm.COLD"+opc+".value")
    dato = obj.value
    if(submenu == 'AUTO')
    { //cambia de funcion  antes de insertar la nueva LINEA
    alert()
		return true;
    }
    switch (Obj)
    { case  "COLB":
        columna = 'PROGRAMA'
        break;
      case "COLC":
		columna = 'DESCRIPCION'
        break;
      case "COLD":
		columna = 'ESTADO'
        break  ;
    }
    CAD  = 'COMUN/INSERSUBMENU.ASP?menu='+menu
    CAD += '&submenu=' + submenu
    CAD += '&columna=' + columna
    CAD += '&dato=' + dato
    document.all.graba.src= CAD
}
function INSER(obj,opc)
{	menu = '<%=trim(pos)%>'
	pro = eval("thisForm.COLB"+opc+".value")
    des = eval("thisForm.COLC"+opc+".value")
    edo = eval("thisForm.COLD"+opc+".value")
    CAD  = 'COMUN/INSERSUBMENU.ASP?menu='+menu
    CAD += '&opc=1'
    CAD += '&pro=' + pro
    CAD += '&des=' + des
    CAD += '&edo=' + edo
    document.all.graba.src= CAD
}
function dd(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.TABLA;
	var pos = parseInt(ff)
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
	oldrow=pos
	return true;

}
function parametros(opc){
menu= '<%=trim(pos)%>'
subm = eval("thisForm.COLA"+opc+".value")
var opc = "directories=no,height=500," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=no," ;
	opc = opc + "left=0,top=0,scrollbars=yes," ;
	opc = opc + "status=no,titlebar=no,toolbar=no," ;
	opc = opc + "width=600";
window.open('subparam.asp?menu='+menu+'&subm='+subm,"",opc)
}
</script>
</body>
</html>
