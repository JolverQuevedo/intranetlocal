<%@ Language=VBScript %>
<%  Response.Buffer = true %>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="includes/funcionesVBscript.asp"-->
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
	PRO = Request.QueryString("PRO")
	VER = Request.QueryString("VER")
	'Response.Write(ESP)
	Set RS2 = Server.CreateObject("ADODB.Recordset")
		RS2.ActiveConnection = Cnn
		RS2.CursorType       = 3 'CONST adOpenStatic = 3
		RS2.LockType         = 1 'CONST adReadOnly = 1
	CAD =	" specs " & "'" & PRO & "'," & "'" & VER & "', " & " '1' " 

'Response.Write(CAD)
	'Response.END
	rs2.open cad , cnn
	PRO = RS2("PROTO")
	VER = RS2("VERSION")
	CLI = RS2("CLIENTE")
%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<link REL="stylesheet" TYPE="text/css" HREF="estilos1.CSS" >
<title>FICHA DE CONSUMOS</title>
<script language="javascript">
var PRO = '<%=PRO%>'
</script>
<script language="javascript" src="INCLUDES/funcionescomunes.js"></script>
<script language="javascript" src="INCLUDES/fichaSpec.js"></script>


</HEAD>
<BODY bgColor=White text="#009999" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<form id=thisForm method=post ACTION="COMUN/INSERSPEC.ASP">
<table border  =0 cellpadding="0" cellspacing="0" width=100%>
	<tr align="center"> 
		<td width="157">
			<img src="imagenes/CERRAR.gif" style="cursor:hand;" 
			onclick="javascript: window.opener.location.replace('ESPECIFICACIONES.asp?perfil=1&pos='+thisForm.ESPEC.value);window.close()">
		</td>
      <td width="766" align = center bgcolor="#ffffff">
		<b> <font color="#003399" size="3" Face=arial> 
       	HOJA DE CONSUMO N° <%=RS2("ESPECIFICACION")%></font></b> 
       <INPUT TYPE="TEXT" STYLE="DISPLAY:NONE" ID="ESPEC" name="ESPEC" VALUE="<%=muestra_cadena(RS2("ESPECIFICACION"))%>">
      </td>
		<td  width=35 ID=MAIL > 
			<a href="<%=CORREO%>"><img src=imagenes/mail.jpg border=1 STYLE=" cursor:hand;" alt="Avisa a Ingeniería">
			<input id ="graba" style="display:none;"></a></td>
		<td  width=35 ID=GRABAR  >
		<% IF TRIM(RS2("COTIZACION"))="" OR ISNULL(RS2("COTIZACION"))  THEN%> 
			<img src="imagenes/arregla.jpg"  border="1"	id="disk" STYLE="cursor:hand;" ALT="GRABA CAMBIOS" onMouseDown="VALIDA()">
		<%END IF%>
		</td>
    </tr>
</TABLE>    

<table	border  =1 cellpadding="1" WIDTH=100% cellspacing="1" bgcolor=White bordercolor=SeaGreen bordercolordark=DARKGREEN bordercolorlight=LightSeaGreen>

    <tr align="center"> 
		<td align="left" bgcolor="#fbfff7" width="8%">
			<b> <font face="Arial" size="1" color="#003399">Proto Versión N°</font></b> 
		</td>
		<td align="left" bgcolor="Snow" width="15%" colspan=3> 
			<FONT COLOR="NAVY" SIZE="2" FACE="ARIAL"><B>
			<%=PRO%>-<%=VER%>
			<INPUT TYPE=HIDDEN ID=PPROTO   NAME=PPROTO   VALUE="<%=trim(pro)%>">
			<INPUT TYPE=HIDDEN ID=PVERSION NAME=PVERSION VALUE="<%=trim(ver)%>">
			</b></font>
		</td>
		<td align="left" bgcolor="#fbfff7"  > 
			<font face="Arial" size="1" color="#003399"> <b>
			  Cliente</b></font> 
        </td>
		<td align="left" bgcolor=#ccffcc WIDTH=15% colspan=3 > 
			<FONT COLOR="NAVY" SIZE="2" FACE="ARIAL"><B>
			<%=RS2("CLIENTE")%>&nbsp;
			<INPUT TYPE=HIDDEN VALUE = "<%=muestra_cadena(RS2("CLIENTE"))%>" NAME=CLI ID=CLI>
			</b></font>
		</td>
</tr>
<tr>		
	<td  width="8%" bgcolor="#fbfff7"> 
		<font face="arial" size="1" color="#003399">Estilo</font>
	</td>
    <td align="left"  bgcolor=#ccffcc WIDTH=15% colspan=3> 
	  <FONT COLOR="NAVY" SIZE="2" FACE="ARIAL"><B>
		<%=RS2("ESTILO")%>&nbsp;
		<INPUT TYPE="HIDDEN" VALUE ="<%=muestra_cadena(RS2("ESTILO"))%>" NAME="EST" ID="EST">
		</b></font>
    </td>
     <td  width="10%" bgcolor="#fbfff7"> 
			<font face="arial" size="1" color="#003399"> 
			Temporada</font>
	  </td>
      <td align="left"  bgcolor="#ccffcc" WIDTH="20%" colspan="3">
		<FONT COLOR="NAVY" SIZE="2" FACE="ARIAL"><B>
		<%=RS2("TEMPORADA")%>&nbsp;
		<INPUT TYPE=HIDDEN VALUE ="<%=muestra_cadena(RS2("TEMPORADA"))%>" NAME=TEM ID=TEM>
		</b></font>
      </td>
</tr>
<tr>
		<td bgcolor="#fbfff7" WIDTH=8%> 
			<font face="arial" size="1" color="#003399"> 
			Género</font> 
		</td>
		<td align="left" bgcolor=#ccffcc WIDTH=15% colspan=3>
			<FONT COLOR="NAVY" SIZE="2" FACE="ARIAL"><B>
			<%=RS2("GENERO")%>&nbsp;
			</b></font>
		</td>
		<td  width="10%" bgcolor="#fbfff7"> 
			<font face="arial" size="1" color="#003399"> 
			Tipo Prenda</font>
		</td>
      <td align="left"  bgcolor=#ccffcc WIDTH=20% colspan=3> 
		<FONT COLOR="NAVY" SIZE="2" FACE="ARIAL"><B>
		<%=RS2("TIPOPRENDA")%>&nbsp;
		</b></font>
      </td>
</tr>
<tr>      
		<td bgcolor="#fbfff7" WIDTH=8%> 
			<font face="arial" size="1" color="#003399"> 
			Descripción </font> 
		</td>
		<td align="left" bgcolor=#ccffcc WIDTH=15% colspan=7>
			<FONT COLOR="NAVY" SIZE="2" FACE="ARIAL"><B>
			<%=RS2("descripcion")%>&nbsp;
			</b></font>
		</td>
</tr>  
<tr>		
	<td width="8%" bgcolor="#fbfff7" COLSPAN="8"> 
		<table WIDTH=100% border=1 CELLPADDING=0 CELLSPACING=0 bordercolor=SeaGreen bordercolordark=DARKGREEN bordercolorlight=LightSeaGreen>
	<tr>
		<td  width="10%" bgcolor="#fbfff7"> 
			<font face="arial" size="1" color="#003399">Ratio</font>
			<input id="TIPRAT" style="display:none;" NAME="TIPRAT" value ="<%=muestra_cadena(RS2("TALLAS"))%>">
		</td>
		<TD WIDTH=2% ALIGN=LEFT valign=middle>	
			<IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;" onClick="HELP('help/HLPtallas.asp')"></TD> 
		<%FOR I=0 TO 9%>		
			<TD WIDTH=8% ALIGN=CENTER>
				<input	id="TAL<%=I%>" READONLY CLASS=TALAS SIZE="4" NAME="TAL<%=I%>" value ="<%=muestra_cadena(rs2("tal" & i))%>">
			</TD>
		<%NEXT%>
	</TR>
	<TR>
		<td  width="10%" bgcolor="#fbfff7"> 
			<font face="arial" size="1" color="#003399">Proporción</font>
			<input id="TIPPROP" NAME="TIPPROP" style="display:none;TEXT-ALIGN:center;" value ="<%=muestra_cadena(rs2("proporcion"))%>">
		</td>
		<TD WIDTH= 2% ALIGN=LEFT valign=middle>
				<IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;" onClick="HELP('help/hlppropor.asp')"></TD> 
			<%FOR I=0 TO 9%>
				<TD WIDTH=8%>
				<input	id="PRO<%=I%>" READONLY class="TALAS" SIZE=4 NAME="PRO<%=I%>" value ="<%=muestra_cadena(RS2("PRO" & i))%>">
				</TD>
			<%NEXT%>
	</tr>
	</table> 
</td>
</tr>
</table>

<TABLE width=100% BORDER=1 cellpadding="5" cellspacing="1"  bgcolor=White bordercolor=SeaGreen bordercolordark=DARKGREEN bordercolorlight=LightSeaGreen>
	<tr>
		<td colspan="4"  BGCOLOR=NAVY >
			<FONT SIZE = 1 COLOR = IVORY FACE=ARIAL>
			<b>Solicitado por  DDP :</b></font>
		</td>
	</tr>	
	<tr ID="FILA7" STYLE="DISPLAY:BLOCK">
		<td colspan="4"  valign=top  BGCOLOR=SNOW >
		
<%		cad =	" SELECT SOLICITA, DDP " & _
				" FROM [proto-OBS] pp  " & _
				" WHERE  pp.proto = '"&pro&"' AND pp.version = '"&ver&"' " 
		rs.open cad,cnn	  
		IF NOT rs.eof AND NOT rs.bof THEN
			rs.movefirst
			SOLICITA = RS("SOLICITA")
		ELSE
			SOLICITA= ""
		END IF%>

			<TEXTAREA ID="SOLICITA" NAME="SOLICITA" CLASS="ADICIONAL" READONLY><%=Trim(SOLICITA)%></TEXTAREA>
	  </td>
	</tr>
<%	'********************************************************
	'        O B S E R V A C I O N E S    D.D.P.             
	'********************************************************	%>
		<tr>
		<td colspan="4"  BGCOLOR=NAVY >
			<FONT SIZE = 1 COLOR = IVORY FACE=ARIAL>
			<b>Observaciones DDP :</b></font>
		</td>
		</tr>	
		<%	IF NOT rs.eof AND NOT rs.bof THEN
				rs.movefirst
				DDP = RS("DDP")
			ELSE
				DDP= ""
			END IF%>
		<tr  ID="FILA8" STYLE="DISPLAY:BLOCK">
			<td colspan="4" valign=top >
			<TEXTAREA ID="DDP" NAME="DDP" CLASS="ADICIONAL" READONLY><%= trim(DDP)%></TEXTAREA>
			</td>
		</tr>

<%rs.CLOSE

tel = rs2("CODtel")
cad =	" SELECT tela +' - ' +ltrim(rtrim(descripcion)) as codtel, " & _
		" DEN = pesom2, " & _
		" ANC = CASE WHEN anchoacabado IS NULL THEN STR(ANCHOTUBULAR,10,2)" & _
		"  ELSE str(anchoacabado,10,2) END, " & _
		" str(galga,10,0) as galga, " & _
		" REND = CASE WHEN RENDIMIENTO IS NULL THEN " & _
		" str(rdto_tela_acabada,10,2) ELSE STR(RENDIMIENTO,10,2) END " & _
		" FROM telas WHERE TELA = '"&trim(tel)&"' " 
  'Response.Write (cad)		
  	rs.open cad,cnn
  	IF NOT rs.eof AND NOT rs.bof THEN
		rs.movefirst		
		dens	= rs("den")
		ancho	= rs("anc")
		gg		= rs("galga")
		ren		= rs("rend")
		codtel  = rs("codtel")
	ELSE
		dens	= ""
		ancho	= ""
		gg		= ""
		ren		= ""
		codtel  = ""
	END IF
  rs.close
%>
		<tr>
		  <td valign=top BGCOLOR=NAVY  COLSPAN=7><IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;" onClick="HELP('help/hlpfamTEL.asp')"> 
			<FONT SIZE = 1 COLOR = IVORY FACE=ARIAL>
			<b>Tela Principal :</b></font></td>
    </tr>
		<tr bgcolor=#E8FED8>
		  <td colspan="4" valign=top ><input id="TEL"  NAME="TEL" TYPE="HIDDEN" value="<%=trim(tel)%>">
			<input type="text"	id="DESTEL" READONLY value="<%=muestra_cadena(codtel)%>" CLASS="texto" ></td>
    </tr>
		<tr >
		  <td width="26%" valign=top ><font face="arial" size="1" color="#003399"> <B>
			Densidad&nbsp;&nbsp;&nbsp;</b></font></td>
          <td width="24%" valign=top ><font face="arial" size="1" color="#003399"> <B>
			Ancho&nbsp;&nbsp;&nbsp;</b></font></td>
          <td width="25%" valign=top ><font face="arial" size="1" color="#003399"> <B>
			Galga&nbsp;&nbsp;&nbsp;</b></font></td>
          <td width="25%" valign=top ><font face="arial" size="1" color="#003399"><B>
			Rendimiento&nbsp;&nbsp;&nbsp;</b></font></td>
	</tr>
		<tr >
		  <td valign=top >
		  	<input	id="DENS" type="hidden" value ="<%=muestra_cadena(dens)%>" CLASS="TALAS" style="width:70%;"> 
			<font face="arial" size="2" color="black"> <B>
			<%=dens%> gr/mt2</b></font></td>
		  <td valign=top >
		  	<input	id="ANCH" type="hidden"  value ="<%=muestra_cadena(ancho)%>" CLASS="TALAS" >
			<font face="arial" size="2" color="black"> <B>
			<%=ancho%> mts.</b></font></td>
		  <td valign=top >
		  <input	id="GG" type="hidden"  value="<%=muestra_cadena(gg)%>" CLASS="TALAS">
			<font face="arial" size="2" color="black"> <B><%=gg%></b></font></td>
		  <td valign=top >
		  <input	id="REND" type = "hidden"  value="<%=muestra_cadena(ren)%>" CLASS="TALAS">
			<font face="arial" size="2" color="black"> <B><%=ren%></b></font></td>
    </tr>

<%	'********************************************	
  	'              SERVICIOS EN PRENDA
  	'********************************************	
%>
		<tr BGCOLOR=NAVY>
		  <td colspan="2" valign=top ><FONT SIZE = 1 COLOR = IVORY FACE=ARIAL>
			<b>Servicios en Prenda :</b></font></td>
		  <td colspan="2" valign=top ><FONT COLOR=ivory SIZE=1 FACE=ARIAL><B>
				Obs.</b></font></td>
    	</tr>

<%	cad =	" DETALLES " & "'01', " & "'" & PRO & "'," & "'" & VER & "'," & "'D'"
	'Response.Write(CAD)
	rs.open cad,cnn	  
	conta=0
	IF NOT rs.eof AND NOT rs.bof THEN
		rs.movefirst

		DO WHILE NOT rs.EOF
%>
		<tr  ID="FILA1<%=conta%>" STYLE="DISPLAY:block;">
		  <td valign=top >
			  <INPUT TYPE=hidden ID='ID1<%=conta%>' NAME='ID1<%=conta%>' value ="<%=trim(RS("ID"))%>">
			  <INPUT TYPE=HIDDEN ID='DEL1<%=conta%>' NAME='DEL1<%=conta%>' VALUE=0>	
			  <INPUT TYPE=text ID='COD1<%=conta%>'  NAME='COD1<%=conta%>' value ="<%=muestra_cadena(RS("CODIGO"))%>" class="datosgrande" disabled>
		  </td>
		  <td valign=top >
			  <TEXTarea ID="DATO1<%=conta%>"   NAME="DATO1<%=conta%>" wrap=PHYSICAL  CLASS=TEXTO	READONLY><%=trim(RS("DD"))%></textarea>
		  </td>
		  <td colspan="2" valign=top >
		  <textarea  ID="ADIC1<%=conta%>" wrap=PHYSICAL NAME="ADIC1<%=conta%>" onBlur="return cuenta(this.value,this.id,200)" CLASS=ADICIONAL><%=trim(rs("adicional"))%></textarea>
		  </td>
	    </tr>

<%			rs.movenext
			conta = conta + 1
		LOOP
	END IF
	rs.close
%>
<INPUT TYPE="hidden" ID="conta1" name="conta1"  value ="<%=conta%>">
<%	'********************************************	
  	'              SERVICIOS EN TELA
  	'********************************************	%>
  
		<tr  bgcolor=NAVY>
		  <td BGCOLOR=NAVY colspan="2" valign=top ><FONT SIZE = 1 COLOR = IVORY FACE=ARIAL>
			<b>Servicios en Tela :</b></font></td>
		  <td colspan="2" valign=top ><FONT COLOR=IVORY SIZE=1 FACE=ARIAL><B>
				Obs.</b></font></td>
    </tr>
<%	cad =	" DETALLES " & "'02', " & "'" & PRO & "'," & "'" & VER & "'," & "'D'"
	rs.open cad,cnn	  
	conta=0
	IF NOT rs.eof AND NOT rs.bof THEN
		rs.movefirst
		DO WHILE NOT rs.EOF
%>		
		<tr  ID="FILA2<%=conta%>" STYLE="DISPLAY:block;">
		  <td valign=top > 
			<INPUT TYPE=text ID='COD2<%=conta%>'  NAME='COD2<%=conta%>' value ="<%=muestra_cadena(RS("CODIGO"))%>" class=datosgrande disabled>
			<INPUT TYPE=hidden ID='ID2<%=conta%>' NAME='ID2<%=conta%>' value ="<%=trim(RS("ID"))%>">
			<INPUT TYPE=HIDDEN ID='DEL2<%=conta%>' NAME='DEL2<%=conta%>' VALUE=0>
		</td>
		  <td valign=top >
			<TEXTarea ID="DATO2<%=conta%>"   NAME="DATO2<%=conta%>" wrap=PHYSICAL  CLASS=TEXTO READONLY><%=trim(RS("DD"))%></textarea>
		  </td>
		  <td colspan="2" valign=top >
		  <textarea  ID="ADIC2<%=conta%>" wrap=PHYSICAL NAME="ADIC2<%=conta%>" onBlur="return cuenta(this.value,this.id,200)" CLASS=ADICIONAL><%=trim(rs("adicional"))%></textarea>
		</td>
    </tr>
<%			rs.movenext
			conta = conta + 1
		LOOP
	END IF
	rs.close
%>
<INPUT TYPE="HIDDEN" ID="conta2" name="conta2"  value ="<%=conta%>">
<%	'********************************************	
  	'              SERVICIOS EN PIEZA
  	'********************************************	%>
	<tr  bgcolor=NAVY>
		  <td BGCOLOR=NAVY colspan="2" valign=top ><FONT SIZE = 1 COLOR = IVORY FACE=ARIAL>
			<b>Servicios en Pieza :</b></font></td>
		  <td colspan="2" valign=top ><FONT COLOR=ivory SIZE=1 FACE=ARIAL><B>
				Obs.</b></font></td>
    </tr>
<%	cad =	" DETALLES " & "'03', " & "'" & PRO & "'," & "'" & VER & "'," & "'D'"
	rs.open cad,cnn
	conta=0
	
	IF NOT rs.eof AND NOT rs.bof THEN
		rs.movefirst
		DO WHILE NOT rs.EOF%>
			<tr ID="FILA3<%=conta%>" STYLE="DISPLAY:block;">
			  <td valign=top > 
			<INPUT TYPE=text ID='COD3<%=conta%>'  NAME='COD3<%=conta%>' value ="<%=muestra_cadena(RS("CODIGO"))%>" class=datosgrande disabled>
			<INPUT TYPE=hidden ID='ID3<%=conta%>' NAME='ID3<%=conta%>' value ="<%=trim(RS("ID"))%>">
  			<INPUT TYPE=HIDDEN ID='DEL3<%=conta%>' NAME='DEL3<%=conta%>' VALUE=0>	
			</td>
		  	<td valign=top >
			<TEXTarea ID="DATO3<%=conta%>"   NAME="DATO3<%=conta%>" wrap=PHYSICAL CLASS=TEXTO READONLY><%=trim(RS("DD"))%></textarea>
		  	</td>
		  	<td colspan="2" valign=top >
		 	 <textarea  ID="ADIC3<%=conta%>" wrap=PHYSICAL NAME="ADIC3<%=conta%>" onBlur="return cuenta(this.value,this.id,200)"  CLASS=ADICIONAL><%= trim(rs("adicional"))%></textarea>
			</td>
    		</tr>
<%			rs.movenext
			conta = conta + 1
		LOOP
	END IF
	rs.close
%>
	<INPUT TYPE=HIDDEN ID="conta3" name=conta3  value ="<%=conta%>">
</TABLE>
<%	' **************************************************
	'                 DETALLE DE TELAS    OPCION "A"    
	' **************************************************	%>
<table width="100%" border=1 cellpadding="5" cellspacing="1" bordercolor=SeaGreen bordercolorlight=LightSeaGreen bordercolordark=DARKGREEN  bgcolor=White id="DETTEL">
  <tr bgcolor=NAVY>
    <td width="3%"><img src="IMAGENES\HELP.GIF" width=20 style="CURSOR:HAND;" onClick="HELP('help/hlpFAMTEL.asp?tip=001&op=4&OPC=')" > <font color=ivory size=1 face=ARIAL><b> </b></font></td>
    <td width="19%"><font color=ivory size=1 face=ARIAL><b>Tela OPCION A</b></font></td>
    <td width="28%" align="right"><font color=ivory size=1 face=ARIAL><b> % UTILIZACIÓN</b></font>
        <input type="text" name=PORA id=PORA onKeyUp= NUMERO('PORA') value="<%=Trim(RS2("PORA"))%>" size="3" maxlength="5" >
    </td>
    <td width="34%"><font color=ivory size=1 face=ARIAL><b>Obs.</b></font></td>
    <td width="4%"><font color=ivory size=1 face=ARIAL><b>Rt.</b></font></td>
    <td width="4%"><font color=ivory size=1 face=ARIAL><b>Mt/P</b></font></td>
    <td width="4%"><font color=ivory size=1 face=ARIAL><b>Kg/P</b></font></td>
    <td width="5%"><font color=ivory size=1 face=ARIAL><b>Mer</b></font></td>
  </tr>
  <%
	op = "04"
	cad =	" DETTELA "  & "'" & PRO & "'," & "'" & VER & "'," & "'D'," & "'" & op & "'"
	rs.open cad,cnn	
	conta=0
	
	IF NOT rs.eof AND NOT rs.bof THEN
		rs.movefirst
		DO WHILE NOT rs.EOF
%>
  <tr ID="FILA4<%=conta%>" STYLE="DISPLAY:BLOCK;">
    <td><INPUT TYPE="HIDDEN" ID="ID4<%=conta%>" NAME="ID4<%=conta%>" value="<%=rs("ID")%>">
        <INPUT TYPE="HIDDEN" ID="DEL4<%=conta%>" NAME="DEL4<%=conta%>" value="0">
        <INPUT TYPE="CHECKBOX" ID="CHK4<%=conta%>" NAME="CHK4<%=conta%>" value="<%=rs("ID")%>" ONCLICK="ids('<%=conta%>','4')">
    </td>
    <td><input type="TEXT" id="COD4<%=CONTA%>" value="<%=muestra_cadena(RS("codtel"))%>" name="COD4<%=CONTA%>" maxlength="5" class="DATOSGRANDE" onChange="BAKE('TELAS', this.value, '4','<%=conta%>')"></td>
    <td><TEXTAREA ID="DATO4<%=conta%>"  NAME="DATO4<%=conta%>" CLASS=TEXTO readonly><%=trim(rs("descripcion"))&" ( DEN: "&trim(rs("DEN"))&" / ANCH: "&trim(rs("ANCHO"))&" / GG: "&trim(rs("GALGA"))&" / REND: "&trim(rs("REND"))&" )"%></TEXTAREA>
    </td>
    <td><TEXTAREA ID="ADIC4<%=conta%>"  NAME="ADIC4<%=conta%>" onfocusout="return cuenta(this.value,this.id,200)" CLASS=ADICIONAL><%=trim(rs("adicional"))%></TEXTAREA>
    </td>
    <td><INPUT TYPE="text" ID="REN4<%=CONTA%>" NAME="REN4<%=CONTA%>"  ONDBLCLICK="HELP('help/hlpTIPREND.asp?ubi=4&pos=<%=CONTA%>')" VALUE = "<%=muestra_cadena(RS("rendimiento"))%>"  CLASS="DATOSkhaki" READONLY ONCHANGE="kgs('<%=conta%>','4')">
    </td>
    <td><INPUT TYPE="text" ID="CON4<%=CONTA%>" NAME="CON4<%=CONTA%>" onChange="kgs('<%=conta%>','4')"  VALUE = "<%=muestra_cadena(RS("METROS"))%>" CLASS="DATOSCENTER">
    </td>
    <td><INPUT TYPE="text" ID="KGS4<%=CONTA%>" NAME="KGS4<%=CONTA%>"  VALUE ="<%=muestra_cadena(RS("PESO"))%>" CLASS="descriptornegro" readonly="true">
    </td>
    <td><INPUT TYPE="text" ID="MER4<%=CONTA%>" NAME="MER4<%=CONTA%>" VALUE="<%=muestra_cadena(RS("MERMA"))%>" CLASS="DATOSCENTER" maxlength="2" >
    </td>
  </tr>

  <%		rs.movenext
			conta = conta + 1
		LOOP
	END IF
	rs.close%>
  <input type="HIDDEN" id="conta4" name="CONTA4" value ="<%=conta%>">
<%
  ' FILA OCULTAS
  FOR I=conta TO 20%>
			<tr ID="FILA4<%=I%>" 
			<%	if i > conta then
				response.Write("STYLE='DISPLAY:NONE'")
			else
				response.Write("style='display:block;'")
			end if %>>
				<td   >
					<INPUT TYPE=HIDDEN   ID='ID4<%=I%>'  NAME='ID4<%=I%>' value="0">
					<INPUT TYPE=HIDDEN   ID='DEL4<%=I%>' NAME='DEL4<%=I%>'value="0">
					<INPUT TYPE=CHECKBOX ID='CHK4<%=I%>' NAME='CHK4<%=I%>' ONCLICK="ids('<%=I%>','4')" value="0">
				</TD>
				<TD >	
					<INPUT TYPE=TEXT CLASS=DATOSGRANDE	MAXLENGTH=5 ID='COD4<%=I%>' NAME='COD4<%=I%>' onKeyPress="MAS('4','<%=i+1%>','20')" onChange="BAKE('TELAS', this.value, '4','<%=i%>')">
				</TD>
				<td>
					<TEXTAREA ID="DATO4<%=I%>" READONLY wrap=virtual CLASS=TEXTO NAME="DATO4<%=I%>"></TEXTAREA>
			  </td>
				<td>
					<TEXTAREA ID="ADIC4<%=I%>" wrap="virtual" NAME="ADIC4<%=I%>" onfocusout="return cuenta(this.value,this.id,200)" CLASS="ADICIONAL"></textarea>
				</td>
				<td>
					<INPUT TYPE="text" ID="REN4<%=I%>" NAME="REN4<%=I%>" ONDBLCLICK="HELP('help/hlpTIPREND.asp?ubi=4&pos=<%=I%>')" ONCHANGE="kgs('<%=i%>','4')" CLASS=DATOSkhaki READONLY>
				</TD>				
				<td>
					<INPUT TYPE="text" ID="CON4<%=I%>" NAME="CON4<%=I%>" onChange="kgs('<%=i%>','4')" CLASS="DATOSCENTER">
				</TD>
				<td>
					<INPUT TYPE="text" ID='KGS4<%=I%>' NAME='KGS4<%=I%>'  CLASS="descriptornegro" readonly="true">
				</TD>
				<td valign=top width=5%>
					<INPUT TYPE="text" ID="MER4<%=I%>" NAME="MER4<%=I%>" CLASS="DATOSCENTER" maxlength="2">
				</TD>
			</tr>
			<%NEXT
	' **************************************************
	'            DETALLE DE TELAS    OPCION "B"         
	' **************************************************	%>
  <tr bgcolor=NAVY>
    <td width="3%"><IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;" onClick="HELP('help/hlpFAMTEL.asp?tip=001&op=7&OPC=')" ></td>
    <td width="19%"><font color=ivory size=1 face=ARIAL><b>Tela OPCION B</b></font></td>
    <td width="28%" align="right"><font color=ivory size=1 face=ARIAL><b> % UTILIZACIÓN</b></font>
        <INPUT ID=PORB NAME=PORB VALUE="<%=Trim(RS2("PORB"))%>" ONKEYUP= NUMERO('PORB') size="3" maxlength=5 >
    </td>
    <td width="34%"><font color=ivory size=1 face=ARIAL><b>Obs.</b></font></td>
    <td width="4%"><font color=ivory size=1 face=ARIAL><b>Rt.</b></font></td>
    <td width="4%"><font color=ivory size=1 face=ARIAL><b>Mt/P</b></font></td>
    <td width="4%"><font color=ivory size=1 face=ARIAL><b>Kg/P</b></font></td>
    <td width="5%"><font color=ivory size=1 face=ARIAL><b>Mer</b></font></td>
  </tr>	
<%	cad =	" DETTELA "  & "'" & PRO & "'," & "'" & VER & "'," & "'D'," & "'" & 11 & "'"
	rs.open cad,cnn	 
	conta=0
	
	IF NOT rs.eof AND NOT rs.bof THEN
		rs.movefirst
			DO WHILE NOT rs.EOF
%>
		 <tr ID="FILA7<%=conta%>" STYLE="DISPLAY:BLOCK;">
		<td><INPUT TYPE="HIDDEN" ID="ID7<%=conta%>" NAME="ID7<%=conta%>" value="<%=rs("ID")%>">
			<INPUT TYPE="HIDDEN" ID="DEL7<%=conta%>" NAME="DEL7<%=conta%>" value="0">
			<INPUT TYPE="CHECKBOX" ID="CHK7<%=conta%>" NAME="CHK7<%=conta%>" value="<%=rs("ID")%>" ONCLICK="ids('<%=conta%>','7')">
		</td>
		<td><INPUT TYPE="TEXT" ID="COD7<%=CONTA%>" VALUE="<%=muestra_cadena(RS("codtel"))%>" NAME="COD7<%=CONTA%>" MAXLENGTH="5" CLASS="DATOSGRANDE"  onChange="BAKE('TELAS', this.value, '7','<%=conta%>')">
		</td>
		<td><TEXTAREA ID="DATO7<%=conta%>"  NAME="DATO7<%=conta%>" CLASS=TEXTO readonly><%=trim(rs("descripcion"))%></TEXTAREA>
		</td>
		<td><TEXTAREA ID="ADIC7<%=conta%>"  NAME="ADIC7<%=conta%>" onfocusout="return cuenta(this.value,this.id,200)" CLASS="ADICIONAL"><%=trim(rs("adicional"))%></TEXTAREA>
		</td>
		<td><INPUT TYPE="text" ID="REN7<%=CONTA%>" NAME="REN7<%=CONTA%>" ONDBLCLICK="HELP('help/hlpTIPREND.asp?ubi=7&pos=<%=CONTA%>')" VALUE = "<%=muestra_cadena(RS("rendimiento"))%>" CLASS="DATOSkhaki" READONLY ONCHANGE="kgs('<%=conta%>','7')">
		</td>
		<td><INPUT TYPE="text" ID="CON7<%=CONTA%>" NAME="CON7<%=CONTA%>" onChange="kgs('<%=conta%>','7')" VALUE = "<%=muestra_cadena(RS("METROS"))%>" CLASS="DATOSCENTER">
		</td>
		<td><INPUT TYPE="text" ID="KGS7<%=CONTA%>" NAME="KGS7<%=CONTA%>" VALUE ="<%=muestra_cadena(RS("PESO"))%>" CLASS="descriptornegro" readonly="true">
		</td>
		<td><INPUT TYPE="text" ID="MER7<%=CONTA%>" NAME="MER7<%=CONTA%>" VALUE="<%=muestra_cadena(RS("MERMA"))%>" CLASS="DATOSCENTER" maxlength="2" >
		</td>
	  </tr>
<%		rs.movenext
		conta = conta + 1
		LOOP
	END IF
	rs.close
%>
<INPUT TYPE=HIDDEN ID="conta7" NAME=CONTA7 value ="<%=conta%>">

	<%FOR I=conta TO 20%>
			<tr ID="FILA7<%=I%>"  
			<%	if i > conta then
				response.Write("STYLE='DISPLAY:NONE'")
			else
				response.Write("style='display:block;'")
			end if %>>
				<td>
					<INPUT TYPE="HIDDEN"   ID="ID7<%=I%>"  NAME="IDK7<%=I%>" value="0">
					<INPUT TYPE="HIDDEN"   ID="DEL7<%=I%>" NAME="DEL7<%=I%>" value="0">
					<INPUT TYPE="CHECKBOX" ID="CHK7<%=I%>" NAME="CHK7<%=I%>" ONCLICK="ids('<%=I%>','7')" value="0">
				</TD>
				<TD>	
					<INPUT TYPE="TEXT" CLASS="DATOSGRANDE"	MAXLENGTH="5" ID='COD7<%=I%>' NAME='COD7<%=I%>' onKeyPress="MAS('7','<%=i+1%>','20')" onChange="BAKE('TELAS', this.value, '7','<%=i%>')">
				</TD>
				<td >
					<TEXTAREA ID="DATO7<%=I%>" READONLY wrap="virtual" CLASS="TEXTO" NAME="DATO7<%=I%>"></TEXTAREA>
			  </td>
				<td >
					<TEXTarea ID="ADIC7<%=I%>" wrap=virtual NAME="ADIC7<%=I%>" onfocusout="return cuenta(this.value,this.id,200)" CLASS="ADICIONAL"></textarea>
				</td>
				<td >
					<INPUT TYPE="text" ID='REN7<%=I%>' NAME='REN7<%=I%>' ONDBLCLICK="HELP('help/hlpTIPREND.asp?ubi=7&pos=<%=I%>')" ONCHANGE="kgs('<%=i%>','7')"  CLASS="DATOSkhaki" READONLY>
				</TD>				
				<td >
					<INPUT TYPE="text" ID='CON7<%=I%>' NAME='CON7<%=I%>' onChange="kgs('<%=i%>','7')" CLASS="DATOSCENTER">
				</TD>
				<td>
					<INPUT TYPE="text" ID='KGS7<%=I%>' NAME='KGS7<%=I%>'   CLASS="descriptornegro" readonly="true">
				</TD>
				<td>
					<INPUT TYPE="text" ID='MER7<%=I%>' NAME='MER7<%=I%>'  CLASS="DATOSCENTER" maxlength="2">
				</TD>
			</tr>
<%		NEXT
	' **************************************************
	'            DETALLE DE TELAS    OPCION "C"         
	' **************************************************
%>

  <tr bgcolor=NAVY>
    <td width="3%"><IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;" onClick="HELP('help/hlpFAMTEL.asp?tip=001&op=8&OPC=')" ></td>
    <td width="19%"><font color=ivory size=1 face=ARIAL><b>Tela OPCION C</b></font></td>
    <td width="28%" align="right"><font color=ivory size=1 face=ARIAL><b> % UTILIZACIÓN</b></font>
        <INPUT NAME=PORC ID=PORC ONKEYUP= NUMERO('PORC') VALUE="<%=Trim(RS2("PORC"))%>" size="3" maxlength=5 >
    </td>
    <td width="34%"><font color=ivory size=1 face=ARIAL><b>Obs.</b></font></td>
    <td width="4%"><font color=ivory size=1 face=ARIAL><b>Rt.</b></font></td>
    <td width="4%"><font color=ivory size=1 face=ARIAL><b>Mt/P</b></font></td>
    <td width="4%"><font color=ivory size=1 face=ARIAL><b>Kg/P</b></font></td>
    <td width="5%"><font color=ivory size=1 face=ARIAL><b>Mer</b></font></td>
  </tr>	
<%	cad =	" DETTELA "  & "'" & PRO & "'," & "'" & VER & "'," & "'D'," & "'" & 12 & "'"
	rs.open cad,cnn	 
	conta=0
	
	IF NOT rs.eof AND NOT rs.bof THEN
		rs.movefirst
			DO WHILE NOT rs.EOF
%>
		 <tr ID="FILA8<%=conta%>" STYLE="DISPLAY:BLOCK;">
		<td><INPUT TYPE="HIDDEN" ID='ID8<%=conta%>' NAME='ID8<%=conta%>' value="<%=rs("ID")%>">
			<INPUT TYPE="HIDDEN" ID='DEL8<%=conta%>' NAME='DEL8<%=conta%>' value="0">
			<INPUT TYPE="CHECKBOX" ID='CHK8<%=conta%>' NAME='CHK8<%=conta%>' value="<%=rs("ID")%>" ONCLICK="ids('<%=conta%>','8')">
		</td>
		<td><INPUT TYPE="TEXT" ID="COD8<%=CONTA%>" VALUE="<%=muestra_cadena(RS("codtel"))%>" NAME="COD8<%=CONTA%>" MAXLENGTH="5" CLASS="DATOSGRANDE"  onChange="BAKE('TELAS', this.value, '8','<%=conta%>')">
		</td>
		<td><TEXTAREA ID="DATO8<%=conta%>"  NAME="DATO8<%=conta%>" CLASS=TEXTO readonly><%=Trim(rs("descripcion"))%></TEXTAREA>
		</td>
		<td><TEXTAREA ID="ADIC8<%=conta%>"  NAME="ADIC8<%=conta%>" onBlur="return cuenta(this.value,this.id,200)" CLASS="ADICIONAL"><%=trim(rs("adicional"))%></TEXTAREA>
		</td>
		<td><INPUT TYPE="text" ID="REN8<%=CONTA%>" NAME="REN8<%=CONTA%>" ONDBLCLICK="HELP('help/hlpTIPREND.asp?ubi=8&pos=<%=CONTA%>')" VALUE = "<%=muestra_cadena(RS("rendimiento"))%>" CLASS="DATOSkhaki" READONLY ONCHANGE="kgs('<%=conta%>','8')">
		</td>
		<td><INPUT TYPE="text" ID="CON8<%=CONTA%>" NAME="CON8<%=CONTA%>" onChange="kgs('<%=conta%>','8')" VALUE = "<%=muestra_cadena(RS("METROS"))%>" CLASS="DATOSCENTER">
		</td>
		<td><INPUT TYPE="text" ID="KGS8<%=CONTA%>" NAME="KGS8<%=CONTA%>" VALUE ="<%=muestra_cadena(RS("PESO"))%>" CLASS="descriptornegro" readonly="true">
		</td>
		<td><INPUT TYPE="text" ID="MER8<%=CONTA%>" NAME="MER8<%=CONTA%>" VALUE="<%=muestra_cadena(RS("MERMA"))%>" CLASS="DATOSCENTER" maxlength="2" >
		</td>
	  </tr>
<%		rs.movenext
		conta = conta + 1
		LOOP
	END IF
	rs.close
%>
<INPUT TYPE=HIDDEN ID="conta8" NAME=CONTA8 value ='<%=conta%>'>

	<%FOR I=conta TO 20%>
			<tr ID="FILA8<%=I%>"  
			<%	if i > conta then
				response.Write("STYLE='DISPLAY:NONE'")
			else
				response.Write("style='display:block;'")
			end if %>>
				<td>
					<INPUT TYPE="HIDDEN"   ID="ID8<%=I%>"  NAME="IDK8<%=I%>" value="0">
					<INPUT TYPE="HIDDEN"   ID="DEL8<%=I%>" NAME="DEL8<%=I%>" value="0">
					<INPUT TYPE="CHECKBOX" ID="CHK8<%=I%>" NAME="CHK8<%=I%>" ONCLICK="ids('<%=I%>','8')" value="0">
				</TD>
				<TD>	
					<INPUT TYPE="TEXT" CLASS="DATOSGRANDE"	MAXLENGTH="5" ID='COD8<%=I%>' NAME='COD8<%=I%>' onKeyPress="MAS('8','<%=i+1%>','20')" onChange="BAKE('TELAS', this.value, '8','<%=i%>')">
				</TD>
				<td >
					<TEXTAREA ID="DATO8<%=I%>" READONLY wrap="virtual" CLASS="TEXTO" NAME="DATO8<%=I%>"></TEXTAREA>
			  </td>
				<td >
					<TEXTarea ID="ADIC8<%=I%>" wrap=virtual NAME="ADIC8<%=I%>" onfocusout="return cuenta(this.value,this.id,200)" CLASS="ADICIONAL"></textarea>
				</td>
				<td >
					<INPUT TYPE="text" ID='REN8<%=I%>' NAME='REN8<%=I%>' ONDBLCLICK="HELP('help/hlpTIPREND.asp?ubi=8&pos=<%=I%>')" ONCHANGE="kgs('<%=i%>','8')"  CLASS="DATOSkhaki" READONLY>
				</TD>				
				<td >
					<INPUT TYPE="text" ID='CON8<%=I%>' NAME='CON8<%=I%>' onChange="kgs('<%=i%>','8')" CLASS="DATOSCENTER">
				</TD>
				<td>
					<INPUT TYPE="text" ID='KGS8<%=I%>' NAME='KGS8<%=I%>' CLASS="descriptornegro" readonly="true">
				</TD>
				<td>
					<INPUT TYPE="text" ID='MER8<%=I%>' NAME='MER8<%=I%>'  CLASS="DATOSCENTER" maxlength="2">
				</TD>
			</tr>

		<%NEXT
	'*************************************************************************
	'                     DETALLES DE CONSRUCCION                             
	'*************************************************************************	%>
	<tr BGCOLOR =NAVY>
			  <td><IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;" onClick="HELP('help/hlpMATRIZ.asp')" ></TD>
			  <TD colspan="7"><FONT SIZE = 1 COLOR = IVORY FACE=ARIAL><b>Detalles de Construcción :</b></font></TD>
    </tr>
<%	cad =	" SELECT *, ss.DESCRIPCION as dd " & _
			" FROM [proto-detalles] pp  " & _
			" INNER JOIN protos on protos.proto = pp.proto " & _
			" and protos.version = pp.version " & _
			" INNER JOIN [matriz_proto] ss on pp.codigo = ss.codigo" & _
			" WHERE tipodetalle = '06' and pp.estado = 'A' " & _
			" and pp.proto = '"&pro&"' and pp.version = '"&ver&"' " 
		rs.open cad,cnn	  
		conta=0
		
	IF NOT rs.eof AND NOT rs.bof THEN
		rs.movefirst
		DO WHILE NOT rs.eof
%>
	<tr ID="FILA6<%=conta%>" STYLE="DISPLAY:BLOCK">
	  <td>
	  	<INPUT TYPE="CHECKBOX" ID='CHK6<%=conta%>' NAME='CHK6<%=conta%>' value="<%=rs("ID")%>"  onclick="ids('<%=CONTA%>','6')">
		<INPUT TYPE='HIDDEN' ID='ID6<%=conta%>' NAME='ID6<%=conta%>' value="<%=rs("ID")%>">
		<INPUT TYPE='HIDDEN' ID='DEL6<%=conta%>' NAME='DEL6<%=conta%>' value="0"></TD>
	  <TD>
	  <INPUT TYPE='text' name='COD6<%=CONTA%>' ID = 'COD6<%=CONTA%>' VALUE="<%=muestra_cadena(RS("CODIGO"))%>" class = 'datosgrande' maxlength='3' onChange="BAKE('MATRIZ_PROTO', this.value, '000','<%=CONTA%>')"></TD>
	  <td >
	  <TEXTAREA ID="DATO6<%=conta%>" name="DATO6<%=conta%>" CLASS='TEXTO' readonly WRAP='VIRTUAL' ><%=trim(rs("dd"))%></TEXTAREA></td>
	  <td colspan="5" ><TEXTAREA ID="ADIC6<%=conta%>" NAME="ADIC6<%=conta%>" onfocusout="return cuenta(this.value,this.id,200)" wrap='virtual' CLASS='ADICIONAL' ><%= trim(rs("adicional"))%></TEXTAREA></td>
    </tr>

<%			rs.movenext
			conta = conta + 1
			LOOP
		END IF
		rs.close
%>
		<INPUT TYPE=HIDDEN ID="conta6" NAME="conta6" value ='<%=conta%>'>
<%	FOR I=conta TO 60%>
	<tr ID="FILA6<%=I%>" 
	<%	if i > conta then
				response.Write("STYLE='DISPLAY:NONE'")
			else
				response.Write("style='display:block;'")
			end if %>>
	  <td>
	  <INPUT TYPE="CHECKBOX" ID="CHK6<%=I%>" NAME='CHK6<%=I%>' onClick="ids('<%=I%>','6')" value="0">
	  <INPUT TYPE='HIDDEN' ID='ID6<%=I%>'  NAME='ID6<%=I%>' value="0">
	  <INPUT TYPE='HIDDEN' ID='DEL6<%=I%>' NAME='DEL6<%=I%>' value="0"></TD>
	  <TD>
	  <INPUT TYPE='text' ID='COD6<%=I%>' NAME='COD6<%=I%>' MAXLENGTH='3' CLASS='DATOSGRANDE' onKeyPress="MAS('6','<%=i+1%>','60')" onChange="BAKE('MATRIZ_PROTO', this.value, '000','<%=i%>')"></TD>
	  <td >
	  <TEXTAREA ID="DATO6<%=I%>" readonly NAME="DATO6<%=I%>" CLASS='TEXTO' ></TEXTAREA></td>
	  <td colspan="5" ><TEXTAREA ID="ADIC6<%=I%>" WRAP='VIRTUAL' NAME="ADIC6<%=I%>" onBlur="return cuenta(this.value,this.id,200)" CLASS='ADICIONAL'></TEXTAREA></td>
    </tr>

<%	NEXT
I=0
	' **************************************************
	'                 DETALLE DE AVIOS                  
	' **************************************************	%>

<tr BGCOLOR='NAVY'>
	  <td><IMG SRC="IMAGENES\HELP.GIF" width=20 STYLE="CURSOR:HAND;" onClick="HELP('help/hlpFAMavi.asp?tip=001&op=1')"></TD>
	  <TD><FONT COLOR='IVORY' SIZE='1' FACE='ARIAL'><B>Avíos</b></font></TD>
	   <td >&nbsp;</td>
	  <td ><FONT COLOR='IVORY' SIZE='1' FACE='ARIAL'><B>Obs.</b></font></td>
	  <td ><FONT COLOR='IVORY' SIZE='1' FACE='ARIAL'><B>T</b></font></td>
      <td ><FONT COLOR='IVORY' SIZE='1' FACE='ARIAL'><B>Cons.</b></font></td>
      <td ><FONT COLOR='IVORY' SIZE='1' FACE='ARIAL'><B>Uni</b></font></td>
      <td ><FONT COLOR='IVORY' SIZE='1' FACE='ARIAL'><B>Mer</b></font></td>
     
	</tr>
<%	cad =	" DETAVIOS " & "'05', " & "'" & PRO & "'," & "'" & VER & "'," & "'D'"
	rs.open cad,cnn	  
	conta=0
	
	IF NOT rs.eof AND NOT rs.bof THEN
		rs.movefirst
		DO WHILE NOT rs.eof
%>
	<tr  ID="FILA5<%=conta%>" STYLE="DISPLAY:BLOCK">
	  <td>
	  <INPUT TYPE='CHECKBOX' ID='CHK5<%=conta%>' NAME='CHK5<%=conta%>' value="<%=rs("ID")%>" ONCLICK="ids('<%=conta%>','5')">
		<INPUT TYPE='HIDDEN' ID='ID5<%=conta%>' NAME='ID5<%=conta%>' value="<%=rs("ID")%>">
		<INPUT TYPE='HIDDEN' ID='DEL5<%=conta%>' NAME='DEL5<%=conta%>' value="0"></TD>
	  <TD>
	  <INPUT TYPE='text' ID='COD5<%=CONTA%>' class='datosgrande' VALUE="<%=muestra_cadena(RS("CODIGO"))%>" NAME='COD5<%=CONTA%>' MAXLENGTH='7' onChange="BAKE('AVIOS', this.value, '000','<%=CONTA%>')"></TD>
	  <td ><TEXTAREA ID="DATO5<%=conta%>"   wrap='virtual' NAME="DATO5<%=conta%>" CLASS='TEXTO' readonly><%=trim(rs("avio")) %></TEXTAREA></td>
	  <td ><TEXTAREA ID="ADIC5<%=conta%>"   wrap'=virtual'  NAME="ADIC5<%=conta%>" onBlur="return cuenta(this.value,this.id,200)" CLASS='ADICIONAL'><%= trim(rs("adicional"))%></TEXTAREA></td>
      <td ><INPUT TYPE='text' ID='TIP5<%=conta%>' NAME='TIP5<%=CONTA%>' READONLY ONDBLCLICK="HELP('help/hlpTIPOAVIO.asp?TIP5=','<%=CONTA%>','','')" VALUE = "<%=muestra_cadena(RS("TIPOAVIO"))%>" CLASS='DATOSkhaki'></td>
      <td ><INPUT TYPE='text' ID='CON5<%=CONTA%>' NAME='CON5<%=CONTA%>'  VALUE ="<%=muestra_cadena(RS("CONSUMO"))%>" CLASS='DATOSDER'></td>
      <td ><INPUT TYPE='text' ID='UNI5<%=CONTA%>' NAME='UNI5<%=CONTA%>' VALUE="<%=muestra_cadena(RS("UNIDAD"))%>" CLASS='TEXTO' DISABLED></td>
      <td ><INPUT TYPE='text' ID='MER5<%=CONTA%>' NAME='MER5<%=CONTA%>' VALUE="<%=muestra_cadena(RS("MERMA"))%>" CLASS='DATOSCENTER' maxlength='2'></td>
	</tr>
	

<%		rs.movenext
		conta = conta + 1
		LOOP
	END IF
	rs.close
%>
		<INPUT TYPE='HIDDEN' ID="conta5"  value ="<%=conta%>" name='conta5'>
		<%	FOR I=conta TO 60%>
	<tr  ID="FILA5<%=I%>" 
	<%	if i > conta then
				response.Write("STYLE='DISPLAY:NONE'")
			else
				response.Write("style='display:block;'")
			end if %>>
	  <td>
	  	<INPUT TYPE='CHECKBOX' ID='CHK5<%=I%>' NAME='CHK5<%=I%>' onClick="ids('<%=I%>','5')" value="0">
		<INPUT TYPE='HIDDEN'   ID='ID5<%=I%>'  NAME='ID5<%=I%>'  value="0">
		<INPUT TYPE='HIDDEN'   ID='DEL5<%=I%>' NAME='DEL5<%=I%>'  value="0"></TD>
	  <TD>
	  <INPUT TYPE='TEXT'   ID='COD5<%=I%>' NAME='COD5<%=I%>' CLASS='DATOSGRANDE' MAXLENGTH='7' onKeyPress="MAS('5','<%=i+1%>','60')" onChange="BAKE('AVIOS', this.value, '000','<%=i%>')"></TD>
	  <td ><TEXTAREA ID="DATO5<%=I%>" readonly wrap='virtual' NAME="DATO5<%=I%>"CLASS='TEXTO'></TEXTAREA></td>
	  <td ><TEXTarea ID="ADIC5<%=I%>" onfocusout="return cuenta(this.value,this.id,200)" wrap='virtual' CLASS='ADICIONAL' NAME="ADIC5<%=I%>"></textarea></td>
	  <td ><INPUT TYPE='text' ID='TIP5<%=I%>' NAME='TIP5<%=I%>' readonly ONDBLCLICK="HELP('help/hlpTIPOAVIO.asp?TIP5=','<%=I%>','','')"  CLASS='datoskhaki'></td>
	  <td ><INPUT TYPE='text' ID='CON5<%=I%>' NAME='CON5<%=I%>'  CLASS='DATOSDER'></td>
	  <td ><INPUT TYPE='text' ID='UNI5<%=I%>' NAME='UNI5<%=I%>' CLASS='texto' disabled></td>
	  <td ><INPUT TYPE='text' ID='MER5<%=I%>' NAME='MER5<%=I%>' CLASS='DATOSCENTER' maxlength='2'></td>
    </tr>
	
<%	NEXT
	'********************************************************
	'        O B S E R V A C I O N E S    INGENIERIA         
	'********************************************************	%>
	
<tr  BGCOLOR=NAVY>
	  <td colspan="8"><FONT SIZE = 1 COLOR = IVORY FACE=ARIAL>
			<b>Observaciones:</b></font></TD>
    </tr>
<%	cad =	" select ING " & _
			" from [proto-OBS] pp  " & _
			" where  pp.proto = '"&pro&"' and pp.version = '"&ver&"' " 
	rs.open cad,cnn	  
	IF NOT rs.eof AND NOT rs.bof THEN
		rs.movefirst
		ING = RS("ING")
	ELSE
		ING= ""
	END IF
	RS.CLOSE%>	
	<tr  ID="FILA7" STYLE="DISPLAY:BLOCK">
	  <td colspan="8">
	  <TEXTAREA ID="ING" NAME="ING" CLASS=ADICIONAL onBlur="return cuenta(this.value,this.id,2000)"><%=Trim(ING)%></TEXTAREA></TD>
    </tr>
</table>
 <TABLE width=100% BORDER=1 cellpadding="5" cellspacing="1"  bgcolor=White bordercolor=SeaGreen bordercolordark=DARKGREEN bordercolorlight=LightSeaGreen>
	<TR>
		<tD width=33%>
			<font color="#003399" size="2" Face=arial> 
			<B>Fecha : 
			<input	value = "<%=date()%>" id=FEC style="width:60%;border:none;color:DarkGreen;font-family:arial; font-size:10px; background-color:transparent" >
			</b></font>
		</TD>
		<tD width=34%>
			<font color="#003399" size="2" Face=arial> 
			<B>Usuario : 
			<input	value = "<%=UCASE(txtUsuario)%>" id=USR style="width:60%;border:none;color:DarkGreen; font-family:arial; font-size:10px; background-color:transparent" >
			</b></font>
			
		</TD>
		<tD width=33% align=right>
			<font color="#003399" size="2" Face=arial> 
			<B>Estado : 
			<input	value = "<%="A"%>" id=EDO style="width:60%;border:none;color:DarkGreen;	font-family:arial; font-size:10px; background-color:transparent" >
			</b></font>
		</TD>
	</TR>
</TABLE>
</form>
</BODY>
</HTML>