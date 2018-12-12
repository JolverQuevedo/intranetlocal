<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>

<script type="text/jscript" language="jscript">
var NUMTAL=0
var aHil = new Array()
var aDes = new Array()
var aKgs = new Array()
var aVal = new Array()
var aRut = new Array()
var aMat = new Array()
var totalhilados = 0

</script>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->

<%Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 
    Set RS3 = Server.CreateObject("ADODB.Recordset")
	RS3.CursorLocation   = 3
	RS3.CursorType       = 3    
	RS3.LockType         = 1 
    Set RS4 = Server.CreateObject("ADODB.Recordset")
	RS4.CursorLocation   = 3
	RS4.CursorType       = 3    
	RS4.LockType         = 1 
	rs.open "select * from tb_ctrl"
	rs.movefirst
	mermatela = rs("mermatela")
    air = rs("air")
    sea = rs("sea")
    dhl = rs("dhl")
	rs.close

    CAD = "EXEC ventas..SP_TIPODECAMBIO"
    RS.Open CAD, Cnn
    bajo = rs("bajo")
    rs.close

    PRO	= Request.QueryString("PRO")
	VER = Request.QueryString("VER")
	CLI	= Request.QueryString("CLI")
    cot	= Request.QueryString("cot")
	CAD =	" exec FICHACOTI_HEAD '"&PRO&"' , '"&VER&"' " 
	
	'response.Write(cAD)
	rs.open cad , cnn
	
		RS.MOVEFIRST
	OBS= RS("OBS")	
    coti = RS("COTI")
    OREDEN = rs("OREDEN")
    dim gKgs, gmerruta, gctorut

	IF RS("COTI")= "AUTO" THEN
	    marka = 0	       
		titulo = "COTIZACION #"
	else
	    marka = 1
		titulo = "COTIZACION # " + trim(rs("COTI"))
	END IF
    cot = trim(rs("COTI"))
dim dolkil
 dolkil = 0
    archivo = "c:\temp\coti" + trim(coti)+ ".xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo  
 %>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>FICHA COTIZADOR</title>

<script language="javascript" type="text/javascript">
RENTAS = parseFloat('<%=CDBL(RS("IMPU")) %>')/100
</script>
<style type="text/css">
body,td,th {
	font-family: Verdana, Geneva, sans-serif;
	font-size: 9px;
	color: #333;
}
</style>
</head>
<body >

<table border="1" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center"> 	
        <td align="center" colspan="16"><%=titulo%>&nbsp;</td>
    </tr>
    <%PRO = RS("PRO") 
        VER = RS("VER")
        TOTPPDA = 0%> 
    <tr>          
	    <td bgcolor="#f7d975" colspan="16">
		    <font size="1" color="#000066" face="Arial, Helvetica, sans-serif" ><b>G E N E R A L E S :</b></font>
	    </td>		
    </tr>    
    <tr>
        <td bgcolor='<%=application("barra")%>'>PROTO :</td>
        <td  colspan="10"><%=rs("PRO")%>-<%=rs("ver")%></td>
        <td bgcolor='<%=application("barra")%>' colspan="3">CODIGO PRODUCCION :</td>
        <td  colspan="2"><%=RIGHT(TRIM(rs("CODARTICULO")),5)%></td>
    </tr>
    <tr>
        <td bgcolor='<%=application("barra")%>' >CLIENTE :</td>
        <td colspan="15"><%=rs("cli")%>-<%=RS("NOM")%></td>
    </tr>    
    <tr>
        <td bgcolor='<%=application("barra")%>'>ESTILO:</td>
        <td colspan="15"><%=rs("est")%>-<%=rs("ecl")%> - <%=rs("des")%></td>
    </tr>
     <tr>
        <td  bgcolor='<%=application("barra")%>'>TELA :</td>
        <td colspan="15">
            <%destela =  trim(rs("tel")) & " - " & trim(rs("dtel")) & " DEN " & trim(rs("PA")) & "  gr/mt2 - REN  "%>
            <%if rs("aa")> 0 then destela = destela & (rs("ra")) else destela = destela & (rs("rt"))%>    
            <%=destela%></td>
    </tr>
    <tr>
        <td bgcolor='<%=application("barra")%>'>GRUPO TELA :</td>
        <td  colspan="15"><%=trim(rs("mot"))%>&nbsp;</td>
    </tr>                                      
   <%DAD = "SELECT TALLA,PROP, cant, orden FROM [PROTO-TALLAS] WHERE PROTO = '"&PRO&"' AND VERSION = '"&VER&"' ORDER BY ORDEN"
  ' RESPONSE.WRITE(DAD)
   RS2.OPEN DAD, CNN 
              IF RS2.RECORDCOUNT > 0 THEN 
                dim atal , ACAN, cantidPREND
                cantidPREND = 0
                atal = array()
                ACAN = ARRAY()
                RS2.MOVEFIRST%>
                    <%DO WHILE NOT RS2.EOF %>
                        <%redim preserve ATAL(ubound(atal)+1)
                        redim preserve acan(ubound(acan )+1)
                        atal(ubound(atal))= trim(rs2("talla"))
                        ACAN(ubound(ACAN))= rs2("CANT")
                        cantidPREND =   cantidPREND + RS2("Cant")
                       RS2.MOVENEXT%>
                   <%LOOP%>    
              <%END IF%>     

    <tr>
        <td  align="LEFT" bgcolor='<%=application("barra")%>'>TALLAS :</td>
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <%FOR I = 0 TO 9%>
                <%if i <= UBOUND(ATAL) then  %>
                   <td align="center" ><%=trim(atal(i))%></td>
                <%end if %>   
            <%NEXT%>
        <td align="center" bgcolor="<%=application("barra")%>">TOTAL PRENDAS</td>
    </tr>   
    <tr>
        <td align="left" bgcolor='<%=application("barra")%>'>CANTIDADES :</td><td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <%FOR I = 0 TO 9%>
            <%if i <= UBOUND(ATAL) then  %> 
                <td align="center"><%=formatnumber(TRIM(acan(i)),0,,true)%></td> 
            <%end if%>
        <%NEXT%>
        <td align="center"><%=formatnumber(cantidPREND,0,,true) %></td>   
    </tr> 
    <tr>
        <td align="left"  bgcolor="<%=application("barra")%>">COBERTURA :</td>
        <td align="center"><%=TRIM(RS("COBE"))%>&nbsp; %</td>  
        <%qty=  cantidPREND*(1+(rs("cobe")/100))%>
        <td align="center" ><%=formatnumber(cantidPREND*(1+(rs("cobe")/100)),0,,true) %></td>  
    </tr>
    <tr>
        <td align="left"  bgcolor="<%=application("barra")%>">Valor Minuto :</td>
        <td align="center"><%=TRIM(RS("MINU"))%></td>    
    </tr>
<%rs2.close%>  
    <tr><td bgcolor="#f7d975" colspan="16" ><font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>T E L A S :</b></font></td></tr>
    <tr valign="middle" bgcolor="<%=(Application("color1"))%>"  >
        <td >COD_TEL</td>
        <td colspan="6">TELA</td>
        <td  align="center">Anc. Mt.</td>
        <td  align="center">Tot Mt.</td>
        <td  align="center">Un. Kg.</td>
        <td  align="center">% MER.</td>
        <td  align="center">Tot Kg&nbsp;</td>
        <td  align="center">$ Kg</td>
        <td  align="center">$ Pda.</td>    
        <td  align="center">Kg COT</td>
        <td  align="center">$ COT</td>   
    </tr>    
    
    <%CAD =	" exec FICHAcoti_TELA '"&PRO&"' , '"&VER&"'  "   
    'RESPONSE.Write(CAD)
    'RS.CLOSE
    RS2.OPEN CAD,CNN
    MAXIM = RS2.RECORDCOUNT%>
    <% RS2.MOVEFIRST%>
    <% I=1 ' contador de los consumos por tela
       j=1 ' contador de los hilos de cada tela
       k=1 ' contador de servicios de cada ruta de tela  
       HILOS = 0  
       cuenta = 0
       dim aTelas(30)
       for rest=0 to 30
        aTelas(rest) = 0
       next
        %>
	<%DO WHILE NOT RS2.EOF%>
		<tr valign="top" bgcolor="#DDEBC6">    
            <td align="left"><%=trim(rs2("TEL"))%></td>
            <td align="left" colspan="6" ><%=rs2("DTE")%> <br /><font color="black"><%=rs2("com") %></font></td>
            <td align="right"><%=formatnumber(rs2("ANC"),2,,,true)%></td>
            <td align="right"><%=formatnumber(rs2("LAR"),2,,,true)%></td>
            <td align="right"><%=formatnumber(rs2("CUN"),3,,,true)%></td>
            <td align="center"><%=trim(rs2("MER"))%>&nbsp; %</td>   
            <td align="right"><%=formatnumber(rs2("TOT"),3,,,true)%></td>
            <td align="right"><%=formatnumber(RS2("CTO"),3,,,true)%></td>
            <td align="right"><%=formatnumber(rs2("TOT")*RS2("CTO"),3,,,true)%></td> 
             <td align="right"  bgcolor="#f7d975"><%=formatnumber(RS2("CTO")*qty,3,,,true)%></td>
            <td align="right"  bgcolor="#f7d975"><%=formatnumber(rs2("TOT")*RS2("CTO")*qty,3,,,true)%></td>  
         <%aTelas(i)= rs2("TOT")*RS2("CTO")%>     
        </tr> 
        <tr style="background-color:#f1f1f1" align="center">
            <%TEL = RS2("tel") 
            RUT = RS2("RUT")
            id = rs2("id")
            %>
            <td align="left">COD_HILO</td>
            <td align="left">HILADO</td>
            <td>%</td>
            <td>TITULO</td>
            <td>Kg/Pda</td>
            <td >$ Kg</td>
            <td>$ Pda</td>
        </tr>
        <%ID = RS2("ID")           
        CAD = " EXEC FICHACOTI_hilo '"&TEL&"', '"&ID&"', '"&COTI&"',  '"&j&"' " 
        'response.write(cad)
        RS3.OPEN CAD, CNN
        IF RS3.RECORDCOUNT > 0 THEN
            RS3.MOVEFIRST%>
                <%cuenta = cuenta + 1 %>                    
            <%DO WHILE NOT RS3.EOF%>
                <%codtel = rs2("tel")
                idi = rs2("id")
                cotizacion = rs("coti")
                dadi = "select replace(isnull(costo,0.1),',','.') as costo from cotihilado where cotizacion = '"&cotizacion&"'  " & _ 
                    " and tela = '"&codtel&"' and id = '"&idi&"' and orden = '"&j&"' "
                '   response.write(dadi)
            rs4.open dadi, cnn
            if rs4.recordcount  > 0 then PKOS = REPLACE(cdbl(rs4("CosTO")),",",".") else pkos = 0
            PPTO = REPLACE(cdbl(rs3("por")),",",".")/100 
            PTOT = REPLACE(cdbl(rs2("TOT")),",",".") 
            dd =  cdbl(PPTO)*cdbl(PTOT) * CDBL(PKOS)
            dolkil = cdbl(dolkil) + cdbl(dd)  
            rs4.close
            %>
            <tr>
                <td ><%=UCASE(TRIM(RS3("HIL")))%>    </td>
                <td ><%=UCASE(TRIM(RS3("DESCRIPCION")))%></td>
                <td align="center"><%=rs3("POR") %>&nbsp;%</td>
                <td align="center"><%=UCASE(TRIM(RS3("TIT")))%>&nbsp;</td>
                <td align="right">
                    <%kh = cdbl(rs3("por"))/100
                    kh = kh * cdbl(rs2("tot")) %>
                    <%=formatnumber(kh,2,,true)%>
                </td>
                <td align="right"><%=formatnumber(pkos,2,,true)%></td>
                <td align="right"><%=FORMATNUMBER(DD,3,,TRUE) %></td> 
                <td colspan="7"></td> 
                <td align="right" bgcolor="#f7d975"><%=formatnumber(kh*qty,2,,true)%></td>
                <td align="right"  bgcolor="#f7d975"><%=FORMATNUMBER(DD*qty,3,,TRUE) %></td> 
            </tr>                  
                    <%j = j+1%>
                    <%RS3.MOVENEXT%>
                <%LOOP%>
            <%END IF%>
            <%RS3.CLOSE%>
              
            <%cad = "EXEC FICHACOTI_RUTA '"&COT&"' , '"&TEL&"' , '"&RUT&"', "&ID&", '"&PRO&"',  '"&VER&"' "  
                   ' RESPONSE.Write(CAD)
            RS3.OPEN CAD,CNN%>
                            
            <tr BGCOLOR="<%=APPLICATION("color1")%>" align="center">
                                
                <td  align="left">COD_SERV&nbsp;&nbsp;</td>
                <td align="left" >SERVICIO</td>
                <td>&nbsp;</td>
                <td >UNID</td>
                <td >Mer</td>
                <td >$ Kg</td>
                <td >$ Pda</td>
                <td colspan="7"></td>
                <td >Kg COT</td>
                <td >$ COT</td>
            </tr>
            <%IF RS3.RECORDCOUNT>0 THEN
                RS3.MOVEFIRST%>
                <%DO WHILE NOT RS3.EOF%>
                <tr>
                    <td align="left">&nbsp;&nbsp;&nbsp;<%=UCASE(TRIM(RS3("codigo")))%>&nbsp;&nbsp;&nbsp;</td>
                    <td ><%=UCASE(TRIM(RS3("DESCRIPCION")))%></td>
                    <td>&nbsp;</td>
                    <td align="center"><%=UCASE(TRIM(RS3("UNIDAD")))%></td>
                    <td align="center"><%=TRIM(RS3("MERMA"))%>&nbsp;% </td>
                    <%if isnull(rs3("costo")) or cdbl(rs3("costo")) <=0 then cct = 0.01 else cct = cdbl(rs3("costo"))%>
                    <td align="right"><%=(formatnumber(cct,2,,,true))%></td>  
                    <%
                    if isnull(RS2("TOT")) = true then gkgs= 0 else gkgs = cdbl(rs2("tot"))
                    if isnull(RS3("merma")) = true then gmerruta= 0 else gmerruta = 1 + (cdbl(rs3("merma"))/100)
                    if isnull(RS3("costo")) = true then gctorut= 0.01 else gctorut = cdbl(rs3("costo")) * gmerruta
                    PPDA = gkgs * gctorut
                    TOTPPDA = TOTPPDA + PPDA
                    %>
                    <td align="right"><%=formatnumber(PPDA,3,,,true)%></td>
                    <td colspan="7"></td>
                    <td align="right" bgcolor="#f7d975"><%=(formatnumber(cct*qty,2,,,true))%></td>  
                    <td align="right" bgcolor="#f7d975"><%=formatnumber(PPDA*qty,3,,,true)%></td>
                </tr>  
                <%k = k+1%>
                <%RS3.MOVENEXT%>   
                <%LOOP%>
            <%END IF%>
            <%RS3.CLOSE%>
 
		<%RS2.MOVENEXT%>
        <%I = I+1%>
	<%LOOP%>
    <%cuentatela = I %>
   
	  <tr>          
	    <td bgcolor="#f7d975" colspan="16">
		    <font size="1" color="#000066" face="Arial, Helvetica, sans-serif" ><b>A V I O S :</b></font>
	    </td>		
    </tr>   
    <!------------------------------------------------------------------------------------------------------------------------->
    <tr valign="middle" bgcolor="<%=(Application("color1"))%>"   align="center" >

        <td align="left">COD</td>
        <td align="left">DESCRIPCION</td>  
         <td>Uni</td>

        <td>% MER.</td>
        <td>Con/Pda </td>
        <td>$ Uni   </td>
        <td>$ Pda</td>
        <td colspan="7"></td>
        <td>Cons. COT   </td>
        <td>$ COT</td>
    </tr>    
    <%CAD =	" exec FICHAPROTO_Avio '"&PRO&"' , '"&VER&"'  "  
   ' response.Write(cad)
    XON = 0
    torpe=0
    RS2.CLOSE
    RS2.OPEN CAD,CNN%>
    <% RS2.MOVEFIRST%>
	<%DO WHILE NOT RS2.EOF%>
        <tr valign="top"> 
           <td  laign="left"><%=trim(rs2("AVI"))%>&nbsp;</td>
           <td class="TEXTOblue100"><%=TRIM(rs2("DES"))%></td>
           <td align="center"><%=rs2("UNI")%></td>
           <%IF RS2("MRR")=0 THEN MRR = 10 ELSE MRR = RS2("MRR") %>
           <td  align="center"><%=MRR%>&nbsp;% </td>
           <td  align="right"><%=formatnumber(rs2("TTO"),3,,,true)%></td>
           <%if cdbl(rs2("cto")) > 0 then costo = cdbl(rs2("cto")) else if cdbl(rs2("cto1")) > 0 then costo = cdbl(rs2("cto1")) else costo = cdbl(rs2("cto2")) %>
           <td  align="right"><%=FORMATNUMBER(COSTO,5,,,TRUE)%></td>
           <%torpe = torpe + costo*cdbl(rs2("tto"))%>
           <td  align="right" id="TA<%=XON%>"><%=formatnumber(costo*cdbl(rs2("tto")),2,,,true)%></td>
           <td colspan="7"></td>
           <td  align="right" bgcolor="#f7d975"><%=FORMATNUMBER(rs2("TTO")*qty,5,,,TRUE)%></td>
           <td  align="right"  bgcolor="#f7d975"><%=formatnumber(costo*qty*cdbl(rs2("tto")),2,,,true)%></td>
        </tr>    
		<%RS2.MOVENEXT%>
        <%I = I+1%>
        <%xon = xon + 1%>
	<%LOOP%>
    <%maxi = I%>
    <%mai = I%>
	<tr valign="middle" bgcolor="#f7d975">
		<td bgcolor="#f7d975" colspan="16" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>T I E M P O S :</b></font>
		</td>		
	</tr>
    <tr bgcolor="<%=application("barra") %>" align="center">
         <td  bgcolor="<%=application("color2")%>">&nbsp;</td>
         <td >&nbsp;</td>
        <td >CORTE</td>
        <td >COSTURA</td>
        <td >ACABADOS</td>
        <td >ADICIONALES</td>
        <td >US $ PDA</td>
        <td colspan="7"></td>
        <td >Min COT</td>
        <td >$ COT</td>
    </tr>
    <tr>    
        <td bgcolor="<%=application("color2") %>">&nbsp;</td>
        <td bgcolor="<%=application("barra") %>">Minutos</td>
        <td align="center"><%=rs("mcor")%></td>
        <td align="center"><%=rs("mcos")%> </td>
        <td align="center"><%=rs("maca")%></td>
        <td align="center"><%=rs("madi")%></td>
    </tr>
    <tr >    
        <td bgcolor="<%=application("color2") %>">&nbsp;</td>
        <td bgcolor="<%=application("barra") %>">% Eficiencia</td>
        <td align="center"><%=rs("ecor")%></td>
        <td align="center"><%=rs("ecos")%></td>
        <td align="center"><%=rs("eaca")%></td>
        <td align="center"><%=rs("eadi")%></td>
    </tr>
    <tr bgcolor="<%=application("barra") %>">    
        <td  bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td  bgcolor="<%=application("barra") %>">Minutos Totales</td>
        <td align="center"><%=formatnumber(rs("tcor"),2,,true) %></td>
        <td align="center"><%=formatnumber(rs("tcos"),2,,true) %></td>
        <td align="center"><%=formatnumber(rs("taca"),2,,true) %></td>
        <td align="center"><%=formatnumber(rs("tadi"),2,,true) %></td>
        <%mintot = cdbl(rs("tcor")) + cdbl(rs("tcos")) + cdbl(RS("taca"))+ cdbl(rs("tadi"))%>
        <%minCOT = mintot * cdbl(rs("minu")) %>
        <td align="center"><%=formatnumber(mincot,2,,true) %></td>
        <td colspan="7"></td>
        <td align="center" bgcolor="#f7d975"><%=formatnumber(mintot*qty,2,,true) %></td>
        <td align="center" bgcolor="#f7d975"><%=formatnumber(mincot*qty,2,,true) %></td>
    </tr>
    <tr bgcolor="<%=application("barra") %>"> 
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>   
        <td bgcolor="<%=application("barra")%>">Desc. Adicionales:</td>
        <td bgcolor="<%=application("color2")%>" colspan="4"><%=trim(rs("desadi"))%>&nbsp;</td>
    </tr>    
 <!--     
	<tr valign="middle" bgcolor="#f7d975">
		<td bgcolor="#f7d975" colspan="16" >
			<font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>C O M E N T A R I O S :</b></font>
		</td>		
	</tr>            
    <tr>            
        <td colspan="5" style="text-align:left;  vertical-align:text-top; background-color:White"><%=rs("obscot")%></td>
        <td>&nbsp;</td>
        <td colspan="5" style="text-align:left;  vertical-align:text-top; background-color:White"><%=OBS%></td>
    </tr>
-->       
	<tr valign="middle" bgcolor="#f7d975">
		<td bgcolor="#f7d975" colspan="16"><font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>C O S T O S &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D I R E C T O S :</b></font></td>	
	</tr>
    <tr bgcolor="<%=application("barra") %>" align="center" >
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td align="left">Concepto</td><td >US $ Unit.</td><td >US $ ORDEN</td>
    </tr>
    <tr   align="RIGHT">
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td  style=" background-color:#F0F0F0" align="left">Tela</td>
        <%telast = 0
        for resum=0 to 30
            TELAST = TELAST + atelas(resum)
        next
        if  CDBL(RS("CANT"))  = 0 then cantprendas = 1 else cantprendas =  CDBL(RS("CANT")) %>
        <td ><%=formatnumber(TELAST,2,,true) %></td>
        <td ><%=formatnumber(TELAST*CANTPRENDAS,2,,true) %></td>
    </tr>
        <tr align="right">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td align="left" >Hilado</td>
            <%IF TELAST > 0 THEN 
                DOLKIL = 0
                TOTPPDA =0 
                END IF  %>
            <td><%=formatnumber(dolkil,2,,true) %></td>
            <td><%=formatnumber(dolkil*CDBL(RS("CANT")),2,,true) %></td>
        </tr>
        <tr align="right">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td align="left" >Servicios </td>
            <td ><%=FORMATNUMBER(TOTPPDA,2,,TRUE) %></td>
            <td ><%=FORMATNUMBER(TOTPPDA*CDBL(RS("CANT")),2,,TRUE) %></td>
        </tr>
          <%totserv = TOTPPDA %>
        <tr align="right">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td style="background-color:#F0F0F0" align="left">Avios </td>
            <%  if  CDBL(RS("CANT"))  = 0 then cantprendas = 1 else cantprendas =  CDBL(RS("CANT")) 
                if  CDBL(RS("AVITOT"))  = 0 then aviostotal = 1 else aviostotal =  CDBL(RS("AVITOT")) 
                AVIT = aviostotal * cantprendas          %>
            <td ><%=formatnumber(avit/cantprendas,2,,true) %></td>
            <td ><%=formatnumber(avit,2,,true) %></td>
        </tr>     
        <tr align="right">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td align="left" >Minutos Corte </td>
            <td ><%=formatnumber(cdbl(rs("mincOR")),2,,true) %></td>
            <td ><%=formatnumber(cdbl(rs("mincoR"))*cantprendas,2,,true) %></td>
        </tr>
        <tr align="right">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td align="left" >Minutos Costura </td>  
            <td ><%=formatnumber(cdbl(rs("mincos")),2,,true) %></td>
            <td ><%=formatnumber(cdbl(rs("mincos"))*cantprendas,2,,true) %></td>
        </tr>
        <tr align="right">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td align="left">Minutos Acabados </td>
            <td ><%=formatnumber(cdbl(rs("minACA")),2,,true) %></td>
            <td ><%=formatnumber(cdbl(rs("minACA"))*cantprendas,2,,true) %></td>
        </tr>
        <tr align="right">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td align="left">Minutos Adicionales</td>
            <td ><%=formatnumber(cdbl(rs("minADI")),2,,true) %></td>
            <td ><%=formatnumber(cdbl(rs("minADI"))*cantprendas,2,,true) %></td>
        </tr>
            <%totmin = ((rs("mincoR")*cantprendas) + (rs("mincos")*cantprendas) + (rs("minACA")*cantprendas) + (rs("minADI")*cantprendas) )%>
        <tr bgcolor="<%=application("barra") %>" align="right">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td align="left" >Sub Total Costo Directo</td>
            <%STCD =  cdbl(telast)+ cdbl(TOTPPDA)+ CDBL(RS("AVITOT"))+ CDBL(RS("MINCOR"))+ CDBL(RS("MINCOS"))+CDBL(RS("MINACA"))+ CDBL(RS("MINADI"))  + cdbl(dolkil)  %>   
            <td ><%=FORMATNUMBER(STCD,2,,TRUE) %></td>
            <td ><%=FORMATNUMBER(STCD*CDBL(RS("CANT")),2,,TRUE) %></td>
        </tr>
        <tr bgcolor="<%=application("barra") %>" align="right">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td align="left">Valor de la Prenda FOB</td>
            <td align="right" ><%=formatnumber(cdbl(rs("fob")),2,,,true)%></td>
            <td ><%=formatnumber(OREDEN,2,,rue) %></td>
        </tr>
     <tr valign="middle" bgcolor="#f7d975">
		<td bgcolor="#f7d975" colspan="16" ><font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>G A S T O S :</b></font></td>		
	</tr>
        <tr bgcolor="<%=application("barra") %>" align="center" >
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td >Concepto</td>
            <td >US $ Unit</td>
            <td >US $ ORDEN</td>
            
        </tr>
        <tr>
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td >Aduanas y Despacho</td>
            <%IF len(trim(RS("EMB"))) = 0  then adua = 0 else IF RS("EMB") = "A" THEN ADUA = CDBL(RS("AIR")) ELSE IF RS("EMB") = "S" THEN ADUA = CDBL(RS("SEA")) ELSE IF RS("EMB") = "D" THEN ADUA = CDBL(RS("DHL")) ELSE ADUA = ""%>
            
            <%if cdbl(rs("cant")) > 0 then canped = cdbl(rs("cant")) else canped = 1%>
            <td  align="right"><%=formatnumber(adua/canped,2,,true) %></td>
            <td  align="right"><%=formatnumber(ADUA,2,,trUe) %></td>
        </tr>
               
        <tr  align="center">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td align="left">Financiamiento: % - F1 - F2 </td>
            <%if len(trim(rs("finord"))) > 0 then finord = rs("FINORD") else finord = 0%>
            
            <%if len(trim(rs("finuni"))) > 0 then finuni = rs("FINuni") else finuni = 0%>
            <td align="right"><%=formatnumber(finuni,2,,true) %></td>
            <td align="right"><%=formatnumber(finord   ,2,,true) %></td>
        </tr>
        <tr>
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td >Certintex</td><%if  rs("certi") > 0 then ceru = formatnumber(100 *  cdbl(rs("certi")),2,,true) else ceru = 0 
            if  rs("certi") > 0 then cermon = 100 else cermon = 0 %>
            <td align="right"><%=formatnumber(cermon,2,,true)%></td>
            <td align="right" ><%=formatnumber(ceru,2,,true)%></td>
           
        </tr>
        <tr>
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td >Otros</td>
            <td align="right"><%=formatnumber(rs("otros")/canped,2,,true) %></td>
            <td align="right"><%=formatnumber(rs("otros"),2,,true) %></td>
        </tr>
        <tr   bgcolor="<%=application("barra") %>">
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
            <td >Sub Total Costos Indirectos</td>
            <%tgast = rgs + adua + finord + ceru + cdbl(rs("otros")) %>
            <td  align="right"><%=formatnumber(tgast/canped,2,,true) %></td>        
            <td  align="right"><%=formatnumber(tgast,2,,true) %></td>   
        </tr>
   <tr valign="middle" bgcolor="#f7d975">
		<td bgcolor="#f7d975" colspan="16" ><font size="1" color="#000066" face="Arial, Helvetica, sans-serif"><b>B A L A N C E :</b></font></td>		
	</tr>
    <tr bgcolor="<%=application("barra") %>" align="center" >
    <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td   align="left" valign="middle" style="height:20px">INGRESOS</td>
        <td bgcolor="<%=application("barra")%>">&nbsp;</td>
       <td >US $ ORDEN</td>
    </tr>
   
    <tr>
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td  >Carta de Credito:</td>
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td   align="right"><%=formatnumber(rs("oreden"),2,,true)%></td>
    </tr>
        <% if telast > 0 then
            TILO = TELAST * CANPED
            ELSE
            tilo =  (dolkil*canped)+ (totppda*canped)
            END IF%>
    <%DRATO = CDBL(rs("drawtot"))+CDBL(RS("OREDEN")) %>
    <%toteg = tgast + totmin + avit+ tilo %>
         
    <tr>
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td >Draw Back:</td>
        <td   align="right"><%=cdbl(rs("draw"))%>&nbsp;% </td>
        <td   align="right"><%=formatnumber(rs("drawtot"),2,,true)%></td>
    </tr>
    <tr style="background-color:'<%=(application("barra"))%>'">
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td  align="left">TOTAL US$ INGRESOS:</td>
        <td bgcolor="<%=application("barra")%>">&nbsp;</td>
        <td align="right"><%=formatnumber(DRATO,2,,true)%></td>
    </tr>
    <tr bgcolor="<%=application("barra") %>" align="center" >
        <td bgcolor="<%=application("color2")%>">&nbsp;</td> 
        <td  align="left" valign="middle" style="height:20px">EGRESOS</td>
        <td bgcolor="<%=application("barra")%>">&nbsp;</td>
       <td >US $ ORDEN</td>
    </tr>
    <tr>
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td >Materia Prima:</td>
            <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td   align="right"><%=formatnumber(tilo,2,,true)%></td>
    </tr>
    <tr><td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td >Avios:</td></td>
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td   align="right"><%=FORMATNUMBER(AVIT,2,,TRUE) %></td>
    </tr>
    <tr><td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td >Servicios ConfecciOn:</td>
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td   align="right"><%=FORMATNUMBER(TOTMIN,2,,TRUE) %></td>
    </tr>
    <tr><td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td >Gastos:</td>
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td   align="right"><%=formatnumber(tgast,2,,true) %></td>
    </tr>
    <tr style="background-color:'<%=(application("barra"))%>'">
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td >TOTAL US$ EGRESOS:</td>
        <td bgcolor="<%=application("barra")%>">&nbsp;</td>
        <td  align="right" ><%=formatnumber(toteg,2,,true) %></td>
    </tr>
    <tr bgcolor="<%=application("barra") %>" align="center" >
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td align="left" valign="middle" style="height:20px">UTILIDAD</td>
        <td bgcolor="<%=application("barra")%>">&nbsp;</td>
        <td >US $ ORDEN</td>
    </tr>
    <tr  align="right">
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td  align="left">Utilidad Bruta:</td>
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <%brutas = drato-toteg %>
        <td  ><%=formatnumber(brutas,2,,true) %></td>
    </tr>
    <tr   align="right">
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td align="left" >Impuesto a la Renta:</td>
        <td ><%=cdbl(rs("impu"))%>&nbsp;% </td>
        <%rentas = cdbl(rs("impu"))/100 * (drato - toteg) %>
        <td  ><%=formatnumber(rentas,2,,true) %></td>
    </tr>
        <%netas = brutas - rentas %>

    <tr align="right">
        <td bgcolor="<%=application("color2")%>">&nbsp;</td>
        <td  align="left">Utilidad Neta:</td>
        <%if oreden  = 0 then oreden= 1%>
        <%poruti =(netas * 100 )/oreden  %>
        <td  ><%=formatnumber(poruti,2,,true)%>&nbsp;%</td>
        <td  ><%=formatnumber(netas,2,,true) %></td>
    </tr>
         
</table> 


<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>

</body>
</html>