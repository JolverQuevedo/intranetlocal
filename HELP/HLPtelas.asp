<%@ Language=VBScript %>
<% Response.Buffer = true %>
<!--#include file="../includes/Cnn.inc"-->
<%	pos = request.QueryString("pos")
hlp = request.QueryString("hlp")
ubi = request.QueryString("ubi")
CAD =	" SELECT TELA, DESCRIPCION, GG,PA, 	" & _
		" RT = cast(RT as numeric(6,2)), RA = cast(RA as numeric(6,2)), " & _
        " AT= cast(aa as numeric(6,2)),AA= cast(aa as numeric(6,2))" & _
        "  from VIEW_TELAS  	" & _
		" WHERE ESTADO = 'A'     		    " & _ 
		" AND CODFAM = '"&POS&"'    	    " & _
		" ORDER BY descripcion  	        " 
		'response.Write(cad)
	RS.Open CAD, Cnn
	
'Nro de columnas regresadas por el objeto RECORDSET	
	columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
</head>
<body>
<script>
UBI = parseInt('<%=UBI%>',10)
HLP = parseInt('<%=HLP%>',10)
function redir(pos)
{	var pos = parseInt(pos,10)
	var t = document.all.TABLA;
	if (HLP == 1) 
		ubi = 0;
	else
		ubi = UBI
//	alert(ubi)
	if (ubi == 0 )
	{	window.opener.window.document.all.thisForm.TELA.value  = trim(t.rows(pos).cells(0).innerText) ;
		window.opener.window.document.all.thisForm.DTEL.value  = ltrim(t.rows(pos).cells(1).innerText) ;
		window.opener.window.document.all.thisForm.GG.value = trim(t.rows(pos).cells(2).innerText) + '"';
		window.opener.window.document.all.thisForm.PA.value = trim(t.rows(pos).cells(3).innerText)+' GR/MT2.' ;
		window.opener.window.document.all.thisForm.RT.value  = trim(t.rows(pos).cells(4).innerText) ;
		window.opener.window.document.all.thisForm.RA.value  = trim(t.rows(pos).cells(5).innerText) ;
		window.opener.window.document.all.thisForm.AT.value   = trim(t.rows(pos).cells(6).innerText) + ' MT. TUBULAR' ;
		window.opener.window.document.all.thisForm.AA.value   = trim(t.rows(pos).cells(7).innerText) + ' MT. ABIERTO';
		if(parseFloat(ltrim(t.rows(pos).cells(4).innerText))>0 )
		{	window.opener.window.document.all.thisForm.RT.style.display='block';
			window.opener.window.document.all.thisForm.RA.style.display='none';
			ttt = 'T'
		}
		else
		{	window.opener.window.document.all.thisForm.RT.style.display='none';
			window.opener.window.document.all.thisForm.RA.style.display='block';
			ttt='A'
		}
		if(parseFloat(ltrim(t.rows(pos).cells(6).innerText))>0 )
		{	window.opener.window.document.all.thisForm.AT.style.display='block';
			window.opener.window.document.all.thisForm.AA.style.display='none';
			aaa = trim(t.rows(pos).cells(6).innerText) 
		}
		else
		{	window.opener.window.document.all.thisForm.AT.style.display='none';
			window.opener.window.document.all.thisForm.AA.style.display='block';
			aaa = trim(t.rows(pos).cells(7).innerText) 	
		}
	}
		eval("window.opener.window.document.all.thisForm.TEL"+ubi+".value =trim(t.rows(pos).cells(0).innerText) ")
		eval("window.opener.window.document.all.thisForm.DTE"+ubi+".value =trim(t.rows(pos).cells(1).innerText) ")
		eval("window.opener.window.document.all.thisForm.PM2"+ubi+".value =trim(t.rows(pos).cells(3).innerText) ")
		if(parseFloat(ltrim(t.rows(pos).cells(4).innerText))>0 )
			ttt = 'T'
		else
			ttt='A'
		if(parseFloat(ltrim(t.rows(pos).cells(6).innerText))>0 )
			aaa = trim(t.rows(pos).cells(6).innerText) 
		else
			aaa = trim(t.rows(pos).cells(7).innerText) 			
		eval("window.opener.window.document.all.thisForm.TIP"+ubi+".value =ttt")
		eval("window.opener.window.document.all.thisForm.ANC"+ubi+".value =aaa ")		
	
	
	window.close();	
}
function dd2(ff)
{	
	dd(ff);
}
</script>
<script language="javascript" src="../INCLUDES/funcionescomunes.js"></script>
<form name="thisForm" METHOD="post" >

<table width="100%">
	<tr>
		<td align="left" width="35%">
			<img src="../imagenes/atras.gif" style="cursor:hand;" alt="" 
            onclick="javascript: window.location.replace('hlpfamtelas.asp?hlp=1');" /></td>
		<td align="center" class="talasblue">TELAS</td>
		<td align="right" width="35%"><img src="../imagenes/logo.GIF" alt="" /></td>
	</tr>
	<tr>
	<td colspan="3"><hr /></td></tr>
</table>
<table id="TABLA" align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="2"  cellspacing="1"  border="1" >
    <%	IF NOT RS.EOF OR NOT RS.BOF THEN
			RS.MOVEFIRST
		else
			response.write("Tabla sin Datos")	
			response.end
		END IF
	CONT = 1
	'LINEA DE CABECERA STANDAR %>
    <%	lIMITE =  COLUMNAS-1%>
    <tr bgcolor='<%=Application("Titulo")%>' >
        <%for I=0 to LIMITE %>  
	        <td align="center" class="AMERICANwhite"><%=RS.FIELDS(I).NAME%></td>
        <%next%>	
    </tr>
    <%' MUESTRA EL GRid (2 colorES) %>
    <%IF NOT RS.EOF THEN%>
    <%DO WHILE NOT RS.EOF%>
    <tr  bgcolor="<% if CONT mod 2  = 0 THEN 
                response.write(Application("color1"))
                else
	            response.write(Application("color2"))
	            end IF%>" onClick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" onDblClick="redir('<%=(cont)%>')" >       
	    <%for i=0 to LIMITE - 4%>
		    <td class="texto"><%=RS.FIELDS.ITEM(I)%>&nbsp;</td>
	    <%NEXT%>	
        <%for j=i to LIMITE%>
		    <td class="texto"><%=formatnumber(cdbl(RS.FIELDS.ITEM(j)),2,,true)%>&nbsp;</td>
	      <%NEXT%>	
	    <%RS.MOVENEXT%>
	    <%CONT = CONT + 1%>
  </tr>
	<%loop%>
    <%end if%>
</table>
<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
<script language="javascript">
dd2('1');
HLP = parseInt('<%=hlp%>',10)
ubi = parseInt('<%=ubi%>',10)


</script>    
</form>
</BODY>
</HTML>