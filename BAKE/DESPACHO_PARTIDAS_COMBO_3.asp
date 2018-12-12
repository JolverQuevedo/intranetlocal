<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID=2057%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->

<%	cli			= Request.QueryString("cli")
    est			= Request.QueryString("est")
    TEM			= Request.QueryString("TEM")
    COM			= Request.QueryString("COM")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
com = replace(com," ", "")
CAD =	" EXEC SP_DESPACHO_PARTIDAS_COMBO '"&CLI&"', '"&EST&"', '"&TEM&"'  , '"&COM&"' "
    
    RS.Open CAD, Cnn
'RESPONSE.WRITE(CAD)
	CONT = 1
 IF NOT RS.EOF OR NOT RS.BOF THEN RS.MOVEFIRST
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1         
      
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count %>
<html>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<body style="margin-top:0px; margin-left:0px; margin-right:0px">
<form id="thisForm" method="post" >
<!--Datos para colocar en la guia por Color de la Po -->
<table id="TABLA" width="100%" align="center" bgcolor="<%=application("color2")%>"  cellpadding="0"  cellspacing="1"  border="0" >
   <tr bgcolor="<%=APPLICATION("TITULO")%>"  align="center" >        
        <td width="1%" class="AMERICANwhite10" ><input type="checkbox" id="cheka"  onclick="chea()" checked/></td>        
        <td width="8%" class="AMERICANwhite10" >PO</td>
        <td width="1%" class="AMERICANwhite10">UBI</td>
        <td width="10%" class="AMERICANwhite10">COLOR-PO</td>
        <td width="3%" class="AMERICANwhite10">QTY</td>
        <td width="40%" class="AMERICANwhite10" colspan="10">TALLAS</td>

    </tr> 
	<%cont=1%>
    <%total=0 %>
    <%DO WHILE NOT RS.EOF%>
        <%pos = rs("po") 
        PAS = " EXEC SP_DESPACHO_CANTIDAD_po '"&CLI&"', '"&EST&"', '"&TEM&"'  , '"&COM&"', '"&POs&"' "
       ' response.write(pas)
        RS2.OPEN PAS,CNN
        IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST%>
         <tr  id="fila<%=cont%>"  >
                <td align="center"> <input type="checkbox" id="chk<%=cont%>"  onclick="check('<%=cont%>')" checked /></td>
                <td align="center" class="AMERICANnavy33" id="po<%=cont%>" name="po<%=cont%>" ><%=trim(rs2("PO"))%></td> 
                <td align="center" class="AMERICANnavy33" width="1%" id="ub<%=cont%>" name="ub<%=cont%>"><%=trim(rs2("UBI"))%></td>  
                <td align="center" class="AMERICANnavy33" id="cm<%=cont%>" name="cm<%=cont%>"><%=trim(rs2("combo"))%></td>   
                           
                <td align="right"  class="AMERICANnavy33" style="padding-right:8px;" id="totpo<%=cont%>"><%=FORMATNUMBER(rs2("qty"),0,,,TRUE)%></td>
                <%for i= 0 to 9 %>
                <%dato = "t"&i %>
                <%POTO = "C"&I %>
                    <%if CDBL(rs2(POTO)) > 0 then %>
                        <td align="center"  class="AMERICANwhite10" style="color:navy" id= "t<%=cont%>t<%=i%>" name=  "t<%=cont%>t<%=i%>"><%=rs2(dato)%></td>
                    <%else%>
                         <td align="center"  class="AMERICANwhite10" style="color:navy; visibility:hidden" id= "t<%=cont%>t<%=i%>" name= "t<%=cont%>t<%=i%>">&nbsp;</td>
                    <%END IF%>
                <%next%>              
            </tr> 
            <tr  id="fila<%=Trim(Cstr(cont))%>a"  valign="top">
                <td align="right" class="AMERICANnavy333" colspan="4" >&nbsp;</td> 
               <%CA = CDBL(rs2("C0")) + CDBL(rs2("C1"))+CDBL(rs2("C2"))+CDBL(rs2("C3"))+CDBL(rs2("C4"))+CDBL(rs2("C5")) +CDBL(rs2("C6"))+CDBL(rs2("C7"))+CDBL(rs2("C8"))+CDBL(rs2("C9"))%>
                    <td align="right"  class="AMERICANnavy333" style="padding-right:5px;"><input id='sumpo<%=cont%>' name='sumpo<%=cont%>' 
                        value='<%=FORMATNUMBER(CA,0,,,TRUE)%>'   class="BARRA333" style="width:100%; text-align:right;padding-right:1px" maxlength="100" disabled/></td>
                     <%for i= 0 to 9 %>
                        <%dato = "C"&i %>
                        <%if CDBL(rs2(dato)) > 0 then %>
                            <td align="center"  class="AMERICANnavy333" ><input id='po<%=cont%>qy<%=i%>' name='po<%=cont%>qy<%=i%>' value='<%=rs2(dato)%>'  class="BARRA333" 
                                style="width:100%; text-align:left;text-align:right;" maxlength="100" 
                                onfocus="seleccionar(this)" onchange="vali('<%=cont%>','<%=i%>');modo('<%=cont%>')" /></td>
                        <%else%>
                         <td align="center"  class="AMERICANwhite10" style="color:navy;visibility:hidden"><input id='po<%=cont%>qy<%=i%>' name='po<%=cont%>qy<%=i%>' value='0'  class="BARRA333" 
                                style="width:100%; text-align:left;text-align:right;" maxlength="100" onchange="modo('<%=cont%>')" /></td>
                        <%END IF%>
                    <%next%>
                
            </tr>         
        <%rs2.close%>
        <%cont = cont + 1 %>
        <%RS.MOVENEXT%>
	<%loop%>
</table>
<input id="maxi" value ='<%=rs.recordcount %>' style="display:block"  />
<input id="tallas" name="tallas" />
<input id="cantis" name="cantis" />
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>

<%
	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
<script type="text/jscript" language="jscript">
function cambia(con) {
   toto = parseInt(document.all.total.value, 10)
   maxim = parseInt(document.all.maxi.value,10)
   tota = 0
   for (i = 1; i < maxim; i++)
   {    qt = "qt" + i.toString()
        if (trim(document.getElementById(qt).value) != '')
            tota += parseInt(document.getElementById(qt).value,10)
   }
   ch = "chk" + con
   // el check si, o si... estara en true
   document.getElementById(ch).checked = true
   document.all.total.value = tota    

}


function check(ff) {
// alert(ff)
    xx = "chk" + ff.toString()
    todo = document.getElementById(xx).checked
    if (todo == false) {
        for (p = 0; p <= 9; p++) {
            col = "po" + ff.toString() + "qy" + p.toString()
            document.getElementById(col).setAttribute('disabled', 'true');
        }
    }
    else {
        for (pe = 0; pe <= 9; pe++) {
            col = "po" + ff.toString() + "qy" + pe.toString()
            document.getElementById(col).removeAttribute('disabled');
        }
    
    }

}
function vali(lin, col) {
    data = "po" + lin.toString() + "qy" + col.toString()
    document.getElementById(data).value = toInt(document.getElementById(data).value)
    if (trim(document.getElementById(data).value) == '' || (document.getElementById(data))== undefined)
    { document.getElementById(data).value = 0 }
    suma = "sumpo" + lin.toString()
    tota = 0
    for (p = 0; p <= 9; p++) 
    {   ww = "po" + lin.toString() + "qy" + p.toString()
        tota +=parseInt(document.getElementById(ww).value,10)
    }
    tpo = "totpo" + lin.toString()
    totpo = parseInt(removecommas(document.getElementById(tpo).innerText), 10)

  
        document.getElementById(suma).value = tota
        document.getElementById(suma).style.backgroundColor = '#fff'
        document.getElementById(suma).setAttribute('disabled', 'true');
    
}


function modo(ff) {

    //eval("document.all.sumpo"+ff+".value = 0")
    rr = "chk" + ff.toString()
    todo = document.getElementById(rr).checked
    ttt = 0
   // alert(todo)
    if (todo == false) 
    {   ch = "chk" + ff
        document.getElementById(ch).checked = false;
        for (e = 0; e <= 9; e++) 
            {   can = parseInt(eval("document.all.po" + ff + "qy" + e + ".value"), 10);
                ttt += parseInt(can, 10);
            }
            eval("document.all.sumpo" + ff + ".value = 0")
           
    
    }
}


//window.onblur = confirmExit;
document.onfocusout = function (e) {
    if (e === undefined) {//ie
        var evt = event; //ie uses event
        if (evt.toElement == null) {//check where focus was lost to
            confirmExit();
        }
    }
};

function confirmExit() {
    var aTal = new Array()
    var aQty = new Array ()
    
    maxim = parseInt(document.all.maxi.value, 10)
    ti = 0
    // recorre todas las PO
    aTTT = new Array(10)
    aQQQ = new Array(10)
    cnt = 0
for (vi = 1; vi <= maxim; vi++) 
{   
    xx = "chk" + vi.toString()
    todo = document.getElementById(xx).checked
    // si tienen el CHECK marcado, capturo el valor de las tallas y cantidades por talla a cortar
    if (todo == true) 
    {   for (mi = 0; mi <= 9; mi++) 
        {   tt = "t" + vi.toString() + "t"  + mi.toString()
            qq = "po"+ vi.toString() + "qy" + mi.toString()
         //   alert(trim(document.getElementById(tt).innerText) + "-" + parseInt(document.getElementById(qq).value, 10))
            aTal[cnt] = trim(document.getElementById(tt).innerText)
            aQty[cnt++] = document.getElementById(qq).value != "" ? parseInt(document.getElementById(qq).value, 10) : 0
        }
       /* aTal[vi] = aTTT
        aQty[vi] = aQQQ
        */
    }
}
//console.log(aTal)
//console.log(aQty)
document.getElementById("tallas").value = aTal
document.getElementById("cantis").value = aQty



/*     document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"

   mexa = parseInt(document.all.maxi.value, 10)
    ttt = 0
    aCan = Array()
    aUbi = Array()
    for (t = 1; t < mexa; t++) {
        CHK = eval("document.all.chk" + t + ".checked");
        if (CHK == true) {
            aCan[t-1] = eval("document.all.qt" + t + ".value");
            aUbi[t-1] = eval("document.all.UB" + t + ".innerText");
        }
    }
    kad  = 'comun/TEMPos.asp?PO=' + trim('<%=POS%>')
    kad += '&nume=' + trim(parent.window.document.all.OS.value)
    kad += '&can=' + aCan
    kad += '&ubi=' + aUbi
   // prompt("",kad)
    document.all.body10.src = kad

*/


}

</script>
</form>
</body>
</html>