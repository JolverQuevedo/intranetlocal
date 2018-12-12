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
<!--#include file="../includes/Cnn.inc"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<%
sp= request.QueryString("sp")
vr = request.QueryString("vr")
CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp =  REQUEST.cookies("spe")
vr =  right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")

 orr = REQUEST.cookies("orden")
 gru  = REQUEST.cookies("gru")
 
 cad = "select po from spec_pos where spec= '"&sp&"' and ver = '"&vr&"'  "
 rs.open cad,cnn
 pos = ""
 if rs.recordcount > 0 then rs.movefirst
 do while not rs.eof
    pos = pos + "'" + trim(rs("po")) + "',"
    rs.movenext
 loop
 if len(pos) <= 0 then  
    response.write("<font color=red size=2>Spec no tiene Pos asignadas...")
    response.end
end if

    po = left(pos, len(pos)-1)
    rs.close
    'response.write(po)
    'response.Write("<br>")
    CAD =   " select distinct spec, ver, codcli, descli, creador, modelista, genEro,    " & _
            " estcli, estilo, temporada, codtem, tela, DESCRIPCION, PESOACA, obs,codest " & _
            " from view_spec_head                                                       " & _ 
            " where spec= '"&sp&"' and ver = '"&vr&"' and po in ("&po&")                "
    rs.open cad,cnn

    if rs.recordcount > 1 then 
        response.write("<font color=red size=2>Revise las POs de este Spec, tienen diferentes telas de cuerpo")
        response.end
    end if
    if rs.recordcount <= 0 then response.end
    rs.movefirst

'response.write(cad)
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 


kad = "select po from spec_pos where spec= '"&sp&"' and ver = '"&vr&"'  "
rs2.open kad,cnn
pss = ""
if rs2.recordcount > 0 then
    rs2.movefirst
    do while not rs2.eof
        pss = pss + trim(RS2("PO")) + " - "
        RS2.MOVENEXT
    loop
    pss = left(pss,len(pss)-3)
end if
rs2.close
cli = rs("codcli")
tem = rs("codtem")
est = rs("codest")
kad =   " select top 1 proto, [version]                                         " & _
        " from View_Cliente_Temporada_Estilo_PO AS VC                           " & _
        " FULL OUTER JOIN SPEC_POS AS SP ON SP.PO = VC.PO                       " & _
        " where cliente = '"&cli&"' and codtem='"&tem&"' and estilo = '"&est&"' " & _
        " AND (SPEC= '"&sp&"' AND VER= '"&vr&"' )                               " & _
        " ORDER BY VC.po                                                        "
rs2.open kad,cnn
if rs2.recordcount > 0 then
    rs2.movefirst
    pro = rs2("proto")
    ver = rs2("version")
end if
rs2.close
kad = "select ruta from [proto-detalles] where proto = '"&pro&"' and version = '"&ver&"' and tipodetalle='TE' and id = 1  "
rs2.open kad,cnn
rut = "001"
if rs2.recordcount > 0 then
    rs2.movefirst
    rut = rs2("ruta")
end if
tel= rs("tela")
rs2.close


kad =   " SELECT tela, servicio AS codigo,	merma, 	    " & _
		" opc, DESCRIPCION FROM TELARUTADETA	        " & _
		" INNER JOIN SERVICIOS ON SERVICIO = CODIGO	    " & _
		" WHERE TELA = '"&TEL&"' and version ='"&RUT&"' " & _
		" ORDER BY TELA DESC, opc, CODIGO			    "
rs2.open kad,cnn

ruk = ""
if rs2.recordcount > 0 then
    rs2.movefirst
    do while not rs2.eof
        ruk = ruk + trim(RS2("descripcion")) + " - "
        RS2.MOVENEXT
    loop
    ruk = left(ruk,len(ruk)-3)
end if

rs2.close
rs2.open "select * from grupomedida where codigo = '"&GRU&"'", cnn
grupos = ""
if rs2.recordcount > 0 then 
    rs2.movefirst
    grupos = trim(ucase(rs2("descripcion")))
END IF
 %>
<body>
<table width="100%" border="1" cellspacing="0" cellpadding="2">
  <tr valign="middle" height="50px">
    <td colspan="2" class="tituloMODELADOR">El Modelador</td>
    <td colspan="2" class="tituloMODELADOR" style="text-align:center">HOJA DE COMO MEDIR : <%=grupos %></td>
    <td colspan="2" class="tituloMODELADOR" style="text-align:right">SPEC # <%=sp%>-<%=vr%>&nbsp;&nbsp; </td>
  </tr>
  <tr>
    <td width="8%" class="tituloGRANDEgris">Cliente</td>
    <td width="8%"  class="TITULITOnavy2" align="center"><%=rs("codcli") %></td>
    <td colspan="2" class="TITULITOnavy2"><%=ucase(RS("descli")) %></td>
    <td width="9%"><div align="center">1</div></td>
    <td width="20%" class="tituloGRANDEgris"><div align="center"><strong>PRODUCCION</strong></div></td>
    
  </tr>
  <tr>
    <td class="tituloGRANDEgris">Estilo</td>
    <td  class="TITULITOnavy2"><%=rs("estcli") %></td>
    <td colspan="2"  class="TITULITOnavy2"><%=rs("estilo") %></td>
    <td class="tituloGRANDEgris">Genero</td>
    <td  class="TITULITOnavy2"><%=rs("genero") %></td>
    
  </tr>
  <tr>
    <td class="tituloGRANDEgris">Temporada</td>
    <td class="TITULITOnavy2"><%=rs("codtem") %></td>
    <td class="TITULITOnavy2" colspan="2"><%=rs("temporada") %></td>
    <td class="tituloGRANDEgris">Densidad</td>
    <td class="TITULITOnavy2"><%=rs("pesoaca") %></td>
    
  </tr>
  
  <tr>
    <td class="tituloGRANDEgris">Tela</td>
    <td class="TITULITOnavy2"><%=rs("tela")%></td>
    <td colspan="2" class="TITULITOnavy2"><%=rs("descripcion")%></td>
    <td class="tituloGRANDEgris">Modelista</td>
    <td class="TITULITOnavy2"><%=rs("modelista") %></td>
   
  </tr>
  <tr>
    <td class="tituloGRANDEgris">Ruta Tela</td>
    <td colspan="3" class="TITULITOnavy2"><%=ruk %>&nbsp;</td>
    <td class="tituloGRANDEgris">Elaborado</td>
    <td class="TITULITOnavy2"><%=rs("creador") %></td>
  </tr>
  <tr>
    <td class="tituloGRANDEgris">Ruta Prenda</td>
    <td colspan="3" class="TITULITOnavy2">&nbsp;</td>
    <td class="tituloGRANDEgris">Fecha</td>
    <td class="TITULITOnavy2"><%=formatdatetime(date(),2) %></td>
  </tr>
  <tr>
    <td class="tituloGRANDEgris">Po's</td>
    <td colspan="5" class="TITULITOnavy2"><%=pss%></td>
    
  </tr>
   <tr>
    <td class="tituloGRANDEgris">Observaciones</td>
    <td colspan="5" class="TITULITOnavy2"><%=trim(rs("obs"))%></td>
    
  </tr>
</table>
</body>
</html>
