<%
Set cnn = Server.CreateObject("ADODB.Connection")
cnn.CommandTimeout = 900

'***********************************************************************************************
'   ESTE ES EL QUE ESTOY USANDO EN LA CASA y en EL MODELADOR
'***********************************************************************************************

txtCon = Application("ConStr")
 Cnn.Open txtCon

Set RS = Server.CreateObject("ADODB.Recordset")
	RS.ActiveConnection = Cnn
	RS.CursorType       = 3 'CONST adOpenStatic = 3
	RS.LockType         = 1 'CONST adReadOnly = 1
	RS.CursorLocation   = 3 'CONST adUseClient = 3
set txtCon = nothing

%>
<%
sp  = REQUEST.cookies("sp")
vr  = REQUEST.cookies("vr")
CLI = REQUEST.cookies("CLI")
TEM = REQUEST.cookies("TEM")
EST = REQUEST.cookies("EST")
sp =  REQUEST.cookies("spe")
vr =  right(REQUEST.cookies("ver"),3)
med = REQUEST.cookies("med")
MMd = REQUEST.cookies("MMD")

 orr = REQUEST.cookies("orden")
 gru  = REQUEST.cookies("grupo")
 
 cad = "select po from spec_pos where spec= '"&sp&"' and ver = '"&vr&"'  "
 rs.open cad,cnn
 pos = ""
 if rs.recordcount > 0 then 
	rs.movefirst
 else
	response.write("spec_pos 1")
 end if	
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
			" numpro, crea,																" & _
            " estcli, estilo, temporada, codtem, tela, DESCRIPCION, PESOACA, obs,codest " & _
            " from view_spec_head                                                       " & _ 
            " where spec= '"&sp&"' and ver = '"&vr&"' and po in ("&po&")                "
    rs.open cad,cnn

    if rs.recordcount > 1 then 
        response.write("<font color=red size=2>Revise las POs de este Spec, tienen diferentes telas de cuerpo")
        response.end
		
    end if
	'response.write(cad)
    if rs.recordcount <= 0 then 
		response.write("Faltan datos de cabecera... ")
		response.end
	END IF
    rs.movefirst
	nume= trim(rs("numpro"))

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
else
    response.write("spec_pos")
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
else
	response.write("view_cliente_temporada_estilo")
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
else
	response.write("servicios tela")
end if

rs2.close
rs2.open "select * from grupomedida where codigo = '"&GRU&"'", cnn
grupos = ""
if rs2.recordcount > 0 then 
    rs2.movefirst
    grupos = trim(ucase(rs2("descripcion")))
else
	response.write("grupomedida")
END IF

rs2.close
rs2.open "select * from view_specruta where spec= '"&sp&"' and ver = '"&vr&"' order by lin ", cnn
servicios=""
if rs2.recordcount > 0 then
	 rs2.movefirst
    do while not rs2.eof
		servicios = servicios +  + trim(RS2("descripcion")) + " - "
        RS2.MOVENEXT
    loop
    servicios = left(servicios,len(servicios)-3)
end if
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
    <td width="9%"><div align="center"><%=nume%>&nbsp;</div></td>
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
    <td class="TITULITOnavy2"><%=rs("pesoaca") %>&nbsp;</td>
    
  </tr>
  
  <tr>
    <td class="tituloGRANDEgris">Tela</td>
    <td class="TITULITOnavy2"><%=rs("tela")%></td>
    <td colspan="2" class="TITULITOnavy2"><%=rs("descripcion")%></td>
    <td class="tituloGRANDEgris">Modelista</td>
    <td class="TITULITOnavy2"><%=rs("modelista") %>&nbsp;</td>
   
  </tr>
  <tr>
    <td class="tituloGRANDEgris">Ruta Tela</td>
    <td colspan="3" class="TITULITOnavy2"><%=ruk %>&nbsp;</td>
    <td class="tituloGRANDEgris">Elaborado</td>
    <td class="TITULITOnavy2"><%=rs("creador") %>&nbsp;</td>
  </tr>
  <tr>
    <td class="tituloGRANDEgris">Ruta Prenda</td>
    <td colspan="3" class="TITULITOnavy2"><%=servicios%>&nbsp;</td>
    <td class="tituloGRANDEgris">Fecha</td>
    <td class="TITULITOnavy2"><%=formatdatetime(date(),2) %></td>
  </tr>
  <tr>
    <td class="tituloGRANDEgris">Po's</td>
    <td colspan="5" class="TITULITOnavy2"><%=pss%></td>
    
  </tr>
   <tr>
    <td class="tituloGRANDEgris">Observaciones</td>
    <td colspan="5" class="TITULITOnavy2"><%=trim(rs("obs"))%>&nbsp;</td>
    
  </tr>
</table>
<center>
<% IF CINT(ORR) > 0 THEN %>
 <%CAD = "../BAKE/recuperaFOTOSpec.asp?spe=" + sp + "&VER=" + vr + "&ORD=" + orr + "&GRU=" + gru%>

    <img id="img<%=i%>" name="img<%=i%>" src="<%=cad%>" border="1" />
<% END IF%>
</center>
</body>
</html>
