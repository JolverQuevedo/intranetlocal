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
var url = '../tallacli.asp?'
var alias = 'CLIENTE_TALLA'
var TBL = 'CLIENTE_TALLA'
var PK  = 'CODCLIENTE+TALLA'
var DS  = 'ORDEN'
var largo = 10  // es el largo del PK (se usa en el dataentry)
var largo2 = 3  // es el largo del descriptor
var oldrow =1
var olddata =''
var chk = ''
</script>
<%' indicar el submenu desde donde es llamado
submenu = "SUBMENU.ASP?TIPO=1"
'****************************************
' Definir el tamaño de la pagina
Dim pagesize 
if nivel = 1 then	pagesize = 10 else pagesize =20
'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "CLIENTE_TALLA"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "CODCLIENTE+TALLA"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "TALLACLI.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "CODCLIENTE+TALLA"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "ORDEN"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
Dim TITULO
TITULO = "TALLAS DEL CLIENTE : " + REQUEST.QueryString("des")
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
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body style=" margin-top:0px;">
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
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT                          " & _
		" ORDEN, TALLA                  " & _ 
		" from cliente_talla WHERE      " & _
        " ESTADO        = 'A' and       " & _
        " codcliente    = '"&POS&"'     " & _
        " ORDER BY ORDEN, TALLA         " 
		'response.Write(cad)
%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%	RS.Open CAD, Cnn
    SINDATOS =1
	CONT = 1
	IF  RS.RECORDCOUNT > 0 THEN 	
		RS.MOVEFIRST
	ELSE
		RESPONSE.Write("<FONT COLOR=#000000 SIZE=2 FACE='ARIAL'>")
		RESPONSE.Write("<B>")
		RESPONSE.Write("NO HAY TALLAS DEFINIDAS PARA ESTE CLIENTE")	
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
            <input type="text" id="COD" name="COD" class="DATOSGRANDE" maxlength=3  onblur="isInt(this.value)" />
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
                cad = "select * from tallas where estado = 'A' order by talla"
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
    </tr>
    <tr>
        <td colspan="4" bgcolor="<%=application("color2") %>">
            <table border="0" align="center"  cellspacing="3">
            <tr>
                <td><img src="imagenes/NEW.gif" alt="REGISTRO EN BLANCO" onClick="NUEVO()" style="cursor:pointer;"></td>
                <td><img src="imagenes/DISK.gif" alt="GRABAR" onClick="GRABAR()" style="cursor:pointer;"></td>		
                <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="DELE()" style="cursor:pointer;"></td>		
                <td><img src="imagenes/print.gif" alt="imprimir" onClick="prn()" style="cursor:pointer;"></td>		
            </tr>
            </table>
        </td>
    </tr>
</table>

<script type="text/jscript" language="jscript"> 
var ckh 
chk = "2"
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
    oldrow=pos;
    return true;
}
function NUEVO() {
chk="0"
	thisForm.COD.value = '';
	thisForm.DES.selectedIndex = -1;
	thisForm.COD.focus();
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
    cli = trim('<%=pos%>')
    cod = trim(document.all.COD.value);
    des = document.all.DES.value;
 /*   document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
*/ 
   cad = 'comun/insertalcli.asp?cli='+cli+'&ord='+cod+'&tal='+des
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
    cad = 'comun/insertalcli.asp?cli='+cli+'&ord='+cod+'&tal='+des
    cad += '&chk=1'
    document.all.ACTIV.src= cad
    return true;
}
function prn()
{
window.open('reportes/PRNtalla_cli.asp?cli='+'<%=pos%>')
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
