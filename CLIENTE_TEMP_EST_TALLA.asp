<%@ Language=VBScript %>
<%  Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	TITULO = "DETALLE DE MEDIDAS DEL GRUPO: "
%>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
</head>
<body>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
    var check = 1
    var dele = 0
    function window_onfocus() {
        return true
    }
    function BORRA() {
        pos = dele
        for (i = 0; i < pos; i++) {
            eval("thisForm.pos" + i + ".value=''")
            eval("thisForm.chk" + i + ".checked=false")
            check = 1
        }

        return true
    }
    function NUMERA(op) {

        if (trim(eval("thisForm.desc" + op + ".value")) == '') {
            eval("thisForm.chk" + op + ".checked=false")
            eval("thisForm.pos" + op + ".value=''")
            return true;
        }
        if (eval("thisForm.chk" + op + ".checked") == true) {

            if (check == 0)
            check = 1
        eval("thisForm.pos" + op + ".value=check++") }
        else
        { eval("thisForm.pos" + op + ".value=''") 
        }
        return true
    }
//-->
</script>
<%
CLI = REQUEST.QUERYSTRING("CLI")
TEM = REQUEST.QUERYSTRING("TEM")
EST = REQUEST.QUERYSTRING("EST")

CAD = "SELECT * FROM CLIENTE_TEMP_EST_TALLA WHERE CLI= '"&CLI&"'  AND CODTEM= '"&TEM&"' AND ESTilo = '"&EST&"' "
'response.write(cad)
'response.write("<BR>")
RS.OPEN CAD,CNN

IF RS.RECORDCOUNT <= 0 THEN     
   rs.close                                                                                                                                                                           
   KAD = " SELECT DISTINCT PP.TALLA, 0 as orden FROM (	                                                                                                                                        " & _
	     "       SELECT DISTINCT T0 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = '"&CLI&"' and codtem='"&TEM&"' and estilo = '"&est&"'  " & _
         " UNION SELECT DISTINCT T1 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = '"&CLI&"' and codtem='"&TEM&"' and estilo = '"&est&"'  " & _    
         " UNION SELECT DISTINCT T2 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = '"&CLI&"' and codtem='"&TEM&"' and estilo = '"&est&"'  " & _    
         " UNION SELECT DISTINCT T3 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = '"&CLI&"' and codtem='"&TEM&"' and estilo = '"&est&"'  " & _    
         " UNION SELECT DISTINCT T4 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = '"&CLI&"' and codtem='"&TEM&"' and estilo = '"&est&"'  " & _    
         " UNION SELECT DISTINCT T5 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = '"&CLI&"' and codtem='"&TEM&"' and estilo = '"&est&"'  " & _    
         " UNION SELECT DISTINCT T6 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = '"&CLI&"' and codtem='"&TEM&"' and estilo = '"&est&"'  " & _    
         " UNION SELECT DISTINCT T7 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = '"&CLI&"' and codtem='"&TEM&"' and estilo = '"&est&"'  " & _                           
         " UNION SELECT DISTINCT T8 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = '"&CLI&"' and codtem='"&TEM&"' and estilo = '"&est&"'  " & _    
         " UNION SELECT DISTINCT T9 AS TALLA FROM [PO-DETA] AS PD INNER JOIN View_Cliente_Temporada_Estilo_PO AS VC ON VC.PO = PD.PO where cliente = '"&CLI&"' and codtem='"&TEM&"' and estilo = '"&est&"'  " & _
         " )PP WHERE PP.TALLA <> ''                                                                                                                                                                         "
   response.write(kad)
    RS.OPEN KAD,CNN

IF RS.RECORDCOUNT > 0 THEN     RS.MOVEFIRST
    CN = 0
    CAD = "INSERT INTO CLIENTE_TEMP_EST_TALLA (CLI, CODTEM, ESTilo) VALUES ('"&CLI&"', '"&TEM&"', '"&EST&"') ;"
    RESPONSE.WRITE("<BR>")
    DO WHILE NOT RS.EOF
        TALLA = "T"+TRIM(CSTR(CN))
        CODTAL = RS("TALLA")
      '   RESPONSE.Write( talla)
      '   RESPONSE.WRITE("<BR>")
        CAD = CAD + " update  CLIENTE_TEMP_EST_TALLA SET  "&TALLA&" = '"&CODTAL&"' WHERE CLI = '"&CLI&"'  AND CODTEM= '"&TEM&"' AND ESTilo = '"&EST&"'; "
        RS.MOVENEXT
        CN = CN + 1
    LOOP 
    RESPONSE.Write(CAD)
   Cnn.Execute(CAD)
   
    
END IF
rs.close

CAD = "SELECT * FROM CLIENTE_TEMP_EST_TALLA WHERE CLI= '"&CLI&"'  AND CODTEM= '"&TEM&"' AND ESTilo = '"&EST&"' "
'response.write(cad)
'response.write("<BR>")
RS.OPEN CAD,CNN
%>
<form id="thisForm" method="post" action="">
<table  cellpadding="0" cellspacing="0" width="100%" >
	<tr valign="center"> 
		<td align="center"><font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b>Tallas de la Temporada / Estilo
        <input type="text" value="<%=cli%>" id="cli" style="display:none" />
        <input type="text" value="<%=est%>" id="est" style="display:none" />
        <input type="text" value="<%=tem%>" id="tmp" style="display:none" />
	</td>
    </tr>
	<tr>
    	<td style="background-color:Red; height:1px; font-size:xx-small"></td>
	</tr>
</table>	

<TABLE width="100%" border="0" id="SERV" name="SERV">
<%cont = 0%>
<%IF RS.RECORDCOUNT <= 0 THEN%>
<center>
	<font face="Arial, Helvetica, sans-serif" size="+1" color="red">
		NO HAY tallas REGISTRADAS para su seleccion.... 

</center>
<%else%>
<%rs.movefirst%>
	<tr bgcolor='<%=application("barra")%>'>
		<td width="1%" class="titulito" align="center">&nbsp;</td>
		<%for i = 0 to 29 %>
            <%if len(trim(rs.fields.item(i+3)))> 0 then %>
                <td><input id="desc<%=i%>" value="<%=rs.fields.item(i+3)%>" class="DESCENTER" /> </td>
            <%else%>
                <%exit for%>
            <%end if%>
		<%next%>
	</tr>		
    <tr>
		<td width=1% align="center" valign="middle"><img border="0" style="cursor:hand;" onClick="BORRA()"	alt="BORRAR SELECCION"	src="imagenes/eraser.jpg">&nbsp;&nbsp;
        <img border="0" style="cursor:hand;" onClick="GRABA()"	alt="BORRAR SELECCION"	src="imagenes/disk.gif">
			</td>
		<%for j=0 to i-1 %>
        <td width="1%" align="center">
			<input type="checkbox" id="chk<%=j%>" name="chk<%=j%>" onClick="NUMERA('<%=j%>')" style="width:20%" > 
            <input type="text"  id="pos<%=j%>" name="pos<%=j%>" maxlength="3" class="DESCRIPTORCENTERnavy" readonly="readonly"	value="" style="width:20%"> 
        <%next %>
		</td>
	</tr>
</table>	
<%end if%>

<input type="text" id="CONTADOR" name="CONTADOR" style="display:none">

<%
set rs= nothing
set cnn=nothing
%>
</form>
<script>

   // alert(thisForm.tmp.value)
    dele = '<%=i%>'
    pos = parseInt(dele, 10)-1
    thisForm.CONTADOR.value = pos
    check = 0
    for (i = 0; i < pos; i++) {
        if (eval("thisForm.pos" + i + ".value") != '') {
            eval("thisForm.chk" + i + ".checked=true")
            check++
        }
    }
    function GRABA() {	//alert(thisForm.CONTADOR.value = pos)
      aDes = new Array()
      aPos = new Array()
        i = 0;
        var t = ''
        cont = 0
        for (ii = 0; ii < dele; ii++) {
            if (eval("thisForm.chk" + ii + ".checked") == true) {
                cont++;
                aPos[ii] = eval("thisForm.pos" + ii + ".value")
                aDes[ii] = eval("thisForm.desc" + ii + ".value")
            }
        }
      //  alert(dele)
        if (cont != dele) {
            alert("Necesitamos ordenar todas las tallas")
            return true;
        }

        cad = "comun/insercliente_temp_est_talla.ASP?cli=" + '<%=cli%>' + '&est=' + '<%=est %>' + '&tem=' + thisForm.tmp.value
        cad += '&pos=' + aPos + '&Des=' + aDes
        window.location.replace (cad)

        //thisForm.action = "comun/insercliente_temp_est_talla.ASP"
        //thisForm.submit()
    }


</script>
</BODY>
</HTML>
