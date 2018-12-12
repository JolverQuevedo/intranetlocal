<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />

<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->


<%
'response.write(request.Cookies("spe"))
ETC = request.QUERYSTRING("ETC")
cli = request.QUERYSTRING("cli")
tem = request.QUERYSTRING("tem")
est = request.QUERYSTRING("est")
tip = request.QUERYSTRING("tip")
 archivo = "c:\temp\ETCexcel.xls"
    Response.Charset = "UTF-8"
    Response.ContentType = "application/vnd.ms-excel" 
    Response.AddHeader "Content-Disposition", "attachment; filename=" & archivo 

Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 
     %>
<body >



<%aLET = ARRAY(" ","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0", "1", "2", "3", "4", "5", "6", "7", "8", "9") 
dad = " SELECT * FROM VIEW_ETC_FICHA WHERE CODETC = '"&ETC&"' AND CODTIP='"&tip&"'  ORDER BY CODETC,  ubi"               
'rESPONSE.WRITE(DAD)
RS2.OPEN DAD, CNN 



IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST%>
<%u=1%>
<table  border="0" cellspacing="0" cellpadding="1" align="left" width="100%" bgcolor="white">
    <tr><td colspan="17" style="FONT-WEIGHT:900; font-size: 14px; COLOR: navy; TEXT-ALIGN: center">Hoja de Combinaciones </td></tr>
    <tr style="color:red"><td colspan="2" >Cliente : </td><td colspan="15"><%=rs2("nombre") %> </td></tr>  
    <tr style="color:red"><td colspan="2" >Estilo  : </td><td colspan="15"><%=rs2("estcli") %> - <%=rs2("desest") %>  </td></tr>  
    <tr style="color:red"><td colspan="2" >Temporada: </td><td colspan="15"> <%=rs2("destem") %> </td></tr>  

   <tr><td colspan="17" style="height:2px; background-color:darkgreen"></td></tr>  
   <tr><td colspan="17" style="height:1px; background-color:darkgreen"></td></tr>  
    <tr class="TITULITOcenterGREEN" style="color:navy">
        <td colspan="2">Nombre del</td>
        <td colspan="14">ETC : <%=etc%>
       
        </td>
        <td colspan="13" align="left"></td>
    </tr>
    <tr >
    <td style="width:5%" colspan="2" class="TITULITOcenterGREEN" style="color:navy">COMBO</td>
        <%FOR I = 1 TO 15%>
            <td align="center" width="3%">
                <% nume = right("00"+ cstr(i),2)
                DES = "DES" & nume %>
                <%IF RS2.RECORDCOUNT>0 THEN dd = ltrim(RS2(DES)) else dd = "" END IF%>
                <%=dd%>
            </td>  
           
        <%NEXT%>  
    </tr> 
    <tr><td colspan="17" style="height:2px; background-color:darkgreen"></td></tr>  
    <tr><td colspan="17" style="height:1px; background-color:darkgreen"></td></tr>  
<%DO WHILE NOT RS2.EOF %>   
  <tr  id="LIN<%=U%>" name="LIN<%=U%>" style="display:block">
    <td class="AMERICANnavy" style="width:1%" id="IT<%=u%>" name="IT<%=u%>"><%=u%></td>
    <td style="width:5%"><%=rs2("COMBO")%></td>
            <%FOR I = 1 TO 15%>
               <td align="left" width="5%">
                   <%nume = right("00"+ cstr(i),2)
                   COL= "COL"&nume %>            
                  <%=RS2(col)%>
              </td>    
            <%NEXT%>   
  </tr>
<%U = U + 1 %>
<%RS2.MOVENEXT%>
<%LOOP%>
</body>

</html>
