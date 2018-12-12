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
    var url = '../GRUPOMEDIDA.asp?pos='
    var alias = 'dbo.GRUPOMEDIDA'
    var TBL = 'dbo.GRUPOMEDIDA'
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
alias = ""&OWNER&".GRUPOMEDIDA"
'*********************************************
' Definir el NOMBRE de la columna del ORDER BY
'*********************************************
Dim indice
indice = "CODIGO"
'*********************************************
' Definir el NOMBRE de la PAGINA ASP de inicio
'*********************************************
Dim urlBase
urlBase = "GRUPOMEDIDA.asp"
'*********************************************
' Definir el TITULO de la PAGINA ASP 
'*********************************************
Dim TITULO
TITULO = "GRUPOS DE MEDICION"
%>
<script>
    var check = 1
    var dele = 0

    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=400,width=500";
 
    // **************************************************************
    //  Indicar el nombre de la página donde se realizan los cambios 
    // **************************************************************
    var funcionalidad = 'comun/INSERtbl.asp?'

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
        dd = 'comun/BORRAgrupoSPEC.asp?spe=' + document.all.spp.value
        dd += '&cli=' + '<%=request.cookies("CLI")%>'
        dd += '&tem=' + '<%=request.cookies("TEM")%>'
        dd += '&est=' + '<%=request.cookies("EST")%>'
        dd += '&med=' + '<%=request.cookies("med")%>'

        check = 1
        window.location.replace(dd)
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
            dd = 'comun/insergruSPEC.asp?gru=' + eval("document.all.gru" + op + ".value") + '&oor=' + (parseInt(op, 10) + 1)
            //alert(dd)
            document.all.ACTIV.style.display='block'
            document.all.ACTIV.src=dd
        }
        else {
            dd  = 'comun/delegrupoSPEC.asp?spe=' + document.all.spp.value
            dd += '&gru=' + eval("document.all.gru" + op + ".value")
            dd += '&ord=' + eval("thisForm.pos" + op + ".value")
            dd += '&cli=' + '<%=request.cookies("CLI")%>'
            dd += '&tem=' + '<%=request.cookies("TEM")%>'
            dd += '&est=' + '<%=request.cookies("EST")%>'
            dd += '&med=' + '<%=request.cookies("med")%>'
            //alert(dd)
            window.location.replace(dd)
        }
       
    }
    function FOTO(op) {
        if (eval("thisForm.pos" + op + ".value") == '') {
            alert("Solo puede asignar foto aa Grupos selecionados")
            return false
        }

        cad = 'FotoMedidaGRUPO.asp?spe=' +trim(document.all.spp.value)
        cad += '&gru=' + eval("document.all.gru" + op + ".value")
        cad += '&ord=' + eval("thisForm.pos" + op + ".value")
        cad += '&cli=' + '<%=request.cookies("CLI")%>'
        cad += '&tem=' + '<%=request.cookies("TEM")%>'
        cad += '&est=' + '<%=request.cookies("EST")%>'
        cad += '&med=' + '<%=request.cookies("med")%>'
       // alert(cad)
        window.open(cad, '', opc)

    
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
RS.OPEN "SELECT TIPMED FROM SPECS_HEAD WHERE  spec = '"&sp&"' and ver = '"&vr&"'   ", CNN
IF RS.RECORDCOUNT > 0 THEN 
    RS.MOVEFIRST
    MED = UCASE(RS("TIPMED"))
END IF
RS.CLOSE
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
CAD =	"SELECT top 100 percent ORDEN, GRUPO, DESCRIPCION, SPEC, VER    " & _
        " from View_SPEC_GRUPOS                                         " & _
        " where spec = '"&sp&"' and ver = '"&vr&"'                      " & _
        " union                                                         " & _
        " select 999 as orden, CODIGO, DESCRIPCION, '"&sp&"' as spec,   " & _
        " '"&vr&"' as ver FROM GRUPOMEDIDA AS GM                        " & _
        " WHERE ESTADO  ='A' AND CODIGO NOT IN (SELECT grupo from       " & _
        " View_SPEC_GRUPOS where spec = '"&sp&"' and ver = '"&vr&"')    " & _
        " AND CODIGO <> '000'                                           " & _
            " ORDER BY orden, grupo                                     " 

RS.Open CAD, Cnn

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
<table  cellpadding="0" cellspacing="0" width="100%" >
	<tr valign="center"> 
		<td align="center"><font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b><%=TITULO%> SPEC : <%=trim(SP)%>-<%=vr%>&nbsp;Medido en <%=med %>   
		<input type="hidden" id="GRU" name="GRU" value="<%=POS%>">
	</td>
    	<td align="center" height="19px"><img src="imagenes/reload.jpg" border="0" style="cursor:pointer; display:none" onclick="location.reload()" />
        </td>
    </tr>
	<tr>
    	<td colspan="3" style="background-color:Red; height:1px; font-size:xx-small"></td>
	</tr>
</table>	
<%'*********************************************************************%>
<TABLE ID="TABLA" ALIGN="CENTER" width=100%
	 cellpadding=2  cellspacing=0 bordercolor=White
	  bgcolor="white" border=0 >
	  
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="#0087d1" >

<td align="center" style="width:10%"><font face="arial" color="ivory" size="1"><B>ORDEN</B> </font></td>	
<td width=1% align="center" valign="middle"><img border="0" style="cursor:hand;" onClick="BORRA()"	alt="BORRAR SELECCION"	src="imagenes/eraser.jpg">
		</td>
<td align="center" style="width:10%"><font face="arial" color="ivory" size="1"><B>GRUPO</B> </font></td>	
<td align="center" style="width:70%"><font face="arial" color="ivory" size="1"><B>DESCRIPCION</B> </font></td>
<td align="center" style="width:10%"><font face="arial" color="ivory" size="1"><B>FOTO</B> </font></td>		
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%DO WHILE NOT RS.EOF%>
    <tr <% IF CONT mod 2  = 0 THEN %> bgcolor='<%=(Application("color1"))%>' 
	    <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
		    onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" 
            ondblclick="FOTO('<%=cont %>')"
		    NAME="fila<%=Trim(Cstr(cont))%>">
    
        <td align="center"><input id="chk<%=cont%>" type="checkbox"  onClick="NUMERA('<%=cont%>')" <%if cint(rs("orden"))<999 then%>checked <%end if %>> </td> 
        <td align="center"><input type="text"  id="pos<%=cont%>" name="pos<%=cont%>" maxlength="3" class="DESCRIPTORCENTERnavy" readonly="readonly"	
       <%IF trim(RS("ORDEN"))= "999" THEN
            XX = ""
        ELSE 
            XX = RS("ORDEN")
        END IF%>
            value='<%=TRIM(XX)%>'> </td> 
        <td>
		    <input id="gru<%=cont%>" name="gru<%=cont%>" class="descriptores" value='<%=trim(rs("grupo"))%>' readonly="readonly">
	    </td>
	    <td><input id="desc<%=cont%>" name="desc<%=cont%>" class="descriptores" value='<%=trim(rs("descripcion"))%>' readonly="readonly"></td> 
        <%if cint(rs("orden"))<999 then
            CAD = "BAKE/recuperaFOTOSpec.asp?spe=" + RS("SPEC") + "&VER=" + RS("VER") + "&ORD=" + CSTR(RS("ORDEN")) + "&GRU=" + RS("GRUPO")
          else
            CAD = "imagenes\blanco.gif"  
            end if
        %>

        <td><img src="<%=CAD%>" alt="" height="30px"/>
         </td>
	    </tr>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
	    <%LOOP%>
	    <%rs.movelast%>
<%END IF %>
<tr>
<td colspan="5">
<%rs.close
obs =""
cam = "select obs from specs_head WHERE SPEC= '"&SP&"' AND VER = '"&VR&"' "
rs.open cam, cnn
'response.write(cam)
if rs.recordcount > 0 then 
    rs.movefirst 
    obs= rs("obs")
end if
    %>
<font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b>Observaciones:<br /></b></font>
<textarea style="width:100%; height:100%; overflow-y: auto; word-wrap:break-word"  id="OBS" name="OBS" onchange="confirmExit()" ><%=obs%></textarea>
</td>
</tr>
</table>
<iframe frameborder="1" style="display:none;" height="100" width="100%" id="ACTIV" name="ACTIV"></iframe>
<input type="text" id="CONTADOR" name="CONTADOR" style="display:none">
<script>
    document.all.spp.value = '<%=request.cookies("spe")%>-<%=right(request.cookies("ver"),3)%>'
    dele = '<%=cont%>'
    pos = parseInt(dele, 10) - 1
    thisForm.CONTADOR.value = pos
    check = parseInt('<%=ordens%>', 10) + 1
    rec = parseInt('<%=rs.recordcount%>', 10)
    if (rec > 0)
        dd2('0');

  
function confirmExit() {
   cad = 'comun/inserobs.asp?spe=' + '<%=spe%>' + '&ver=' + '<%=right(trim(REQUEST.QUERYSTRING("Spe")),3) %>' + '&OBS=' + Left(toAlpha(document.all.OBS.value), 500)
   document.all.ACTIV.src = cad
    
} 

</script>  

<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</form>
</BODY>
</HTML>
