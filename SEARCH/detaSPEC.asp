<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>


<script type="text/jscript" language="jscript">
    var chk = ''
    var marca = 0
    var oldrow = 1
    var url = '../detaproto.asp?'
    var alias = 'VIEW_Protos'
    var TBL = 'PrOtoS'
    var PK = 'proto'
    var DS = 'version'
    var largo = 10  // es el largo del PK (se usa en el dataentry)
    var largo2 = 3  // es el largo del descriptor
    var pagesize = 10
    var oldrow = 1
    var olddata = ''
    var chk = ''
    var ficha = 'fichaproto.asp?po='
    mm = -1

var oldrow=1
</script>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="COMUN/COMUNprotodeta.asp"-->


<%Dim pageSize 
if txtPerfil > 1 then 	pageSize = 16 else 	pageSize = 6
' Captura la posición inicial del browse
POS = Request.QueryString("pos")
if pos = "" or isnull(pos)  or pos = " " then
	pos = ""
end if
pro = Request.QueryString("pro")
if pro = "" or isnull(pro)  or pro = " " then
	pro = ""
end if
ver = Request.QueryString("ver")
if ver = "" or isnull(ver)  or ver = " " then
	ver = ""
end if
TEM = Request.QueryString("TEM")
if TEM = "" or isnull(TEM)  or TEM = " " then
	TEM = ""
end if

EST = Request.QueryString("EST")
if EST = "" or isnull(EST)  or EST = " " then
	EST = ""
end if

'****************************************************
' Texto del Comando (SELECT) a ejecutar (POR DEFAULT)
'****************************************************
dato = pro&ver

CAD =	" SELECT top 16 PRO, VER, NOM, ECL, DES,        " & _
        " DGEN, MOT AS GPO_TEL, TEL, DTEL, DTEM, ADIC, TPRE, " & _
        " CLI, EST, TEM, ART, TIP, GEN                  " & _
        " FROM VIEW_PROTOS AS T1                        " & _
		" WHERE T1.EDO = 'A' and                        " & _
        " CLI  = '"&POS&"' and                          "
IF   LEN(DATO) > 0  THEN
    cad = cad + " pro+ver >= '"&dato&"'	ORDER BY PRO, VER      " 
ELSEIF LEN(TEM) > 0  THEN
    cad = cad + " DTEM >= '"&TEM&"'	 ORDER BY DTEM, PRO, VER     " 
ELSEIF LEN(EST)> 0 THEN
    cad = cad + " ECL >= '"&EST&"'	ORDER BY ECL, PRO, VER      " 
ELSE
    cad = cad + " pro+ver >= '"&dato&"'	ORDER BY PRO, VER      " 
END IF
  
'	response.Write(cad)
' abre recordset	
	RS.Open CAD, Cnn
' contador de lineas
	CONT = 1
IF RS.RECORDCOUNT > 0 THEN 
	RS.MOVEFIRST%>
<%else%>
    <script type="text/jscript">
	    marca = 1	
    </script>
<%END IF%>
<script type="text/jscript">
mm= '<%=rs.recordcount%>'
</script>
<%' Nro de columnas regresadas por el objeto RECORDSET	
columnas = rs.Fields.Count
' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<head>
<title><%=tabla%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<html xmlns="http://www.w3.org/1999/xhtml">
<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<html>
<head>
<title></title>
<meta name="GENERATOR" Content="Microsoft Visual Studio 6.0">
</head>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >
<form name="thisForm" method="post" action="DETAPROTO.asp">
<%'*********************************************************************%>
<table id="TABLA" align="CENTER" cols="2" width="100%"
	 cellpadding="2"  cellspacing="1" bordercolor="White"
	  bgcolor="lightgrey" border="1" >
<%'**************************%>
<%'LINEA DE CABECERA STANDAR %>
<%'**************************%>
<tr bgcolor="#0087d1" valign="top">
    <%for I=0 to columnas-7 %>
	    <td align="center">
		    <font face="arial" color="IVORY" size="1">
		    <b><%=RS.FIELDS(I).NAME%></b>
		    </font>
	    </td>
    <%next%>
	  <%for I=columnas-6 to columnas-1 %>
	    <td align="center" style="display:none">
		    <font face="arial" color="IVORY" size="1">
		    <b><%=RS.FIELDS(I).NAME%></b>
		    </font>
	    </td>
    <%next%>
</tr>
<%'*****************************%>
<%' MUESTRA EL GRID (2 COLORES) %>
<%'*****************************%>
<%IF NOT RS.EOF THEN%>
<%RS.MOVEFIRST%>
<%DO WHILE NOT RS.EOF %>
	<tr <% IF CONT mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			onclick="dd('<%=(cont)%>')" id="fila<%=Trim(Cstr(cont))%>" valign="top" ondblclick="EDITA('<%=cont%>')">
	    <%FOR i=0 TO columnas-7%>
		    <td class="texto"><%=TRIM(RS.FIELDS.ITEM(I))%></td>
	    <%NEXT%>
	    <%FOR i=COLUMNAS-6 TO columnas-1%>
		    <td class="texto" style="display:none"><%=TRIM(RS.FIELDS.ITEM(I))%></td>
	    <%NEXT%>
    </tr>
	<%RS.MOVENEXT%>
	<%CONT = CONT + 1%>
<%LOOP%>
</table>
<table border="0" align="center"  cellspacing="5">
	<tr valign="top">
		<td><img src="imagenes/primera.gif" style="cursor:pointer;" onClick="primera('<%=pos%>')" alt="PRIMERA PAGINA" /></td>
		<td><img src="IMAGENES/PREV.GIF" alt="PAGINA ANTERIOR"	onclick="atras('<%=pos%>')" style="cursor:pointer" /></td>
		<td><img src= "imagenes/arriba.gif" alt="REGISTRO ANTERIOR" onClick="retrocede('<%=pos%>')" style="cursor:pointer" /></td>
		<td><img src="imagenes/abajo.gif" alt="REGISTRO SIGUIENTE" onClick="avanza()"  style="cursor:pointer" /></td>
		<td><img src="imagenes/next.gif" alt="PAGINA SIGUIENTE" onClick="pagina('<%=pos%>')" style="cursor:pointer" /></td>

		<td><img src= "imagenes/ultima.gif" alt="ULTIMA PAGINA" onClick="ultima('<%=pos%>')" style="cursor:pointer;" /></td>
        
    <td><img src="imagenes/SEARCH.gif" onClick="document.all.seeker.style.display='block'" alt="BUSCAR" style="cursor:pointer;" /></td>
	<td id="seeker" name="seeker" style="display:none">
	<table align="center"  width="100%" bordercolor="#FFFFFF"
	  bgcolor="lightgrey"  cellpadding="0"  cellspacing="1"  border="1" >
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Proto-ver</b></font></td>
		<td><input id="kd" name="kd" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Estilo</b></font></td>
		<td><input id="st" name="st" value="" /> </td>    
	  </tr>
      <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>'><font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b>Temporada</b></font></td>
		<td><input id="tm" name="tm" value="" /> </td>    
	  </tr>
	  <tr>  
	    <td  bgcolor='<%=Application("COLOR2")%>' align="center" style="cursor:pointer" onClick="document.all.seeker.style.display='none'">
	        <font face="arial" color="red" size="1">
		    <b><u>(X) Cerrar</u></b></font></td>
		<td  bgcolor='<%=Application("COLOR2")%>' align="CENTER" style="cursor:pointer" onClick="return BUSQUE()">
		<font face="arial" color='<%=Application("Titulo")%>' size="1">
		    <b><U>FILTRAR</U></b></font></td>
	  </tr>
	 </table> 
	</td>	
	</tr>
	</table>
<%end if%>

<iframe  width="100%" src="" id="body0" name="body0" scrolling="yes" frameborder="1" height="400" align="middle" style="display:none" ></iframe>

<table border="0" align="center"  cellspacing="3">
    <tr>
        <td><img  id="Img1"  alt="REGISTRO EN BLANCO" onClick="NUEVO()" style="cursor:pointer;" src="imagenes/NEW.gif" /></td>
        <td><img src="imagenes/DELETE.gif" alt="ELIMIAR REGISTRO" onClick="elimina()" style="cursor:pointer;" /></td>		
         <td><img src="imagenes/ruta.jpg" alt="IMPRIMIR CONSUMO" onClick="IMPRIME()" style="cursor:pointer;" /></td>		
    </tr>
</table>

 
<%rs.close%>

<script type="text/jscript" language="jscript">

function BUSQUE() {

    if (trim(document.all.thisForm.kd.value) == '' && trim(document.all.thisForm.st.value) == '' && trim(document.all.thisForm.tm.value) == '') {
        alert("Debe informar algun dato");
        window.thisForm.kd.focus();
    }
    pr = trim(document.all.thisForm.kd.value)
    ppo = ''
    vee=''
    if (pr.length < 14 && pr.length > 0 ) {
        po = pr.indexOf('-')
        if (po <= 0) {
            alert("Informar Proto-Versión por favor")
            document.all.thisForm.kd.focus()
            return true
        }
        ppo = Left(pr,po)
        ppo =strzero(ppo,10)
        vee = invertircadena(pr)
        vee = strzero(Left(vee, vee.indexOf('-')), 3)
        document.all.thisForm.kd.value = ppo+'-'+vee
    }
    
    cad  = 'detaproto.asp?pos=' + '<%=trim(pos) %>'
    cad += '&pro=' + ppo;
    cad += '&ver=' + vee;
    cad += '&tem=' + ltrim(document.all.thisForm.tm.value)
    cad += '&est=' + ltrim(document.all.thisForm.st.value)
   // alert(cad)
         window.location.replace(cad);
       
        return true
}




if (marca == 0)
	dd('1');				
function NUEVO()
{   OBS = ''
    window.open('fichaproto.asp?PRO=AUTO&cli='+'<%=pos%>'+'&ver=')
  return true;
}
function LLENA(ff)
{return true;  
}
function EDITA(ff)
{ var t = document.all.TABLA;
    var pos = parseInt(ff,10)
    PRO = ltrim(t.rows(pos).cells(0).innerText);
	VER = ltrim(t.rows(pos).cells(1).innerText) ;
	DES = ltrim(t.rows(pos).cells(2).innerText) ;
	OBS = ltrim(t.rows(pos).cells(4).innerText) ;
	EST = ltrim(t.rows(pos).cells(11).innerText) ;
	GEN =  trim(t.rows(pos).cells(15).innerText) ;
    TIP =  trim(t.rows(pos).cells(14).innerText) ;
	CON =  trim(t.rows(pos).cells(8).innerText) ;
	TEM =  trim(t.rows(pos).cells(12).innerText) ;
    TEL =  trim(t.rows(pos).cells(6).innerText) ;


	datos  = '&PRO='+PRO+'&VER='+VER+'&DES='+DES
	datos += '&EST='+EST+'&TEL='+TEL
	datos += '&TEM='+TEM
	window.open('fichaproto.asp?cli='+'<%=pos%>'+ datos)
    return true;
}

function IMPRIME() {
    var t = document.all.TABLA;
    var pos = parseInt(oldrow, 10)
    PRO = trim(t.rows(pos).cells(0).innerText);
    VER = trim(t.rows(pos).cells(1).innerText);
    CAD = 'REPORTES/PRNCONSUMO.ASP?PRO=' + PRO + '&VER=' + VER
    
    //alert(CAD)
    window.open(CAD);
    return true;
}

function elimina()
{	var t = document.all.TABLA;
    var pos = parseInt(oldrow,10)
    var si
	{si = confirm("¿ Confirma la Eliminación de este Registro ? ");} 
	if (si == false)
	{ return false;}
	PRO = trim(t.rows(pos).cells(0).innerText);
	VER = trim(t.rows(pos).cells(1).innerText);
	CAD = 'COMUN/DELEtbl2.ASP?cod=' + PRO
	CAD += '&pk1=PROTO&PK2=VERSION&tbl=protos'
	CAD += '&des=' + VER
	CAD += '&URL=../DETAPROTO.ASP?POS=' + '<%=Request.QueryString("pos")%>'
    //alert(CAD)
	window.location.replace(CAD); 
	return true;
}


//pagina de inicio
pag = 'detaproto.asp?cli=' + '<%=trim(request.QueryString("pos"))%>'
</script>    
<%IF txtPerfil = 1 THEN%>
<SCRIPT> 
if (marca == 1)
	NUEVO()
</SCRIPT>
<%END IF%>

<%SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING  %>
</form>
</body>
</html>
