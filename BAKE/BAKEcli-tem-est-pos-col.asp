<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil")
	'Response.Write(txtperfil)
	
%>

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<%
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CLI = Request.QueryString("CLI")
tem = Request.QueryString("tem")
est = replace(Request.QueryString("est"), " ", "")
col = Request.QueryString("col")
pos = replace(Request.QueryString("pos")," ","")
oss = replace(Request.QueryString("oss")," ","")
cod = right(oss,4)


Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 
ser = left(oss,3)
IF  cod = "AUTO" then

    cad =   " SELECT DISTINCT                                      " & _ 
            " dd.po AS pos, dd.ubi AS uu, tot105, dd.color,        " & _
            " (tot105-isnull((SELECT SUM(cant) FROM servidet       " & _
            " AS xx WHERE LEFT(xx.numord, 3) = '"&SER&"' AND       " & _
            " xx.po = dd.po), 0)) AS qty,                          " & _
            " (tot105-isnull((SELECT SUM(cant) FROM servidet AS    " & _
            " xx WHERE LEFT(xx.numord, 3) = '"&SER&"'              " & _
            " AND xx.po = dd.po), 0)) AS DISP                      " & _
            " FROM View_Cliente_Temporada_Estilo_PO_color AS dd    " & _
            " FULL OUTER JOIN servidet AS ss ON ss.po = dd.po      " & _
            " WHERE CLIENTE = '"&CLI&"' AND codtem = '"&TEM&"'     " & _
            " AND estilo = '"&EST&"'                               " & _
            " AND color = '"&COL&"'                                " & _
            " ORDER BY dd.PO;                                      "                                     
else
    cad =   " SELECT dd.po as pos, dd.ubi as uu, tot105, dd.color,  " & _
            " isnull(cant,0) as qty   ,                             " & _ 
            " (tot105+ isnull(cant, 0)-isnull((SELECT SUM(cant)     " & _
            " FROM servidet AS xx WHERE LEFT(xx.numord,3)='"&ser&"' " & _
            " AND xx.po = dd.po), 0)) as disp                       " & _
            " from View_Cliente_Temporada_Estilo_PO_color as dd     " & _
            " full outer join servidet as ss on ss.po = dd.po       " & _
            " WHERE CLIENTE = '"&cli&"' and codtem = '"&tem&"' and  " & _
            " estilo = '"&est&"' and color = '"&col&"' and          " & _
            " numord = '"&oss&"'                                    " & _
            " ORDER BY ss.PO;                                       "
end if

		'Response.Write(cad)
		'RESPONSE.END
	RS.Open CAD, Cnn
	IF  RS.RECORDCOUNT = 0 THEN  
        response.end  
    ELSE 
        MAXI= RS.RECORDCOUNT
    end if
    rs.movefirst
%>	
<script type="text/jscript" language="jscript">
    var oldrow = 1



function dd2(ff) 
{	var pos = parseInt(ff,10)
	var t = document.all.TABLA;
    //alert(ff)
	if ((oldrow%2) ==0)
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
	else
		eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
	// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO )
	eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
   
    PPO =  trim(t.rows(pos+1).cells(0).innerText) ;
    UBI =  trim(t.rows(pos+1).cells(1).innerText) ;
	oldrow=pos
    document.all.deta.src='bakePOCOL.asp?po='+PPO + '&UBI='+ UBI
	return true;
}

</script>
<HTML>
<form name="Form1" METHOD="post">
<HEAD>
<TITLE>COLORES</TITLE>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY topmargin="0" leftmargin="20" rightmargin="20" border="0" text="#000000">
<form id="thisForm" METHOD="post" >

<table id="TABLA1" width ="100%" align="left" bgcolor="<%=application("color2")%>"  cellpadding="0"  cellspacing="1"  border="0" >
<%cont=0%>
<%total=0 %>
<tr valign="top"> 
    <td  width="50%">
        <table id="TABLA" width ="100%" align="left" bgcolor="<%=application("color2")%>"  cellpadding="0"  cellspacing="1"  border="0" >
           <tr bgcolor="<%=APPLICATION("TITULO")%>" >
                <td align="center" class="AMERICANwhite10" width="10%">PO</td>
                <td align="center" class="AMERICANwhite10" width="1%">it</td>
	            <td align="center" class="AMERICANwhite10" width="15%">COLOR</td>
                <td align="center" class="AMERICANwhite10" width="10%">TOT+5%</td>
                <td align="center" class="AMERICANwhite10" width="10%">DISP</td>
                <td align="center" class="AMERICANwhite10" width="10%">QTY</td>
            </tr>
            <%DO WHILE NOT RS.EOF %>    
                <tr <% IF CONT mod 2  = 0 THEN %> bgcolor='<%=(Application("color1"))%>' 
	<%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
	            onclick="dd2('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" >         
                    <td class="AMERICANnavy33" align="left"  id="po<%=cont%>"><%=trim(RS("pos"))%></td>
                    <td class="AMERICANnavy33" align="center"  id="ub<%=cont%>"><%=trim(RS("uu"))%></td>
                    <td class="AMERICANnavy33" align="left"><%=trim(RS("COLOR"))%></td>
	                <td class="AMERICANnavy33" align="right" id="cn<%=cont%>" style="padding-right:10px"><%=rs("tot105")%></td>
                    <td class="AMERICANGREEN11" align="right" id="ds<%=cont%>" style="padding-right:10px"><%=rs("DISP")%></td>
                    <td class="AMERICANnavy33"><input id="qt<%=cont%>" value="<%=rs("qty")%>" class="AMERICANnavy1" style="width:95%;text-align:right;padding-right:5px;" onchange="cambia()"/></td>       
                    <%total = total + cdbl(rs("qty")) %>
                    </tr>           
                <%cont=cont+1%>
                <%RS.MOVENEXT%>
            <%LOOP%>
        </table>
    </td>
    <td  width="50%">
        <iframe id="deta" src=""  width= "100%" scrolling="auto" frameborder="0"></iframe>
        </td>
    </tr>
    <tr style="display:none">
       <td class="AMERICANnavy33" width="50%"><input id="recs" value='<%=rs.recordcount%>'</td>
       <td align="right"><input id="total" value="<%=total%>" class="AMERICANnavy33" disabled="disabled"/></td> 
        
    </tr>
    </table>
    <iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>

</form>
<script language="jscript" type="text/jscript">

parent.window.document.all.TOTCOL.value = parseFloat('<%=total%>')
taxi = '<%=rs.recordcount %>'
for (ri = 0; ri < taxi; ri++) {
    id = "qt" + ri.toString()
    dd = "ds" + ri.toString()
    canti = trim(toInt(document.getElementById(id).value));

    kanti = document.getElementById(dd).innerText;
    if (parseInt(canti, 10) == 0) {
        canti = 0
    }
    if (parseInt(kanti, 10) == 0)
    { document.getElementById(id).disabled = true }
    //alert(id)
}





function cambia() {
    maxi = '<%=rs.recordcount %>'
    toto = 0

    for (ii = 0; ii < maxi; ii++) {
        id = "qt" + ii.toString()
        di = "ds" + ii.toString()
        canti = trim(toInt(document.getElementById(id).value));
        if (trim(canti) == '')
        { canti = 0 }
        dispo = document.getElementById(di).innerText;
        if (parseInt(canti, 10) > parseInt(dispo, 10)) {
            alert("No puede enviar mas de lo disponible")
            document.getElementById(id).value =  parseInt(dispo,10)
            return false;
        }
        document.getElementById(id).value =  parseInt(canti,10)
        toto += parseInt(canti, 10)
        //alert(id)
    }

   
    document.getElementById("total").value = parseFloat(toto)
    parent.document.getElementById("TOTCOL").value = parseFloat(toto)

    if (trim(parent.document.getElementById("PUN").value) != '')
    { window.parent.precio() }
}


pre = trim(parent.document.getElementById("PUN").value)
if (pre == '')
    pre = 0
if ( parseFloat(pre) > 0  )
{ window.parent.precio() }

rs = parseInt('<%=rs.recordcount%>', 10)
if (rs > 0)
    dd2(0)
</script>

</BODY>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</HTML>
