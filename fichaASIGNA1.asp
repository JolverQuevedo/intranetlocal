<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID=2057 %>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="comun/funcionescomunes.asp"-->
<link rel="Stylesheet" type="text/css" href="estilos1.css" />
<script language="jscript" type="text/jscript">
    var oldrow = 1
    var oldpos = 1
</script>

<%	pos			= Request.QueryString("pos")
    CLI			= Request.QueryString("CLI")
    tel			= Request.QueryString("tel")
    cct			= Request.QueryString("cct")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
cad =   " SELECT *                  " & _
        " FROM VIEW_EXPLOSION_TELAS " & _
        " WHERE CLI = '"&CLI&"'     " & _
        " AND TELA = '"&TEL&"'      " & _
        " AND YEAR(FECHA) >= 2018   "
    '    response.write(cad)
RS.OPEN CAD, CNN
IF RS.RECORDCOUNT <= 0 THEN
    RESPONSE.WRITE("<center>")
    RESPONSE.WRITE("<font color='red' size=12 face='arial'>")
    RESPONSE.WRITE("Cliente no tiene OFIS Explosionadas")
    RESPONSE.WRITE(" con este codigo de TELA-COLOR")
    response.end
end if
RS.CLOSE
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 

CAD =	" exec SP_CCT_DISPONIBLES '"&CLI&"','"&pos&"'	"
    'RESPONSE.WRITE(CAD)
	RS.Open CAD, Cnn
	CONT = 1
	IF RS.RECORDCOUNT > 0 THEN 
        RS.MOVEFIRST
        saldoz = rs("kpar")
    else
        rs.close
        cad = " exec SP_CCT_DISPONIBLES_saldo '"&CLI&"','"&pos&"'	"
        rs.open cad, cnn
        if rs.recordcount > 0 then    %>
            <script language="jscript" type="text/jscript">
                alert("Esta partida no tiene mas Ofis Explosionadas\npara matar el SALDO")
            </script>
        <%end if%>
        <script language="jscript" type="text/jscript">
            window.location.replace('reportes/prnASIGNA.asp?cct='+ '<%=cct%>')
        </script>
   <%
    response.end
   end if
'************************************************************************
'
'   HAY QUE VER COMO SE MUESTRAN LOS DATOS SI EL SALDO DE LA PARTIDA = 0
'
'************************************************************************	

' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count %>

<form name="thisForm" METHOD="post" >
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="middle" > 
		<td width="20%"><img src="imagenes/CERRAR.gif" style="cursor:pointer;" onClick="window.close()" /></td>	
        <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
                <tr><td>
                    <table cellpadding="0" cellspacing="0" border="0" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
                        <tr><td class="TITULITOcenterBLUE22" width="50%" style="text-align:left">PARTIDA: <%=RS("PARTIDA")%> </td>  
                            <td><input id="DISP" value='<%=formatnumber(cdbl(RS("kpar")),3,,,true)%>' class="TITULITOcenterBLUE222" style="text-align:right; padding-right:10px"/></td>
                            <td class="TITULITOcenterBLUE22" width="30%" align="left" >kilos </td>  
                        </tr>
                        <tr><td class="TITULITOcenterBLUE" width="50%" style="text-align:center;" colspan="3">Ficha: <%=cct%> </td>  
                        </tr>
		            </table>
                </td></tr> 
            </table>
        </td>
         
        <td id="grab" align="center" width="10%"><img id="Img1" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba(1)" src="imagenes/disk.gif" /></td>
        <td  width="10%" align="right"><img src="imagenes/logo.gif" border="0"  alt="" id="GRABA"  /></td>
    </tr>
</table>  
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="middle" > 
        <td class="TITULITOcenterGREEN">TELA: <%=RS("TELA")%> - <%=RS("DESCRI")%></td>
    </tr>
</table>

<table id="TABLA" class="colores" align="center"  bordercolor="<%=application("color2")%>"   bgcolor="<%=application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1"  width="100%">
<%	'**************************
	'LINEA DE CABECERA STANDAR 
	'**************************
	cont=1%>

<tr bgcolor="<%=APPLICATION("TITULO")%>" >
    <td align="center" class="AMERICANwhite" width="6%"></td>
    <td align="center" class="AMERICANwhite" width="1%">Chk</td>
	<td align="center" class="AMERICANwhite" width="1%">OFI</td>
	<td align="center" class="AMERICANwhite" width="1%">PO</td>
    <td align="center" class="AMERICANwhite" width="1%">PDAS</td>
    <td align="center" class="AMERICANwhite" width="1%">REQ</td>
    <td align="center" class="AMERICANwhite" width="5%">Asig KG</td>
    <td align="center" class="AMERICANwhite" width="4%">Asig Pds</td>
    <td align="center" class="AMERICANwhite" width="5%">Cons Uni</td>
</tr>  
<%'*****************************
  ' MUESTRA EL GRID (2 COLORES) 
  '*****************************
  ' MUESTRA EL GRid (2 colorES) %>
    <%total=0 %>
    <%DO WHILE NOT RS.EOF%>
    <tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			    onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" ondblclick="ficha('<%=cont%>')">
        <td align="center" class="AMERICANwhite" width="10%">&nbsp;</td>
        <td class="texto po" align="center"><input class="chk" type="checkbox" id="chk<%=cont%>" onclick="check('<%=cont%>')" /></td>
        <td class="texto po" align="center"><%=RS("OFI")%></td>
        <td class="texto po" align="left" style="padding-left:15px" id="po<%=cont%>"><%=RS("PO")%></td>       
        <td class="texto po" align="right" style="text-align:right; padding-right:5px" id="ppp<%=cont%>" ><%=RS("QTY")%></td>
        <td class="texto po" align="right" style="text-align:right; padding-right:5px" id="rq<%=cont%>"><%=RS("KREQ")%></td>
        <td class="texto po" align="right"><input id="qt<%=cont%>"  value="" class="datos" style="text-align:right; padding-right:5px" disabled="disabled"/></td>
        <td class="texto po" align="right"><input id="pd<%=cont%>"  value="" class="datos" style="text-align:right; padding-right:5px" disabled="disabled"/></td>
        <td align="center" class="texto po" width="10%" id="cn<%=cont%>"><%=formatnumber(cdbl(RS("KREQ"))/cdbl(rs("qty")),3,,,true)%></td>
    </tr>
    <tr id="show<%=cont%>" style="display:none">
        <td colspan="8">
        <%ppp = rs("po")
        ubi = rs("ubi")
        rs2.open "select * from VIEW_PO_DETA_105 where po = '"&ppp&"' and ubi = "&ubi&"", cnn
        if rs2.recordcount > 0 then rs2.movefirst %>
            <table id="Tab<%=cont%>" align="center" cellpadding="2"  cellspacing="1"  border="0"  width="100%">
                <tr>
                    <%for i=0 to 9 %>
                        <td><input class="talasrojo" style="width:50px" id="e<%=cont%>ti<%=i%>" value="<%=rs2.fields.item(i+17)%>" /></td>
                    <%next %>
                </tr>
                <tr>
                    <%for i=0 to 9 %>
                        <td><!-- CANTIDAD SOLICITADA PARA ASIGNAR -->
                        <input type="text" value="<%=response.write(rs2.fields.item(i+7))%>" onclick="seleccionar(this)" onchange="cambia('<%=cont%>','<%=i%>')"
                        id="t<%=cont%>al<%=i%>"  class = "DESCRIPTORCENTERnavy2" style="width:50px"/>
                        <!-- CANTIDAD DE LA PO AL 105% (ORIGINAL) -->
                        <input type="text" value="<%=response.write(rs2.fields.item(i+7))%>" id="q<%=cont%>ty<%=i%>"  style="display:none"/></td>
                    <%next %>
                </tr>
            </table>
            <%rs2.close %>
        </td>
    </tr>
     <%total = total + tot %>
        <%RS.MOVENEXT%>
	<%cont=cont+1%>
	<%loop%>
    <tr>
        <td style="display:block"><input id="maxi" value ='<%=cont-1%>' class="TEXTO po" /></td>
        <td colspan="2">Saldo</td>
        <td class="texto" align="right"><input id="saldo" value="<%=formatnumber(saldoz,3,,,true)%>" /></td>
    </tr>
    </table>
<iframe src='' frameborder="1" id="bake" name="bake" style="display:block" width="100%" height="200px"></iframe>


<script language="jscript" type="text/jscript">
maxi = parseInt(document.getElementById("maxi").value,10)
for (t=1; t<= maxi; t++)
{   for(j=0; j<=9; j++)
    {   dato = "t"+ t.toString() + "al" + j.toString()
        eti  = "e"+ t.toString() + "ti" + j.toString()
        if (parseInt(document.getElementById(dato).value,10) == 0)
        {   document.getElementById(dato).style.display = 'none'
            document.getElementById(eti).style.display = 'none'
        }
    }
    pos = "t"+t.toString()+ "al"
    totp  = parseInt(eval("document.all."+pos+"0.value"),10) 
    totp += parseInt(eval("document.all."+pos+"1.value"),10)
    totp += parseInt(eval("document.all."+pos+"2.value"),10)
    totp += parseInt(eval("document.all."+pos+"3.value"),10)
    totp += parseInt(eval("document.all."+pos+"4.value"),10)
    totp += parseInt(eval("document.all."+pos+"5.value"),10)
    totp += parseInt(eval("document.all."+pos+"6.value"),10)
    totp += parseInt(eval("document.all."+pos+"7.value"),10)
    totp += parseInt(eval("document.all."+pos+"8.value"),10)
    totp += parseInt(eval("document.all."+pos+"9.value"),10)
    pren = "ppp"+ t.toString()
  //  alert(totp)
    document.getElementById(pren).innerText = totp

}
function cambia(cont,i)
{   inp = "t"+ cont.toString() + "al" + i.toString()
    ped = "q"+ cont.toString() + "ty" + i.toString()
    if (trim(document.getElementById(inp).value)=='')
        document.getElementById(inp).value = 0
    inpu =  parseInt(document.getElementById(inp).value,10)
    pedi =  parseInt(document.getElementById(ped).value,10)

    if( inpu > pedi)
    {   alert("NO puede solicitar mas de lo requerido por PCP")
        document.getElementById(inp).value = pedi
        return true;
    }
for (p=0; p<9; p++)
{   

}

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
   	oldrow=pos
	return true;
}
function check(ff)
{   var pos = parseInt(ff,10)
    qty = "qt" + pos.toString()
    chk = "chk" + pos.toString()
 //   req = "rq" + pos.toString()
    totpda  = parseInt(eval("document.all.t"+pos+"al0.value"),10)
    totpda += parseInt(eval("document.all.t"+pos+"al1.value"),10)
    totpda += parseInt(eval("document.all.t"+pos+"al2.value"),10)
    totpda += parseInt(eval("document.all.t"+pos+"al3.value"),10)
    totpda += parseInt(eval("document.all.t"+pos+"al4.value"),10)
    totpda += parseInt(eval("document.all.t"+pos+"al5.value"),10)
    totpda += parseInt(eval("document.all.t"+pos+"al6.value"),10)
    totpda += parseInt(eval("document.all.t"+pos+"al7.value"),10)
    totpda += parseInt(eval("document.all.t"+pos+"al8.value"),10)
    totpda += parseInt(eval("document.all.t"+pos+"al9.value"),10)

    con = "cn" + pos.toString()
    pda = "pd" + pos.toString()
    
    sl = parseFloat(document.getElementById("saldo").value)
    cn = parseFloat(document.getElementById(con).innerText)
    rq = parseFloat(cn)* parseFloat(totpda)
    //alert(rq)
    if (document.getElementById(chk).checked == true)
    {   
        if(parseFloat(rq) > parseFloat(sl))
        {   pda = Math.floor(parseFloat(sl) / parseFloat(cn))
            alert("No puede asignar mas de lo disponible\nSolo alcanza para " + pda + " prendas")

            document.getElementById(chk).checked = false;
            return true;    }
        else
          { document.getElementById(qty).value =  parseFloat(rq)
            document.getElementById("saldo").value = parseFloat(document.getElementById("saldo").value) - parseFloat(rq)
           
            //alert(totpda)
            document.getElementById(pda).value = totpda
            }
    }
    else
     {   if (trim(document.getElementById(qty).value) != '')
        document.getElementById("saldo").value = parseFloat(document.getElementById("saldo").value) + parseFloat(document.getElementById(qty).value)
     
     document.getElementById(qty).value = ''  
     
     }
}

function ficha(ff) 
{	var pos = parseInt(ff,10)
    // oculta la anterior
	eval("document.all.show"+oldpos+".style.display='none'")
	// muestra el detalle de la PO
	eval("document.all.show" + pos + ".style.display='block'")
    oldpos=pos
	return true;
}


function graba()
{ cad = 'comun/inserASIG.asp?cct='+'<%=cct%>'
var aPo = new Array()
var aKg = new Array()
var aCn = new Array()
for (y=1; y <= parseInt(document.all.maxi.value,10); y++)
{   aPo[y] = eval("document.all.po"+y.toString()+".innerText")
    aCn[y] = eval("document.all.pd"+y.toString()+".value")
    aKg[y] = eval("document.all.qt"+y.toString()+".value")
}

cad += '&Can=' + aCn + '&Po=' + aPo + '&kgs='+ aKg
cad += '&sal=' + document.all.saldo.value
document.all.bake.src = cad
}
</script>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>




</form>
