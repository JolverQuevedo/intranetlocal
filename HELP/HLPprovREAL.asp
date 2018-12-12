<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%	pos			= Request.QueryString("pos") 
	cod			= Request.QueryString("cod")
    des			= Request.QueryString("des") 
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
kad = ""
if trim(pos) = "" then limite = " top 100 " else limite = " top 100 percent"

'RESPONSE.Write(pos)


    if trim(pos) <> "" then
        pos = pos + "%"
        kad = " Where Ac_CCODIGO like'"&pos&"'" 
      '  RESPONSE.Write("<br>")
      '  RESPONSE.Write("cod y des blancos")
    elseif  trim(cod) <> "" then
       ' RESPONSE.Write("<br>")
      '  RESPONSE.Write(Cod)
        cod = trim(cod) + "%"
        kad = " and AC_CCODIGO like'"&cod&"'" 
    else
       ' RESPONSE.Write("<br>")
      '  RESPONSE.Write(des)
        des = "%" + trim(des) + "%"
        kad = " and AC_CNOMBRE like'"&des&"'"             
    end if
cad =   " Select  "&limite&" AC_CCODIGO as Cod ,AC_CNOMBRE as Razon_Social ," & _
        " ac_cruc, AC_CTELEF1, ac_cdirecc                       " & _
        " From RSCONCAR..CP0001MAES Where AC_CVANEXO='P'        " 
        
cad = cad + KAD
cad = cad + " order by AC_CNOMBRE         "        
    '   RESPONSE.Write(CAD)
       ' RESPONSE.END
	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN
		RS.MOVEFIRST
	END IF 
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<link REL="stylesheet" TYPE="text/css" HREF="../ESTILOS1.CSS" >
<script language="javascript" type="text/jscript">
oldrow=1
function redir(fam) {
    var t = document.all.TABLA;
    HLP = trim('<%=request.QueryString("HLP")%>')
    ff = parseInt(fam,10)
    window.opener.thisForm.PRO.value = t.rows(ff).cells(0).innerText;
    window.opener.thisForm.RUC.value = t.rows(ff).cells(2).innerText;
    // alert( t.rows(ff).cells(1).innerText)
    window.opener.thisForm.NOM.value = t.rows(ff).cells(1).innerText;
    window.opener.thisForm.FAX.value = t.rows(ff).cells(3).innerText;
    window.opener.thisForm.DPRO.value = t.rows(ff).cells(4).innerText;
    
	window.close()	
}
function dd2(ff)
{	// LLENA TEXTBOX ADICIONALES AL COMUN
	// LOS DEL COMUN SON CODIGO Y DESCRIPCION
	var t = document.all.TABLA;
	var pos = parseInt(ff) ;
	dd(ff);
}

</script>
</HEAD>
<BODY topmargin=0 leftmargin=10 rightmargin=10 text="#000000">

<iframe  width="100%" style="display:block;" src="hlpbuscaPROVREAL.asp" id="body10" name="body10" scrolling="no" frameborder="0" height="100px"></iframe>
<form name="thisForm" METHOD="post" >

<hr />
<table id="TABLA" align="center"  bordercolor="<%=application("color2")%>" bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" with="100%">
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>
<TR bgcolor="<%=APPLICATION("TITULO")%>" >
	<%FOR I=0 TO 4 %>
		<TD align="center" class="AMERICANwhite" width="1%"><%=trim(RS.FIELDS(I).NAME)%></TD>
	<%NEXT%>
</TR>
<%	'*****************************
	' MUESTRA EL GRID (2 COLORES) 
	'*****************************	%>
  <%' MUESTRA EL GRid (2 colorES) %>
    <%IF NOT RS.EOF THEN%>
    <%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>"
	            onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="redir('<%=(cont)%>')" >       
	    
		    <td class="texto" align="center"><%=trim(RS.FIELDS.ITEM(0))%>&nbsp;</td>
             <td class="texto" align="left"><%=trim(RS.FIELDS.ITEM(1))%>&nbsp;</td>
	     <td class="texto" align="left"><%=trim(RS.FIELDS.ITEM(2))%>&nbsp;</td>
         <td class="texto" align="left"><%=trim(RS.FIELDS.ITEM(3))%>&nbsp;</td>
         <td class="texto" align="left"><%=trim(RS.FIELDS.ITEM(4))%>&nbsp;</td>
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%end if%>
    </table>

<script language="javascript">
red ='<%=rs.recordcount %>'
if (parseInt(red,10) > 0)
dd2('1');
</script>    
</form>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
    </BODY>
</HTML>