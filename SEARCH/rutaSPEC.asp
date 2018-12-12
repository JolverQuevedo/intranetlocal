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
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNleftgrupo.ASP"-->
<script>
    // SI AUTO ESTA EN cero, SIGNIFICA QUE ES CODIGO MANUAL
    // SI auto ESTA EN 1, SIGNIFICA QUE LA LLAVE ES IDENTITY
    var auto = 1;
    var url = '../SPECRUTA.asp?pos='
    var alias = 'dbo.SPECRUTA'
    var TBL = 'dbo.SPECRUTA'
    var PK = 'CODIGO'
    var DS = 'desCRIPCION'
    var largo = 3
    var largo2 = 200
    var oldrow = 1

</script>
<%
'****************************************
' Definir el tamaño de la pagina
'****************************************
Dim pageSize 
if nivel > 1 then
	pageSize = 16
else
	pageSize = 6
end if
'****************************************
' Definir el NOMBRE de la Tabla base
'****************************************
Dim ALIAS
alias = ""&OWNER&".SPECRUTA"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "CODIGO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "RUTASPEC.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "RUTA DE PRODUCCION DEL SPEC"
%>
<script>
    var check = 1
    var dele = 0

    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=400,width=500";
 
    // **************************************************************
    //  Indicar el nombre de la página donde se realizan los cambios 
    // **************************************************************
    var funcionalidad = 'comun/INSERSPECRUTA.asp?'

    function dd2(ff) {	// LLENA TEXTBOX ADICIONALES AL COMUN
        // LOS DEL COMUN SON CODIGO Y DESCRIPCION
        var t = document.all.TABLA;
        var pos = parseInt(ff);
        dd(ff);
    }

function BORRA() {
    pos = dele
    for (ti = 0; ti < pos; ti++) {
        eval("thisForm.pos" + ti + ".value=''")
        eval("thisForm.chk" + ti + ".checked=false")
        check = 1
        
    }
    // alert();
  //  document.all.ACTIV.src = 'delegrupoSPEC.asp?spe=' + '<%=spe%>'
       return true
}
    function NUMERA(op) {

        if (trim(eval("thisForm.desc" + op + ".value")) == '') {
            eval("thisForm.chk" + op + ".checked=false")
            ord = eval("thisForm.pos" + op + ".value")
            eval("thisForm.pos" + op + ".value=''") 
            return true;
        }
        if (eval("thisForm.chk" + op + ".checked") == true) {
            if (check == 0)
                check = 2
            eval("thisForm.pos" + op + ".value=check++")
           
        }
       
    }
   
</script>
<%

CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp  = REQUEST.cookies("spe")
vr  = right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")


'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
cad =   " SELECT top 1 percent ORDEN from View_SPEC_GRUPOS              " & _
        " where spec = '"&sp&"' and ver = '"&vr&"'                      " & _
        " order by orden desc"
rs.open cad, cnn
ordens = 0
if rs.recordcount > 0 then ordens = cint(rs("orden"))
rs.close
CAD =	"SELECT top 100 percent LIN,   CODIGO,   DESCRIPCION            " & _
        " from View_SPECRUTA                                            " & _
        " where spec = '"&sp&"' and ver = '"&vr&"'                      " & _
        " union                                                         " & _
        " select 999 as LIN, CODIGO, DESCRIPCION FROM PROCESOS          " & _
        " WHERE ESTADO  ='A' AND CODIGO NOT IN (SELECT CODIGO from      " & _
        " View_SPECRUTA where spec = '"&sp&"' and ver = '"&vr&"')       " & _
        " ORDER BY lin                                                  " 

    RS.Open CAD, Cnn
    cnt= 0
	'response.write(cad)
	CONT = 0
	IF NOT RS.EOF OR NOT RS.BOF THEN	RS.MOVEFIRST%>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count-2%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<BODY topmargin=0 text="#000000">
<form id="thisForm" method="post" action="">
<input type="text" id="spp" name="spp" value="<%=sp%>-<%=vr%>" style="display:none">
<table  cellpadding="0" cellspacing="0"align="center">
	<tr valign="center"> 
		<td align="center"><font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b><%=TITULO%> SPEC : <%=trim(SP)%>-<%=vr%></td>
    </tr>
	<tr><td style="background-color:Red; height:1px; font-size:xx-small"></td></tr>
</table>	
<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="CENTER" cellpadding="2" cellspacing="0" bordercolor="White" bgcolor="white" border="0" >
	  
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="#0087d1" >
    <td align="center" ><font face="arial" color="ivory" size="1"><B>SEC</B> </font></td>	
    <td  align="center" valign="middle"><img border="0" style="cursor:hand;" onClick="BORRA()"	alt="BORRAR SELECCION"	src="imagenes/eraser.jpg"></td>
    <td align="center" ><font face="arial" color="ivory" size="1"><B>CODIGO</B> </font></td>	
    <td align="center" ><font face="arial" color="ivory" size="1"><B>PROCESO</B> </font></td>
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
    <tr <% IF CONT mod 2  = 0 THEN %> bgcolor='<%=(Application("color1"))%>' 
	    <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
		    onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
            name="fila<%=Trim(Cstr(cont))%>">
    
        <td align="center"><input id="chk<%=cont%>" type="checkbox"  onClick="NUMERA('<%=cont%>')" <%if cint(rs("LIN"))<999 then%>checked <%end if %>> </td> 
        <td align="center"><input type="text"  id="pos<%=cont%>" name="pos<%=cont%>" maxlength="3" class="DESCRIPTORCENTERnavy" readonly="readonly"	
       <%IF trim(RS("LIN"))= "999" THEN
           XX  = ""  
        ELSE 
            XX = cint(RS("LIN"))
            cnt= cnt + 1
        END IF%>
            value='<%=TRIM(XX)%>'> </td> 
        <td><input id="gru<%=cont%>" name="gru<%=cont%>" class="descriptores" value='<%=trim(rs("CODIGO"))%>' readonly="readonly"></td>
	    <td><input id="desc<%=cont%>" name="desc<%=cont%>" class="descriptores" value='<%=trim(rs("descripcion"))%>' readonly="readonly"></td> 
	</tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
	<%LOOP%>
<%END IF %>
</table>
<center>
 <input type="button" value= "" onclick="graba()" style="display:block; background-image:url(imagenes/disk.gif);width:26px;height:26px;cursor:pointer;"  >
 </center>
<iframe frameborder="1" style="display:none;" height="200" width="100%" id="ACTIV" name="ACTIV"></iframe>
<input type="text" id="CONTADOR" name="CONTADOR" style="display:none">
<script language="jscript" type="text/jscript">
    document.all.spp.value = '<%=request.cookies("spe")%>-<%=right(request.cookies("ver"),3)%>'
    dele = '<%=cont%>'
    pos = parseInt(dele, 10) - 1
    thisForm.CONTADOR.value = pos
    check = parseInt('<%=cnt%>', 10) + 1
    rec = parseInt('<%=rs.recordcount%>', 10)
    if (rec > 0)
        dd2('0');

function graba() {
    var aRut = new Array()
    var aPos = new Array()
    it = 0 
    for (op = 0; op < rec; op++) {
        if (eval("thisForm.chk" + op + ".checked") == true) {
            aPos[it]   = eval("thisForm.pos" + op + ".value")
            aRut[it++] = eval("thisForm.gru" + op + ".value")        
        }
    }

    CAD = 'COMUN/INSERPECruta.ASP?POS='+ aPos + '&rut=' + aRut
    document.all.ACTIV.style.display='block'
    document.all.ACTIV.src = CAD
}  

</script>  

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</BODY>
</HTML>
