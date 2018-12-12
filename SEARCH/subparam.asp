<%@Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="HITEPIMA.CSS" >
<html>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%menu =request.QueryString("MENU")
subm=request.QueryString("subM")
tbl = (Application("owner"))+"."+ "submenu"
cad =   " Select * from "&tbl&"         " & _
        " where menu = '"&menu&"' and   " & _
        " submenu = '"&subm&"'          "
rs.open cad,cnn
rs.movefirst
%>
<head>
<title>Parametros de : <%=rs("descripcion") %></title>
    
</head>
<body topmargin="0" leftmargin="0" rightmargin="0">
<table id="TABLA" align="CENTER"  width="100%" cellpadding="2"  cellspacing="1"
	  bordercolor="White" bgcolor="lightgrey" border="1">
    <%'**************************%>
    <%'LINEA DE CABECERA STANDAR %>
    <%'**************************%>
    <tr bgcolor="<%=application("head")%>" >
    <%for I=0 to rs.fields.count-1 %>
	    <td align="center"><span  class="titulitowhite"><%=RS.FIELDS(I).NAME%></span> </td>
    <%next%>	
    </tr>
    <tr  bgcolor='<%=(Application("barra"))%>' >
	    <%FOR i=0 TO rs.fields.count-1%>
		    <td><span  class="texto"><%=TRIM(RS.FIELDS.ITEM(I))%></span> </td>
	    <%NEXT%>
    </tr>
</table>
<table id="Table1" align="CENTER"  width="100%" cellpadding="2"  cellspacing="1"
	  bordercolor="White" bgcolor="lightgrey" border="1">
    <%'LINEA DE CABECERA STANDAR %>
    <tr bgcolor="<%=application("head")%>" >
	    <td align="center"><span  class="titulitowhite">NOMBRE </span> </td>
	    <td align="center"><span  class="titulitowhite">VALOR </span> </td>
    </tr>
    <%'PREPRARA LOS PARAMETROS PARA DESGLOSE 
        dim aVal()
        redim aVal(-1)
        dim aPar()
        redim aPar(-1)
        
        cad = TRIM(rs("parametros"))
        do while len(cad)>0 and instr(1,cad,"=") > 0
            ' PARAMETRO
            xx1 =instr(1,cad,"&")
            cad = right(cad,len(cad)-xx1)
            xx2 =instr(1,cad,"=")
            redim preserve aVal(ubound(aVal)+1)
            aVal(ubound(aVal)) = LEFT(TRIM(cad),xx2-1)
            CAD = RIGHT(CAD,LEN(CAD)-(XX2))
            if instr(1,cad,"&") > 0 then xx = instr(1,cad,"&")-1 else xx =len(cad)
            CAD2 = LEFT(CAD,xx)
            IF (CAD2 = "&") THEN CAD2 = ""
            redim preserve aPar(ubound(aPar)+1)
            aPar(ubound(aPar)) = cad2
       loop
  %>    
  <% for i=0 to ubound(aVal)%>
  <tr <% IF i mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			onclick="dd('<%=(i)%>');"  id="fila<%=Trim(Cstr(i))%>" >
	    <td align="center"><span  class="titulito"><%=aVal(i)%>&nbsp;</span> </td>
	    <td align="center"><span  class="titulito"><%=aPar(i)%>&nbsp;</span> </td>
    </tr>  
    <%next %>
    <tr <% IF i mod 2  = 0 THEN %>bgcolor='<%=(Application("color1"))%>' <%else%> bgcolor='<%=(Application("color2"))%>' <%end IF%>
			onclick="dd('<%=(i)%>');" id="fila<%=Trim(Cstr(i))%>">
	    <td align="center"><span  class="titulito">&nbsp;</span> </td>
	    <td align="center"><span  class="titulito">&nbsp;</span> </td>
    </tr>  
</table>

<table	align="center" width="100%" border="1" 
		cellpadding="1" cellspacing="0"  bgcolor="WHITE" bordercolorlight="GAINSBORO" bordercolordark="WHITE" 
		id="DATAENTRY">
    <tr> 
		<td  bgcolor='<%=(Application("barra"))%>' width="10%"> 
			<span  class="TITULITO">PARAMETRO</span> </td>
		<td width="40%"> 
		<input  id ="COD" type="TEXT"   class="DATOSGRANDE" />		</td>
    	<td width="10%" bgcolor='<%=(Application("barra"))%>'><span  class="TITULITO">VALOR</span> </td>
        <td colspan="1" WIDTH=40%><input  type="text" name="DES" id="DES" class="DATOSGRANDE"  /></td>
        <td><input id="chk" type="checkbox" value = '<%=i %>'onclick="graba(this.value)"></td>
    </tr>
  </table>	

<iframe src='' frameborder="1" id="bake" name="bake" style="display:none" width="100%"></iframe>
<script>
oldrow=0
maxi = '<%=ubound(aVal) %>'
if (parseInt(maxi,10) >=0)
    dd(0)
function dd(ff) 
{	// recibe el número de linea que tiene que pintar de celeste
	var t = document.all.Table1;
	var pos = parseInt(ff)
		if ((oldrow%2) ==0)
			eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color1"))%>'");
		else
			eval("document.all.fila" + oldrow + ".style.backgroundColor='<%=(Application("color2"))%>'");
			
		document.all.COD.value = ltrim(t.rows(pos+1).cells(0).innerText);
	    document.all.DES.value = ltrim(t.rows(pos+1).cells(1).innerText) ;
	    document.all.chk.checked = false
	    document.all.chk.value = pos+1
		// PINTA LA LINEA DEL COLOR OSCURO (PREDETERMINADO)
		eval("document.all.fila"+ff+".style.backgroundColor='<%=(Application("BARRA"))%>'");
		oldrow=pos
		return true;
}
function graba(opc)
{   cad = 'comun/inserpar.asp?'
    op = parseInt(opc,10)
    if(document.all.chk.checked == true)
      { var aPar = Array(document.all.Table1.rows.length-1)
        var aVal = Array(document.all.Table1.rows.length-1)
        for (i=0; i<=document.all.Table1.rows.length-1; i++)
        {   if (i == op)
            {   aPar[i]= document.all.COD.value;
                aVal[i]= document.all.DES.value;
            }
            else
            {   aPar[i]= document.all.Table1.rows(i).cells(0).innerText;
                aVal[i]= document.all.Table1.rows(i).cells(1).innerText;
            }   
        }
      }
     cad += 'param=' + aPar + '&valu=' + aVal
     cad += '&menu=' + '<%=trim(menu)%>'
     cad += '&subm=' + '<%=trim(subm)%>'
     document.all.bake.src=cad
}
</script>
</body>

</html>
