<%@ Language=VBScript %>
<% Response.Buffer = true %>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL	= Request.Cookies("Usuario")("Perfil") %>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<html>
<head>
<title></title>
</head>
<body>
<%nume= "1"

sp  = request.Cookies("spe")
vr  = right(request.Cookies("ver"),3)

cli = request.Cookies("cli")
tem = request.Cookies("tem")
med = request.Cookies("med")
mmd = request.Cookies("mmd")
est = request.Cookies("est")
cad = "selEct * from view_spec_head where spec= '"&sp&"' and ver = '"&vr&"'"
rs.open cad , cnn
if rs.recordcount >0 then 
    rs.movefirst
    medi = rs("tipmed")
    mode = rs("crea")
    nume = rs("numpro")
    obse = rs("obs")
    come = rs("comentarios")
    nota = rs("NOTA")
end if
%>
<form id="formato" method="post" action="">

<center>
<font face="arial" size="3" style="color:'#F63'"><strong>Datos Adicionales Spec N&deg; <%=sp%>-<%=vr%> :</strong></font><br /><br />
</center>
<table align="center" width="100%" border="1" cellpadding="3" cellspacing="3"  >	
    <tr>
        <td>
	        <table align="center" width="100%" border="0" cellpadding="1" cellspacing="1"  >
                <tr>
                    <td><font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b>Unidades de Medici&oacute;n :</b></font>&nbsp;&nbsp;&nbsp;&nbsp;
		                <select id="MED" name="MED" class="Data" onchange="ESTILO()">
			                <option value='CMS'>Centimetros</option>           
                            <option value='PLG'>Pulgadas</option>           
		                </select>
	                </td>
                    <td><font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b>Modelista :</b></font>&nbsp;&nbsp;&nbsp;&nbsp;
		                <select id="MMD" name="MMD" class="Data" >
			                <%cad =	"select * from USUARIOS where estado = 'a' order by NOMBRES "
                            Set RS2 = Server.CreateObject("ADODB.Recordset")
		                    RS2.ActiveConnection = Cnn
		                    RS2.CursorType       = 3 'CONST adOpenStatic = 3
		                    RS2.LockType         = 1 'CONST adReadOnly = 1

                            rs2.open cad,cnn
                            IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST%>
                            <%DO WHILE NOT RS2.EOF%>
			                <option value='<%=TRIM(rs2("USUARIO"))%>'><%=trim(rs2("nombreS"))%></option>
			                <%RS2.MOVENEXT%>
		                <%LOOP%>    
		                </select>
	                </td>
                    <td><font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b>N&deg; Produccci&oacute;n :</b></font>&nbsp;&nbsp;&nbsp;&nbsp;
		                <input id="nume" name="nume" class="data" value='<%=nume%>' maxlength="2" style="width:40px;">
	                </td>
                </tr>
                <tr>
                    <td colspan="7"><hr /></td>
                </tr>
                <tr>
                    <td  colspan ="7" >
                        <font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b><br />Observaciones :<br /></b></font>
                        <textarea style="width:100%; height:100%; overflow-y: auto; word-wrap:break-word"  id="Textarea1" name="Textarea1"><%=OBSE%></textarea>
                    </td>
                </tr>
                <tr>
                    <td  colspan ="7" >
                        <font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b><br />Comentarios 1 :<br /></b></font>
                        <textarea style="width:100%; height:100%; overflow-y: auto; word-wrap:break-word"  id="Textarea2" name="Textarea2"> <%=COME%></textarea>
                    </td>
                </tr>
                <tr>
                    <td  colspan ="7" >
                        <font face="arial" size="2" color='<%=APPLICATION("TITULO") %>'><b><br />Nota Importante :<br /></b></font>
                        <textarea style="width:100%; height:100%; overflow-y: auto; word-wrap:break-word"  id="Textarea3" name="Textarea3"><%=NOTA%></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan ="7" align="center"> <input type="button" value= "" onclick="graba()" style="display:block; background-image:url(imagenes/disk.gif);width:26px;height:26px;cursor:pointer;"  ></td>
	            </tr>
            </table>	
        </td>
    </tr>
</table>
</form>
<script type="text/jscript" language="jscript">
    var subcadena = "<%=MEDI%>"
    var elemento = document.all.formato.MED
    document.all.formato.MED.selectedIndex = seleindice(subcadena, elemento);
    var subcadena = "<%=mode%>"
    var elemento = document.all.formato.MMD
    document.all.formato.MMD.selectedIndex = seleindice(subcadena, elemento);

function graba() {


    document.all.formato.action = 'comun/completaSPEC.asp'
    // alert( document.all.formato.action)
 
    document.all.formato.submit()

 }


</script>
</body>
</html>
