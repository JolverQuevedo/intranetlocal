<%@ Language=VBScript %>
<%  Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil	= Request.Cookies("Usuario")("Perfil")
	NIVEL		= txtPerfil
%>


<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<title>FICHA DE CORTE</title>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>

function window_onfocus() {
	document.body.style.fontFamily = "arial"
	document.body.style.color='NAVY'
	CALCULA()
}

function cambia()
{	thisForm.PEDIDO.value = thisForm.cli.options(thisForm.cli.selectedIndex).innerText;
	thisForm.CODCLI.value=thisForm.cli.value
	alert(thisForm.CODCLI.value)    //
}
var LaunchedWin
function HELP(pag)
{	var opc = "directories=no,height=400," ;
	opc = opc + "hotkeys=no,location=no," ;
	opc = opc + "menubar=no,resizable=no," ;
	opc = opc + "left=0,top=0,scrollbars=yes," ;
	opc = opc + "status=no,titlebar=no,toolbar=no," ;
	opc = opc + "width=400";
LaunchedWin = window.open(pag,'HELP',opc)
}
function borra(i,k)
{ cad = eval("thisForm.cel"+i+"0.value")
	cad = trim(cad)
	if (cad.length == 0)
	{	eval("thisForm.chk"+i+".checked=false")
		return true;
	}
	if(eval("thisForm.chk"+i+".checked")== true)
		for (b=0;b<12; b++)
		{	eval("thisForm.cel"+i+b+".value=''")
			eval("thisForm.chk"+i+".checked=false")
			eval("fil"+i+".style.display='none'")
		}
}

function cierra()
{	window.opener.location.replace('pos.asp?pos='+trim(thisForm.PO.value) + '&perfil=1')
	window.close()
}
//-->
</SCRIPT>
</HEAD>
<%	pos= Request.QueryString("pos")
	CAD =	" POSDATA" &  "'" & POS & "'"
	
	RS.OPEN CAD,CNN
	'RS.MOVEFIRST	''''''''''''''''''XXXX
SET RS2 = Server.CreateObject("ADODB.RecordSet")
	RS2.ActiveConnection	= Cnn
	rs2.CursorType			= 3
	rs2.LockType			= 1
%>
<BODY bgColor=white text="#009999" leftmargin="0" topmargin="0" 
	marginwidth="0" marginheight="0" LANGUAGE=javascript >
      
<form id=thisForm method=post name=thisForm action='comun/inserfcorte.asp'>
<table WIDTH="100%">
	<tr>
		<td align= left WIDTH="35%">
			<IMG style="CURSOR: 
			hand"
			 onclick="javascript: window.location.replace('LIQUIDACIONCORTE.ASP');" src="imagenes/ATRAS.gif" >
			
		</td>
		<td align= middle>
			<font face=arial size= 3 color=darkblue><B>
			<%=titulo%>
			
			</B></font>
		</td>
		<TD ALIGN=right WIDTH="35%"> 
		  	<IMG src="imagenes/logo.GIF">
		  </TD>
        </tr></TR>
	<TR>
	<td COLSPAN=3>
			<HR>
		</td>
	</TR>
</table>

<table >
<tr >	
	<td width="30%">&nbsp;</td>    
	<td>
<table width="619" border="1" cellspacing="0" cellpadding="0" style="WIDTH: 619px; HEIGHT: 114px" >
  <tr> 
    <td width="13%" bgcolor="#badcdc" >
            <P align=right>	<FONT SIZE = 1       
            FACE=ARIAL COLOR=black><b>OFI:&nbsp;&nbsp;<IMG 
            id=IMG1 style ="CURSOR:hand" 
            onclick="HELP('HELP/HLPliquidacioncorte.ASP');" alt=PEDIDO src="imagenes/HELP.gif" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            </FONT></B></P>
	</td>
	 <td> 
      <input onKeypress="NUMERO()"
			 onChange="BAKE('calidadtela',this.value)" 
			class=datosgrande      
      id=CODPED size   
      =6 name="CODPED" 
            style="WIDTH: 95.26%; HEIGHT: 19px" 
            ="middle">
    </td>  
    <td width="6%" bgcolor="#badcdc">	<FONT size = 1  FACE = ARIAL COLOR = black><b>#CORTE</b></FONT> </td>
    <td width="15%">&nbsp;</td>
    <td width="15%"  bgcolor="#badcdc">	<FONT size = 1  FACE = ARIAL COLOR = black><b></b></FONT></td>
    <td width="18%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="13%" bgcolor="#badcdc">	<FONT size = 1  FACE = ARIAL COLOR = black><b>CLIENTE:</FONT></B></td>
    <td width="22%" >&nbsp;</td>
    <td width="6%" bgcolor="#badcdc">	<FONT size = 1  FACE = ARIAL COLOR = black><b>ESTILO</b></FONT></td>
    <td width="15%">&nbsp;</td>
    <td width="9%"  bgcolor="#badcdc">	<FONT size = 1  FACE = ARIAL COLOR = black><b>FECHA DE GIRO</b></FONT>  </td>
    <td width="18%">&nbsp;</td>
  </tr>  
  <tr> 
	<td width="13%" bgcolor="#badcdc">
            <P align=right>	<FONT size = 1       
            FACE=ARIAL COLOR=black><b>TELA:&nbsp;<IMG 
            style="CURSOR: hand" onclick="HELP('HELP/HLPTELAS.ASP');" alt=TELAS 
            src="imagenes/HELP.gif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            </FONT></B></P>
	</td>
    <td width="22%" ><INPUT 
      style="LEFT: 2px; WIDTH: 131px; TOP: 3px; HEIGHT: 21px" size=6>&nbsp;
    </td>
    <td width="6%" bgcolor="#badcdc">	<FONT size = 1  FACE = ARIAL COLOR = black><b>COLOR</b></FONT></td>
    <td width="15%">&nbsp;</td>
    <td width="9%" bgcolor="#badcdc">  </td>
    <td width="18%">&nbsp;</td>
   </tr>  
   <tr> 
	<td width="15%" bgcolor="#badcdc">	<FONT size = 1  FACE = ARIAL COLOR = black><b>DESCRIPCION DE LA PRENDA</b></FONT> </td>
	<TD colspan = 5><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT>&nbsp; </TD>  
  </tr>  
</table>
<table width="618" border="1" cellspacing="0" cellpadding="0" style="WIDTH: 618px; HEIGHT: 86px">
  <TR>
	<td width=18% bgColor=#badcdc align=center  id=HLPTALLA><img
			src=imagenes\help.gif WIDTH=20
			style="border:none;cursor:hand; "
			onclick="HELP('help/hlpTALLAS.asp?pos=',thisForm.TALLAS.value)">
			<FONT SIZE=2><b>TALLAS</td> 
		
		<TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		<TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		<TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		<TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		<TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		<TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		<TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		<TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		<TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		<TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		<TD width="13%"  bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b>TOTAL</b></FONT> </TD>
  </TR>    
  <TR> 
    <TD width="9%"	  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>Q. 
            PEDIDO</b></FONT>&nbsp; </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>   
  </TR>
  <TR>
    <TD width="9%"	  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>%.MERMA</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;&nbsp;</b></FONT> </TD>
  </TR>    
  <TR> 
    <TD width="9%"	  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>Q.TOTAL</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
  </TR>
</table>
<BR>
<FONT size = 1 FACE=ARIAL COLOR=black><b>GIRO DE ORDEN DE CORTE</b></FONT>
<BR>
<TABLE style="WIDTH: 870px; HEIGHT: 170px" cellSpacing=1 cellPadding=1 width=870>  
  <TR>
    <TD width="17%">
      <TABLE style="WIDTH: 464px; HEIGHT: 148px" cellSpacing=1 cellPadding=1 width=464 border=1>
        
        <TR>
          <TD width="17%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>TALLAS</b></FONT> </TD>
          <TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
          <TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
          <TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		  <TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
		  <TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
          <TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
          <TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
          <TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
          <TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b></b></FONT> </TD>
          <TD width="8.5%" bgColor=#badcdc><FONT size = 1 FACE=ARIAL COLOR=black><b>TOTAL</b></FONT> </TD>       
          </TR>
        <TR>
          <TD width="17%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>PROPORCION</b></FONT> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 32px; HEIGHT: 22px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 32px; HEIGHT: 22px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 32px; HEIGHT: 22px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 32px; HEIGHT: 22px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 32px; HEIGHT: 22px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 32px; HEIGHT: 22px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 32px; HEIGHT: 22px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 32px; HEIGHT: 22px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 32px; HEIGHT: 22px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 32px; HEIGHT: 22px" size=1> </TD>
          
        </TR>
        <TR>
          <TD width="17%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>PROGRAMADO</b></FONT> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px; TOP: 2px;" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          </TR>
        <TR>
          <TD width="17%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>REAL</b></FONT> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          </TR>
        <TR>
          <TD width="17%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>Nº PAÑOS</b></FONT> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 31px; HEIGHT: 21px" size=1> </TD>
          <TD width="8.5%"><INPUT style="WIDTH: 30px; HEIGHT: 21px" size=1> </TD>
          </TR>
          
          </TABLE>
        
    <TD>
    
    <TABLE style="WIDTH: 148px; HEIGHT: 75px" cellSpacing=1 cellPadding=1 width=148 border=1>
        <TR>
          <TD width="36%" COLSPAN = 2 bgColor=#badcdc> <FONT size = 1       
                  FACE=ARIAL COLOR=black><b>KG. PROGRAMADOS</b></FONT> </TD>
		 
        </TR>
        <TR> 
         <TD COLSPAN = 2><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
        </TR>
        
       <TR>
          <TD width="36%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>COLLERETA</b></FONT> </TD>
          <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
       </TR>
     </TABLE>
     
    
     <TABLE style="WIDTH: 148px; HEIGHT: 77px" cellSpacing=1 cellPadding=1 width=148 border=1>
      
        <TR>
          <TD width="35%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>E%</b></FONT> </TD>
          <TD width="21%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>L</b></FONT> </TD>
          <TD width="21%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>A</b></FONT> </TD>
          <TD width="21%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>R%</b></FONT> </TD>
          
        <TR>
          <TD width="17%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>LAV</b></FONT> </TD>
          <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
          <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
          <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
            
         <TR>
          <TD width="17%" bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>VAP</b></FONT> </TD>
          <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
          <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
          <TD><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
            
        <TR></TR>
    </TABLE></TD></TR>
</TABLE><BR>
  <table width="622" border="1" cellspacing="0" cellpadding="0" style="WIDTH: 622px; HEIGHT: 736px" >

  <TR>
    <TD width=72 colSpan=2 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>TENDIDO</b></FONT> </TD>
    <TD width=96 colSpan=2><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD width=108 colSpan=3 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>HORA INICIO</b></FONT> </TD>
    <TD width=96 colSpan=2><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD width=100 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>HORA DE TERMINO</b></FONT></TD>
    <TD width=60 colSpan=3><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD width=48 colSpan=2 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>FECHA</b></FONT> </TD>
    <TD width=48 ><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    </TR>
  <TR style="mso-yfti-irow: 1">
  
    <TD width=86 colSpan=2  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>TENDEDOR 1</b></FONT> </TD>
    <TD width=204 colSpan=5><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    
    <TD width=96 colSpan=2  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>TENDEDOR 2</b></FONT> </TD>
    
     
      <TD  colSpan=10><FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    </TR>
    
  <TR style="mso-yfti-irow: 2">
    <TD width=72 colSpan=2  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>MEDIDAS</b></FONT> </TD>
    <TD width=96 colSpan=2  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>ANCHO DE TELA</b></FONT> </TD>
    <TD width=108 colSpan=3  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>RENDIMIENTO DE  TELA</b></FONT> </TD>
    <TD width=96 colSpan=2  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>ANCHO DE TIZADO</b></FONT> </TD>
    <TD width=84  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>LARGO DE TIZADO</b></FONT> </TD>
    <TD width=60 colSpan=3  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>Nº TIZADO</b></FONT> </TD>
    <TD colSpan=6   bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>PESO DEL PAÑO</b></FONT> </TD>
  </TR>
  
  
  <TR>
   <TD width=72 colSpan=2  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>BASICA</b></FONT> </TD>
   <TD width=96 colSpan=2> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=108 colSpan=3> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=96 colSpan=2> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=84> <FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
   <TD width=60 colSpan=3> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=96 colSpan=8> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
   
   
  <TR>
    <TD width=945 colSpan=18>&nbsp;
    </TD>
  </TR>
  
  
  <TR style="mso-yfti-irow: 5">
	
   <TD width=99 colSpan=3 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>COLOR</b></FONT> </TD>
   <TD width=99 colSpan=4   bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>Nº DE ROLLO</b></FONT> </TD>
   <TD width=99 colSpan=3   bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>Nº DE PAÑOS</b></FONT> </TD>
   <TD width=99 colSpan=3  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>PESO</b></FONT> </TD>
   <TD width=99 colSpan=5   bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>PARTIDA</b></FONT> </TD>
   
   </TR>
  
  
  <TR style="mso-yfti-irow: 5">
	
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   
   </TR>
  
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
  <TR style="mso-yfti-irow: 5">
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=4 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=3 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   <TD width=99 colSpan=5 > <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
  
	
  <TR>
  <TD width=945 colSpan=18></TD>
  
  </TR>


  <TR>
    
    <TD width=945 colSpan=18  bgColor=#badcdc>
      <P align=center> <FONT size = 1 FACE = ARIAL COLOR=black><b>CORTE</b></FONT> </P> </TD>
    
  </TR>
  <TR>
    <TD width=50 colSpan=2  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>CORTE</b></FONT> </TD>
    <TD width=36>							<FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD width=180 colSpan=5  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>HORA DE INICIO</b></FONT> </TD>
    <TD width=36>							<FONT size = 1   
      FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD width=120 colSpan=3  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>HORA DE TERMINO</b></FONT> </TD>
    <TD width=50 >				<FONT size = 1       
      FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
    <TD width=50  bgColor=#badcdc>			<FONT size = 1  FACE = ARIAL COLOR = black><b>FECHA</b></FONT> </TD>
    <TD width=60 colSpan=4>				<FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
   </TR>
   
   
  <TR style="mso-yfti-irow: 30">
    <TD width=72 colSpan=2  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>CORTADOR1</b></FONT> </TD>
    <TD width=156 colSpan=4> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
    <TD width=100 colSpan=2  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>CORTADOR2</b></FONT> </TD>
    <TD width=100 colSpan=5> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
    
    
  <TR>
    <TD width=72 colSpan=2 rowSpan=2  
      bgColor=#badcdc> <FONT size = 1       
      FACE=ARIAL COLOR=black><b>TELA 1RA</b></FONT> </TD>
    <TD width=156 colSpan=4 rowSpan=2 bgColor=#badcdc> <FONT size = 1 FACE=ARIAL COLOR=black><b>TELA FALLADA</b></FONT> </TD>
    <TD width=100 colSpan=2 rowSpan=2 bgColor=#badcdc> <FONT size = 1 FACE=ARIAL COLOR=black><b>PUNTAS</b></FONT> </TD>
    <TD width=100 colSpan=4 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>RETAZOS</b></FONT> </TD>
    <TD width=108 colSpan=5 rowSpan=2 bgColor=#badcdc> <FONT size = 1 FACE=ARIAL COLOR=black><b>ENTRECORTE</b></FONT> </TD>
      
  </TR>
  <TR style="mso-yfti-irow: 32">
    <TD width=120  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>MENOS DE 30 CM</b></FONT> </TD>
    <TD width=160  colSpan=2 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>MAS DE 30 CM</b></FONT> </TD>
  </TR>
  
  
  <TR>
    <TD width=72 colSpan=2> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
    <TD width=156 colSpan=4> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
    <TD width=108 colSpan=2> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
    <TD width=48 colSpan=2> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
    <TD width=108 colSpan=3> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
    <TD width=108 colSpan=5> <FONT size = 1  FACE = ARIAL COLOR = black><b>&nbsp;</b></FONT> </TD>
  </TR>
   
</table>
<P>&nbsp;</P>

<table width="622" border="1" cellspacing="0" cellpadding="0" style="WIDTH: 622px; HEIGHT: 44px">
	<TR>
		<TD width=160  bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>TIPO DE TENDIDO</b></FONT> </TD>
		<TD width=160 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>TUBULAR</b></FONT> </TD>
		<TD width=160 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>ABIERTO</b></FONT> </TD>
	</TR>
	
	<TR>
		<TD width=160  > <FONT size = 1       
      FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
		<TD width=160 > <FONT size = 1       
      FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
		<TD width=160 > <FONT size = 1       
      FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
	</TR>

</table>

<BR>
<BR>

<table width="624" border="1" cellspacing="0" cellpadding="0" style="WIDTH: 624px; HEIGHT: 65px" >
	<TR>
		<TD width=200 COLSPAN = 2 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>CONSUMO PROG.</b></FONT> </TD>
		<TD width=200 COLSPAN = 2 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>CONS. TIZADO</b></FONT> </TD>
		<TD width=200 COLSPAN = 2 bgColor=#badcdc> <FONT size = 1  FACE = ARIAL COLOR = black><b>CONS. REAL</b></FONT> </TD>
		<TD width=200 COLSPAN = 2 ROWSPAN = 2 bgColor=#badcdc> <FONT size = 1       
      FACE=ARIAL COLOR=black><b>PESO DE COLLERETA</b></FONT> </TD>
		
	</TR>
	
	<TR>
		<TD width=63  > <FONT size = 1 FACE=ARIAL COLOR=black><b>MTS</b></FONT> </TD>
		<TD width=63 > <FONT size = 1 FACE=ARIAL COLOR=black><b>KGS</b></FONT> </TD>
		<TD width=63 > <FONT size = 1 FACE=ARIAL COLOR=black><b>MTS</b></FONT> </TD>
		<TD width=63  > <FONT size = 1 FACE=ARIAL COLOR=black><b>KGS</b></FONT> </TD>
		<TD width=63 > <FONT size = 1 FACE=ARIAL COLOR=black><b>MTS</b></FONT> </TD>
		<TD width=63  > <FONT size = 1 FACE=ARIAL COLOR=black><b>KGS</b></FONT> </TD>
		
	</TR>
	
	
	<TR>
		<TD width=63  > <FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
		<TD width=63 > <FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
		<TD width=63 > <FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
		<TD width=63  > <FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
		<TD width=63 > <FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
		<TD width=63  > <FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
		<TD width=63  > <FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
	</TR>
	
	
	
</table>

<BR>

<table width="624" border="1" cellspacing="0" cellpadding="0" style="WIDTH: 624px; HEIGHT: 30px">
	<TR>
		<TD width=200  bgColor=#badcdc> <FONT size = 1 FACE=ARIAL COLOR=black><b>DENSIDAD DE TELA</b></FONT> </TD>
		<TD width=200  > <FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
		<TD width=200  bgColor=#badcdc> <FONT size = 1 FACE=ARIAL COLOR=black><b></b>TAPETA</FONT> </TD>
		<TD width=200  > <FONT size = 1 FACE=ARIAL COLOR=black><b>&nbsp;</b></FONT> </TD>
				
	</TR>

</table></FONT>

</td></tr>
</table>


<script>

//window_onfocus()
				//window.name='BASE';

function MAS(opc, dat, ch)
{	var op = opc.substr(5)
	var celpa = "FILA8"+ (parseInt(op)+1)
	t = document.all.OBSERVA
	if (parseInt(op)>=0 && parseInt(op)< t.rows.length-5   )
	{	eval(celpa+".style.display = 'block'");
	}
	else
	{	alert("Si desea más líneas, primero grabe la ficha")
	}
}
function CALCULA()
{ aTot = Array('A','B','C','D','E','F','G','H','I','J','K','L','M')	
// sumas HORIZONTAL
for (mm=0; mm<=12; mm++)
{	total = 0
	for (k=3; k<=12; k++)
	{	dato = eval("thisForm.cel"+aTot[mm]+k+".value")
		if (trim(dato) != '')
		{	total += parseInt(dato,10)
			eval("thisForm.TOT"+aTot[mm]+".value=total")
		}
	}
}

// SUMAS VERTICALES
mm=0
k=0
gt = 0
for (k=3; k<=12; k++)
// COLUMNAS 10 COLUMNAS + TOTAL
{	total = 0
	IND = (parseInt(k,10)-3)
	for (mm=0; mm<13; mm++)
	// FILAS 13 FILAS = TOTALFILA
	{	col = mm + 3
		dato = eval("thisForm.cel"+aTot[mm]+k+".value")
		if (isNaN(parseInt(dato,10)) != true)
		{	total += parseInt(dato,10)
			eval("thisForm.TT"+IND+".value=total")
		}
	}
	gt+= total
}
thisForm.CANTIDAD.value = gt;
// número de colores
thisForm.NUMCOL.value= 0	
for (cc=0; cc<13; cc++)
{ cad = eval("thisForm.cel"+aTot[cc]+"0.value")
	if (cad.length != 0)
	{	thisForm.NUMCOL.value++
	}
}
// GRAN TOTAL
eval("thisForm.TT10.value=gt")
}
function NUMERO(i,k)
{	total = 0
	dato = ''
	for (m=3; m<12; m++)
	{	dato = trim(eval("thisForm.cel"+i+m+".value"))
		color = trim(eval("thisForm.cel"+i+"0.value"))
		if (color == '')
		{	alert("SOLO se aceptan cantidades en filas con COLOR")
			nume = ''
			eval("thisForm.cel"+i+k+".value=nume")
			eval("thisForm.cel"+i+k+".focus()")
			return false;
		}
		if (dato != '')
		{	if (isNaN(dato))
			{	alert("SOLO se aceptan Números")
				//largo = dato.length -1
				nume = ''
				eval("thisForm.cel"+i+m+".value=nume")
				eval("thisForm.cel"+i+m+".focus()")
				return false;
			}
			total += parseInt(dato,10)
		}
	}
	eval("thisForm.TOT"+i+".value=total")
	col = parseInt(k,10)
	col = col - 3
	cad = eval("thisForm.TAL"+col+".value")
	if (trim(cad) == '')
	{ alert("NO puede colocar una cantidad en una\ncolumna sin código de talla")
		return true;
	}
}


function VALIDA()
{	if (trim(thisForm.PO.value) == '')
	{	alert("favor informar el Número de la PO del PEDIDO")
		thisForm.PO.focus();
		return false;
	}

	if (trim(thisForm.CODCLI.value) == '' )
	{	alert("¿A qué PEDIDO nos estamos refiriendo?")
		thisForm.cli.focus();
		return false;
	}
	if (trim(thisForm.PROTO.value) == '')
	{	alert("Favor seleccionar un PROTO de base")
		HELP('help/hlpPROTOS.asp?cli=',thisForm.cli.value); 
		return false;
	}
	if (trim(thisForm.ID.value) == '')
	{	alert("Favor seleccionar un DESTINO para esta PO ")
		HELP('help/hlpDESTINO.asp?cli=',thisForm.CODCLI.value)
		return false;
	}
	
	dia =parseFloat(thisForm.FECEMB.day)
	if (parseFloat(dia) < 10 )	
		dia = '0'+ trim(dia.toString())
	mes = 	thisForm.FECEMB.month
	if (parseInt(mes,10)< 10)
		mes = '0'+ trim(mes.toString())
		
	fecha = dia + '/'+ mes+ '/' + trim(thisForm.FECEMB.year)

	if (trim(fecha)== '') 
	{	alert("Favor INFORMAR la fecha de embarque")
		thisForm.FECEMB.focus();
		return false;
	}
	FEC = fecha
		d = '<%=now()%>';
	if (FEC== false)
		{	thisForm.FECEMB.focus();
			return false;
		}
	if (FEC == true && fecha < d)	
	{	alert("La fecha de embarque NO puede ser menor a la fecha actual")
		thisForm.FECEMB.focus();
		return false;
	}
	if (thisForm.TIPOEMB.selectedIndex == 0)
		{	alert("¿Cómo va a ser el tipo de embarque?")
			thisForm.TIPOEMB.focus();
			return false;
		}
	if (trim(thisForm.TIPRAT.value) == '')
	{	alert("Favor informar la estructura de tallas");
		HELP('help/hlpTALLAS.asp?tem=', thisForm.TALLAS.value)
		return false;
	}
	if (trim(thisForm.REFERENCIA.value) != '')
	{	cad = ltrim(toAlpha(thisForm.REFERENCIA.value))
		thisForm.REFERENCIA.value = cad
	}
	CALCULA();
	if (thisForm.NUMCOL.value == 0)
	{	alert("No ha informado los COLORES de la PO en la matriz")
		return false;
	}
	if (thisForm.CANTIDAD.value == 0)
	{	alert("No ha informado la cantidad de prendas de la PO en la matriz")
		return false;
	}
	 aTot  = Array('A','B','C','D','E','F','G','H','I','J','K','L','M')	
	// verifica que los colores tengan cantidad PEDIDA
	for (mm=0; mm<=12; mm++)
	{	total = 0
		color = eval("thisForm.cel"+aTot[mm]+"1.value")
		// armar array para guardar colores VALIDOS	
		for (k=3; k<=12; k++)
		{	if (trim(color) != '')
			{	dato = eval("thisForm.cel"+aTot[mm]+k+".value")
				if (trim(dato) != '')
					total ++;
			}
		}
		if (total == 0 && trim(color) != '')
		{	alert("El color : " + color + "No tiene NINGUNA prenda requerida")
			eval("thisForm.cel"+aTot[mm]+"3.focus()")
			return false;
		}
	}
	
	
	thisForm.EMBARQUE.value =  fecha
	//window.open(prueba.asp)
	return true;
}

function chec(i)
{	eval("thisForm.ADIC8"+i+".value=''")
  	eval("thisForm.CHK8"+i+".checked='false'")
  	if (eval("thisForm.CHK8"+i+".value")=='') 
  	{// es nuevo y nooooooooo se graba
  		eval("thisForm.CHK8"+i+".value='0")
  	// en caso contrario tendrá el valor de "ID" de la tbl	
  	}
}
</script>

<%
set rs= nothing
set cnn=nothing
%>
</FONT></form>




</BODY>
</html>
