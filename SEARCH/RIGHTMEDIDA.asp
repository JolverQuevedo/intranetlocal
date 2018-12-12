<%@ Language=VBScript %>
<%  Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	TITULO = "MEDIDAS : "
%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body topmargin=0 text="#000000">
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
    var check = 1
    var dele = 0
    function window_onfocus() {
        return true
    }
    function BORRA() {
        pos = dele
        for (i = 0; i < pos; i++) {
            eval("thisForm.pos" + i + ".value=''")
            eval("thisForm.chk" + i + ".checked=false")
            check = 1
            document.all.verif.value = '0'
        }

        return true
    }
    function NUMERA(op) {

        if (trim(eval("thisForm.desc" + op + ".value")) == '') {
            eval("thisForm.chk" + op + ".checked=false")
            eval("thisForm.pos" + op + ".value=''")
            return true;
        }
        if (eval("thisForm.chk" + op + ".checked") == true) {
            document.all.verif.value = '1'
            if (check == 0)
            check = 1
            eval("thisForm.pos" + op + ".value=check++") }
        else {
            eval("thisForm.pos" + op + ".value=''") 
            check--
        }
        return true
    }
//-->
</script>
<%
POS = REQUEST.QUERYSTRING("POS")
CAD = "SELECT DESCRIPCION FROM grupoMEDIDA WHERE CODIGO = '"&POS&"'"
'response.write(cad)
RS.OPEN CAD,CNN
DESGRU= ""
IF RS.RECORDCOUNT > 0 THEN DESGRU = RS("DESCRIPCION")
RS.CLOSE
%>
        
<iframe frameborder="1" style="display:none;" height="100" width="100%" id="ACTIV" name="ACTIV"></iframe>
<table  cellpadding="0" cellspacing="0" width="100%" >
	<tr valign="center"> 
    <td align="center"><img src="imagenes/disk.Gif" style="cursor:hand;" onclick='javascript: GRABA();'>
				
		</td>
		<td align="center"><font face="arial" size="2" color='red'><b><%=TITULO%><%=trim(DESGRU)%> Spec: <%=request.QueryString("spp") %> </td>
<td align="center">
			<img src="imagenes/next1.JPG" style="cursor:hand;display:none" onclick='javascript: next();' onmouseover="this.src='imagenes/next2.JPG'" onmouseout="this.src='imagenes/next1.JPG'"></td>

    </tr>
	<tr>
    	<td colspan="3" style="background-color:Red; height:1px; font-size:xx-small"></td>
	</tr>
</table>	
<%  sp =  left(request.QueryString("spp"),10)
    vr = right(request.QueryString("spp"),3)
    ch = request.QueryString("ch")
    ord = request.QueryString("ord")
MMD = REQUEST.QUERYSTRING("MMD")
 %>
<form id="thisForm" method="post" action=""><span style="display:none">
<%
CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp =  REQUEST.cookies("spe")
vr =  right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")
 %>
<input id="verif" name="verif" value="0" />	
<input type="text" id="GRU" name="GRU" value="<%=POS%>">
<input type="text" id="spp" name="spp" value="<%=request.QueryString("spp") %>">
<input type="text" id="ord" name="ord" value="<%=request.QueryString("ord") %>">
</span>
<%'RESPONSE.END %>
<%leftrow= request.QueryString("leftrow")
CAD =	" select * from View_specs_grupo_medidas        " & _
        " where spec = '"&sp&"' and ver = '"&vr&"'      " & _
        " and orden = '"&ord&"' and  grupo  ='"&pos&"'  " & _
        " and grupo <> '000'                            " & _
        " UNION                                         " & _
        " SELECT '"&SP&"', '"&VR&"', '"&ORD&"',         " & _
        " '"&POS&"', CODIGO, DESCRIPCION, 999 AS LIN    " & _
        " FROM TIPOMEDIDA WHERE estado='a' and          " & _
        " codigo > '000' AND ESTADO = 'A' AND  CODIGO   " & _
        " NOT IN (SELECT MEDIDA FROM SPECS_MEDIDAS      " & _
        " WHERE spec = '"&sp&"' and ver = '"&vr&"'      " & _
        " and orden = '"&ord&"' and  grupo ='"&pos&"'   " & _
        " and medida > '000'  )                         " & _
		" ORDER BY lin, MEDIDA                          "
		'Response.Write(cad)
		RS.OPEN CAD ,CNN
if rs.recordcount> 0 then	
	RS.MOVEFIRST
else
	Response.end
end if 		
'RS.OPEN CAD, CNN%>
<TABLE width="100%" border="0" id="SERV" name="SERV">
<%cont = 0%>
<%IF RS.RECORDCOUNT <= 0 THEN%>
<center>
	<font face="Arial, Helvetica, sans-serif" size="+1" color="red">
		NO HAY MEDIDAS REGISTRADAS.... <br />
		Avise a DESARROLLO
</center>
<br />
<%else%>
<%rs.movefirst%>
	<tr bgcolor='<%=application("barra")%>'>
		<td width="5%" class="titulito">CODIGO</td>
		<td width=1% align="center" valign="middle">
        <img border="0" style="cursor:hand;" onClick="BORRA()"	alt="BORRAR SELECCION"	src="imagenes/eraser.jpg">
		</td>
		<td width="1%" class="titulito">#</td>
		<td width="50%" class="titulito">DESCRIPCION</td>
		
	</tr>		
	<%DO WHILE NOT RS.EOF%>
		<tr <%if CONT mod 2  = 0 then%>
	 bgcolor="<%=application("color1")%>"
		<%end if%>	>
			<td width=10% align="center" >
				<input id="cod<%=cont%>" name="cod<%=cont%>" readonly="readonly" value="<%=trim(RS("medida"))%>"	class="DESCRIPTORCENTERnavy"></td>
			<td width="1%" align="center">
				<input type="checkbox" id="chk<%=cont%>" name="chk<%=cont%>" onClick="NUMERA('<%=cont%>')" <%IF RS("lin")<> "999" THEN%>
					checked
                    <%END IF%>> 
			</td>
			<td width="5%" align="center">
				<input type="text"  id="pos<%=cont%>" name="pos<%=cont%>" maxlength="3" class="DESCRIPTORCENTERnavy" readonly="readonly"<%IF RS("lin")<> "999" THEN%>
					 value='<%=trim(RS("lin"))%>' <%else%> value=""<%END IF%>> 
			</td>
			<td>
				<input id="desc<%=cont%>" name="desc<%=cont%>" class="descriptores" value='<%=trim(rs("descripcion"))%>' readonly="readonly">
			</td>
			
		</tr>
		<%RS.MOVENEXT%>
		<%cont = cont + 1%>
	<%LOOP%>
	<%I=cont%>
	
</table>	
<%end if%>

<table  border="0" cellpadding="0" align="center" cellspacing="1" width="100%" bgcolor="<%=application("color2")%>" bordercolor="SeaGreen" bordercolordark="DARKGREEN" bordercolorlight="LightSeaGreen">
	<tr>
		<td colspan="6">
		<hr size="1" color="RED">
		</td>
	</tr>
</table>
<table  border="0" cellpadding="0" align="center" cellspacing="8" >    
	<tr>	
		<td class="TEXTO2" >Fecha :</td>
		<td class="TEXTOazul2"  ><%=DATE()%></td>
		<td class="TEXTO2" >Usuario :</td>
		<td class="TEXTOAZUl2" ><%=TXTUSUARIO%></td>
		<td class="TEXTO2" >Estado :</td>
		<td class="TEXTOAZUL2" >A<input type="text" id="CONTADOR" name="CONTADOR" style="display:block">
		</td>
	</tr>
</table>	
<%
set rs= nothing
set cnn=nothing
%>
</form>


<script>
    dele = '<%=cont%>'
    pos = parseInt(dele, 10)-1
    thisForm.CONTADOR.value = pos
    check = 1
    for (i = 0; i < pos; i++) {
        if (eval("thisForm.pos" + i + ".value") != '') {
            eval("thisForm.chk" + i + ".checked=true")
            check++
        }
    }
    function GRABA() {	//alert(thisForm.CONTADOR.value = pos)
        i = 0;
        var t = ''
        cont = 0
        aMed = new Array()
        aLin = new Array()
        for (ii = 0; ii < pos; ii++) {
            if (eval("thisForm.chk" + ii + ".checked") == true) {
                aMed[cont] = eval("thisForm.cod" + ii + ".value")
                aLin[cont++] = eval("thisForm.pos" + ii + ".value")
            }
        }
        if (cont == 0) {
            alert("Debe seleccionar ALGUNA MEDIDA PARA ESTE GRUPO")
            return true;
        }
        
        cad = "comun/inserRIGHTmedida.ASP?spe=" + document.all.spp.value
        cad += '&gru=' + document.all.GRU.value
        cad += '&ord=' + document.all.ord.value
        cad += '&med=' + aMed
        cad += '&lin=' + aLin
      // alert(cad)
     //   document.all.ACTIV.style.display = 'block';
        document.all.ACTIV.src= cad


        /*thisForm.action = "comun/inserRIGHTmedida.ASP"
        thisForm.submit()
        */
    }
function next() {
var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";
 
cad  = 'fichaMedidas.asp?spe=' + document.all.spp.value
cad += '&cli=' + top.window.frames[0].document.all.CLI.value
cad += '&tmp=' + top.window.frames[0].document.all.TEM.value
cad += '&est=' + top.window.frames[0].document.all.ESTI.value


window.open(cad,'SPECs',opc)


}


</script>
</BODY>
</HTML>
