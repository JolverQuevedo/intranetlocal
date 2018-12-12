<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<%
    if request.QueryString("oc") <> undefined then
        if request.QueryString("modificar") <> undefined and request.QueryString("modificar") = "true" then
            cad = "Update RSFACCAR..CO0001MOVc Set oc_cusuari = 'rh01' Where OC_CNUMORD='"+request.QueryString("oc")+"' "
            %><script>alert("actualizado correctamente");</script><%
            Cnn.Execute(CAD)

        end if

        cad="select OC_CNUMORD,OC_CCODPRO,OC_CRAZSOC,OC_cuniord from RSFACCAR..CO0001MOVc Where OC_CNUMORD='"+request.QueryString("oc")+"' "    
        'response.Write(cad)
        RS.Open CAD, Cnn
    LIMITE =  rs.fields.count - 1
    %>

<table id="TABLA" align="center"  bordercolor="#FFFFFF" bgcolor="<%=Application("color2")%>"  cellpadding="2"  cellspacing="1"  border="1" >
        <tr  bgcolor=#294052  >
        
        <%for I=0 to LIMITE %>
	        <td align="center" style="color:#fff;padding:5PX 5PX" class="Estilo8">
		        <%=RS.FIELDS(I).NAME%>
	        </td>
        <%next%>	
        </tr>

        <% DO WHILE NOT RS.EOF%>
		<tr>

            <td><%=RS(0) %></td>
            <td><%=RS(1) %></td>
            <td><%=RS(2) %></td>
            <td><%=RS(3) %></td>


		</tr>
	    <%RS.MOVENEXT %>
        <%CONT = CONT + 1%>
        <%LOOP %>

	
    </table>
    


<%



        response.End
    end IF%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Reiniciar O/C</title>
    <link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body style="margin-top: 0;" onload="document.getElementById('oc').focus();">
    <form id="thisForm" method="post" name="thisForm" action="">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr valign="center">
                <td width="10%" align="center">
                    <img src="imagenes/atras.gif" style="cursor: pointer;" onclick="javascript: window.location.replace('SUBMENU.ASP?TIPO=13');" /></td>

                <td align="center" class="TALASBLUE" width="80%">
                    <table cellpadding="10" cellspacing="1" border="1" bgcolor="#f7d975" align="center" width="100%">
                        <tr>
                            <td class="talasblue" align="center">CAMBIA USR O/C PARA RHIN</td>
                        </tr>
                    </table>
                </td>
                <td width="10%" align="center">
                    <img src="imagenes/logo.gif" />
                </td>
            </tr>
        </table>

        <table cellpadding="5" cellspacing="0" border="1" style="width: 100%" align="center">
            <tr>
                <td class="tituloGRANDEorange" colspan="3" style="text-align: left">OC : </td>
            </tr>
            <tr>
                <td class="">Ingrese OC</td>
                <td><input id="oc" name="oc" onchange="buscar()"/></td>
                <td><button onclick="modificar()">Actualizar</button></td>
            </tr>
            <tr>
                
            </tr>
        </table>
        <iframe id="miiframe" width="100%"></iframe>
    </form>
    <script>
        function buscar(){
            var oc=strzero(document.getElementById("oc").value,10);
            document.getElementById("miiframe").src="./ss.ASP?oc="+oc;
        }
        function modificar(){
            var oc=strzero(document.getElementById("oc").value,10);
            document.getElementById("miiframe").src="./ss.ASP?oc="+oc+"&modificar=true";
            
        }
    </script>
</body>
</html>




