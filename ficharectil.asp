<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<script type="text/jscript" language="jscript">
// SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
// SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES idENTITY
var auto=1;
var url = '../ficharectil.asp?'
var alias = 'rectil_cli_talla'
var TBL = 'rectil_cli_talla'
var PK  = 'CODIgo&orden'
var DS  = 'talla'
var largo = 10  // es el largo del PK (se usa en el dataentry)
var largo2 = 5  // es el largo del descriptor
var oldrow =1
var olddata =''
var chk = ''
</script>
<%
'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "rectil_cli_talla"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "CODigo+orden"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "ficharectil.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "CODIGO+ORDEN"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "ORDEN"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
Dim TITULO
TITULO = "TALLAS DEL CLIENTE : " + REQUEST.QueryString("des") + " --> Spec :  " + REQUEST.QueryString("pos") 
%>
<script type="text/jscript" language="jscript">
// **************************************************************
//  Indicar el nombre de la página donde se realizan los cambios 
// **************************************************************
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}
function redime() {
window.moveTo(100,100)
window.resizeTo(800,500)
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body onload="redime()">
<form name="thisForm" id="thisForm" method="post" action="">


<%
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
des = Request.QueryString("des")
if des = "" or isnull(des)  or des = " " then
	des = ""
end if
CLI = Request.QueryString("CLI")
if CLI = "" or isnull(CLI)  or CLI = " " then
	CLI = ""
end if
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT ORDEN,TALLA,AGUJAS, ANCHO as LARGO  " & _ 
		" from RECTIL_cli_talla WHERE               " & _
        " ESTADO        = 'A' and                   " & _
        " CODIGO    = '"&POS&"'                     " & _
        " ORDER BY ORDEN, TALLA                     " 
		'response.Write(cad)
%>


<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<table width="100%" border="0">
	<tr><td align= "left" width="15%"><img src="imagenes/CERRAR.gif" style="cursor:POINTER;" alt=""	onclick="javascript: window.close();" />
		</td>
		<td align="center" class="TALASROJO"><%=titulo%> </td>
        <td align= "left" width="15%"><img src="imagenes/logo.gif"  alt=""	 />
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>
<%	RS.Open CAD, Cnn
    SINDATOS =1
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST
	ELSE
		RESPONSE.Write("<FONT COLOR=#000000 SIZE=2 FACE='ARIAL'>")
		RESPONSE.Write("<B>")
		RESPONSE.Write("NO HAY TALLAS DEFINIDAS AUN")	
		SINDATOS =0
		'RESPONSE.End()
	END IF	
%>

<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count %>
<%'*********************************************************************%>
<table id="TABLA" align="center"  bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor='<%=Application("Titulo")%>' >
<%	IF NIVEL > 1 THEN LIMITE =  rs.fields.count - 3 ELSE  LIMITE =  rs.fields.count - 1%>
<%for I=0 to LIMITE %>
	<td align="center">
		<font face="arial" color="IVORY" size="1">
		<b><%=RS.FIELDS(I).NAME%></b>
		</font>
	</td>
<%next%>	
</tr>
<%'*****************************%>
<%' MUESTRA EL GRid (2 colorES) %>
<%'*****************************%>
<%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >
	<%for i=0 to LIMITE%>
		<td>
			<font face="Arial, Helvetica, sans-serif" color="MidnightBlue" size="1">
			<b><%=RS.FIELDS.ITEM(I)%></b>&nbsp;
			</font>
		</td>
	  <%NEXT%>	
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
  </tr>
	<%loop%>
</table>

<iframe frameborder="1" style="visibility:hidden" height="1" width="10" id="ACTIV" name="ACTIV"></iframe>
<table	border="0" id="DATAENTRY" style="display:none;" align="center" cellpadding="1" cellspacing="1" bgcolor="<%=application("borde")%>" border="1">
    <tr valign="middle"> 
        <td width="80" bgcolor="<%=(Application("barra"))%>" align= "right">
         <font face="arial" size="1" color="MidnightBlue"><b> 
          # DE ORDEN :</b></font>
         </td>
        <td bgcolor="<%=application("color2") %>" width="50" valign="middle"> 
            <input type="text" id="COD" name="COD" class="DATOSGRANDE" maxlength=3  onblur="isInt(this.value)" readonly/>
        </td>
        <td width="60" bgcolor="<%=(Application("barra"))%>" align="RIGHT"> <font face="arial" size="1" color="#000066"><b> 
          TALLA :</b></font> </td>
        <td bgcolor="#FFFFFF" width="100"> 
              <select id="DES" name="DES"  style="width:100%" >
                <option> </option>
              <%Set   RS2 = Server.CreateObject("ADODB.Recordset")
                RS2.ActiveConnection = Cnn
                RS2.CursorType       = 3 'CONST adOpenStatic = 3
                RS2.LockType         = 1 'CONST adReadOnly = 1  
                cad = "select * from tallas where estado = 'a' order by talla"
                rs2.open cad,cnn
                if rs2.recordcount > 0 then
                    rs2.movefirst%>
                    <%do while not rs2.eof%>
                        <option value="<%=rs2("talla")%>"><%=rs2("talla") %></option>
                        <%rs2.movenext %>
                    <%loop %>
                <%end if %>
              </select>
        </td>
         <td width="80" bgcolor="<%=(Application("barra"))%>" align= "right">
         <font face="arial" size="1" color="MidnightBlue"><b> 
          # DE AGUJAS:</b></font>
         </td>
        <td bgcolor="<%=application("color2") %>" width="50" valign="middle"> 
            <input type="text" id="AGU" name="AGU" class="DATOSGRANDE" maxlength=3  onblur="isInt(this.value)" />
        </td>
         <td width="80" bgcolor="<%=(Application("barra"))%>" align= "right">
         <font face="arial" size="1" color="MidnightBlue"><b> 
          LARGO :</b></font>
         </td>
        <td bgcolor="<%=application("color2") %>" width="50" valign="middle"> 
            <input type="text" id="ANC" name="ANC" class="DATOSGRANDE" maxlength=10  />
        </td>
    </tr>
    <tr>
        <td colspan="8" bgcolor="<%=application("color2") %>">
            <table border="0" align="center"  cellspacing="3">
            <tr>
                <td><img src="imagenes/NEW.gif" alt="REGISTRO EN BLANCO" onClick="NUEVO()" style="cursor:hand;"></td>
                <td><img src="imagenes/DISK.gif" alt="GRABAR" onClick="GRABAR()" style="cursor:hand;"></td>		
                <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="DELE()" style="cursor:hand;"></td>		
            </tr>
            </table>
        </td>
    </tr>
</table>

<script type="text/jscript" language="jscript"> 
function dd(ff) 
{	var pos = parseInt(ff,10)
    var t = document.all.TABLA;
    if ((oldrow%2) ==0)
	    eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
    else
	    eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
    // PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
    eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
	thisForm.COD.value = ltrim(t.rows(pos).cells(0).innerText );
	var subcadena =  trim(t.rows(pos).cells(1).innerText) ;
	var elemento = thisForm.DES;
	thisForm.DES.selectedIndex = seleindice(subcadena,elemento); 
    thisForm.AGU.value = trim(t.rows(pos).cells(2).innerText) ;
    thisForm.ANC.value = ltrim(t.rows(pos).cells(3).innerText) ;

    oldrow=pos;
    return true;
}
function NUEVO() {
chk="0"
	thisForm.COD.value = '<%=RS.RECORDCOUNT + 1%>';
	thisForm.DES.selectedIndex = -1;
    thisForm.AGU.value = ''
    thisForm.ANC.value = ''
	thisForm.DES.focus();
}    
function GRABAR(opc) 
{   if (trim(document.all.COD.value)=='')
    {   alert("Debe Ingresar un número de Orden")
        document.all.COD.focus()
        return false;
    }
    if (document.all.DES.selectedIndex<0)
    {   alert("Debe seleccionar una talla")
        document.all.DES.focus();
        return false;
    }
    document.all.AGU.value = toInt(document.all.AGU.value)
     if (trim(document.all.AGU.value)=='')
    {   alert("Debe Ingresar el número de Agujas")
        document.all.AGU.focus()
        return false;
    }
    
    document.all.ANC.value = toAlpha(document.all.ANC.value)    
     if (trim(document.all.ANC.value)=='')
    {   alert("Debe Ingresar el Ancho del Rectilineo")
        document.all.ANC.focus()
        return false;
    }
    POS = trim('<%=pos%>')
    cod = trim(document.all.COD.value);
    des = document.all.DES.value;
/*   document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
    */
   cad  = 'comun/inserFICHAREC.asp?cOD='+POS+'&ord='+cod+'&tal='+document.all.DES.value
   cad += '&agu=' + trim(document.all.AGU.value)
   cad += '&anc=' + ltrim(document.all.ANC.value)
   cad += '&chk='+chk
   document.all.ACTIV.src= cad
}

function DELE()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	cli = trim('<%=pos%>')
    cod = trim(document.all.COD.value);
    des = document.all.DES.value;
  /*  document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
	*/
    cad = 'comun/inserFICHAREC.asp?cOD='+cli+'&ord='+cod+'&tal='+document.all.DES.value
    cad += '&chk=1'
    document.all.ACTIV.src= cad
    return true;
}
rec = parseInt('<%=rs.recordcount%>',10)
if (rec > 0 )
dd2('1');
</script>    

<%IF txtPerfil = 1 THEN%>
	<script type="text/jscript" language="jscript"> 
		eval("DATAENTRY.style.display='block'");
		thisForm.COD.maxLength=largo
		if (rec <= 0)
		{  NUEVO()
		    SS = trim('<%=SINDATOS%>')
		    if (SS == "1")
		    {thisForm.kod.maxLength=largo
		    }
		}    
	</script>
<%END IF %>


<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</body>
</html>
