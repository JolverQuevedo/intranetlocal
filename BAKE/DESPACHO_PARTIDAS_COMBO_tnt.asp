<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID=2057%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
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
if rs.recordcount = 0 then
response.end
end if

	CONT = 1
 IF NOT RS.EOF OR NOT RS.BOF THEN RS.MOVEFIRST
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1         
      
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count %>
<body style="margin-top:0px; margin-left:0px; margin-right:0px">
<form id="thisForm" METHOD="post" >

<table id="TABLA" width="100%" align="center" bgcolor="<%=application("color2")%>"  cellpadding="0"  cellspacing="1"  border="0" >
   <tr bgcolor="<%=APPLICATION("TITULO")%>"  align="center" >        
        <td width="8%" class="AMERICANwhite10" >PO</td>
        <td width="10%" class="AMERICANwhite10">COLOR-PO</td>
        <td width="20%" class="AMERICANwhite10" colspan="2">ARTICULO</td>
        <td width="5%" class="AMERICANwhite10">PARTIDA</td>
        <td width="5%" class="AMERICANwhite10">KGS</td>
        <td width="3%" class="AMERICANwhite10">QTY</td>
        <td width="1%" class="AMERICANwhite10" colspan="10">TALLAS</td>

    </tr> 
	<%cont=1%>
    <%total=0 %>
    <%DO WHILE NOT RS.EOF%>
        <%pos = rs("po") 
        PAS = " EXEC SP_DESPACHO_PARTIDAS_po '"&CLI&"', '"&EST&"', '"&TEM&"'  , '"&COM&"', '"&POs&"' "
        'response.write(pas)
        RS2.OPEN PAS,CNN
        IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST%>
         <tr  id="fila<%=cont%>"  >
                <td align="center" class="AMERICANred333" ><%=rs2("PO")%></td> 
                <td align="center" class="AMERICANred333" ><%=rs2("combo")%></td>
                <td align="center" class="AMERICANred333" colspan="4"></td>
                <td align="right"  class="AMERICANred333" style="padding-right:5px;"><%=FORMATNUMBER(rs2("qty"),0,,,TRUE)%></td>
                <%for i= 0 to 9 %>
                <%dato = "t"&i %>
                    <%if len(trim(rs2(dato))) > 0 then %>
                        <td align="center"  class="AMERICANred333" ><%=rs2(dato)%></td>
                    <%END IF%>
                <%next%>
                
            </tr> 
            <%MAR = 0 %>   
        <%do while not rs2.eof %>
            <tr  id="fila<%=Trim(Cstr(cont))%>"  valign="top">
                <td align="right" class="AMERICANnavy333" colspan="2" >&nbsp;</td> 
               
                <td align="left"   class="AMERICANnavy333" ><%=trim(rs2("tela"))%>&nbsp;&nbsp;</td>
                <td align="left"   class="AMERICANnavy333" ><%=trim(rs2("ar_cdescri"))%></td>
                <td align="center" class="AMERICANnavy333" ><%=trim(rs2("partida"))%></td>
                <td align="right"  class="AMERICANnavy333" ><%=formatnumber(cdbl(rs2("kgs")),3,,,true)%></td>
               <%IF MAR = 0 THEN %>
               <%CA = CDBL(rs2("C0")) + CDBL(rs2("C1"))+CDBL(rs2("C2"))+CDBL(rs2("C3"))+CDBL(rs2("C4"))+CDBL(rs2("C5")) +CDBL(rs2("C6"))+CDBL(rs2("C7"))+CDBL(rs2("C8"))+CDBL(rs2("C9"))%>
                <td align="right"  class="AMERICANnavy333" style="padding-right:5px;"><%=FORMATNUMBER(CA,0,,,TRUE)%></td>
               
                <%for i= 0 to 9 %>
                <%dato = "C"&i %>
                    <%if CDBL(rs2(dato)) > 0 then %>
                        <td align="center"  class="AMERICANnavy333" ><%=rs2(dato)%></td>
                    <%END IF%>
                <%next%>
                <%elseif mar = 1 then %>
                    <td align="right"  class="AMERICANnavy333" style="padding-right:5px;"><input disabled id='po<%=cont%>' name='po<%=cont%>' value='<%=FORMATNUMBER(CA,0,,,TRUE)%>'   class="BARRA333" style="width:100%; text-align:left" maxlength="100" disabled/></td>
                     <%for i= 0 to 9 %>
                        <%dato = "C"&i %>
                        <%if CDBL(rs2(dato)) > 0 then %>
                            <td align="center"  class="AMERICANnavy333" ><input id='po<%=cont%>qy<%=i%>' disabled name='po<%=cont%>qy<%=i%>' value='<%=rs2(dato)%>'  class="BARRA333" style="width:100%; text-align:left" maxlength="100" /></td>
                        <%END IF%>
                    <%next%>
                <%END IF %>
            </tr>    
            
            
            <%RS2.MOVENEXT%>
	    <%cont=cont+1%>
        <%MAR =MAR + 1 %>
        <%loop%>
        <%rs2.close%>
        <%RS.MOVENEXT%>
	<%loop%>
</table>

<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="maxi" value ='' style="display:none"  />
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

function marca(op) {
    
    qt = "qt" + op
   // alert(trim(document.getElementById(qt).value))
    toto = parseInt(document.all.total.value, 10)
    // esta es la cantidad que habia en el input
    if (trim(document.getElementById(qt).value) == '') {
        document.getElementById(qt).value = 0
      //  alert(document.getElementById(qt).value)
    
    }
    can = parseInt(document.getElementById(qt).value, 10)
    //se la resto al total
    ch = "chk" + op
    //alert(ch)
    if (document.getElementById(ch).checked == true) {
        toto -= parseInt(can, 10)
        //alert(toto)
        // esta es la cantidad de la PO en el innerText
        qty = parseInt(eval("document.all.cn" + op + ".innerText"), 10);
        document.getElementById(qt).value = qty;
        // suma al total la cantidad de po
        toto += qty;

    }
    else {
        // qt = al valor del Input cuando estaba en check
        qty = document.getElementById(qt).value 
        // se lo resto al total
        toto -=qty
        // blanqueo el valor del input
        document.getElementById(qt).value=''
    }
    document.all.total.value = parseInt(toto, 10)
}

function modo() {

    document.all.total.value = 0
    mexa = parseInt(document.all.maxi.value, 10)
    ttt = 0
    if (document.all.todo.checked == true) {
        for (t = 1; t < mexa; t++) {
            eval("document.all.chk" + t + ".checked='true'");
            can = parseInt(eval("document.all.cn" + t + ".innerText"), 10);
            eval("document.all.qt" + t + ".value=can");
            ttt += parseInt(can, 10);
        }
        document.all.total.value = ttt
    }
    else {

        for (e = 1; e < mexa; e++) {
            ch = "chk" + e
            document.getElementById(ch).checked = false;
            eval("document.all.qt" + e + ".value=''");
        }
    
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

    document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"

/*    mexa = parseInt(document.all.maxi.value, 10)
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
</html>
</body>