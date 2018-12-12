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
        'RESPONSE.Write(RS2.RECORDCOUNT)
	END IF
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
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
{	FONT-WEIGHT: 200;
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
.DESCRIPTORnavy
{   FONT-SIZE: 10px;
    WIDTH: 100%;
    COLOR: navy;
    FONT-FAMILY: Arial;
    BACKGROUND-COLOR: gainsboro
}
.DESCRIPTORnavy2
{   FONT-SIZE: 10px;
    COLOR: navy;
    FONT-FAMILY: Arial;
    BACKGROUND-COLOR: gainsboro
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
{
	FONT-WEIGHT: 700;
	FONT-SIZE: 10px;
	color : black;
	background-color:#c0c0c0;
	WIDTH: 100%;
	FONT-FAMILY: Arial;
	
}
.TALASROJO
{
    FONT-WEIGHT: 900;
    FONT-SIZE: 11px;
    WIDTH: 100%;
    COLOR: RED;
    FONT-FAMILY: "Arial";
    
}
.BARRA_des
{   FONT-SIZE: 10px;
	color:Black;
    WIDTH: 100%;	
    FONT-FAMILY: Arial, Helvetica, sans-serif;
    text-align:right;
    padding-right:5px;
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
        .style7
        {   FONT-SIZE: 10px;
	        COLOR: NAVY;
            width: 5%;
            text-align : center;
            font-weight:bold;
            BACKGROUND-COLOR: gainsboro
        }
        .style8
        {
            FONT-SIZE: 9px; 
            color: Black;
            WIDTH: 5%;
            FONT-FAMILY: Arial, Helvetica, sans-serif;
            text-align: left padding-left:5px;
        }
.style10
        {
            FONT-SIZE: 9px; 
            color: Black;
            WIDTH: 35%;
            FONT-FAMILY: Arial, Helvetica, sans-serif;
            text-align: left padding-left:5px;
        }
         .style9
        {
            FONT-SIZE: 9px;      
            color: Black;
            WIDTH: 75%;
            FONT-FAMILY: Arial, Helvetica, sans-serif;
            text-align: left padding-left:5px;
        }
    </style>
</head>
<body>
<table cellpadding="22" cellspacing="0" border="0" align="center" width="100%" bordercolorlight="#f7d975">
	<tr><td align="center" class="talasblue"><%=titulo%></td></tr>
</table>   
<hr />
<table cellpadding="5" cellspacing="0" border="0" width="100%" align="center" >
    <tr><td class="tituloGRANDEgris" style="text-align:left">DATOS GENERALES : </td></tr>
</table> 
<table width="100%" cellspacing="0" border="0" cellpadding="1">
    <tr valign="top">
        <td width="100%">
            <table border="0" cellpadding="2" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" 
            bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
              <tr valign="top">
                <td width="10%" class="style5">OFI #:</td>
                <td class="style3" width="5%"><%=trim(rs("OFI"))%> </td>    
                <td width="10%" class="style5">Estilo:</td>
                <td class="style4" width="10%"><%=TRIM(rs("ESTCLI")) %> </td>
                <td class="style6" colspan="2" width="60%"><%=TRIM(rs("CODEST"))%> - <%=TRIM(rs("DESEST")) %></td>
            </td>
            </tr>
<!-------------------------------------------------->
           <tr >
                <td class="style5"  >ARTICULO:</td>
                <td class="style3" ><%=trim(rs2("Codart"))%>  </td>  
                <td class="style5">Temporada:</td>
                <td class="style4"><%=TRIM(rs2("codtem"))%> - <%=TRIM(rs2("destem"))%></td>
                <td class="style5">Tejido:</td>
                <td class="DESCRIPTORES" ><%=TRIM(rs2("codtel"))%> - <%=TRIM(rs2("destel"))%></td>
            </tr>

<!-------------------------------------------------->
            <tr >
                <td class="style5"  >CANTIDAD:</td>
                <td class="style3" ><%=formatnumber(rs("CANT"),0,,,true)%></td>  
                <td class="style5">Tipo Prenda:</td>
                <td class="style4"><%=TRIM(rs("TPRE"))%> - <%=TRIM(rs("DPRE"))%></td>
                <td class="style5">Genero:</td>
                <td class="DESCRIPTORES" ><%=TRIM(rs("CGEN"))%> - <%=TRIM(rs("DGEN"))%></td>
            </tr>

            <!-------------------------------------------------->
           <tr >
                <td class="style5">PROTO:</td>
                <td class="style3" ><%=trim(rs2("PRO"))%> -  <%=TRIM(rs2("VER"))%></td>
                <td class="titulito"></td>
                <td class="style4"></td>
                <td class="style5"></td>
                <td class="DESCRIPTORES" ></td>
            </tr>



        </table>
        </td>
       
    </tr>
</table>   
<%COBER = CDBL(RS2("COBER")) + 100
        rs2.close
        cad = 	" exec DATOS_avios_OFI  '"&COD&"' "
        'response.write(cad)
        rs2.open cad,cnn
        if rs2.recordcount >0 then 
            rs2.movefirst 
        else 
            response.end
        end if %>
      <table  border="1" cellspacing="0" cellpadding="1" align="left" width="100%" >
            <tr  class="tituloGRANDEgris"><td >&nbsp;</td>
                <td colspan="3">TALLA-COLOR ==> <%=FORMATNUMBER(COBER,0,,TRUE) %>%</td>
                <td align="center"  class="tituloGRANDEgris" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t0")%>&nbsp;</td>    
                <td align="center"  class="tituloGRANDEgris" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t1")%>&nbsp;</td>    
                <td align="center"  class="tituloGRANDEgris" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t2")%>&nbsp;</td>    
                <td align="center"  class="tituloGRANDEgris" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t3")%>&nbsp;</td>    
                <td align="center"  class="tituloGRANDEgris" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t4")%>&nbsp;</td>    
                <td align="center"  class="tituloGRANDEgris" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t5")%>&nbsp;</td>    
                <td align="center"  class="tituloGRANDEgris" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t6")%>&nbsp;</td>    
                <td align="center"  class="tituloGRANDEgris" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t7")%>&nbsp;</td>    
                <td align="center"  class="tituloGRANDEgris" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t8")%>&nbsp;</td>    
                <td align="center"  class="tituloGRANDEgris" style="padding-left:10px; padding-right:10px;">&nbsp;<%=rs2("t9")%>&nbsp;</td>     
                <td>TOTAL_COLOR</td>
            </tr>  
            <%
        dim ATT(10)
        dim aTot(10)
        dim ATT2(10)
        DO WHILE NOT RS2.EOF%> 
             <tr>
                <td  class="style7">&laquo;&nbsp;&raquo; </td>
                <td  class="descriptornavy" colspan="3"><%=RS2("COLOR") %></td>
                    <%linea = 0%>
                    <%FOR I = 0 TO 9%>
                        <td align="center"  class="descriptornavy"  >
                        <%can = "c"&i  
                        ATT(i) = ATT(i) + CDBL(rs2(can))
                        linea = linea +CDBL(rs2(can) )
                        if rs2(can) > 0 then ccc = formatnumber(rs2(can),0,,true) else ccc = "&nbsp;" %>
                            <%=ccc%>
                        </td>    
                    <%NEXT%>
                <td class="descriptornavy" style="text-align:right;padding-right:2px;"><%=formatnumber(linea,0,,,true)%></td>
            </tr>
            <%PZA_COL = RS2("COLOR")%>  
            <%DO WHILE NOT RS2.EOF AND PZA_COL = RS2("COLOR")%>
               
                 <tr> <td  class="style8"><%=trim(rs2("avio"))%></td>
                    <td  COLSPAN="1" class="style9"><%=trim(RS2("desavi"))%></td>
                    <td  COLSPAN="1" class="style10"><%=trim(RS2("obs"))%>&nbsp;</td>
                    <td  COLSPAN="1" class="style8"><%=trim(RS2("uni"))%>&nbsp;</td>
                        <%linea2 = 0%>
                        <%FOR I = 0 TO 9%>
                            <td align="center"  class="BARRA_des">
                            <%can = "cn"&i 
                            ATT2(i) = ATT2(i) + CDBL(rs2(can))
                            linea2 = linea2 +CDBL(rs2(can) )
                            if rs2(can) > 0 then ccc = formatnumber(rs2(can),0,,true) else ccc = "&nbsp;" %>
                                <%=ccc%>
                            </td>    
                        <%NEXT%>
                 <td class="BARRA_des" style="text-align:right;padding-right:2px;" ><%=formatnumber(linea2,0,,,true) %></td>
                </tr>
                <%RS2.MOVENEXT%>
                <%IF RS2.EOF THEN EXIT DO%>
            <%LOOP %>   

                <%IF RS2.EOF THEN EXIT DO%>
            <%LOOP %>   
             <tr>
               <td class="tituloGRANDEgris" colspan="4">TOTALES POR TALLA :</td>      
                        <%FOR I = 0 TO 9%>
                           <td align="center" width="5%" class="tituloGRANDEgris" >
                             <%if ATT(i)> 0 then response.write(formatnumber(att(i),0,,,true)) else response.write("&nbsp;")  %></td>    
                        <%NEXT%>
                        <%gtot = ATT(0) + ATT(1) + ATT(2)+ ATT(3)+ ATT(4)+ ATT(5) + ATT(6) + ATT(7) + ATT(8) + ATT(9) %>
                        <td class="tituloGRANDEgris" style="text-align:right"><%=formatnumber(gtot,0,,,true) %></td>
              </tr>
    
     
        </table>
    </td>
</tr>
</table>




<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>