<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%Response.Buffer = true %>
<%Session.LCID=2058%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<LINK REL="stylesheet" TYPE="text/css" HREF="../estilos1.CSS">
<!--#include file="../comun/funcionescomunes.asp"-->
<!--#include file="../includes/funcionesVBscript.asp"-->
<!--#include file="../includes/cnn.inc"-->



<% 
IF  request.QueryString("EXCEL") = "1" THEN
  archivo = "c:\temp\despacho.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 
END IF



    cli = trim(request.QueryString("cli") )
    fec = trim(request.QueryString("fec") )
    gte = trim(request.QueryString("gte") )
    est = trim(request.QueryString("est") )
    poo = trim(request.QueryString("poo") )
    tem = trim(request.QueryString("tem") )
    tel = trim(request.QueryString("tel") )
    PRO = trim(request.QueryString("PRO") )
    OFI = trim(request.QueryString("OFI") )
if len(trim(ofi)) = 2 then
    cad =   " exec SP_PLANEA_juan2 '"&CLI&"', '"&FEC&"', '"&GTE&"', '"&POO&"', '"&TEM&"', "&OFI&", '"&PRO&"', '"&EST&"' , '"&TEL&"' " 
else    
    cad =   " exec SP_PLANEA_juan '"&CLI&"', '"&FEC&"', '"&GTE&"', '"&POO&"', '"&TEM&"', "&OFI&", '"&PRO&"', '"&EST&"' , '"&TEL&"' " 
end if
'RESPONSE.WRITE (len(trim(cad)))
'RESPONSE.END


rs.open cad,cnn
if rs.recordcount <=0 then 
    RESPONSE.WRITE("NO HAY DATOS QUE CUMPLAN LOS CRITERIOS DE SU FILTRO")
    RESPONSE.End
END IF

%>

<body >

<center>
<table id="TABLA" align="CENTER" width="100%"	 cellpadding="1" cellspacing="1" style="background-color:#c4c4c4">
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr class="BARRA333" valign="top" align="center"  style="background-color:#FFF;">
    <td colspan="6"></td>
    <td colspan="18" align="center">P E D I D O&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100%</td>
    <td colspan="18" align="center">C O R T E&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;105%</td>
    <td colspan="22" align="center">T E L A &nbsp;&nbsp;&nbsp;&nbsp;P R I N C I P A L &nbsp;&nbsp;&nbsp;&nbsp;105%</td>
    <%for i=2 to 10 %>
     <td colspan="22" align="center">T E L A &nbsp;&nbsp;&nbsp;&nbsp;<%=i%> &nbsp;&nbsp;&nbsp;&nbsp;105%</td>
     <%next%>
</tr>

<tr class="BARRA333" valign="top" align="center"  style="background-color:#FFF;">
    <td >PO</td>   
    <td align="center">ESTILO</td>
    <td align="center">OFI</td>
    <td align="center">PROTO</td>
    <td align="center">COD</td>
    <td align="center">COLOR</td>
    <%FOR I=16 TO 31 %>
    <td align="center" style="background-color:#CAFFFF; font-size:smaller; font-weight:800"><%=RS.FIELDS(I).NAME%></td>
    <%NEXT %>
    <td align="center" style="background-color:#FFF; font-size:smaller; font-weight:800"><%=RS.FIELDS(I).NAME%></td>
    <%FOR I=16 TO 31 %>
    <td align="center" style="background-color:#FFFFB9; font-size:smaller; font-weight:800"><%=RS.FIELDS(I).NAME%></td>
    <%NEXT %>
    <td align="center" style="background-color:#FFf; font-size:smaller; font-weight:800"><%=RS.FIELDS(I).NAME%></td>
    <%for m= 1 to 10 %>
        <td align="center" style="background-color:#aec8de; font-size:smaller; font-weight:800">TELA</td>
        <td align="center" style="background-color:#f9ebd3; font-size:smaller; font-weight:800">Kg</td>
      <td align="center" style="background-color:#ded9ff; font-size:smaller; font-weight:800">Pza</td>  
       <%FOR I=16 TO 31 %>
        <td align="center" style="background-color:#d4ecd8; font-size:smaller; font-weight:800"><%=RS.FIELDS(I).NAME%></td>
        <%NEXT %>
        <td align="center" style="background-color:#FFf; font-size:smaller; font-weight:800"><%=RS.FIELDS(I).NAME%></td>
         <td align="center" style="background-color:#ead6e2; font-size:smaller; font-weight:800">T2</td>  
    <%next %>
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN RS.MOVEFIRST%>
<%DO WHILE NOT RS.EOF %>
	<tr valign="top"   style="background-color:#FFF;">
	    <td class="DATOSnormal" style="background-color:#fff; font-size:smallest; font-weight:300" align="center"><%=RS("PO")%></td>
	    <td class="DATOSnormal" style="background-color:#fff; font-size:smallest; font-weight:300" align="center"><%=ucase(rs("ESTCLI"))%></td>
        <td class="DATOSnormal" style="background-color:#fff; font-size:smallest; font-weight:300" align="center"><%=RS("OFI")%></td>
        <td class="DATOSnormal" style="background-color:#fff; font-size:smallest; font-weight:300" align="center"><%=RS("ajuste")%></td>
        <td class="DATOSnormal" style="background-color:#fff; font-size:smallest; font-weight:300" align="center"><%=SoloNumeros(rs("color"))%></td>
        <td class="DATOSnormal" style="background-color:#fff; font-size:smallest; font-weight:300" align="left"><%=Sololetras(RS("COLOR"))%></td>
        <!-- pedido 100% -->
        <%FOR I=16 TO 31 %>
        <td align="right"  class="DATOSnormal"  style="background-color:#CAFFFF; font-size:smallest; font-weight:300"><%IF CDBL(RS.FIELDS.item(i)) > 0 THEN RESPONSE.WRITE(formatnumber(RS.FIELDS.item(i),0,,,true))%></td>
        <%NEXT %>
        <td align="right"  class="DATOSnormal"  style="background-color:#fff; font-size:smallest; font-weight:300"><%IF CDBL(RS.FIELDS.item(i)) > 0 THEN RESPONSE.WRITE(formatnumber(RS.FIELDS.item(i),0,,,true))%></td>
        <!-- pedido 105% -->
        <%FOR I=34 TO 49 %>
        <td align="right"  class="DATOSnormal"  style="background-color:#FFFFB9; font-size:smallest; font-weight:300"><%IF CDBL(RS.FIELDS.item(i)) > 0 THEN RESPONSE.WRITE(formatnumber(RS.FIELDS.item(i),0,,,true))%></td>
        <%NEXT %>
        <td align="right"  class="DATOSnormal"  style="background-color:#fff; font-size:smallest; font-weight:300"><%IF CDBL(RS.FIELDS.item(i)) > 0 THEN RESPONSE.WRITE(formatnumber(RS.FIELDS.item(i),0,,,true))%></td>
        
        
        <!-- empieza las telas -->
        <%LETRAS = "ABCDEFGHIJ"
        INI = 55
        for K= 1 TO 10 %>
            <%
            COD = MID(LETRAS, K,1) + "COD"
            IF ISNULL(RS(COD)) THEN 
               TELA = "" 
               TOC=""
            ELSE 
                TELA = rs(COD) 
                t2 = MID(LETRAS,  K,1) + "TOC"
                IF LEFT(TELA,1) = "9" THEN 
                    if isnull(RS(T2)) then
                        toc = ""
                    else
                        TOC = FORMATNUMBER(CDBL(RS(T2))/1000,3,,,TRUE) 
                    end if
                end if
            END IF
            CON = MID(LETRAS,  K,1) + "CON"
            IF  ISNULL(RS(CON))  THEN  KILO = "" ELSE KILO = FORMATNUMBER(CDBL(RS(CON))/1000,5,,,TRUE) 
            TOT  = MID(LETRAS, K,1) + "TOT"
            IF ISNULL(RS(TOT)) THEN  TOTAL = "" ELSE TOTA = FORMATNUMBER(CDBL(RS(TOT))/1000,0,,,TRUE) 
            PZA = MID(LETRAS,  K,1) + "pza"
            IF ISNULL(RS(PZA)) THEN  PZA= "" ELSE PZA = FORMATNUMBER(CDBL(RS(PZA)),0,,,TRUE) 
            %>
            <td align="right"  class="DATOSnormal"  style="background-color:#aec8de; font-size:smallest; font-weight:300"><%=TELA%></td>
            <td align="right"  class="DATOSnormal"  style="background-color:#f9ebd3; font-size:smallest; font-weight:300"><%=KILO%></td>
            <td align="right"  class="DATOSnormal"  style="background-color:#ded9ff; font-size:smallest; font-weight:300"><%=PZA%></td>
            <%
            FOR I=INI TO INI + 15%>
                <%IF ISNULL(RS.FIELDS.item(i)) THEN  CANTI= "" ELSE IF CDBL(RS.FIELDS.item(i)) > 0 THEN CANTI =FORMATNUMBER(CDBL(RS.FIELDS.item(i)),0,,,TRUE) ELSE CANTI = "" %>
                <td align="right"  class="DATOSnormal"  style="background-color:#d4ecd8; font-size:smallest; font-weight:300"><%=CANTI%></td>
            <%NEXT %>
             <%IF ISNULL(RS.FIELDS.item(i)) THEN  TOT= "" ELSE IF CDBL(RS.FIELDS.item(i)) > 0 THEN TOT =FORMATNUMBER(CDBL(RS.FIELDS.item(i)),3,,,TRUE) ELSE TOT = "" %>
            <td align="right"  class="DATOSnormal"  style="background-color:#FFF; font-size:smallest; font-weight:300"><%=TOT%></td>
            <td align="right"  class="DATOSnormal"  style="background-color:#ead6e2; font-size:smallest; font-weight:300"><%=TOC%></td>  
            <%INI = INI + 22 %>    
        <%NEXT%>
        <!--  fin bloque tela i -->






    </tr>

	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
<%LOOP%>
</table>
<p>&nbsp;</p>
<%  
Public Function SoloNumeros(cadena)
     Solo= ""
For i = 1 To Len(cadena) 
    letra   = Mid(cadena, i, 1) 
    If IsNumeric(letra) Then Solo = Solo + Mid(cadena, i, 1) 
Next 
SoloNumeros = Solo
end function

Public Function Sololetras(cadena)
     Solo= ""
For i = 1 To Len(cadena) 
    letra   = Mid(cadena, i, 1) 
    If IsNumeric(letra) = false Then Solo = Solo + Mid(cadena, i, 1) 
Next 
Sololetras = Solo
end function

%>
</html>
