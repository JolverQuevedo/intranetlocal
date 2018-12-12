<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">
var aTallas = Array()
var pasacolor = ""

function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight+25;

  //change the height of the iframe
  document.getElementById('body0').height=
      the_height;
}
</script>
<%	COD = Request.QueryString("pos")
    rea = Request.QueryString("REA")
    SUN = Request.QueryString("SUN")
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CURSORLOCATION   = 3
	RS2.CursorType       = 3 
	RS2.LockType         = 1 
	
	CAD =	" SELECT T1.CODIGO, T1.DESCRIPCION, T2.CODCOL,          " & _
            " T3.DESCRIPCION AS DESCOL,T2.CODTALLA,                 " & _
            " T4.TALLA AS DESTAL, T1.TIPEXPLO AS NIVEL,       " & _
            " T5.DESCRIPCION AS DESNIV                              " & _
            " FROM AVIOS AS T1                                      " & _
            " INNER JOIN AVIOSDETA AS T2 ON T1.CODIGO = T2.AVIO     " & _
            " INNER JOIN CODCOL AS T3 ON T2.CODCOL = T3.CODIGO      " & _
            " INNER JOIN TALLAS AS T4 ON T2.CODTALLA = T4.TALLA  " & _
            " INNER JOIN TIPEXPLO AS T5 ON T1.TIPEXPLO = T5.CODIGO  " & _
            " WHERE T1.CODIGO =  '"&COD&"'                          " & _
            " ORDER BY T1.CODIGO                                    "
	'response.Write(cad)
	rs.open cad , cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
		marka = 1
		titulo = trim(rs("codigo"))+ " -> " + trim(rs("descripcion"))
	else
		marka = 0	
		titulo = "NUEVO"
	END IF%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=titulo%></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body>
<form id="thisForm" method="post" name="thisForm" action="comun/inserAVIODETA.asp">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
		  <td width="10%"><img src="imagenes/CERRAR.gif" style="cursor:hand;" onClick="window.close()" /></td>		
          <td align = "center" class="TALASBLUE" width="80%">
            <table cellpadding="22" cellspacing="0" border="1" bgcolor="#f7d975" align="center" width="100%" bordercolorlight="#f7d975">
		        <tr><td align="center" class="talasblue"><%=titulo%></td></tr>
		    </table> 
         </td>
	     <td  width="10%" align="center"><img src="imagenes/logo.gif" border="0"  alt="" id="GRABA"  />
	     <input id="COD" name="COD" value="<%=rs("CODIGO") %>" style="display:none;"/></td>
    </tr>
</table>  
<center><span class="talasrojo">Avio de tipo : <%=rs("desniv")%></span></center>

<%if(trim(rs("nivel"))="G") then response.End
XX=1
SS=1%>
<iframe  width="100%" onLoad="calcHeight();" src="'AVIOSDETA.ASP?POS='+thisForm.COD.value" id="body0" name="body0"  scrolling="yes" frameborder="0" height="1" align="middle"></iframe>


<table width="100%" border="1" bordercolordark="DarkOrange" cellpadding="2" cellspacing="1" bordercolorlight="DarkOrange">   
	<tr valign="middle">
		<td bgcolor="#f7d975" class="TALASBLUE" width="50%" <%if inStr(trim(rs("NIVEL")),"C")= 0 then %> style="display:none"<%end if %>>COLORES</td >     
        <td bgcolor="#f7d975" class="TALASBLUE" width="50%" <%if inStr(trim(rs("NIVEL")),"T")= 0 then %> style="display:none"<%end if %>>TALLAS</td >	
	</tr>
    <tr valign="top">
    	<td width="50%"  <%if inStr(trim(rs("NIVEL")),"C")= 0 then %> style="display:none"<%end if %> >
		    <table width="100%">
		    	<%con=0
		    	cont3=0
				cad =   " select * from CODCOL AS t1 where estado ='a'  " & _
				        " AND T1.CODIGO > '0000' AND T1.CODIGO          " & _
                        " NOT IN (SELECT CODCOL FROM AVIOSDETA AS T2    " & _
                        " WHERE T2.AVIO = '"&COD&"' AND T2.ESTADO='A')  " & _
                        " order by descripcion                          " 
				rs2.open cad,cnn
				if rs2.recordcount > 0 then
					rs2.movefirst%>
		            <%DO WHILE NOT RS2.EOF%>
					    <tr bgcolor="<% if cont3 mod 2  = 0 THEN 
							response.write(Application("color1"))
            			    else
							response.write(Application("BARRA"))
							end IF%>" >       
								<td class="AMERICANnavy" width="45%"><%=trim(rs2("descripcion"))%></td>
								<td width="5%"><input type="checkbox" value="<%=trim(rs2("CODIGO"))%>" id="C<%=Trim(Cstr(con))%>"></td>
                                <%RS2.MOVENEXT%>
                                <%con=con+1 %> 
                           <%if not rs2.eof then%>     
	                           	<td class="AMERICANnavy" width="45%"><%=trim(rs2("descripcion"))%></td>
								<td width="5%"><input type="checkbox" value="<%=trim(rs2("CODIGO"))%>" id="C<%=Trim(Cstr(con))%>"></td>
								<%conT3=conT3+1 %>
                            <%else%>    
                            	<td class="AMERICANnavy" width="45%">&nbsp;</td>
								<td width="5%">&nbsp;</td>
								<%EXIT DO %>
                           <%end if%>     
						</tr>
                        <%RS2.MOVENEXT%>
                         <%con=con+1 %> 
					<%loop%> 
					<%conT3=conT3+1 %> 
                    <tr <% if cont3 mod 2  = 0 THEN %> bgcolor='<%=(Application("color1"))%>'
            			        <%else%>
							        bgcolor='<%=(Application("barra"))%>'
							    <%end IF%> >       
                        <td class="AMERICANnavy" width="95%" colspan="3">SELECCIONAR TODO</td>
					    <td width="5%"><input type="checkbox" value="<%=con%>" id="Color" onClick="TODO('<%=con %>')"></td>        
                    </tr>            
 				<%else 
 				XX = 0%>	   
       	<%end if%>
            </table>    
        </td>
        <td width="50%" <%if inStr(trim(rs("NIVEL")),"T")= 0 then %> style="display:none"<%end if %> >
        	<table width="100%">
		    	<%rs2.close
				cont3=0
				con=0
				cad =   " select * from TALLAS AS t1 where estado ='a'" & _ 
				        " AND T1.TALLA > '00000' AND T1.TALLA         " & _
				        " NOT IN (SELECT CODTALLA FROM AVIOSDETA AS T2  " & _
                        " WHERE T2.AVIO = '"&COD&"' AND T2.ESTADO='A')  " & _
				        " order by talla                          "                         
				rs2.open cad,cnn
				if rs2.recordcount > 0 then
					rs2.movefirst%>
		            <%DO WHILE NOT RS2.EOF%>
					    <tr  bgcolor="<% if CONT3 mod 2  = 0 THEN 
							response.write(Application("color1"))
            			    else
							response.write(Application("BARRA"))
							end IF%>" >       
								<td class="AMERICANnavy" width="45%"><%=trim(rs2("talla"))%></td>
								<td width="5%"><input type="checkbox" value="<%=trim(rs2("talla"))%>" id="T<%=Trim(Cstr(con))%>"></td>
                                <%RS2.MOVENEXT%>
                                <%con=con+1 %>
                           <%if not rs2.eof then%>     
	                           	<td class="AMERICANnavy" width="45%"><%=trim(rs2("talla"))%></td>
								<td width="5%"><input type="checkbox" value="<%=trim(rs2("talla"))%>" id="T<%=Trim(Cstr(con))%>"></td>
								  <%conT3=conT3+1 %>
                            <%else%>    
                            	<td class="AMERICANnavy" width="45%">&nbsp;</td>
								<td width="5%">&nbsp;</td>
								<%EXIT DO %>
                           <%end if%>     
                         
						</tr>
                        <%RS2.MOVENEXT%>
                        <%con=con+1%>
					<%loop%>     
					<%conT3=conT3+1 %>
        		
                <tr <% if CONT3 mod 2  = 0 THEN %> bgcolor='<%=(Application("color1"))%>'
            			    <%else%>
							    bgcolor='<%=(Application("barra"))%>'
							<%end IF%> >       
                    <td class="AMERICANnavy" width="95%" colspan="3">SELECCIONAR TODO</td>
					<td width="5%"><input type="checkbox" value="<%=con%>" id="Talla" onClick="TODO2('<%=con%>')"></td>        
                </tr>            
   				<%else
   				    SS=0%>	
                <%end if%>
            </table>    
        </td>
    </tr>
</table>
<center><%if xx=1 OR SS=1 then %>
<input type="button" value="ACTUALIZAR" onClick="FILTRO()" 
onmouseover="style.backgroundColor='darkOrange'" onMouseOut="style.backgroundColor='<%=Application("color1") %>'"></center>
<%end if %>



<script type="text/jscript" language="jscript">
function TODO(OP)
{	tope = parseInt(OP,10)
	data = thisForm.Color.checked
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
function TODO2(OP)
{	tope = parseInt(OP,10)
	data = thisForm.Talla.checked
	if(data == true)
	{  	for(r=0;r<tope; r++)
        {   eval("thisForm.T"+r+".checked=true")
        }
    }
    else
    {    for(r=0;r<tope; r++)
        {   eval("thisForm.T"+r+".checked=false")
        }
    }    
}
function FILTRO()
{   var nivel
    var col = new Array()
    var tal = new Array()
    talla = ''
    cad = ''
    marker=0
    nivel = parseInt('<%=trim(inStr(trim(rs("NIVEL")),"C"))%>',10)
    if((thisForm.Color) != undefined)
       marker = parseInt(thisForm.Color.value,10)
     
    if (nivel > 0 &&  marker > 0 )  
    {   vv = thisForm.Color.value
        vv = parseInt(vv,10)
        // COLORES DE AVIOS
        con = 0
        for(f=0;f<vv; f++)
        {   if (eval("thisForm.C"+f+".checked")==true)
              col[con++] =eval("thisForm.C"+f+".value")
        } 
   
        for (i=0;i<con;i++)
            cad += col[i]+ ','
        cad =  Left(cad, cad.length-1) 
    }
    nivel2 = parseInt('<%=trim(inStr(trim(rs("NIVEL")),"T"))%>',10)
    if (thisForm.Talla != undefined)
        marker = parseInt(thisForm.Talla.value,10)
    if (nivel2 > 0 && marker >0 )
    {   ss = thisForm.Talla.value
        ss = parseInt(ss,10)
        // TALLAS DE AVIO
        cont = 0
        for(fq=0;fq<ss; fq++)
        {   if (eval("thisForm.T"+fq+".checked")==true)
              tal[cont++] =eval("thisForm.T"+fq+".value")
        } 
/*        if(cont==0)
         {  alert("No se ha seleccionado ninguna TALLA")
            return false;
         }
*/         
        for (i=0;i<cont;i++)
            talla += tal[i]+ ','
        talla =  Left(talla, talla.length-1)  
    }   
    
    KAD  = 'comun/inserdetaavio.asp?cod='+thisForm.COD.value
    KAD += '&tal=' + talla
    KAD += '&col=' + cad
    KAD += '&REA=' + '<%=REA%>'
    KAD += '&SUN=' + '<%=SUN%>' 
//alert(KAD)
    
document.all.body0.src= KAD  
}

document.all.body0.src='AVIOSDETA.ASP?POS='+thisForm.COD.value
function CERRAR()
{	window.close()
}

</script>
	<%	RS.Close 
	SET RS  = NOTHING
	Cnn.Close
	SET Cnn = NOTHING %>
</form>
</body>
</html>