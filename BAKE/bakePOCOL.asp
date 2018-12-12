<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%session.LCID=2057%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<%	pos			= Request.QueryString("PO")
    UBI			= Request.QueryString("UBI")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
CAD =	" SELECT * FROM [PO-DETA] WHERE REPLACE(PO,' ' , '')= '"&POS&"' AND UBI  = "&UBI&" "
   ' RESPONSE.WRITE(CAD)
	RS.Open CAD, Cnn
	CONT = 1
	IF NOT RS.EOF OR NOT RS.BOF THEN RS.MOVEFIRST
	
' Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count %>
<body style="margin-top:0px; margin-left:0px; margin-right:0px">
<form id="thisForm" METHOD="post" >
<table id="TABLA" width="100%" align="center" bgcolor="<%=application("color2")%>"  cellpadding="0"  cellspacing="1"  border="0" >
    <%'LINEA DE CABECERA STANDAR 
	   cont=1%>
    <tr bgcolor="<%=APPLICATION("TITULO")%>" >
        <%for i= 0 to 9 %>
        <td align="center" class="AMERICANred11" width="5%"><%=rs.fields.item(i+14)%></td>
        <%next%>
    </tr>  
    <%' MUESTRA EL GRID (2 COLORES) %>
    <%total=0 %>
    <%DO WHILE NOT RS.EOF%>
    <tr  id="fila<%=Trim(Cstr(cont))%>" >
        <%for i=0 to 9 %>
         <td align="right"><input id="Text1" value="<%=rs.fields.item(i+4)%>" class="AMERICANnavy33" /></td> 
        <%next%>
        <%RS.MOVENEXT%>
    </tr>
	<%cont=cont+1%>
	<%loop%>
</table>
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




}

</script>
</form>
</html>
</body>