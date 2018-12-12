<%@ Language=VBScript %>
<%  Response.Buffer = true 
' Evita el cache del navegador
Response.addHeader "pragma", "no-cache"
Response.CacheControl = "Private"
Response.Expires = 0
txtUsuario = Request.Cookies("Usuario")("USUARIO")
%>
<LINK REL="stylesheet" TYPE="text/css" HREF="HITEPIMA.CSS" >
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
' recibe tabla, primary key, y descripcion
tbl = trim(application("owner"))+".PROTOS"
tabla = ucase("PROTOS")
PRO = Request.QueryString("DAT1")
VER= Request.QueryString("DAT2")
'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
cad = " SP_TABLE_DEFINITION "&TABLA&"  "
'response.Write(cad)
rs.open cad,cnn
RS.MOVEFIRST
dim acols()
dim aLen()
redim acols(-1)
redim alen(-1)

DO WHILE NOT RS.EOF
    redim preserve acols(ubound(acols)+1)
    redim preserve alen(ubound(alen)+1)
    ACOLS(ubound(acols)) = rs("column")
    alen(ubound(alen)) = rs("length")
    RS.MOVENEXT
LOOP
pk = acols(0)
ds = aCols(1)
rs.close
CAD =	" SELECT " 
for i=lbound(acols) to ubound(acols)-1
cad = cad + " "&acols(i)&", "
next
cad = cad + " "&acols(ubound(acols))&"      " & _
		" from "&tbl&"					    " & _
		" WHERE "&acols(0)&" = '"&PRO&"'	" & _
		" AND "&acols(1)&" = '"&VER&"'	    " & _
		" ORDER BY "&acols(0)&"				" 
'Response.Write(CAD)
' abre recordset	
	RS.Open CAD, Cnn
SET rs2 =  SERVER.CreateObject("ADODB.RECORDSET")
rs2.CURSORLOCATION = 3
rs2.LOCKTYPE       = 3  
rs2.CURSORTYPE     = 1


IF RS.RECORDCOUNT > 0 THEN 	
	rs.movefirst
	nuevo = 1
	cliente = rs("cliente")
else 
	nuevo = 0
	cc = ""
end if%>

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title>ESPECIFICACION TECNICA - PROTOTIPOS</title>
<SCRIPT>
function cliente()
{   if (thisForm.CLI.selectedIndex==-1) 
    {   alert("primero seleccionamos cliente") 
        thisForm.CLI.focus();   
    }
     fMuestra('imagenes/atras.gif');	
    return true;
}
function HELP(pag)
{
	var opc = "directories=no,height=500," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=no," ;
	opc = opc + "left=0,top=0,scrollbars=yes," ;
	opc = opc + "status=no,titlebar=no,toolbar=no," ;
	opc = opc + "width=600";
	window.open(pag,'HELP',opc)
}

</SCRIPT>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
function numero(numero, op) 
{	if ( isNaN(trim(numero)) == true )
	{	alert("Sólo se aceptan números");
		return false ;    
	}
return true;	
}

//-->
</SCRIPT>

</HEAD>
<BODY bgColor=White text="#009999" leftmargin="0" topmargin="0" 
	marginwidth="0" marginheight="0" >
<form id=thisForm method=post >
<table border  =0 cellpadding="0" cellspacing="0" width=100%>
	<tr valign="center" > 
		<td>
			<img src="imagenes/CERRAR.gif" 	style="cursor:hand;" onClick="javascript: window.close();">
		</TD>		
		<td bgcolor="#ffffff" align = center><b>
			<table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" 
		width="100%" bordercolorlight="#f7d975">
		    <tr>
		        <td><span  class="reportescenter">FICHA PROTO</span></td>
		    </tr>
		</table>
		</td>
		<td align = right > 
			<img src=imagenes/disk.gif style="cursor:hand;" onClick="return GRABA();"> 
		</td>
    </tr>
</TABLE> 
<TABLE width=100% border=1 bordercolordark=navy 
cellpadding="3" cellspacing="0" bordercolorlight=white>   
	<TR valign=middle>
		<td bgcolor="<%=APPLICATION("HEAD")%>" >
			<span class ="titulitowhite">G E N E R A L E S</span>
		</td>	
	</TR>
</TABLE>

<table	border  =1 cellpadding="1" width=100% cellspacing="0" 
bgcolor=White bordercolor=SeaGreen bordercolordark=white
bordercolorlight=gainsboro>
  <tr valign="center">
    <td align="left" bgcolor="<%=application("barra")%>" width="10%">
    <span class=titulito>Proto-Ver</span></td>
    <td align="left" width="10%"><input type="text" id="COD" name="COD" value=
		'<%if nuevo=1 then Response.Write(rs("PROTO")) else Response.Write("AUTO")%>' 
		tabindex=-1 readonly class=texto >    </td>
		<td align="left" width="5%"><input type="text" id="VER" name="VER" value=
		'<%if nuevo=1 then Response.Write(rs("version")) else Response.Write("001")%>' 
		tabindex=-1 readonly class=texto >    </td>
       
    <td width="10%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">CLIENTE</span> </td>
        <td colspan="1" width="30%">
        <select id="CLI" style="WIDTH:100%" class="DATOSgrande " onchange="return cliente()" onmouseout="fOculta('imagenes/atras.gif')">
        <%TBL1 = APPLICATION("OWNER")+".EMPRESAS"
	    CAD = "SELECT * FROM "&TBL1&" WHERE  ESTADO = 'A'  ORDER BY NOMBRE "
	    RS2.OPEN CAD, Cnn
	    if rs2.eof or rs2.bof then%>
            <option value=''>No Hay Clientes Registrados </option>
            <%else%>
            <%rs2.movefirst%>
            <option value=''></option>
            <%do while not rs2.eof%>
                <option value=<%=rs2("cliente")%> >
                <%=rs2("nombre")%> </option>
                <%rs2.movenext%>
            <%loop%>
          </select>
          <%end if %>
          <script type="text/jscript">
          NN= '<%=CINT(TRIM(NUEVO) )%>'
          cc = '<%=trim(cliente)%>' 
          if (NN == 1)
          { subcadena =  trim(cc) ;
	        elemento = thisForm.CLI ;
	        thisForm.CLI.selectedIndex = seleindice(subcadena,elemento);
	      }  
          </script>
          </td>
         <td rowspan="8" width="30%" valign="middle" align="center" >HACER CLICK PARA COLOCAR FOTO
         </td> 
  </tr>
  <tr>
    <td width="10%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">ESTILO</span> 
    </td>
   <td colspan="2" width="15%"><select id="EST" style="WIDTH:100%" class="DATOSgrande"  >
        <%TBL1 = APPLICATION("OWNER")+".estilos"
	    CAD = "SELECT * FROM "&TBL1&" WHERE cliente = case when '"&cliente&"'<>'' then '"&cliente&"' end and  ESTADO = 'A'  ORDER BY descripcion "
	    rs2.close
	    RS2.OPEN CAD, Cnn
	    if rs2.eof or rs2.bof then%>
            <option value=''>No Hay estilos Registrados para este cliente</option>
            <%else%>
            <%rs2.movefirst%>
            <option value=''></option>
            <%do while not rs2.eof%>
                <option value=<%=rs2("estilo")%> >
                <%=rs2("descripcion")%> </option>
                <%rs2.movenext%>
            <%loop%>
          </select>
          <%end if %>
    </td>
    <td width="10%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">TEMPORADA</span> 
    </td>    
  </tr>

</TABLE>    
<TABLE width=100% border=1 bordercolordark=DarkOrange 
cellpadding="3" cellspacing="0" bordercolorlight=white>   
	<TR valign=middle>
		<td bgcolor="#f7d975" >
			<FONT SIZE=1 COLOR=navy FACE=ARIAL><b>C R U D O  
		</td>	
	</TR>
</TABLE>
<%'T E J E D U R I A %>
<TABLE border  =1 cellpadding="1" 
	cellspacing="0" width=100%
  bgcolor=White bordercolor=SeaGreen bordercolordark=white
  bordercolorlight=gainsboro>  

<TR>
	<td align="CENTER" bgcolor="#ddebc6"  WIDTH=12%><span class=titulito>Galga</td>
	<td align="left" bgcolor="Snow" width="12%" ><input id =GG  NAME=GG
		<%if nuevo = 1 then %> VALUE= '<%=RS("GALGA")%>' <%END IF%> TYPE=TEXT 
		onchange="return numero(window.thisForm.GG.value)" class=datosgrande></td>
	<td bgcolor="#ddebc6" width="12%" ALIGN=CENTER><SPAN CLASS =TITULITO> Diámetro</td>
  	<td bgcolor="Snow" width="12%"><input id =DIA  NAME=DIA <%if nuevo = 1 then %> VALUE= '<%=RS("DIA")%>' 
  		<%END IF%> TYPE=TEXT CLASS=DATOSGRANDE onChange="return numero(window.thisForm.DIA.value)"></td>
	<td bgcolor="#ddebc6" ALIGN=CENTER WIDTH=12%><SPAN CLASS=TITULITO>Ancho Crudo</td>
	<td align="left" bgcolor="Snow" WIDTH=12%><input id =ATCRUDO name=ATCRUDO <%if nuevo = 1 then %>
		VALUE= '<%=TRIM(RS("ANCHCRU"))%>' <%END IF%> TYPE=TEXT CLASS=DATOSGRANDE></td>
	<td bgcolor="#ddebc6" ALIGN=CENTER WIDTH=12%><SPAN CLASS=TITULITO>PM2 Crudo</td>
    <td bgcolor="Snow" WIDTH=12%><input id =PMCRUDO name=PMCRUDO <%if nuevo = 1 then %>
        VALUE= '<%=TRIM(RS("PESOCRU"))%>' <%END IF%>  TYPE=TEXT CLASS=DATOSGRANDE></td>
	</tr>
</TABLE>  

<TABLE width=100% border=1 bordercolordark=DarkOrange 
cellpadding="3" cellspacing="0" bordercolorlight=white>   
	<TR valign=middle>
		<td bgcolor="#f7d975" >
			<FONT SIZE=1 COLOR=navy FACE=ARIAL><b>A C A B A D O
		</td>	
	</TR>
</TABLE>
<%'A C A B A D O%>
<table border  =1 cellpadding="1" 	cellspacing="0" width=100%  bgcolor=White 
bordercolor=SeaGreen bordercolordark=WHITE  bordercolorlight=GAINSBORO>  
	<tr valign="center" width=10%> 
		<td bgcolor="#ddebc6" width="5%" ALIGN=CENTER><SPAN CLASS=TITULITO> Pm2 Acabado</td>
		<td align="CENTER" bgcolor="#ddebc6"><SPAN CLASS=TITULITO>Ancho Tubular</td>
		<td align="CENTER" bgcolor="#ddebc6"><SPAN CLASS=TITULITO>Ancho Abierto</td>
		<td bgcolor="#ddebc6" ALIGN=CENTER><SPAN CLASS=TITULITO>Rend. Tela Tubular</td>
		<td bgcolor="#ddebc6" ALIGN=CENTER><SPAN CLASS=TITULITO>Rend. Tela Abierta</td>
	</TR>
	<TR>
		<td  bgcolor="Snow" width="5%"> 
			<input id =PM2 name= PM2 <%if nuevo = 1 then %> VALUE= '<%=rs("pesoaca")%>' <%end if%>
			TYPE=TEXT class=datosgrande>
		</td>				
		<td align="left" bgcolor="Snow" width="10%"> 
			<input id =AT NAME=AT <%if nuevo = 1 then %>
				VALUE= '<%=rs("anchtub")%>' <%end if%> TYPE=TEXT 
			onKeyUp="return rtt();" class=datosgrande>
		</td>		
		<td align="left" bgcolor="Snow" width="10%"> 
			<input id =AA NAME=AA <%if nuevo = 1 then %> VALUE= '<%=rs("anchabi")%>' <%end if%>
			TYPE=TEXT onKeyUp="return rta()" class=datosgrande>
		</td>
		<td align="left" bgcolor="Snow" width="10%" > 
			<input type=text  <%if nuevo = 1 then %> value = '<%=rs("renDtub")%>' <%end if%>
			id=REN	NAME=REN onChange="return numero(window.thisForm.REN.value)"
			class= texto readonly="-1">
		</td>
		<td align="left" bgcolor="Snow" width="10%"> 
			<input id =RTA  NAME=RTA <%if nuevo = 1 then %> VALUE= '<%=rs("rendabi")%>' <%end if%>
			 TYPE=TEXT onChange="return numero(window.thisForm.RTA.value)" class=texto readonly="-1">
      </td>	
    </tr>
   </TABLE>    
<TABLE width=100% border=1 bordercolordark=DarkOrange 
cellpadding="3" cellspacing="0" bordercolorlight=white>   
	<TR valign=middle>
		<td bgcolor="#f7d975" >
			<FONT SIZE=1 COLOR=navy FACE=ARIAL><b>C O S T O S
		</td>	
	</TR>
</TABLE><%'I N V E N T A R I O%>
<table border  =1 cellpadding="1" 
	cellspacing="0" width=100%
	bgcolor=White bordercolor=SeaGreen bordercolordark=WHITE
	bordercolorlight=GAINSBORO>  
<tr>
      <td  bgcolor="#ddebc6" width="8%"><span class=titulito> Uni. Med.</td>
      <td bgcolor="Snow" width="2%"><IMG	SRC="IMAGENES\HELP.GIF" width=20
			STYLE="CURSOR:HAND;"onclick="HELP('help/hlpUNI.asp')"><input
			<%if nuevo = 1 then %> VALUE= '<%=rs("uni")%>' <%end if%> readonly
			id=UNI NAME=UNI class=texto tabindex=-1 STYLE="DISPLAY:NONE"></TD> 
	<TD width=20%>			
        <input <%if nuevo = 1 then %> VALUE= '<%=rs("uni")%>' <%end if%> readonly
				id=DESUNI  class=texto tabindex=-1>
	</td>
    <td  width="5%"  bgcolor=#ddebc6><span class=titulito>Moneda</td>
    <td bgcolor="Snow"  width="2%"><IMG	SRC="IMAGENES\HELP.GIF" width=20
		STYLE="CURSOR:HAND;" onClick="HELP('help/hlpMON.asp')"><input <%if nuevo = 1 then %> 
		VALUE= '<%=rs("mon")%>' <%end if%> readonly id=MON style="display:none;" NAME=MON>
	</td><td width=20%>			
		<input	<%if nuevo = 1 then %> VALUE= '<%=rs("desmon")%>' <%end if%> 
		tabindex =-1 readonly class =texto id=DESMON>
	</td>
    <td  bgcolor="#eef1ed" width="5%"><span class=titulito>COSTO:</td>
      <td  bgcolor=Snow width="10%"><INPUT ID = PROM NAME=PROM
       <%if nuevo = 1 then %> VALUE= '<%=rs("costo")%>' <%end if%>  
		CLASS=DATOSGGRANDE>
      </td>
	</tr>      
	
</table>

  <TABLE width=100% border=1 bordercolordark=DarkOrange 
cellpadding="3" cellspacing="0" bordercolorlight=white>   
	<TR valign=middle>
		<td bgcolor="#f7d975" >
      <FONT SIZE=1 COLOR=navy FACE=ARIAL><b>O B S E R V A C I O N E S</td>
    </TR>
</TABLE>    
<table	border  =1 cellpadding="1" width=100% cellspacing="0" 
bgcolor=White bordercolor=SeaGreen bordercolordark=white
bordercolorlight=gainsboro>    
    <TR> 
      <td colspan=13 bgcolor=Snow> 
        <TEXTAREA id="CONTENIDO" NAME = CONTENIDO rows=5 wrap=virtual
		style="width:100%;"	 > <%if nuevo = 1 then %> 
		<%=rs("OBSERVACION")%> <%end if%> </textarea>
      </td>
    </TR>
  </table>
  <TABLE BORDER=0 cellpadding="1" 	cellspacing="0" ALIGN=CENTER
  bgcolor=White bordercolor=SeaGreen bordercolordark=WHITE
  bordercolorlight=GAINSBORO>
	<TR>
		<tD width=20% >
			<SPAN CLASS=TITULITODER><FONT COLOR=NAVY>&nbsp;&nbsp;Fecha : &nbsp;&nbsp;</TD>
			<TD><input	value = '<%=DATE()%>'id=FEC CLASS=TEXTO></TD>
		<tD width=20% ><SPAN CLASS=TITULITODER><FONT COLOR=NAVY>&nbsp;&nbsp;Usuario :&nbsp;&nbsp;</TD>
		<TD ><input	value = '<%=txtUsuario%>'id=USR CLASS=TEXTO ></TD>
		<tD width=20% align=right><SPAN CLASS=TITULITODER><FONT COLOR=NAVY>&nbsp;&nbsp;Estado :&nbsp;&nbsp; </TD>
		<TD><input	value = 'A' id=EDO NAME=EDO CLASS=TEXTO ></TD>
	</TR>
</TABLE>

<div id="nombre" name="nombre" style="LEFT:200px; WIDTH:500px; POSITION:absolute; TOP:100px; HEIGHT:600px;visibility:hidden">
	<img id="img1" height="300"></img>
	</div>
<script type="text/jscript">
function fMuestra(_x)
{
document.getElementById('nombre').style.top = document.body.scrollTop;
	document.getElementById('nombre').style.visibility= 'visible';
	document.getElementById('img1').src=_x;
}
function fOculta()
{
document.getElementById('nombre').style.visibility= 'hidden';
}
 function NUMERO(obj)
 {	if (isNaN(obj.value))
	{	obj.value = ''
		alert("Sólo se aceptan números")
		obj.focus()
		return false
	}
 }
 
 function fValidaInput() 
{
  var mcadena = document.getElementById('DES').value;
  /*var mcadena =thisForm.COD.value*/
   var marray1 = mcadena.split("'");
   var marray2 = mcadena.split("&");
   if (marray1.length > 1 )
	{	alert('Caracter Invalido');
		document.getElementById('DES').focus();
	 	document.getElementById('DES').value ='';		
		return false;
	}	
   if (marray2.length > 1 )
	{	alert('Caracter Invalido, usa "Y"');
		document.getElementById('DES').focus();
	 	document.getElementById('DES').value ='';		
		return false;
	}	
}
 
function DES()
{		thisForm.DES.value = trim(thisForm.FM.value) + ' ' 
		h11 = thisForm.MP1.value
		h1 = h11.substr(4,2)+'/'+h11.substr(6,1) +' ' + trim(thisForm.P1.value)+ ' %'
		if (trim(thisForm.MP2.value)!= '')
		{	h22 = thisForm.MP2.value
			h2 = h22.substr(4,2)+'/'+h22.substr(6,1) +' ' + trim(thisForm.P2.value)+ ' %'
		}
		else
		h2=''
		if (trim(thisForm.MP3.value)!= '')
		{	h33 = thisForm.MP3.value
			h3 = h33.substr(4,2)+'/'+h33.substr(6,1) +' ' + trim(thisForm.P3.value)+ ' %'
		}
		else
		h3=''
		thisForm.DES.value += h1 + ' ' + h2 + ' ' +h3 + ' ' +  ltrim(thisForm.DESTPTEL.value)
		
} 
function COD_onclick() {

}

</script>	
</form>
</BODY>
</HTML>
