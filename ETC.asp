<%@  language="VBScript" %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Untitled Document</title>
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNleftgrupo.ASP"-->
<%
'response.write(request.Cookies("spe"))
ETC = request.QUERYSTRING("ETC")
cli = request.QUERYSTRING("cli")
tem = request.QUERYSTRING("tem")
est = request.QUERYSTRING("est")
tip = request.QUERYSTRING("tip")

IF LEN(TRIM(ETC)) <=0 THEN
    CAD = "SELECT * FROM ETC WHERE CODCLI = '"&CLI&"' and CODTEM = '"&tem&"' and CODEST='"&est&"' "
    RESPONSE.WRITE(CAD)
    RS.OPEN CAD , CNN
    IF RS.RECORDCOUNT > 0 tHEN 
        RS.MOVEFIRST
        CODETC = RS("CODETC")
        RS.CLOSE
        RS.OPEN "SELECT CODETC, CODTIP FROM ETC WHERE CODTIP = '"&TIP&"'ORDER BY 1 DESC", CNN
        IF RS.RECORDCOUNT <= 0 THEN
            CAD =   " INSERT INTO ETC SELECT '"&CODETC&"', '"&CLI&"', '"&EST&"', '"&TEM&"', 'T' ,'','','','','','','','','','','','','','','', '"&txtUsuario&"', GETDATE(), 'A'  ; " & _
                    " INSERT INTO ETC SELECT '"&CODETC&"', '"&CLI&"', '"&EST&"', '"&TEM&"', 'A' ,'','','','','','','','','','','','','','','', '"&txtUsuario&"', GETDATE(), 'A'  ; "       
            RESPONSE.WRITE(CAD)
            RESPONSE.WRITE("<BR>")
            CNN.EXECUTE CAD 
        END IF
    ELSE
        RS.CLOSE
        RS.OPEN "SELECT TOP 1 CODETC FROM ETC ORDER BY 1 DESC", CNN
        IF RS.RECORDCOUNT > 0 THEN
            RS.MOVEFIRST
            CODETC = RIGHT("0000000000" + CSTR(CDBL(RS("CODETC"))+ 1),10)
        ELSE
            CODETC = "0000000001"
        END IF
        CAD = " INSERT INTO ETC SELECT '"&CODETC&"', '"&CLI&"', '"&EST&"', '"&TEM&"', '"&TIP&"', '','','','','','','','','','','','','','','', '"&txtUsuario&"', GETDATE(), 'A'   "
        response.write(cad)
        CNN.EXECUTE CAD 

    END IF
    RS.CLOSE
ELSE
    CODETC =  ETC
END IF
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 
%>
<script language="jscript" type="text/jscript">

    function autofitIframe(id) {
        if (!window.opera && document.all && document.getElementById) {
            id.style.height = id.contentWindow.document.body.scrollHeight;
        } else if (document.getElementById) {
            id.style.height = id.contentDocument.body.scrollHeight + "px";
        }
    }

</script>
<body>
    <form id="thisForm" method="post" name="thisForm" action="">
    <%aLET = ARRAY(" ","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0", "1", "2", "3", "4", "5", "6", "7", "8", "9") 
dad = " SELECT * FROM VIEW_ETC_FICHA WHERE CODETC = '"&CODETC&"' AND CODTIP='"&tip&"'  ORDER BY CODETC,  ubi"               
'RESPONSE.WRITE(DAD)
RS2.OPEN DAD, CNN 
IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST%>
    <%u=1%>
    <table border="0" cellspacing="0" cellpadding="1" align="left" width="100%" bgcolor="#e1e1e1">
        <tr>
            <td colspan="17" style="height: 2px; background-color: darkgreen">
            </td>
        </tr>
        <tr>
            <td colspan="17" style="height: 1px; background-color: darkgreen">
            </td>
        </tr>
        <tr class="TITULITOcenterGREEN" style="color: navy">
            <td colspan="2">
                Nombre del
            </td>
            <td colspan="2">
                ETC :
                <%=codetc%>
                <input id="veri" name="veri" value="0" style="display: none">
            </td>
            <td colspan="13" align="left">
                Indicar a que Pieza corresponde el color
            </td>
        </tr>
        <tr>
            <td style="width: 5%" colspan="2" class="TITULITOcenterGREEN" style="color: navy">
                COMBO
            </td>
            <%FOR I = 1 TO 15%>
            <td align="center" width="3%">
                <% nume = right("00"+ cstr(i),2)
                DES = "DES" & nume %>
                <%IF RS2.RECORDCOUNT>0 THEN dd = ltrim(RS2(DES)) else dd = "" END IF%>
                <textarea id="x<%=i%>" name="x<%=i%>" style="height: 20em; overflow: hidden; width: 100%;
                    text-align: center; vertical-align: top" onchange="cuenta(this)" class="tituloGRANDEgris2"><%=dd%></textarea>
            </td>
            <%NEXT%>
        </tr>
        <tr>
            <td colspan="17" style="height: 2px; background-color: darkgreen">
            </td>
        </tr>
        <tr>
            <td colspan="17" style="height: 1px; background-color: darkgreen">
            </td>
        </tr>
        <%DO WHILE NOT RS2.EOF %>
        <tr id="LIN<%=U%>" name="LIN<%=U%>" style="display: block">
            <td class="AMERICANnavy" style="width: 1%" id="IT<%=u%>" name="IT<%=u%>">
                <%=u%>
            </td>
            <td style="width: 5%">
                <input id="COL<%=u%>" name="COL<%=u%>" class="DATOSkhaki3" onkeyup="FLECHA('<%=U%>')"
                    style="text-align: left; width: 100%; background-color: white" onfocus="lineas('<%=u%>');"
                    value="<%=rs2("COMBO")%>" />
            </td>
            <%FOR I = 1 TO 15%>
            <td align="center" width="5%">
                <%nume = right("00"+ cstr(i),2)
                   COL= "COL"&nume %>
                <input id="C<%=I%>C<%=U%>" name="C<%=I%>C<%=U%>" value="<%=RS2(col)%>" onkeyup="FLECHA('<%=u%>')"
                    style="background-color: white" class="DATOSkhaki3" style="width: 100%" />
            </td>
            <%NEXT%>
        </tr>
        <%U = U + 1 %>
        <%RS2.MOVENEXT%>
        <%LOOP%>
        <%' solo tengo 36 caracteres entre letras y numeros a un digito%>
        <%for k=u to 50 %>
        <tr id="LIN<%=k%>" name="LIN<%=K%>" style="display: none">
            <td class="AMERICANnavy" style="width: 1%" id="IT<%=k%>" name="IT<%=k%>">
                <%=k%>
            </td>
            <td style="width: 5%">
                <input id="COL<%=k%>" name="COL<%=k%>" class="DATOSkhaki3" style="text-align: left;
                    width:69%;margin:0;padding:0;" onfocus="lineas('<%=k%>');" style="background-color: white" onkeyup="FLECHA('<%=K%>')"
                    onchange="colormismo('<%=K%>')" />
                <img src="imagenes/search.gif" alt="buscar" onclick="showwindowcolor('<%=K%>')" style="width:20px;display:inline;margin:0;padding:0;" />
            </td>
            <%FOR I = 1 TO 15%>
            <td align="center" width="5%">
                <input id="C<%=I%>C<%=k%>" name="C<%=I%>C<%=k%>" value="" class="DATOSkhaki3" style="background-color: white"
                    onkeyup="FLECHA('<%=K%>')" style="width: 100%" />
            </td>
            <%NEXT%>
        </tr>
        <%next %>
        <tr>
            <td colspan="8" align="right">
                <input type="button" value="  " onclick="ENVIO()" class="botonok2">&nbsp;&nbsp;&nbsp;
            </td>
            <td colspan="8" align="left">
                &nbsp;&nbsp;<input type="button" value="  " onclick="prn()" class="botonok3">
            </td>
        </tr>
    </table>
    </form>
    <iframe id="head" name="head" src="" onload="autofitIframe(this);" width="100%" scrolling="no"
        frameborder="0"></iframe>
    <iframe id="cuerpo" name="cuerpo" src="" onload="autofitIframe(this);" width="100%"
        scrolling="no" frameborder="0"></iframe>
</body>
<script language="jscript" type="text/jscript">
    function showwindowcolor(k) {
        var opcx = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
        opcx += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";

        window.open('help/helpcoloresetc.asp?elid=' + k + '&cliente=<%=cli%>', '', opcx);
    }
    function colormismo(k) {

        if (confirm("deseas rellenar los datos automaticamente?")) {
            for (var i = 1; i <= 15; i++) {
                if (eval("document.all.x" + i + ".value") != "") {
                    var cad = "document.all.C" + i + "C" + k + ".value = document.all.COL" + k + ".value";
                    eval(cad);
                }
            }
            eval("document.all.COL" + (parseFloat(k) + 1) + ".focus()");
        }
    }


    var TOPE = parseInt('<%=k%>', 10)


    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";

    document.all.veri.value = TOPE
    tto = parseInt('<%=u%>', 10)
    tto = tto
    var lets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    lineas('<%=u-1%>')

    function lineas(op) {
        op = parseInt(op, 10)

        if (op < TOPE - 1) {
            op++
            eval("document.all.LIN" + op + ".style.display='block'")
        }
    }

    function cuenta(element) {
        element.value = toAlpha(element.value)
        len = element.value.length
        if (parseInt(len, 10) > 200) {
            alert("Maximo 200 caracteres")
            return false;
        }
    }

    function ENVIO() {
        MAXIM = 0
        // armo array de columnas con etiqueta de color
        LBL = new Array()
        for (c = 1; c <= 15; c++)
        { LBL[c] = trim(eval("document.all.x" + c + ".value")) }

        //les = trim(lets)

        // revisa si todas las lineas con combo tienen al menos un color
        for (d = 1; d < TOPE; d++) {
            LINEA = eval("document.all.LIN" + d + ".style.display")
            // letra = Left(les, 1)
            // les = Right(les, (les.length - 1))
            // alert(letra)
            if (LINEA == 'block') {
                COMBO = trim(eval("document.all.COL" + d + ".value"))
                // COMBO tiene descruipcion de color
                if (trim(COMBO) != '') { //  alert(COMBO)
                    // revisa las columnas de etiqueta (0-9)
                    for (y = 1; y <= 15; y++) {
                        dato = eval("document.all.C" + y + "C" + d + ".value")
                        // SI LA COLUMNA TIENE VALOR DE ETIQUETA
                        if (LBL[y].length == 0) {
                            if (trim(dato) != '') {
                                alert("No tiene etiqueta descriptiva la columna : " + (y + 1) + ", LINEA : " + d)
                                eval("document.all.C" + y + "C" + d + ".value=''")
                                return false;
                            } // dato
                        } // for columnas "y"
                    }
                }
                else { // BORRO LOS COLORES DDE UN COMBO EN BLANCO
                    for (WE = 1; WE <= 15; WE++) {   //alert("C" + WE + letra)
                        eval("document.all.C" + WE + "C" + d + ".value=''")
                    }
                }

            } // block
            else {
                break;
            } // else block
        }


        thisForm.action = 'comun/inserFichaETC.asp?ETC=' + '<%=CODETC%>' + '&maxi=' + TOPE + '&tip=' + '<%=tip%>'
        // alert()
        thisForm.submit()

        return true
    }

    function FLECHA(op) {
        if (event.keyCode == 40) {
            ooo = parseInt(op, 10) + 1
            if (ooo < TOPE)
                seleccionar(eval("document.all.COL" + ooo))
        }
    }


    function prn() {
        window.open('reportes/prnETC.asp?ETC=' + '<%=CODETC%>' + '&tip=' + '<%=tip%> ')

    }
</script>
</html>
