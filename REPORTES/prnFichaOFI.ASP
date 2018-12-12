<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>



<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
var aCod = Array() 

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
	
    ' DATOS DE CABECERA DE LA PO
    CAD =	" exec FICHAOFI '"&COD&"' , '"&cli&"'  " 
    
	KAD =  " exec FICHAOFI_ADIC '"&COD&"' , '"&cli&"'  " 
    ' response.Write(cAD)
	rs.open cad , cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
		TITULO ="OFI # : " + COD  +" -> " + ucase(trim(DESCLI))
        RS2.OPEN KAD, CNN
	END IF

    archivo = "%temp%"+"ofi" + trim(cod)+ ".xls"
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<%  Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo  %>




<title><%=titulo%></title>

    <style type="text/css">
        .style3
        {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            FONT-SIZE: 10px;
            WIDTH: 12%;
            COLOR: navy;
            FONT-FAMILY: Arial;
            BACKGROUND-COLOR: transparent;
        }
        .style4
        {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            FONT-SIZE: 10px;
            WIDTH: 21%;
            COLOR: navy;
            FONT-FAMILY: Arial;
            BACKGROUND-COLOR: transparent;
        }
        .style5
        {
            FONT-WEIGHT: 900;
            FONT-SIZE: 11px;
            color: #000;
            FONT-FAMILY: "Arial";
            width: 11%;
        }
        .style6
        {
            border-style: none;
            border-color: inherit;
            border-width: medium;
            FONT-SIZE: 10px;
            WIDTH: 11%;
            COLOR: navy;
            FONT-FAMILY: Arial;
            BACKGROUND-COLOR: transparent;
        }
.TITULITO
{	FONT-WEIGHT: 900;
    FONT-SIZE: 11px;
    color:#000;
    FONT-FAMILY: "Arial";
}
.TALASBLUE
{   FONT-WEIGHT: 600;
    FONT-SIZE: 15px;
    COLOR: NAVY;
    FONT-FAMILY: Arial;
  
}
.DESCRIPTORES
{
    BORDER-RIGHT: medium none;
    BORDER-TOP: medium none;
    FONT-SIZE: 10px;
    BORDER-LEFT: medium none;
    WIDTH: 100%;
    COLOR: navy;
    BORDER-BOTTOM: medium none;
    FONT-FAMILY: Arial;
    BACKGROUND-COLOR: transparent
}
.TITULITOnavy
{	FONT-WEIGHT: 900;
    FONT-SIZE: 11px;
    color:Navy;
    FONT-FAMILY: "Arial";
}
.tituloGRANDEgris
{	BORDER-RIGHT: medium none;
    BORDER-TOP: medium none;
	FONT-WEIGHT: 700;
	FONT-SIZE: 12px;
	color : black;
	background-color:#c0c0c0;
	WIDTH: 100%;
	FONT-FAMILY: Arial;
	TEXT-ALIGN: CENTER;
    BORDER-LEFT: medium none;
	BORDER-BOTTOM: medium none;
}
.TITULITOWHITE
{
    BORDER-RIGHT: medium none;
    BORDER-TOP: medium none;
    FONT-WEIGHT: 900;
    FONT-SIZE: 11px;
    BORDER-LEFT: medium none;
    WIDTH: 100%;
    COLOR: white;
    BORDER-BOTTOM: medium none;
    FONT-FAMILY: "Arial";
    
}
.BARRA_des
{   FONT-SIZE: 10px;
    font-weight:bold;
	color:Black;
    WIDTH: 100%;	
    FONT-FAMILY: Arial, Helvetica, sans-serif;
    text-align:left
    padding-left:5px;
}

.TEXTO
{   BORDER-RIGHT: medium none;
    BORDER-TOP: medium none;
    FONT-SIZE: 10px;
	COLOR: NAVY;
    BORDER-LEFT: medium none;
    BORDER-BOTTOM: medium none;
    FONT-FAMILY: Arial;
}



    </style>
</head>
<body>


<table cellpadding="22" cellspacing="0" border="0" align="center" width="100%" bordercolorlight="#f7d975">
	<tr><td align="center" class="talasblue"><%=titulo%></td></tr>
</table> 
     

<hr />
<table cellpadding="5" cellspacing="0" border="0" width="100%" align="center" >
    <tr><td class="american14" style="text-align:left">DATOS GENERALES : </td></tr>
</table> 


<table width="100%" cellspacing="0" border="0" cellpadding="1">
    <tr valign="top">
        <td width="100%">
            <table border="0" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" 
            bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
              <tr valign="top">
                <td width="10%" class="TITULITO">OFI #:</td>
                <td class="style3" width="5%"><%=trim(rs("OFI"))%> </td>    
                <td width="10%" class="TITULITO">Estilo:</td>
                <td class="style4" width="10%"><%=TRIM(rs("ESTCLI")) %> </td>
                <td class="style6" colspan="2" width="60%"><%=TRIM(rs("CODEST"))%> - <%=TRIM(rs("DESEST")) %></td>
            </td>
            </tr>

<!-------------------------------------------------->


            <tr class="TITULITO" >
                <td class="TITULITO"  >ARTICULO:</td>
                <td class="style3" ><%=trim(rs2("Codart"))%>  </td>  
                <td class="titulito">Temporada:</td>
                <td class="style4"><%=TRIM(rs2("codtem"))%> - <%=TRIM(rs2("destem"))%></td>
                <td class="style5">Tejido:</td>
                <td class="DESCRIPTORES" ><%=TRIM(rs2("codtel"))%> - <%=TRIM(rs2("destel"))%></td>
            </tr>
            <%rs2.close%>
<!-------------------------------------------------->



            <tr class="TITULITO" >
                <td class="TITULITO"  >CANTIDAD:</td>
                <td class="style3" ><%=formatnumber(rs("CANT"),0,,,true)%></td>  
                <td class="titulito">Tipo Prenda:</td>
                <td class="style4"><%=TRIM(rs("TPRE"))%> - <%=TRIM(rs("DPRE"))%></td>
                <td class="style5">Genero:</td>
                <td class="DESCRIPTORES" ><%=TRIM(rs("CGEN"))%> - <%=TRIM(rs("DGEN"))%></td>
            </tr>
        </table>
        </td>
       
    </tr>
</table>   
<hr />

<table cellpadding="5" cellspacing="0" border="0" width="100%" align="center" >
    <tr style="height:30px;"><td style="text-align:left" class="american14" >DETALLE DE PO'S :</td>
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
            aPo1(cn)= rs2("po")
        RS2.MOVENEXT
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

<table  border="0" cellspacing="1" cellpadding="1" align="left" width="100%">
<tr>
    <td>
        <table  border="0" cellspacing="1" cellpadding="3" align="left">
        <%NUMPO = RS2("PO") %>    
        <%do while not rs2.eof %>
            <tr style="background-color:'<%=application("color1")%>'"  >
                <td >&nbsp;</td>
                <td class="titulitoNAVY">PO  # <%=trim(rs2("po"))%></td>
                <td align="center"  class="titulitoNAVY" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t0")%>&nbsp;</td>    
                <td align="center"  class="titulitoNAVY" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t1")%>&nbsp;</td>    
                <td align="center"  class="titulitoNAVY" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t2")%>&nbsp;</td>    
                <td align="center"  class="titulitoNAVY" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t3")%>&nbsp;</td>    
                <td align="center"  class="titulitoNAVY" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t4")%>&nbsp;</td>    
                <td align="center"  class="titulitoNAVY" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t5")%>&nbsp;</td>    
                <td align="center"  class="titulitoNAVY" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t6")%>&nbsp;</td>    
                <td align="center"  class="titulitoNAVY" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t7")%>&nbsp;</td>    
                <td align="center"  class="titulitoNAVY" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t8")%>&nbsp;</td>    
                <td align="center"  class="titulitoNAVY" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t9")%>&nbsp;</td>                           
                <td align="center" class="titulitoNAVY">TOTAL_COLOR</td>
            </tr>   
            <%NUMPO = RS2("PO")%>
            <%DO WHILE NOT RS2.EOF AND RS2("PO") = NUMPO%>   
                <tr>
                <td class="BARRA_des" colspan="2"><%=trim(RS2("COLOR"))%></td><%linea = 0%>
                        <%FOR I = 0 TO 9%>
                            <td align="center" class="TEXTO" style="width:100%">
                            <%can = "can"&i 
                            aTot(i) = aTot(i) + rs2(can)
                            linea = linea + rs2(can) 
                            if rs2(can) > 0 then ccc = formatnumber(rs2(can),0,,true) else ccc = "-"%>
                                 <%=ccc%>
                            </td>    
                        <%NEXT%>
                        <td class="texto" style="text-align:right"><%=formatnumber(linea,0,,,true)%></td>
                </tr>
                <%RS2.MOVENEXT%>
                <%IF RS2.EOF THEN EXIT DO %>
            <%LOOP %>
            <%IF RS2.EOF THEN EXIT DO %>
        <%LOOP %>
         <tr class="tituloGRANDEgris">
               <td colspan="2">SUB-TOTALES POR TALLA : </td>      
                        <%FOR I = 0 TO 9%>
                           <td align="center" >
                             <%if atot(i)> 0 then response.write(formatnumber(atot(i),0,,,true)) else response.write("-") %>
                          </td>    
                        <%NEXT%>
                        <%gtot = aTot(0) + aTot(1) + atot(2)+ atot(3)+ atot(4)+ atot(5) + atot(6) + atot(7) + atot(8) + atot(9) %>
                        <td class="tituloGRANDEgris"  style="text-align:right" ><%=formatnumber(gtot,0,,,true) %></td>
              </tr>
        </table>
    </td>
</tr>
<tr>
<td>

        <%RS2.MOVEFIRST %>

        <table  border="0" cellspacing="1" cellpadding="1" align="left" >
            <tr  class="tituloGRANDEVERDE">
            
                <td colspan="2">RESUMEN POR TALLA-COLOR ==> 100%</td>
                <td align="center"  class="TITULITOWHITE" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t0")%>&nbsp;</td>    
                <td align="center"  class="TITULITOWHITE" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t1")%>&nbsp;</td>    
                <td align="center"  class="TITULITOWHITE" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t2")%>&nbsp;</td>    
                <td align="center"  class="TITULITOWHITE" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t3")%>&nbsp;</td>    
                <td align="center"  class="TITULITOWHITE" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t4")%>&nbsp;</td>    
                <td align="center"  class="TITULITOWHITE" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t5")%>&nbsp;</td>    
                <td align="center"  class="TITULITOWHITE" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t6")%>&nbsp;</td>    
                <td align="center"  class="TITULITOWHITE" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t7")%>&nbsp;</td>    
                <td align="center"  class="TITULITOWHITE" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t8")%>&nbsp;</td>    
                <td align="center"  class="TITULITOWHITE" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t9")%>&nbsp;</td>     
                <td>TOTAL_COLOR</td>
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
                <tr><td></td>
                <td  class="BARRA_des"><%=RS2("COLOR") %></td><%linea = 0%>
                        <%FOR I = 0 TO 9%>
                            <td align="center"  class="texto">
                            <%can = "c"&i 
                            aTt(i) = aTt(i) + rs2(can)
                            linea = linea + rs2(can) 
                            if rs2(can) > 0 then ccc = formatnumber(rs2(can),0,,true) else ccc = "-" %>
                                <%=ccc%>
                            </td>    
                        <%NEXT%>
                        <td class="texto" style="text-align:right;padding-right:2px;" ><%=formatnumber(linea,0,,,true) %></td>
                </tr>
                <%RS2.MOVENEXT%>
            <%LOOP %>   
             <tr>
               <td class="tituloGRANDEgris" colspan="2">TOTALES POR TALLA :</td>      
                        <%FOR I = 0 TO 9%>
                           <td align="center" width="5%" class="tituloGRANDEgris" >
                             <%if atot(i)> 0 then response.write(formatnumber(att(i),0,,,true)) else response.write("-")  %></td>    
                        <%NEXT%>
                        <%gtot = aTt(0) + aTt(1) + att(2)+ att(3)+ att(4)+ att(5) + att(6) + att(7) + att(8) + att(9) %>
                        <td class="tituloGRANDEgris" style="text-align:right"><%=formatnumber(gtot,0,,,true) %></td>
              </tr>
    
     
        </table>
    </td>
</tr>
</table>

<%END IF %>



<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>