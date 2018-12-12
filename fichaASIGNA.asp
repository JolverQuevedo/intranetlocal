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
        " AND TELA = '"&TEL&"'      " 
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
 '   RESPONSE.WRITE(CAD)
	RS.Open CAD, Cnn
	CONT = 1
	IF RS.RECORDCOUNT > 0 THEN 
        RS.MOVEFIRST
        saldoz = rs("saldo")
    else
        rs.close
        cad = " exec SP_CCT_DISPONIBLES_saldo '"&CLI&"','"&pos&"'	"
     '   RESPONSE.WRITE(CAD)
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

<form name="thisForm" method="post" action='comun/inserasig.asp' >
<input id="posi" style="display:none" name="posi"/>
<input id="canti"style="display:none" name="canti" />
<input id="kili" style="display:none" name="kili"/>
<input id="ubic" style="display:none" name="ubic"/>
<input id="cctt" style="display:none" name="cctt" value='<%=cct%>' />
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="middle" > 
		<td width="20%"><img src="imagenes/CERRAR.gif" style="cursor:pointer;" onClick="window.close()" /></td>	
        <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
                <tr><td>
                    <table cellpadding="0" cellspacing="0" border="0" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
                        <tr><td class="TITULITOcenterBLUE22" width="50%" style="text-align:left">PARTIDA: <%=RS("PARTIDA")%> </td>  
                            <td><input id="DISP" value='<%=formatnumber(cdbl(RS("saldo")),3,,,true)%>' class="TITULITOcenterBLUE222" style="text-align:right; padding-right:10px"/></td>
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
	%>

<tr bgcolor="<%=APPLICATION("TITULO")%>" >
    <td align="center" class="AMERICANwhite" width="1%"><input class="chk" type="checkbox" id="cheka" onclick="chea()" /></td>
	<td align="center" class="AMERICANwhite" width="10%">OFI</td>
	<td align="center" class="AMERICANwhite" width="15%">PO</td>
    <td align="center" class="AMERICANwhite" width="10%" colspan="2">COMBO</td>
    <td align="center" class="AMERICANwhite" width="5%">PDAS</td>
    <td align="center" class="AMERICANwhite" width="5%">REQ</td>
    <td align="center" class="AMERICANwhite" width="10%">Asig KG</td>
    <td align="center" class="AMERICANwhite" width="10%">Asig Pds</td>
    <td align="center" class="AMERICANwhite" width="15%">Cons Uni</td>
</tr>  
<%'*****************************
  ' MUESTRA EL GRID (2 COLORES) 
  '*****************************
  ' MUESTRA EL GRid (2 colorES) %>
    <%total=0 
      cont=1
    %>
    <%DO WHILE NOT RS.EOF%>
    <%if  cdbl(rs("qty")) > 0 then %>
        <tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			         id="fila<%=Trim(Cstr(cont))%>">
        
            <td class="texto po" align="center"><input class="chk" type="checkbox" id="chk<%=cont%>" onclick="check('<%=cont%>')" /></td>
            <td class="texto po" align="center"><%=RS("OFI")%></td>
            <td class="texto po" align="left" style="padding-left:15px" id="po<%=cont%>"><%=RS("PO")%></td>      
            <td class="texto po" align="left" style="padding-left:15px" id="it<%=cont%>"><%=RS("ubi")%></td>  
            <td class="texto po" align="left" style="padding-left:15px" ><%=RS("COLOR")%></td>  
            <td class="texto po" align="right" style="text-align:right; padding-right:5px" id="ppp<%=cont%>" ><%=RS("QTY")%></td>
            <td class="texto po" align="right" style="text-align:right; padding-right:5px" id="rq<%=cont%>"><%=RS("KREQ")%></td>
            <td class="texto po" align="right"><input id="qt<%=cont%>"  value="" class="datos" style="text-align:right; padding-right:5px" disabled="disabled"/></td>
            <td class="texto po" align="right"><input id="pd<%=cont%>"  value="" class="datos" style="text-align:right; padding-right:5px" disabled="disabled"/></td>
            <%if cdbl(rs("qty")) = 0 then 
                qty = 1 
              else 
                qty= rs("qty") 
              END IF  
                %>
            <td align="center" class="texto po" id="cn<%=cont%>"><%=formatnumber(cdbl(RS("KREQ")) /cdbl(qty),3,,,true)%></td>
        </tr>
         <%cont=cont+1%>
         <%total = total + tot %>
     <%end if%>
        <%RS.MOVENEXT%>
	
	<%loop%>
    <tr>
        <td style="display:block"><input id="maxi" value ='<%=cont-1%>' class="TEXTO po" /></td>
        <td colspan="2">Saldo</td>
        <td class="texto" align="right" colspan="2"><input id="saldo" name="saldo" value="<%=formatnumber(saldoz,3,,,true)%>" /></td>
    </tr>
    </table>
<iframe src='' frameborder="1" id="bake" name="bake" style="display:none" width="100%" height="200px"></iframe>


<script language="jscript" type="text/jscript">

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
 // kilos real
    qty = "qt" + pos.toString()
// consumo calculado
    con = "cn" + pos.toString()
    chk = "chk" + pos.toString()
// prendas real
    pdd = "pd" + pos.toString()
// saldo en kilos de la partida    
    sl = parseFloat(document.getElementById("saldo").value)
// lo requerido segun la explosion
    cn = parseFloat(document.getElementById(con).innerText)
    totpda = parseInt(eval("document.all.ppp"+pos+".innerText"),10)
    rq = parseFloat(cn)* parseFloat(totpda)
    //alert(rq)
    if (document.getElementById(chk).checked == true)
    {   
        if(parseFloat(rq) > parseFloat(sl))
        {   pda = Math.floor(parseFloat(sl) / parseFloat(cn))
            if (Math.floor(parseFloat(sl) / parseFloat(cn)) > 0)
            {    var si
	            {si = confirm("Solo alcanza para " + Math.floor(parseFloat(sl) / parseFloat(cn)) + " prendas"+"\nDesea asignar lo disponible?");}
                if (si == false)
                {   document.getElementById(chk).checked = false;
                    return false;}
                else
                {   document.getElementById(pdd).value = pda
                    document.getElementById(qty).value =  redondeajolver(pda *parseFloat(cn),3)
                    document.getElementById("saldo").value = redondeajolver(parseFloat(document.getElementById("saldo").value) -   parseFloat(document.getElementById(qty).value )    ,3)
                      }
            }
            else
            {   alert("No hay saldo suficiente ")
                 document.getElementById(chk).checked = false;
                return false;
            }

        }
        else
          { document.getElementById(qty).value =  redondeajolver(parseFloat(rq),3)
            document.getElementById("saldo").value = redondeajolver(parseFloat(document.getElementById("saldo").value) - parseFloat(rq),3)
            document.getElementById(qty).value =  redondeajolver(totpda *parseFloat(cn),3)
       //     alert(totpda +"    "+ redondeajolver(parseFloat(cn),3))
            document.getElementById(pdd).value = totpda
        
            }
    }
    else
     {   if (trim(document.getElementById(qty).value) != '')
        document.getElementById("saldo").value = redondeajolver(parseFloat(document.getElementById("saldo").value) + parseFloat(document.getElementById(qty).value),3)
        document.getElementById(qty).value = ''  
        document.getElementById(pdd ).value = ''  
       
     }
    return true;
}



function graba()
{ cad = 'comun/inserASIG.asp'
var aPo = new Array()
var aKg = new Array()
var aCn = new Array()
var aIt = new Array()
for (y=1; y <= parseInt(document.all.maxi.value,10); y++)
{   aPo[y] = eval("document.all.po"+y.toString()+".innerText")
    aCn[y] = eval("document.all.pd"+y.toString()+".value")
    aKg[y] = eval("document.all.qt"+y.toString()+".value")
    aIt[y] = eval("document.all.it"+y.toString()+".innerText")
}
document.all.ubic.value  = aIt;
document.all.posi.value  = aPo;
document.all.canti.value = aCn;
document.all.kili.value  = aKg;


//alert()
document.thisForm.submit()

//cad += '&Can=' + aCn + '&Po=' + aPo + '&kgs='+ aKg + '&aIt=' + aIt
//cad += '&sal=' + document.all.saldo.value
//document.all.bake.style.display= 'block'
//prompt('',cad)
//document.all.bake.src = cad
}


function chea()
{ maxim = parseInt(document.all.maxi.value,10)
    if (document.all.cheka.checked == true)
    {   for (y= 1; y<=maxim; y++)
        {   eval("document.all.chk" + y.toString()+".checked='true'")
            if (check(y) == false)
            {   return true;
            }
        }
    }

}

</script>
<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>




</form>
