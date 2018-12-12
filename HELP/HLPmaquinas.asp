<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = Request.Cookies("Usuario")("Perfil") 
	pos = Request.QueryString("pos")%>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<script type="text/jscript" language="jscript">
function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight;

  //change the height of the iframe
  document.getElementById('body0').height=
      the_height;
}
function ACTUALIZA(cod,cad,TIT)
{	return true
/*	eval("window.opener.window.thisForm.M"+pos+".value = trim(cod)");
	eval("window.opener.window.document.all.D"+pos+".classname='textominibb'");
	eval("window.opener.window.document.all.D"+pos+".innerHTML = cad");
	eval("window.opener.window.document.all.T"+pos+".innerHTML = TIT");
	window.close();
	*/
}

function REDIR(ff)
{	return true
	/*var t = document.all.TABLA;
	var pos = parseInt(ff,10) ;
	var cad = t.rows(pos).cells(0).innerText;
	var a = trim(cad);
	var kad = t.rows(pos).cells(1).innerText;
	var TIT = t.rows(pos).cells(2).innerText;
	kad = ltrim(kad);
	ACTUALIZA(a,kad, TIT);
	*/
}

</script>

<% ' Modelo de objetos de secuencia de comandos de VI 6.0 habilitado %>
<link href="../estilos1.CSS" rel="stylesheet" type="text/css" />
<head>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">

</head>
<html>
<body topmargin="0" leftmargin="10" rightmargin="10" border="0" text="#000000" >

<table width="100%">
	<tr>
		<td align= "left" width="25%">
			<img src="../imagenes/CERRAR.gif" style="cursor:hand;" onClick="javascript: window.close();">
		</td>
		<td align="center"><font face="arial" size="2" color="#000066"><b>MAQUINAS DE TEJEDURÍA</b></font></td>
        <td align= "right" width="25%">
			<img src="../imagenes/LOGO.gif">
		</td>
        </tr>
	</tr>
	<tr>
	<td colspan="3">
			<HR>
		</td>
	</tr>
</table>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->
<form name="thisForm" id="thisForm" METHOD="post" >
<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="2" cellspacing="1" bordercolorlight="DarkOrange">   
	<tr valign="middle">
		<td bgcolor="#f7d975" class="TALASBLUE" width="40%">MODELO</td >     
        <td bgcolor="#f7d975" class="TALASBLUE" width="60%" >MARCA</td >	
	</tr >
    <tr valign="top">
    	<td width="20%">
        	<table width="100%">
		    	<%cad = "select * from modmaq where estado ='a' order by descripcion" 
				cont1 =0
				rs.open cad,cnn
				if rs.recordcount > 0 then
					rs.movefirst%>
		            <%DO WHILE NOT RS.EOF%>
					    <tr  bgcolor="<% if CONT1 mod 2  = 0 THEN 
							response.write(Application("color1"))
            			    else
							response.write(Application("BARRA"))
							end IF%>">       
								<td class="DESCRIPTORnavy" width="95%"><%=trim(rs("descripcion"))%></td>
								<td width="5%"><input type="radio" value="<%=trim(rs("CODIGO"))%>" name="MOD" id="MOD"></td>
						</tr>
                        <%RS.MOVENEXT%>
						<%CONT1 = CONT1 + 1%>
					<%loop%>     
        		<%end if%>
	                <tr><td bgcolor="#f7d975" class="TALASBLUE" colspan="2" >TIPO</td>
                </tr>
                <tr>
                <td colspan="2">
                <table width="100%">
		    	<%rs.close
				cont2 =0
				cad = "select * from tipmaq where estado ='a' order by descripcion" 
				rs.open cad,cnn
				if rs.recordcount > 0 then
					rs.movefirst%>
		            <%DO WHILE NOT RS.EOF%>
					    <tr  bgcolor="<% if CONT2 mod 2  = 0 THEN 
							response.write(Application("color1"))
            			    else
							response.write(Application("BARRA"))
							end IF%>">       
								<td class="DESCRIPTORnavy" width="95%"><%=trim(rs("descripcion"))%></td>
								<td width="5%"><input type="radio" value="<%=trim(rs("CODIGO"))%>" id="TIP" name="TIP"></td>
						</tr>
                        <%RS.MOVENEXT%>
						<%CONT2 = CONT2 + 1%>
					<%loop%>     
        		<%end if%>
                    </table>     
                </td>
                </tr>
            </table>    
        </td>
        <td width="80%">
        	<table width="100%">
		    	<%rs.close
				cont3=0
				con = 0
				cad = "select * from marcatej where estado ='a' order by descripcion" 
				rs.open cad,cnn
				if rs.recordcount > 0 then
					rs.movefirst%>
		            <%DO WHILE NOT RS.EOF%>
					    <tr  bgcolor="<% if CONT3 mod 2  = 0 THEN 
							response.write(Application("color1"))
            			    else
							response.write(Application("BARRA"))
							end IF%>" >       
								<td class="DESCRIPTORnavy" width="45%"><%=trim(rs("descripcion"))%></td>
								<td width="5%"><input type="checkbox" value="<%=trim(rs("CODIGO"))%>" id="C<%=Trim(Cstr(con))%>"></td>
                                <%RS.MOVENEXT%>
                                <%con=con+1 %>
                                 <%if rs.eof then exit do %>
                           <%if not rs.eof then%>     
	                           	<td class="DESCRIPTORnavy" width="45%"><%=trim(rs("descripcion"))%></td>
								<td width="5%"><input type="checkbox" value="<%=trim(rs("CODIGO"))%>" id="C<%=Trim(Cstr(con))%>"></td>
                            <%else%>    
                            	<td class="DESCRIPTORnavy" width="45%">&nbsp;</td>
								<td width="5%">&nbsp;</td>
                           <%end if%>     
						</tr>
                        <%RS.MOVENEXT%>
                        <%con=con+1 %>
						<%CONT3 = CONT3 + 1%>
                        <%if rs.eof then exit do %>
					<%loop%>     
        		<%end if%>
                <tr <% if CONT3 mod 2  = 0 THEN %> bgcolor='<%=(Application("color1"))%>'
            			    <%else%>
							    bgcolor='<%=(Application("barra"))%>'
							<%end IF%> >       
                    <td class="DESCRIPTORnavy" width="95%" colspan="3">SELECCIONAR TODO</td>
					<td width="5%"><input type="checkbox" value="0000" id="C<%=Trim(Cstr(con))%>" onClick="TODO()"></td>        
                </tr>            
            </table>    
        </td>
    </tr>
</table>
<center><input type="button" value="FILTRAR" onClick="FILTRO()" 
onmouseover="style.backgroundColor='darkOrange'" onMouseOut="style.backgroundColor='<%=Application("color1") %>'"></center>
<iframe  width="100%" onLoad="calcHeight();" src="" id="body0" name="body0"  scrolling="yes" frameborder="0" height="1" align="middle"></iframe>




<script type="text/jscript" language="jscript">
function TODO()
{	tope = '<%=con%>'
	tope = parseInt(tope,10)
	data = eval("thisForm.C"+tope+".checked")
	if(data == true)
	{  	for(r=0;r<tope; r++)
        {   eval("thisForm.C"+r+".checked=true")
        }
    }
    else
    {    for(r=0;r<tope; r++)
        {   eval("thisForm.C"+r+".checked=false")
        }
    }    
}
function FILTRO()
{    mass = '<%=cont1 %>'
    mass = parseInt(mass,10)
    // modelo de máquina
    mode=''
    for(W=0;W<mass; W++)
    {   if (thisForm.MOD(W).checked==true)
        {   mode =(thisForm.MOD(W).value)
            break; 
        }
    } 
    if (W == mass)
    {   alert("No ha seleccionado ningún modelo de Máquina")
        return false;
    }
    mas = '<%=cont2 %>'
    mas = parseInt(mas,10)
    // tipo de máquina
    tip =''
    for(d=0;d<mas; d++)
    {   if (thisForm.TIP(d).checked==true)
        {   tip =(thisForm.TIP(d).value)
            break 
        }
    } 
    if (d==mas)
    {    alert("No ha seleccionado ningún Tipo de Máquina")
        return false;
    }
   
    vv = '<%=con %>'
    vv = parseInt(vv,10)
    // marca de máquina
    var mar = new Array()
    con = 0
    for(f=0;f<vv; f++)
    {   if (eval("thisForm.C"+f+".checked")==true)
          mar[con++] =eval("thisForm.C"+f+".value")
    } 
    cad = ''
    if(con==0)
     {  alert("No se ha seleccionado niunguna marca")
        return false;
     }
    for (i=0;i<con;i++)
        cad += mar[i]+ ','
    cad = Left(cad, cad.length-1)    
       
    KAD ='HLPdesmaq.asp?modE='+ mode + '&tip=' + tip + '&mar=' + cad    

//alert(KAD)
    
 document.all.body0.src= KAD  
}

</script>




<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
 
</form>
</body>
</html>
