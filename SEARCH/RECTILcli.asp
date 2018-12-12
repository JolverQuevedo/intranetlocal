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
var url = '../RECTILcli.asp?'
var alias = 'VIEW_RECTILINEOS_HEAD'
var TBL = 'RECTILINEOS'
var PK  = 'CODIGO+TELA'
var DS  = 'CLIENTE'
var largo = 10  // es el largo del PK (se usa en el dataentry)
var largo2 = 5  // es el largo del descriptor
var oldrow =1
var olddata =''
var chk = ''
</script>
<%'****************************************
' Definir el tamaño de la pagina
Dim pagesize 
if nivel = 1 then	pagesize = 10 else pagesize =20
'****************************************
' Definir el NOMBRE de la Tabla base
Dim ALIAS
alias = "VIEW_RECTILINEOS_HEAD"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
Dim indice
indice = "CODIGO&TELA"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
Dim urlBase
urlBase = "RECTILCLI.asp"
'*********************************************
' Definir el nombre del Primary Key
Dim pk
pk = "CODIGO&TELA&CLIENTE"
'*********************************************
' Definir nombre de la columna descriptor
Dim ds
ds = "ORDEN"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
Dim TITULO

POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then	pos = ""

cli = Request.QueryString("cli")
if cli = "" or isnull(cli)  or cli = " " then	cli = ""

tel = Request.QueryString("tel")
if tel = "" or isnull(tel )  or tel = " " then	tel = ""

dek = Request.QueryString("dek")
if dek = "" or isnull(dek)  or dek = " " then	dek = ""

TITULO = "Artículo: " + tel + " --> Rectilineos para CLIENTE : " + cli + " " + REQUEST.QueryString("des") 

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
<body>
<form name="thisForm" id="thisForm" method="post" action="">

<table width="100%" border="0">
	<tr>
		<td align="center" class="TALASROJO"><%=titulo%></td>
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>
<%


'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT *                  	" & _ 
		" from VIEW_RECTILINEOS_HEAD	" & _
		" WHERE      					" & _
        " ESTADO        = 'A' and       " & _
        " codcli       = '"&cli&"'      " & _
		" AND TEL      = '"&TEL&"'		" & _
        " ORDER BY 1			        " 
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
		RESPONSE.Write("NO HAY RECTILINEOS DEFINIDOS PARA ESTE CLIENTE")	
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
<%	 LIMITE =  rs.fields.count - 6 %>
<%for I=0 to LIMITE %>
	<td<%IF I=2 THEN %> style="display:none" <%END IF %> salign="center">
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
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" ondblclick="detalle()">
	<%for i=0 to LIMITE%>
		<td<%IF I=2 THEN %> style="display:none" <%END IF %>>
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
<table id="DATAENTRY" align="center"  width="100%" bordercolor="<%=APPLICATION("COLOR2")%>" 	  bgcolor="<%=APPLICATION("BORDE")%>" cellpadding="2"  cellspacing="1"  border="0" >
    <tr valign="middle"> 
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align= "right" class="TEXTOAZULPOS">CODIGO :</td>
        <td width="5%" bgcolor="<%=application("color2") %>" valign="middle"> <input type="text" id="COD" name="COD" class="BARRAS" readonly tabindex="-1" /></td>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT" class="TEXTOAZULPOS">  TELA :</td>
        <td width="5%" bgcolor="#FFFFFF">  <input id="TEL" class="barras" readonly tabindex="-1" ></td>
        <td width="80%" bgcolor="#FFFFFF" colspan="6"> <input id="DES" class="barras" readonly tabindex="-1" ></td>
    </tr>
    <tr valign="middle"> 
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align= "right" class="TEXTOAZULPOS">DESCRIPCION :</td>
        <td width="5%" bgcolor="<%=application("color2") %>" valign="middle" colspan="9"> <input type="text" id="ADI" name="ADI" class="DATOSGRANDE" maxlength="150"/></td>
    
    <tr valign="middle"> 
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align= "right" class="TEXTOAZULPOS">FACTOR :</td>
        <td width="5%" bgcolor="<%=application("color2") %>" valign="middle"> <input type="text" id="FAC" name="FAC" class="DATOSGRANDE" onblur="if(isInt(this.value)==false) this.focus()" maxlength="1"/></td>
        <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT" class="TEXTOAZULPOS">  # CABOS :</td>
             <td width="5%" bgcolor="<%=application("color2") %>" valign="middle"> <input type="text" id="CAB" name="CAB" class="DATOSGRANDE" onblur="isInt(this.value)" maxlength="1"/></td>
         <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT" class="TEXTOAZULPOS"> PASADAS :</td>
             <td width="5%" bgcolor="<%=application("color2") %>" valign="middle"> <input type="text" id="PAS" name="PAS" class="DATOSGRANDE" onblur="isInt(this.value)" maxlength="3"/></td>
 <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT" class="TEXTOAZULPOS"> ALTO :</td>
             <td width="5%" bgcolor="<%=application("color2") %>" valign="middle"> <input type="text" id="ALT" name="ALT" class="DATOSGRANDE" onblur="isInt(this.value)" maxlength="3s"/></td>  
              <td width="5%" bgcolor="<%=(Application("barra"))%>" align="RIGHT" class="TEXTOAZULPOS"> UNIDAD :</td>
             <td width="5%" bgcolor="<%=application("color2") %>" valign="middle"><select id="UNI" style="width:100%" name="UNI" class="datos">
       <%Set   RS2 = Server.CreateObject("ADODB.Recordset")
        RS2.ActiveConnection = Cnn
        RS2.CursorType       = 3 'CONST adOpenStatic = 3
        RS2.LockType         = 1 'CONST adReadOnly = 1 %>
       <option></option>
        <%CAD = "select TG_CCLAVE AS COD, TG_CDESCRI AS DES from RSFACCAR.DBO.AL0001TABL WHERE TG_CCOD='05' ORDER BY DES"
        RS2.OPEN CAD, Cnn %>
        <%if rs2.recordcount <=0 then%>
       		 <option value=''>No Hay Unidades Registradas </option>
        <%else%>
			<%rs2.movefirst%>
            <%do while not rs2.eof%>
                    <option value="<%=rs2("COD")%>"><%=(ucase(rs2("DES")))%> </option>
            <%rs2.movenext%>
            <%loop%>
      <%end if %>
      <%rs2.close%>
    </select></td>               
    </tr>
    <tr>
        <td colspan="10" bgcolor="<%=application("color2") %>">
            <table border="0" align="center"  cellspacing="3">
            <tr>
                <td><img src="imagenes/NEW.gif" alt="REGISTRO EN BLANCO" onClick="NUEVO()" style="cursor:hand;"></td>
                <td><img src="imagenes/DISK.gif" alt="GRABAR" onClick="GRABAR()" style="cursor:hand;"></td>		
                <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="DELE()" style="cursor:hand;"></td>		
                <td><img src="imagenes/print.gif" alt="Imprimir" onClick="PRN()" style="cursor:hand;"></td>
            </tr>
            </table>
        </td>
    </tr>
</table>

<script type="text/jscript" language="jscript"> 
function detalle()
{   cad= 'ficharectil.asp?pos='+ trim(thisForm.COD.value) + '&CCLI='+ '<%=CLI %>'+ '&DES='+ '<%=REQUEST.QueryString("des")%>'
    window.open(cad)

}
function PRN() {
    CAD = "reportes/prnRECTOS.ASP?COD=" + trim(thisForm.COD.value)
    window.open(CAD, "")
}

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
	thisForm.TEL.value = '<%=tel%>';
	thisForm.DES.value = '<%=dek%>'; 
	thisForm.CAB.value = ltrim(t.rows(pos).cells(5).innerText );
	thisForm.FAC.value = ltrim(t.rows(pos).cells(3).innerText );
	thisForm.PAS.value = ltrim(t.rows(pos).cells(6).innerText );
	thisForm.ALT.value = ltrim(t.rows(pos).cells(7).innerText );	
	thisForm.ADI.value = ltrim(t.rows(pos).cells(8).innerText );	
	var subcadena =  trim(t.rows(pos).cells(4).innerText) ;
	var elemento = thisForm.UNI ;
	thisForm.UNI.selectedIndex = seleindice(subcadena,elemento);
    oldrow=pos;
    return true;
}
function NUEVO() {
chk="0"
	thisForm.COD.value = 'AUTO';
	thisForm.TEL.value='<%=tel%>';
	thisForm.DES.value='<%=dek%>';
	thisForm.CAB.value = '';
	thisForm.FAC.value = '';
	thisForm.PAS.value = '';
	thisForm.ALT.value = '';	
	thisForm.ADI.value = '';	
	thisForm.UNI.selectedIndex=-1;
	thisForm.COD.focus();
}    
function GRABAR(opc) 
{   if (trim(document.all.ADI.value)=='')
    {   alert("Debe Ingresar el Descriptor del Rectilineo")
        document.all.ADI.focus()
        return false;
    }
    if (trim(document.all.FAC.value)=='')
    {   alert("Debe Ingresar el Factor")
        document.all.FAC.focus()
        return false;
    }
	if (trim(document.all.CAB.value)=='')
    {   alert("Debe Ingresar el número de Cabos")
        document.all.CAB.focus()
        return false;
    }
	if (trim(document.all.PAS.value)=='')
    {   alert("Debe Ingresar el número de Pasadas")
        document.all.PAS.focus()
        return false;
    }
	if (trim(document.all.ALT.value)=='')
    {   alert("Debe Ingresar la altura del Rectilíneo")
        document.all.ALT.focus()
        return false;
    }
    if (document.all.UNI.selectedIndex<0)
    {   alert("Debe seleccionar una unidad de medida")
        document.all.UNI.focus();
        return false;
    }
    cli = trim('<%=cli%>')
    tel = trim('<%=tel%>')
    dek = trim('<%=dek%>')
    cod = trim(document.all.COD.value);
  /*  document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
 */
   cad = 'comun/inserrectcli.asp?cli='+cli+'&tel='+tel+'&cod='+document.all.COD.value
   cad += '&cab='+trim(thisForm.CAB.value)
   cad += '&fac='+trim(thisForm.FAC.value)
   cad += '&PAS='+trim(thisForm.PAS.value)
   cad += '&ALT='+ltrim(thisForm.ALT.value)
   cad += '&UNI='+trim(thisForm.UNI.value)
   cad += '&ADI='+toAlpha(ltrim(thisForm.ADI.value))
   cad += '&dek=' + dek
   cad += '&chk='+chk
   document.all.ACTIV.src= cad
}

function DELE()
{	var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
    cli = trim('<%=cli%>')
    tel = trim('<%=tel%>')
    dek = trim('<%=dek%>')
    cod = trim(document.all.COD.value);
    des = document.all.DES.value;
 /*   document.all.ACTIV.style.visibility='visible'
	document.all.ACTIV.height="150"
	document.all.ACTIV.width="100%"
	*/
    cad = 'comun/inserRECtcli.asp?cli='+cli+'&tel='+tel+'&cod='+cod
    cad += '&dek=' + dek
    cad += '&chk=1'
    alert(cad)
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
