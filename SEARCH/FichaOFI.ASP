<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
    var aCod = Array()
    var aPos11 = Array()
nume = 0
function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight+25;
  //change the height of the iframe
  document.getElementById('body0').height=
      the_height;
}
</script>
<%	COD = Request.QueryString("OFI")
    CLI = Request.QueryString("cli")
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
    rs.open "select nombre  from cliente where codigo = '"&cli&"' ", cnn
    rs.movefirst
    descli = rs("nombre")
    rs.close
    'response.write(descli)
    'response.end
	
    ' DATOS DE CABECERA DE LA OFI
    CAD =	" exec FICHAOFI '"&COD&"' , '"&cli&"'  " 
    
	'response.Write(cAD)
	rs.open cad , cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
		TITULO ="OFI -> " + ucase(trim(DESCLI))

	END IF
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body onload="document.all.ESTCLI.focus()">
<form id="thisForm" method="post" name="thisForm" action="comun/inserFICHAPO.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
		  <td width="20%"><img src="imagenes/CERRAR.gif" style="cursor:pointer;" onClick="window.close()" /></td>	
          
          <td align = "center" class="TALASBLUE" width="60%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="talasblue"><%=titulo%></td></tr>
		    </table> 
         </td>
         <td id="grab" align="RIGHT" width="10%"><img id="Img1" alt="GRABA CAMBIOS" style="cursor:pointer; " onClick="graba(1)" src="imagenes/disk.gif" />
         <img id="Img4" alt="Imprime Ficha" style="cursor:pointer; " onClick="window.open('reportes/prnfichaofi.asp?ofi='+'<%=rs("ofi") %>'+'&cli='+ '<%=cli%>')" src="imagenes/print.gif" />
	     </td>
         <td  width="20%" align="right"><img src="imagenes/logo.gif" border="0"  alt="" id="GRABA"  />
	     <input id="COD" name="COD" value="<%=rs("ofi")%>" style="display:none;"/></td>
    </tr>
</table>  
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="veri" name="veri" value="0" style="display:none">
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="0" cellspacing="0" bordercolorlight="<%=application("color2")%>" >   
	<tr valign="middle">
		<td bgcolor="#f7d975" style="height:1px;"></td>	
	</tr>
</table>
<table cellpadding="5" cellspacing="0" border="1" style="background-color:'<%=APPLICATION("FONDITO") %>';border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
    <tr><td align="left" class="AMERICANnavy">DATOS GENERALES : </td></tr>
</table> 
<table width="100%" cellspacing="0" border="0" cellpadding="1">
    <tr valign="top">
        <td>
            <table border="1    " cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" 
            bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
              <tr valign="top">
                <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">OFI #:</td>
                <td width="8%"><input type="text" id="OFI" name="OFI" value="<%=rs("OFI")%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
                <td width="5%" bgcolor="<%=(Application("BARRA"))%>" class="TITULITO">Estilo:</td>
                <td width="2%" bgcolor="<%=(Application("BARRA"))%>"><img src="imagenes/help.gif" border="0" id="estilocli" onClick="help()"
                            alt="Selecciona estilo" style="cursor:pointer" /></td>
                <td width="15%" colspan="2"><input type="text" id="ESTCLI" name="ESTCLI" value="<%=rs("ESTCLI") %>" class="datoskhaki" onchange="bakeEST();" /></td>
                <td width="5%"><input type="text" id="CODEST" name="CODEST" value="<%=rs("CODEST") %>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
                <td width="35%" colspan="2"><input type="text" id="DESEST" name="DESEST" value="<%=rs("DESEST") %>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
             </tr>
            <tr>
                <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" >CANTIDAD:</td>
                <td><input type="text" id="CANT" name="CANT" value="<%=formatnumber(rs("CANT"),0,,,true)%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>  
                <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">Tipo Prenda:</td>
                <td><input type="text" id="TPRE" name="TPRE" value="<%=rs("TPRE")%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
                <td><input type="text" id="DPRE" name="DPRE" value="<%=rs("DPRE")%>" class="DESCRIPTORES"readonly tabindex="-1" /></td>
                <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">Género:</td>
                <td width="1%"><input type="text" id="CGEN" name="CGEN" value="<%=rs("CGEN")%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
                <td width="10%" colspan="2"><input type="text" id="DGEN" name="DGEN" value="<%=rs("DGEN")%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
             </tr>
             <%KAD = "EXEC FICHAOFI_ADIC '"&COD&"', '"&CLI&"' "
             'response.write(kad)
             RS2.OPEN KAD,CNN 
             desart = ""
             IF RS2.RECORDCOUNT > 0 THEN
                RS2.MOVEFIRST
                ctem = rs2("codtem")
                dtem = rs2("Destem")
                teje = rs2("destel")
                art = rs2("codart")
                GTEL = RS2("GRUPOTELA")
            ELSE 
                ctem = ""
                dtem = ""
                teje = ""
                art = ""
                GTEL = ""
             END IF
            RS2.CLOSE %>
            <tr>
                <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO">Articulo:</td>
                <td><input type="text" id="ART" name="ART" value="<%=trim(art)%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>  
                <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">Temporada:</td>
                <td><input type="text" id="CTEM" name="CTEM" value="<%=trim(ctem)%>" class="DESCRIPTORES" readonly tabindex="-1"/></td>
                <td><input type="text" id="DTEM" name="DTEM" value="<%=trim(dtem)%>" class="DESCRIPTORES"readonly tabindex="-1" /></td>
                <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO" width="5%">Grupo Tela:</td>
                <td colspan="3"><input type="text" class="DESCRIPTORES" id="TEJE" name="TEJE" readonly tabindex="-1" value="<%=trim(GTEL)%>" /></td>             
             </tr>
           <tr>
               <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITO">Tela:</td>
                 <td colspan="8"><input type="text" id="DESART" name="DESART" value="<%=TRIM(TEJE) %>" class="descriptores" /></td>
           </tr>
        </table>
        </td>
        <td style="width:50px"><img src="BAKE/recuperaFOTOESTILO.asp?ID=<%=rs("codest")%>&CLI=<%=RS("CLI")%>" width="50px" ID="FOT" readonly tabindex="-1" /></td>
    </tr>
</table>   
<table cellpadding="5" cellspacing="0" border="1" style="background-color:'<%=APPLICATION("FONDITO") %>';border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
    <tr style="height:30px;"><td align="left" class="titulitoNAVY" >DETALLE DE PO'S :&nbsp;&nbsp;<img src="imagenes/help.gif" border="0" id="Img3" onClick="pos()" alt="Asocia PO's" style="cursor:pointer" /></td>
    </tr>
</table> 

<% cad = "SELECT distinct  pp.po FROM OFIS OO INNER JOIN POS pp ON pp.OFI = OO.codigo where oo.codigo = '"&COD&"'"
RS2.OPEN CAD, CNN
dim aPo1(20)
dim aTot(10)
IF RS2.RECORDCOUNT > 0 and rs2.recordcount < 20 THEN
    rs2.movefirst
    CN = 0
    do while not rs2.eof
            aPo1(cn)= rs2("po")%>
            <script language="jscript" type="text/jscript">
                aPos11[nume++] = '<%=rs2("po") %>'
            </script>
        <%RS2.MOVENEXT
        CN = CN + 1
    loop
END IF
rs2.close
cad = 	" exec NEWPOSOFIS '"&aPo1(0)&"',  '"&aPo1(1)&"', '"&aPo1(2)&"','"&aPo1(3)&"','"&aPo1(4)&"','"&aPo1(5)&"','"&aPo1(6)&"','"&aPo1(7)&"','"&aPo1(8)&"','"&aPo1(9)&"', " & _
        " '"&aPo1(10)&"',  '"&aPo1(11)&"', '"&aPo1(12)&"','"&aPo1(13)&"','"&aPo1(14)&"','"&aPo1(15)&"','"&aPo1(16)&"','"&aPo1(17)&"','"&aPo1(18)&"','"&aPo1(19)&"' "
'response.write(cad)
rs2.open cad,cnn
if rs2.recordcount >0 then %>
<%rs2.movefirst%>

<table  border="1" cellspacing="1" cellpadding="1" align="center" width="100%">
<%NUMPO = RS2("PO") %>    
<%do while not rs2.eof %>
    <tr style="background-color:'<%=application("barra")%>';"  >
        <td width="1%"><img src="imagenes/dele.jpg" border="0" id="Img2" onClick="dele('<%=trim(rs2("po"))%>')" alt="Elimina PO" style="cursor:pointer" /></td>
        <td class="titulitoNAVY">PO  # <%=rs2("po") %></td>
            <%FOR I = 0 TO 9%>
                <td align="center" width="5%">
                    <%TALLA = "T"&i %>
                    <input id="x<%=i%>" name="x<%=i%>" value="<%=rs2(talla)%>" class="talas" style="width:100%" tabindex=-1 readonly/>
                </td>    
            <%NEXT%>
        <td width="15%" class="texto" align="center">TOTAL COLOR</td>
    </tr>   
    <%NUMPO = RS2("PO")%>
    <%DO WHILE NOT RS2.EOF AND RS2("PO") = NUMPO%>   
        <tr  id="LIN<%=U%>" name=",LIN<%=U%>">
        
        <td style="width:39%" class="BARRA_des" colspan="2"><%=RS2("COLOR") %></td><%linea = 0%>
                <%FOR I = 0 TO 9%>
                    <td align="center" width="5%">
                    <%can = "can"&i 
                    aTot(i) = aTot(i) + rs2(can)
                    linea = linea + rs2(can) 
                    if rs2(can) > 0 then ccc = formatnumber(rs2(can),0,,true) else ccc = "" %>
                         <input id="Text1" name="x<%=i%>" value="<%=ccc%>" class="texto" style="width:100%; text-align:right" tabindex=-1 readonly/>
                    </td>    
                <%NEXT%>
                <td style="width:15%"><input id="TOT<%=u%>" name="TOT<%=u%>" value="<%=formatnumber(linea,0,,,true) %>" class="texto" style="width:100%;text-align:right;" tabindex=-1 readonly/></td>
        </tr>
        <%RS2.MOVENEXT%>
        <%IF RS2.EOF THEN EXIT DO %>
    <%LOOP %>
    <%IF RS2.EOF THEN EXIT DO %>
<%LOOP %>
 <tr>
       <td colspan="2" style="width:39%"><input id="COL<%=k%>" name="COL<%=k%>" class="tituloGRANDEgris" style="text-align:right;width:100%" value="SUB-TOTALES POR TALLA : " tabindex=-1 readonly /></td>      
                <%FOR I = 0 TO 9%>
                   <td align="center" width="5%">
                     <input id="SUBT<%=I%>" name="SUBT<%=I%>" value="<%if atot(i)> 0 then response.write(formatnumber(atot(i),0,,,true))  %>" class="tituloGRANDEgris" style="width:100%;text-align:right" tabindex=-1 readonly />
                  </td>    
                <%NEXT%>
                <%gtot = aTot(0) + aTot(1) + atot(2)+ atot(3)+ atot(4)+ atot(5) + atot(6) + atot(7) + atot(8) + atot(9) %>
                <td><input value="<%=formatnumber(gtot,0,,,true) %>" class="tituloGRANDEgris" style="width:100%;text-align:right" tabindex=-1 readonly/></td>
      </tr>
</table>
<%RS2.MOVEFIRST %>

<table  border="1" cellspacing="1" cellpadding="1" align="left" width="100%">
    <tr  class="tituloGRANDEVERDE">
        <td style="width:39%"  >RESUMEN POR TALLA-COLOR ==> 100%</td>
            <%FOR I = 0 TO 9%>
                <td align="center" width="5%">
                    <%TALLA = "T"&i %>
                    <input id="Text2" name="x<%=i%>" value="<%=rs2(talla)%>" class="tituloGRANDEVERDE" style="width:100%" tabindex=-1 readonly/>
                </td>    
            <%NEXT%>
        <td width="15%"align="center">TOTAL COLOR</td>
    </tr>  
    <%rs2.close
cad = 	" exec RESUMENPOSOFIS '"&aPo1(0)&"',  '"&aPo1(1)&"', '"&aPo1(2)&"','"&aPo1(3)&"','"&aPo1(4)&"','"&aPo1(5)&"','"&aPo1(6)&"','"&aPo1(7)&"','"&aPo1(8)&"','"&aPo1(9)&"', " & _
        " '"&aPo1(10)&"',  '"&aPo1(11)&"', '"&aPo1(12)&"','"&aPo1(13)&"','"&aPo1(14)&"','"&aPo1(15)&"','"&aPo1(16)&"','"&aPo1(17)&"','"&aPo1(18)&"','"&aPo1(19)&"' "
'response.write(cad)
rs2.open cad,cnn
if rs2.recordcount >0 then 
    rs2.movefirst 
else 
    response.end
end if
dim aTt(10)
%>
   <%DO WHILE NOT RS2.EOF%>   
        <tr>
        <td style="width:39%" class="BARRA_des"><%=RS2("COLOR") %></td><%linea = 0%>
                <%FOR I = 0 TO 9%>
                    <td align="center" width="5%">
                    <%can = "c"&i 
                    aTt(i) = aTt(i) + rs2(can)
                    linea = linea + rs2(can) 
                    if rs2(can) > 0 then ccc = formatnumber(rs2(can),0,,true) else ccc = "" %>
                         <input id="Text3" name="x<%=i%>" value="<%=ccc%>" class="texto" style="width:100%; text-align:right" tabindex=-1 readonly/>
                    </td>    
                <%NEXT%>
                <td style="width:15%"><input id="Text4" name="TOT<%=u%>" value="<%=formatnumber(linea,0,,,true) %>" class="texto" style="width:100%;text-align:right;" tabindex=-1 readonly/></td>
        </tr>
        <%RS2.MOVENEXT%>
    <%LOOP %>   
    
    
     <tr>
       <td style="width:39%"><input id="Text5" class="tituloGRANDEgris" style="text-align:right;width:100%" value="TOTALES POR TALLA : " tabindex=-1 readonly /></td>      
                <%FOR I = 0 TO 9%>
                   <td align="center" width="5%">
                     <input id="Text6" name="SUBT<%=I%>" value="<%if atot(i)> 0 then response.write(formatnumber(att(i),0,,,true))  %>" class="tituloGRANDEgris" style="width:100%;text-align:right" tabindex=-1 readonly />
                  </td>    
                <%NEXT%>
                <%gtot = aTt(0) + aTt(1) + att(2)+ att(3)+ att(4)+ att(5) + att(6) + att(7) + att(8) + att(9) %>
                <td><input value="<%=formatnumber(gtot,0,,,true) %>" class="tituloGRANDEgris" style="width:100%;text-align:right" tabindex=-1 readonly/></td>
      </tr>
    
     
</table>


<%END IF %>



<script type="text/jscript" language="jscript">

    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";

function pos() {
    if (trim(document.all.ESTCLI.value) == '') {
        alert("Primero seleccione el estilo del Cliente")
        document.all.ESTCLI.focus();
        return true;
    }
    /*   document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"    */
    cad = 'help/HLPposOFI.asp?cli=' + '<%=TRIM(CLI)%>' + '&est=' + document.all.CODEST.value + '&ofi=' + trim(document.all.OFI.value) + '&esCLI=' + document.all.ESTCLI.value 
    window.open(cad, '', opc)
}
function dele(pos) {
   
    document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"   
   
    cad = 'comun/deleposOFI.asp?cli=' + '<%=TRIM(CLI)%>' + '&est=' + document.all.CODEST.value + '&ofi=' + trim(document.all.OFI.value) + '&po=' + pos
    {si = confirm("¿ Confirma la Eliminación de esta PO ? ");}
    if (si == false)
    { return false; }
    else
    { document.all.body10.src = cad }

return true    
}
function bakeEST() {
    cad = 'bake/bakeESTILOofi.asp?pos=' + trim(thisForm.ESTCLI.value) + '&cli=' + '<%=Request.QueryString("cli")%>'
   /*    
    document.all.body10.style.display = 'block'
    document.all.body10.height = "350"
    document.all.body10.width = "100%"
    */
    document.all.body10.src = cad
}

function help() {   
cad = 'help/HLPestiloOFI.asp?cli=' + '<%=TRIM(CLI)%>'
window.open(cad,'',opc)
}
function graba() { 
aa = trim(document.all.OFI.value)
bb = trim(document.all.ESTCLI.value)

if ((aa == 'AUTO' || aa == '') && (bb.length==0)) {
    alert("¿Va a crear una ofi sin estilo?")
    return false;
}
cc = parseInt('<%=rs2.recordcount%>',10)
if (cc <= 0) {
    alert("¿Va a generar una OFI sin PO's?")
    return false;    
}
// eliminar TODAS las POS
// Falta un for....

for (khs = 0; khs < nume; khs++) {
    pos = aPos11[khs]
    cad = 'comun/deleposOFI.asp?cli=' + '<%=TRIM(CLI)%>' + '&est=' + document.all.CODEST.value + '&ofi=' + trim(document.all.OFI.value) + '&po=' + pos
    document.all.body10.src = cad
}
// volver a asignar todas las po's para que se recalcule la cantidad total de la ofi
for (plata = 0; plata < nume; plata++) {
    cad = 'help/HLPposOFI.asp?cli=' + '<%=TRIM(CLI)%>' + '&est=' + document.all.CODEST.value + '&ofi=' + trim(document.all.OFI.value) + '&esCLI=' + document.all.ESTCLI.value + '&apos=' + aPos11
document.all.body10.src = cad

}






    alert("Todo correcto")
return true;

}

</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>