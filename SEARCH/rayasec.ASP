<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID=2057 %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<style type="text/css" media="all">
#boton { background:url('imagenes/disk.gif') no-repeat; border:3; width:25px; height:25px; }
</style>
    
<%  
	letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    POS = Request.QueryString("pos")
    TEL = Request.QueryString("TEL")
    CAD = "exec FIBRAS_TELA '"&tel&"' "
    'response.Write(cad)
    rs.open cad,cnn
    xx=0
    aFib = Array(0)   
    if rs.recordcount > 0 then
        rs.movefirst
        do while not rs.eof
            redim preserve aFib(xx)
            aFib(xx) = rs("fibra")
            xx=xx+1
            rs.movenext
        loop
    end if
    rs.close
	CAD =	" SELECT COLOR, DESCRIPCION, LETRA1, SEC, ALTURA, RAPPORT, NUMCOL,  " & _
	        " NUMFRA, PASADAS, FIBRA1,   marka = case when sum(altura) is null  " & _
            " then 0 else 1 end, letra2, letra3, letra4,letra5,letra6,          " & _
            " fibra2, fibra3, fibra4, fibra5, fibra6                            " & _ 
	        " FROM RAYASEC AS R1 RIGHT OUTER JOIN COLORES ON COLOR = CODIGO     " & _
	        " WHERE COMBIN = '00' AND COLOR = '"&POS&"' AND R1.ESTADO = 'A'     " & _
            " group by COLOR, DESCRIPCION, LETRA1, SEC, ALTURA, RAPPORT, NUMCOL, " & _
            " NUMFRA, PASADAS, FIBRA1, letra2, letra3, letra4,letra5,letra6,    " & _
            " fibra2, fibra3, fibra4, fibra5, fibra6                            " & _
	        " ORDER BY 4                                                        " 
	'response.Write(cAD)

	rs.open cad , cnn
	if rs.recordcount > 0 then
	    maxi = rs("rapport")
	    FRA = RS("NUMFRA")
	    numlet = rs("numcol")
	    descrip = trim(rs("descripcion"))%>
    <script type="text/jscript" language="jscript">
        top.window.frames.item(1).document.all.marka.value = '<%=rs("marka") %>'
    </script>
    <%ELSE %>
        <%RESPONSE.END %>
     <%end if%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body >
<form id="thisForm" method="post" name="thisForm" action="">

<iframe  width="100%" style="display:none" src="" id="body0" name="body0"  scrolling="yes" frameborder="0" height="200" align="middle"></iframe>

<table width="100%" border="1" bordercolordark="<%=application("barra")%>" cellpadding="3" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="<%=application("contraste") %>" class="AMERICANwhite">ESTRUCTURA DEL LISTADO :<%=POS%> - <%=descrip%> </td>	
	</tr>
</table>
<table border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="<%=application("borde")%>" width="100%">
    <tr valign="middle" bgcolor="<%=(Application("BARRA"))%>" align="center">
        <td width="10%" class="DESCRIPTORnavyBOLD">FRANJA<br />#</td>
        <td width="10%" class="DESCRIPTORnavyBOLD">PASADAS</td>
        <%LETTER = rs("numcol") %>
        <%for x=0 to ubound(afib) %>
	        <td width="10%" class="DESCRIPTORnavyBOLD">L<%=x+1%>
                <select type="text" id="LETER<%=X+1%>"   class="BARRA2" onchange="LETRAS('<%=x+1%>')"  />
                    <option></option>
                    <%for h=1 to LETTER %>
                        <option value="<%=mid(letras,h,1) %>"><%=mid(letras,h,1) %></option>
                    <%next %>
                </select>
            </td>
        <%next %>
            <td width="10%" class="DESCRIPTORnavyBOLD">ALTURA<br /> cms.</td>
        <%for x=0 to ubound(afib) %>
            <td width="20%" class="DESCRIPTORnavyBOLD">FIB<%=x+1 %>
             <select type="text" id="SELE<%=x+1%>"   class="BARRA2" onchange="fibras('<%=x+1%>')"  />
                <option></option>
                <%for h=0 to ubound(aFib) %>
                    <option value="<%=aFib(h)%>"><%=aFib(h)%></option>
                <%next %>
                </select></td>
        <%next%> 
	</tr>
    <%if rs.recordcount <=0 then response.end %>	
    <%cn=0 
    totpas = 0
    ttoa = 0%>	
    <%rs.movefirst %>
    <%do while not rs.eof %>
      <tr valign="middle" bgcolor="<%if cn mod 2 = 0 then response.write(Application("color1")) else response.write(Application("color2")) %>" align="center">
            <td class="DESCRIPTORnavyBOLD" width="10%" ><%=rs("sec")%></td>
            <td width="10%"><input type="text" id="PAS<%=cn%>" name="PAS<%=cn%>" value="<%=rs("pasadas")%>" class="datos" /></td>
            
	       <%for x=0 to ubound(afib) %>
                <%vari = "letra"&(x+1)%>           
                <td width="10%">
                    <select  id="LEC<%=cn%><%=x+1%>" value="<%=rs(vari)%>" name="LEC<%=cn%><%=x+1%>" class="BARRA2"  />
                        <option></option>
	                    <%for i=1 to rs("numcol")%>
	                    <option value="<%=mid(letras,i,1) %>">&nbsp;<%=mid(letras,i,1)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
	                    <%next%>
	                </select>
       	                <%if len(trim(rs(vari))) > 0  then%>              
                        <script language="jscript" type="text/jscript">
			                var subcadena =  trim('<%=rs(vari)%>') ;
			                var elemento = eval("thisForm.LEC" + trim('<%=cn%>') + trim('<%=x+1%>'));
			                eval("thisForm.LEC"+trim('<%=cn%>')+trim('<%=x+1%>')+".selectedIndex= seleindice(subcadena,elemento)");
		                </script>
		            <%else %>
                        <script language="jscript" type="text/jscript">
		                    eval("thisForm.LEC"+trim('<%=cn%>')+trim('<%=x+1%>')+".selectedIndex= -1");
		                </script>
		            <%END IF %>
	            </td>	
            <%next %>
            <td width="10%"><input type="text" id="ALT<%=cn%>" name="ALT<%=cn%>" value="<%=rs("ALTURA")%>" class="datos" onchange=" suma()" /></td>
             <%for x=0 to ubound(afib)%>    
                 <td width="20%"> 
                    <%fibi = "fibra"&(x+1)%>
                    <select  id="FIB<%=CN%><%=x+1%>"  name="FIB<%=CN%><%=x+1%>" value="<%=rs(fibi)%>" class="BARRA2" />
                    <option></option>
                    <%for h=0 to ubound(aFib) %>
                        <option value="<%=aFib(h)%>"><%=aFib(h)%></option>
                    <%next %>
                    </select>
                    <%if len(trim(rs(fibi))) > 0  then%> 
                        <script language="jscript" type="text/jscript">
                            var subcadena = trim('<%=rs(fibi)%>');
                            var elemento = eval("thisForm.FIB" + trim('<%=cn%>')+trim('<%=x+1%>'));
                            eval("thisForm.FIB" + trim('<%=cn%>') + trim('<%=x+1%>') +".selectedIndex= seleindice(subcadena,elemento)");
		                </script>
		            <%else %>
		                <script language="jscript" type="text/jscript">
		                    eval("thisForm.FIB" + trim('<%=cn%>') + trim('<%=x+1%>') + ".selectedIndex= -1");
		                </script>
		            <%END IF %>
                  </td>
            <%next %>
	    </tr>
        <%cn = cn+1 
        IF ISNULL(rs("altura")) OR LEN(TRIM(rs("altura")))=0 THEN ALT = 0 ELSE ALT = cdbl(rs("altura"))
        IF ISNULL(rs("pasadas")) OR LEN(TRIM(rs("pasadas")))=0 THEN PASA = 0 ELSE PASA = cdbl(rs("pasadas"))
        tota = tota + ALT
        TOTPAS = TOTPAS + PASA%>
        <%rs.movenext %>
    <%loop%>   
    <%if rs.recordcount < fra then %>
        <%for k = cn+1 to fra %>
            <tr valign="middle" bgcolor="<%if cn mod 2 = 0 then response.write(Application("color1")) else response.write(Application("color2")) %>" align="center">
                <td class="DESCRIPTORnavyBOLD" ><%=k%></td>
                  <td width="10%"><input type="text" id="PAS<%=k-1%>" name="PAS<%=k-1%>" class="datos" /></td>
	            <td><select type="text" id="LEC<%=k%>" name="LEC<%=k%>" class="BARRA2"  />
	                    <%for i=1 to numlet %>
	                    <option value="<%=mid(letras,i,1) %>">&nbsp;<%=mid(letras,i,1)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
	                    <%next%>
	                </select>            
	            </td>
                <td width="20%">
                <select type="text" id="FIB<%=k%>"  name="FIB<%=k%>" value="<%=rs("FIBRA")%>" class="BARRA2"  />
                <option></option>
                <%for h=0 to ubound(aFib) %>
                    <option value="<%=aFib(h)%>"><%=aFib(h)%></option>
                <%next %>
                </select>
              </td>
              
                <td width="10%"><input type="text" id="ALT<%=k-1%>" name="ALT<%=k-1%>" class="datos" onchange="suma()" /></td>
	        </tr>
        <%next %>
    <%end if %>
    <tr valign="middle" bgcolor="<%=(Application("BARRA"))%>" align="center">
            <td colspan="1" class="DESCRIPTORnavyBOLD" width="20%">Total</td>
            <td class="DESCRIPTORnavyBOLD" width="10%"><input type="text" id="PASADA" name="PASADA" value="<%=totPAS%>" class="barras" readonly tabindex="'-1" "/></td>
             <td colspan="<%=ubound(afib)+1%>"></td>
            <td class="DESCRIPTORnavyBOLD" width="10%"><input type="text" id="TOTA" name="TOTA" value="<%=tota%>" class="barras" readonly tabindex="'-1" /></td>
            <td colspan="<%=ubound(afib)+1%>"></td>
    </tr>
</table>
<center>
<br />
    <input type="button" id="boton" value="" style="cursor:hand;" onclick="graba()" />
</center>
</form>
<script type="text/jscript" language="jscript">
var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";

var maxi = parseFloat('<%=maxi %>')
var FRA = parseInt('<%=FRA %>',10)

function fibras(op) {
    op = parseInt(op, 10)
    ss = eval("document.all.SELE" + op + ".value")
    var subcadena = ss

    for (t = 0; t < FRA; t++) {
        var elemento = eval("thisForm.FIB" + t + op);
        eval("document.all.FIB"+t + op + ".value=ss")
        eval("thisForm.FIB" + t + op + ".selectedIndex= seleindice(subcadena,elemento)");
    }

}
function LETRAS(op) {
    op = parseInt(op, 10)
    ss = eval("document.all.LETER" + op + ".value")
    var subcadena = ss

    for (t = 0; t < FRA; t++) {
        var elemento = eval("thisForm.LEC" + t + (op));
        eval("document.all.LEC" + t + (op) + ".value=ss")
        eval("thisForm.LEC" + t + (op) + ".selectedIndex= seleindice(subcadena,elemento)");
    }

}
function graba() {
    if (suma() == false)
        return false;
    fibi = parseInt('<%=ubound(afib)%>', 10)+1
   // alert(fibi)
    for (u=0; u<FRA; u++) {
        //dato = trim(eval("document.all.ALT" + u + ".value"))

        for (tt = 1; tt <= fibi; tt++) {
            
            data = eval("document.all.LEC"+u + tt + ".value")
            if (trim(data) == '') {
                alert("Se debe informar la LETRA del color de todas las franjas")
                eval("document.all.LEC"+u + tt + ".focus()")
                return false;
            }
        }
       // deta = eval("document.all.PAS" + u + ".value")
        for (txt = 1; txt <= fibi; txt++) {
            teta = eval("document.all.FIB" + u + txt+".value")
            if (trim(teta) == '') {
                alert("Se debe informar la Fibra")
                eval("document.all.FIB" + u + txt+".focus()")
                return false;
            }
        }
        
   }
KAD  = 'comun/inserrayas3.asp?pos=' + '<%=trim(pos)%>'
KAD += '&tel=' + '<%=tel%>'+'&fibras='+fibi + '&lin=' + FRA
//alert(KAD)
document.all.thisForm.action = KAD

thisForm.submit()

/*
document.all.body0.style.display='block'
document.all.body0.src= KAD  
*/
}

function suma()
{   tot=0
xx = 0

    for (u=0; u<FRA; u++) {
        dato = trim(eval("document.all.ALT" + u + ".value"))
      //  alert(eval("document.all.ALT" + u + ".id"))
        if (dato!='' )
        {   xx = dato
            tot += parseFloat(xx)
            eval("document.all.ALT" + u + ".value=deci(xx,2)")            
        }    
   }
    document.all.TOTA.value = deci(tot, 2)
    document.all.PASADA.value = deci(tot, 2)
 /*  if (tot > maxi) {
       alert("Los parciales de las franjas suman más que la altura total del rapport\nR E V I S E . . . . . .")
       return false;
   }
*/
   return true;}

</script>
	<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>

</body>
</html>