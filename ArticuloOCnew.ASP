<%@ Language=VBScript%>
<%Response.Buffer = true%>
<%Session.LCID=2052%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
<script type="text/jscript" language="jscript">
var aCod = Array() 
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

<%
 oc =  request.QueryString("oc") 
lin =  request.QueryString("lin") 
cod =  request.QueryString("cod") 
can =  request.QueryString("can")
des =  request.QueryString("des") 
uni =  request.QueryString("uni") 
igv =  request.QueryString("igv") 
isc =  request.QueryString("isc") 
alm =  request.QueryString("alm") 
al2 =  request.QueryString("al2") 
al1 =  request.QueryString("al1") 
ofi =  request.QueryString("ofi") 
lt2 =  request.QueryString("lt2") 
lt1 =  request.QueryString("lt1") 
ser =  request.QueryString("ser") 
cla =  request.QueryString("cla") 
ki1 =  request.QueryString("ki1")
ki2 =  request.QueryString("ki2")
ki3 =  request.QueryString("ki3")
ki4 =  request.QueryString("ki4")
ki5 =  request.QueryString("ki5")
ki6 =  request.QueryString("ki6")
hi1 =  request.QueryString("hi1")
hi2 =  request.QueryString("hi2")
hi3 =  request.QueryString("hi3")
hi4 =  request.QueryString("hi4")
hi5 =  request.QueryString("hi5")
hi6 =  request.QueryString("hi6")



aOfi = split(ofi, ",")
aCod = split(cod, ",")
aCan = split(can, ",")
aHi1 = split(hi1, ",")
aHi2 = split(hi2, ",")
aHi3 = split(hi3, ",")
aHi4 = split(hi4, ",")
aHi5 = split(hi5, ",")
aHi6 = split(hi6, ",")
aKi1 = split(ki1, ",")
aKi2 = split(ki2, ",")
aKi3 = split(ki3, ",")
aKi4 = split(ki4, ",")
aKi5 = split(ki5, ",")
aKi6 = split(ki6, ",")

for t=0 to ubound(acod)
    if len(trim(aCod(t))) =6 then aCod(t) = trim(aCod(t))+"0000000000"
next


'response.write(ofi)
'IF  LEN(TRIM(request.QueryString("can"))) = 0 THEN CAN= 0 ELSE can =  request.QueryString("can") 
'if trim(request.QueryString("pre")) = "" then pre = 0 else pre =  request.QueryString("pre") 
com =  request.QueryString("com") 

    if trim(oc)= "" then oc = "AUTO"
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
    Set RS3 = Server.CreateObject("ADODB.Recordset")
	    RS3.CursorLocation   = 3
	    RS3.CursorType       = 3    
	    RS3.LockType         = 1 	
    ' NOMBRE DEL CLIENTE
    rs.open "select cli from  VIEW_OFIS where ofi = '"&aofi(0)&"'", cnn
    if rs.recordcount > 0 then cli = rs.fields.item(0) else cli= ""
    rs.close
aTal =  Array("","","","","","","","","","")
aQty =  Array(0,0,0,0,0,0,0,0,0,0)
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA O/C</title>
</head>
<body style="margin-left:0px; margin-top:0px; margin-right:0px;" >
<form id="thisForm" method="post" name="thisForm" action="">
<iframe id="Iframe1" width="100%" style="display:none; width:100%;" src=""  name="Iframe1" scrolling="yes" frameborder="0" ></iframe>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="center" > 
    <td width="15%" align="right"><img src="imagenes/CERRAR.gif" style="cursor:pointer;" onClick="top.window.close()" /></td>	
    <td width="15%" align="right">&nbsp;</td>	
          <td align = "center" class="TALASBLUE" width="60%">   
            <table cellpadding="10" cellspacing="1" border="1" bgcolor="#f7d975" align="center" width="100%">
		        <tr><td style="text-align:right" class="talasblue">ARTICULO O/C EXPLOSION</td></tr></table>
    </tr>
</table>  
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<table width="100%" border="1" border="<%=APPLICATION("COLOR2") %>" cellpadding="0" cellspacing="0" >   
	<tr valign="middle"><td bgcolor="#f7d975" style="height:1px;"></td></tr>
</table>
<table cellpadding="5" cellspacing="0" border="0" bgcolor='<%=APPLICATION("FONDITO") %>' bordercolor='<%=APPLICATION("COLOR2") %>' width="100%">
    <tr align="left" class="tituloGRANDEorange" ><td style="width:100%">DATOS DE LOS ARTICULOS</td></tr></table>
<table border="1" cellpadding="0" width="100%" cellspacing="0" bgcolor="<%=(Application("color2"))%>" 
id="TABLA" name="TABLA" bordercolordark="<%=(Application("borde"))%>" bordercolorlight="<%=(Application("COLOR1"))%>">
  <tr>
      <td bgcolor="<%=(Application("BARRA"))%>" class="TEXTO6">Item</td>
      <td bgcolor="<%=(Application("BARRA"))%>" class="TEXTO6">Codigo</td>
      <td bgcolor="<%=(Application("BARRA"))%>" class="TEXTO6">Descripcion</td>
      <td bgcolor="<%=(Application("BARRA"))%>" class="TEXTO6">Und.</td>
      <td bgcolor="<%=(Application("BARRA"))%>" class="TEXTO6">Cant</td>
      <td bgcolor="<%=(Application("BARRA"))%>" class="TEXTO6">US$</td>
  </tr>

  <%for i= 0 to ubound(acod)%> 
        <%IF UCASE(CLA) = "S"  THEN 
            MINI = I
            MAXI = I
         ELSE 
            MINI = 0
            MAXI = UBOUND(AOFI)   
        END IF %>
    <tr valign="top" id="lin<%=i%>" name="lin<%=i%>" <%if i = 0 then%>style="background-color:#f7d975"<%end if %>>
        <%lin=right("0000"+ cstr((i+1)),4)  %>
        <td><input type="text" id="LIN<%=i%>" name="LIN<%=i%>"value='<%=lin%>' style="width:100%; text-align:center"class="descriptores"  tabindex="-1" readonly/></td>
        <td><input type="text" id="COD<%=i%>" name="COD<%=i%>" class="descriptores" readonly tabindex="-1"
         value="<%if cla="S" then response.write(ser) else response.write( aCOD(i))%>" /></td>
        <%if ucase(cla) = "C" then
            cad = "exec OC_LIN_COD '"&oc&"', '"&lin&"' , '"&aCod(i)&"' "  
        else
            cad = "exec OC_LIN_COD '"&oc&"', '"&lin&"' , '"&ser&"' "  
        end If
         '   response.Write(cad)  
	    rs.open cad, cnn
	    IF RS.RecordCount > 0 THEN 		RS.MOVEFIRST%>
        
        <%IF TRIM(RS("DESCRI")) = "" THEN
            if ucase(cla) = "S" then
                ddd = "Select AR_CDESCRI, ar_cunidad From RSFACCAR..AL0001ARTI Where AR_CCODIGO='"&ser&"'"
            else
                ddd = "Select AR_CDESCRI, ar_cunidad From RSFACCAR..AL0001ARTI Where AR_CCODIGO='"&aCod(I)&"'"
            end if
            RS3.OPEN ddd, CNN
            'response.write(RS3.RECORdCOUNT)
            IF RS3.RECORdCOUNT > 0 THEN
                RS3.MOVEFIRST
                DESCRI = RS3("AR_CDESCRI")
                uni = RS3("AR_Cunidad")
            ELSE
                DESCRI = "NO HAY"
                uni = "..."
            END IF
            RS3.CLOSE
            '**************************************************************************
            ' acod tiene el codigo del crudo.... hay que buscar el resto de la descri
            ' si la CLASE = S
            '**************************************************************************
           ' RESPONSE.WRITE(ACOD(I))
             if ucase(cla) = "S" then
                CAD = "Select AR_CDESCRI, ar_cunidad From RSFACCAR..AL0001ARTI Where AR_CCODIGO='"&aCod(I)&"'"
                RS3.OPEN CAD, CNN
                RS3.MOVEFIRST
                DESCRI = DESCRI +" "+ TRIM(RS3("AR_CDESCRI"))
                RS3.CLOSE
             END IF
        else%>
            <%DESCRI=rs("descri")
            UNI= RS("UNI") %>
        <%end if%>

        <td><input type="text" id="DES<%=i%>" name="DES<%=i%>" value="<%=descri%>" class="descriptores" maxlength= "60" style="width:100%;text-align:left;" readonly tabindex="-1" /></td>
         <%IF UCASE(cla) = "C" THEN pedido = aCan(i) else pedido = cdbl(aki1(i))+cdbl(aki2(i))+cdbl(aki3(i))+cdbl(aki4(i))+cdbl(aki5(i))+cdbl(aki6(i))%>
            <!-- LO QUE TENGO QUE COLOCAR ES LO PEDIDO DE LA TNT Y NO LO REQUERIDO DE LA po -->
        <td><input type="text" id="UNI<%=i%>" name="UNI<%=i%>" value="<%=uni%>" class="DESCRIPTORES" style="text-align:center" readonly tabindex="-1" /></td>
        <td><input type="text" id="PED<%=i%>" name="PED<%=i%>" class="descriptores" style="width:100%; text-align:right; padding-right:5px" maxlength="10" tabindex="-1" readonly  
        value="<%IF UCASE(cla) = "C" THEN 
                    RESPONSE.WRITE(formatnumber(aCan(i),3,,true)) 
                ELSE
                    RESPONSE.WRITE(cdbl(aki1(i))+cdbl(aki2(i))+cdbl(aki3(i))+cdbl(aki4(i))+cdbl(aki5(i))+cdbl(aki6(i)))
                end if%>"/></td>

        <td width="60px"><input type="text" id="PRE<%=i%>" name="PRE<%=i%>" value="<%=formatnumber(rs("PRE"),2,,true)%>" class="BARRA333" style="width:100%; text-align:right; padding-right:5px" maxlength="10" 
         onchange="this.value=toInt(this.value);grabar('<%=i%>', '<%=lin%>')" onfocus="pasa(this,'<%=i%>');seleccionar(this)"  /></td>       
      </tr>   
      <tr>
        <td class="TEXTO6" >Obs </td>
        <td colspan="5"><textarea id="COME<%=i%>" name="COME<%=i%>" rows="5" class="datos"><%=trim(rs("COMe"))%></textarea></td>
      </tr>   
     
       <%li=1%>
       <%texti = Array()%>
       <%FOR x=MINI TO MAXI
            Redim preserve texti(X+1)
            cantidad = 0
            REPARTO=aCan(i)
            QTY = 0
           '  response.write(lt1)
            if cla = "S" then
                if ucase(lt1) = "H" AND ucase(lt2)= "C" then
                    tad =   " select  ISNULL(sum(k1),0) AS K1, ISNULL(sum(k2),0) AS K2, " & _
                            " ISNULL(sum(k3),0) AS K3, ISNULL(sum(k4),0) AS K4,         " & _
                            " ISNULL(sum(k5),0) AS K5, ISNULL(sum(k6),0) AS K6,         " & _
                            " QTY=0 from EXPLOSION_TELA                                 " & _
                            " where OFI = '"&aOfi(x)&"' AND left('"&aCod(i)&"',6)= crudo" & _
                            " group by qty                                              "          
                ELSEIF ucase(lt1) = "H" AND ucase(lt2)= "T" then
                    tad =   " select  ISNULL(sum(k1),0) AS K1, ISNULL(sum(k2),0) AS K2, " & _
                            " ISNULL(sum(k3),0) AS K3, ISNULL(sum(k4),0) AS K4,         " & _
                            " ISNULL(sum(k5),0) AS K5, ISNULL(sum(k6),0) AS K6,         " & _
                            " QTY=0 from EXPLOSION_TELA                                 " & _
                            " where OFI = '"&aOfi(x)&"' AND '"&aCod(i)&"' = TELA        " & _
                            " group by qty                                              "
                ELSEIF ucase(lt1) = "C" AND ucase(lt2)= "T" then
                    tad = " select ISNULL(sum(kgsteje),0), qty= case when left(crudo,1)  " & _
                          " ='9' then isnull(sum(qty),0) else 0 end from EXPLOSION_TELA  " & _  
                          " where OFI = '"&aOfi(x)&"' AND TELA='"&aCod(i)&"'             " & _
                          " group by crudo                                               "
                ELSE
                     tad = " select ISNULL(sum(kgs),0), qty= case when left(crudo,1)     " & _
                          " ='9' then isnull(sum(qty),0) else 0 end from EXPLOSION_TELA  " & _  
                          " where OFI = '"&aOfi(x)&"' AND TELA='"&aCod(i)&"'             " & _
                          " group by crudo                                               "
                end if
            else
                if ucase(lt2)= "H" then 
                    tad = " select ISNULL(sum(k1),0) ,QTY=0 from EXPLOSION_TELA         " & _
                          " where  OFI = '"&aOfi(x)&"' AND '"&aCod(i)&"' = h1           " & _
                          " group by qty                                                " & _
                          " UNION select ISNULL(sum(k2),0), QTY=0 from EXPLOSION_TELA   " & _
                          " where  OFI = '"&aOfi(x)&"' AND '"&aCod(i)&"' = h2           " & _
                          " group by qty                                                " & _
                          " UNION select ISNULL(sum(k3),0), QTY=0 from EXPLOSION_TELA   " & _
                          " where  OFI = '"&aOfi(x)&"' AND '"&aCod(i)&"' = h3           " & _
                          " group by qty                                                " & _
                          " UNION select ISNULL(sum(k4),0), QTY=0 from EXPLOSION_TELA   " & _
                          " where  OFI = '"&aOfi(x)&"' AND '"&aCod(i)&"' = h4           " & _
                          " group by qty                                                " & _
                          " UNION select ISNULL(sum(k5),0), QTY=0 from EXPLOSION_TELA   " & _
                          " where  OFI = '"&aOfi(x)&"' AND '"&aCod(i)&"' = h5           " & _
                          " group by qty                                                " & _
                          " UNION select ISNULL(sum(k6),0), QTY=0 from EXPLOSION_TELA   " & _
                          " where  OFI = '"&aOfi(x)&"' AND '"&aCod(i)&"' = h6           " & _
                          " group by qty                                                " 
                elseif ucase(lt2)= "T" then 
                    tad = " select ISNULL(sum(kgs),0), qty= case when left(tela,1) ='9' " & _
                          " then isnull(sum(qty),0) else 0 end  from EXPLOSION_TELA     " & _  
                          " where  OFI = '"&aOfi(x)&"' AND '"&aCod(i)&"' = tela         " & _
                          " group by tela                                               "
                else
                    tad = " select ISNULL(sum(kgsteje),0), qty= case when left(crudo,1)  " & _
                          " ='9' then isnull(sum(qty),0) else 0 end from EXPLOSION_TELA  " & _  
                          " where OFI = '"&aOfi(x)&"' AND crudo=left('"&aCod(i)&"',6)    " & _
                          " group by crudo                                               "
                end if ' DE LO QUE LLEGA HILO, CRUDO, TELA
            end if ' de la CLASE (SERVICIO o COMPRA)
'*************************************************************************************************************
           ' RESPONSE.WRITE(tAD)
            RS2.OPEN tad, CNN
           'response.write(cantidad)
            IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF
                ' CANTIDAD = REQUERIDO POR LA EXPLOSION
                CANTIDAD = CANTIDAD + CDBL(RS2.FIELDS.ITEM(0))
                QTY = QTY + CDBL(RS2.FIELDS.ITEM(1))
                RS2.MOVENEXT
            LOOP
            RS2.CLOSE    
            cad2 =  " select isnull(kgs,0), isnull(qty,0) from rsv_tela where alm= '"&alm&"'  and   " & _
                    " OFI = '"&aOfi(x)&"' and codigo = '"&acod(i)&"' and  tipo = '"&lt2&"'      " 
            rs2.open cad2, cnn
            ' CAN2 = RESERVADO 
            can2 = 0
            qty2 = 0         
            if rs2.recordcount > 0 then    
                rs2.movefirst
                can2 = cdbl(rs2.fields.item(0))
                qty2 = cdbl(rs2.fields.item(1))
            end if
            rs2.close
            ' CANTIDAD = NETO ENTRE LO REQUERIDO MENOS LO RESERVADO
            cantidad = cantidad - can2
            qty = qty - qty2
            ' REPARTO = LO QUE HAY QUE DISTRIBUIR
           ' response.write(cantidad)
            IF UCASE(CLA) = "C" THEN reparto = aCan(lin-1)       ELSE REPARTO = CANTIDAD
            if qty > 0 then 
               repa = reparto - qty
            else
               repa = reparto - cantidad
            end if
            if repa < 0 then 
                reparto = aCan(lin-1) 
                aCan(lin-1) = 0
            end if
            %> 
            <!-- hay que restar lo reservado de lo solicitado-->
            <%if CDBL(cantidad) > 0  then %> 
                <%if qty > 0 then 
                    dato = cantidad
                    cantidad = qty                   
                end if 
                if cdbl(cantidad) > cdbl(reparto) then 
                    cantidad=(reparto)
                end if          
                bli = right("00"+ cstr((li)),2)  %>
                <%if CDBL(cantidad) > 0  then %> 
                    <tr id="d<%=lin%>o<%=bli%>" style="display:none">
                        <td><input id="LDET<%=lin%>x<%=bli%>" name="LDET<%=lin%>x<%=bli%>" class="DESCRIPTORES" style="width:100%; text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(li))),2) %>'/></td>
                        <td><input id= "OFI<%=lin%>x<%=bli%>" name= "OFI<%=lin%>x<%=bli%>" class="DESCRIPTORES" style="width:100%;" value="<%=aOfi(x)%>"  readonly tabindex="-1" /></td>
                        <td><input id= "CAN<%=lin%>x<%=bli%>" name= "CAN<%=lin%>x<%=bli%>" class="DESCRIPTORES"  readonly tabindex="-1" style="width:100%;text-align:right;padding-right:5px;" value="<%=formatnumber((CANTIDAD),3,,true)%>"/></td>
                      <td>d<%=lin%>o<%=bli%></td>
                    </tr>                 
                    <%li= li + 1%>
                    <%'=rs("come")%>
                    <%if len(trim(rs("come"))) = 0 then texti(X) = texti(X) & " OFI "+ aOfi(x)+ ": " %>
                    <%if left(aCod(i),1) ="9" then %>
                    <!-- Si es crudo hay que acumular las cantidades por color  -->
                        <%if lt2 = "c" then
                            'crudo = left(aCod(i),6)
                            crudo = aCod(i)
                            mass = "exec SP_tnt_rectilineos_ofi_crudo '"&cli&"', '"&crudo&"', '"&aOfi(x)&"' "
                         elseif lt2 = "t" then 
                            mass = "exec SP_tnt_rectilineos_ofi '"&cli&"', '"&aCod(i)&"', '"&aOfi(x)&"' "                        
                        end if%>
                        <%'=mass%>
                        <%rs2.open mass, cnn
                        if rs2.recordcount > 0 then rs2.movefirst
                        tota= 0
                        do while not rs2.eof
                            for u = 0 to 9
                                At = "t"+ cstr(U)
                                AC = "c" + cstr(U)
                                if cint(rs2(AC)) > 0 then 
                                    IF REPARTO >  cint(rs2(AC))  THEN 
                                        if len(trim(rs("come")))    = 0 then  TEXTI(X) = TEXTI(X) + RS2(At) + "/" + cstr(rs2(Ac)) + " "
                                        REPARTO = REPARTO -  cint(rs2(AC)) 
                                        tota = tota + cint(rs2(ac))
                                    else
                                        if len(trim(rs("come")))    = 0 then  TEXTI(X) = TEXTI(X) + RS2(At) + "/" + cStr(reparto) + " "
                                        tota = tota + reparto
                                        reparto = 0
                                    end if
                                    aCan(lin-1) = reparto
                                end if                          
                            NEXT
                            rs2.movenext                           
                        loop 
                        if len(trim(rs("come")))    = 0 then texti(X) = texti(X) & " = " + cstr(tota)
                        'response.write(reparto)
                        rs2.close%>
                        <%else
                            if len(trim(rs("come")))    = 0 then  texti(x) = texti(X) &  cstr(formatnumber((CANTIDAD),3,,true))  & "Kgs."                          
                        end if%> 
                <%end if %>
               
             <%end if%>
             <script language="jscript" type="text/jscript">
             ooo= "COME" + '<%=i%>'
             com = '<%=rs("come")%>'
             texti=''
             if (com.length == 0) 
                texti =  ltrim('<%=texti(x)%>')
             if (texti.length > 0 )
                document.getElementById(ooo).value +=  '<%=texti(x)%>'+'\n'
             </script>
<!------------------------------------------------->            
<!------------------------------------------------->
<!------------------------------------------------->
<!------------------------------------------------->
<!------------------------------------------------->
      <tr style="display:block">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch">Cod Referencia</td>
        <td ><input type="text" id="KOD<%=i%>" name="KOD<%=i%>" value="<%=aCod(i)%>" class="DESCRIPTORES" style="width:100%" readonly tabindex="-1"/></td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="2">&nbsp;</td>      
      </tr>  
<!------------------------------------------------->
<!------------------------------------------------->
<!------------------------------------------------->
<!------------------------------------------------->
        <%NEXT%>
        <%texti=Array(0)%>

      <tr style="display:none">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch">Unidad </td>
        
        <td bgcolor="<%=(Application("BARRA"))%>">&nbsp;</td>
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch">F. Entrega </td>
        <td WIDTH="10%"><input type="text" id="ENT<%=i%>" name="ENT<%=i%>" value="<%=date()%>" class="BARRA333" style="text-align:center; width:100%"  /></td>
    </tr>
    <tr style="display:none">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" >Part Arancelaria </td>
        <td><input id="PAR<%=i%>" name="PAR<%=i%>" class="descriptores" readonly tabindex="-1" /></td>
        <td colspan="3"><input id="ARA<%=i%>" name="ARA<%=i%>" class="DESCRIPTORES" readonly tabindex="-1" style="width:100%" /></td>
    </tr> 
    <tr valign="middle"  style="display:none">
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" >Precio Original </td>
       
        <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="2">&nbsp;</td>
    </tr>
    <tr valign="middle" style="display:none">
      <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" >Solicitante</td>
      <td width="10%" ><input type="text" id="SOLI<%=i%>" name="SOLI<%=i%>" value="<%%>" class="BARRA333" style="width:100%; text-align:left" maxlength="3" value="<%=trim(rs("soli"))%>"/></td>
      <td colspan="3"  bgcolor="<%=(Application("BARRA"))%>">&nbsp;</td>
    </tr>
    <tr valign="middle" style="display:none">
     <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch"  width="20%">C. Costo</td>
     <td colspan="4"><select id="CCTO<%=i%>" name="CCTO<%=i%>" class="DESCRIPTORES">
            <option value =""></option>
            <%CAD = "Select * From RSFACCAR..AL0001TABL Where TG_CCOD='10' Order by TG_CCLAVE" 
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT >0 THEN     RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF%>
            <option value ='<%=RS2("TG_CCLAVE")%>'><%=RS2("TG_CCLAVE")%>&nbsp;&nbsp;<%=RS2("TG_CDESCRI")%></option>
                <%RS2.MOVENEXT
            LOOP
            RS2.CLOSE%>
        </select>
     </td>
 </tr>
 <tr valign="middle" style="display:none">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="2">Dsct. Financiero</td>
  <td width="10%" ><input type="text" id="FINA<%=i%>" name="FINA<%=i%>" value="<%=formatnumber(rs("fina"),2,,true)%>" class="BARRA333" style="width:100%; text-align:right; padding-right:5px;"maxlength="3" onkeyup="this.value=toInt(this.value)" /></td>
  <td colspan="2" bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle" style="display:none">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="1">Dsct. Item</td>
  <td bgcolor="<%=(Application("BARRA"))%>" ><input type="checkbox" id="CHK1<%=i%>" name="CHK1<%=i%>" value="0" class="BARRA333" style="width:100%; text-align:center;"/></td>
  <td width="10%" ><input type="text" id="DITE<%=i%>" name="DITE<%=i%>" value="<%=formatnumber(rs("DITE"),2,,true)%>" class="BARRA333" style="width:100%; text-align:right; padding-right:5px;"maxlength="5" onkeyup="this.value=toInt(this.value)" /></td>
  <td colspan="2" bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle" style="display:none">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="1">Dsct. Adic</td>
  <td bgcolor="<%=(Application("BARRA"))%>" ><input type="checkbox" id="CHK2<%=i%>" name="CHK2<%=i%>" value="0" class="BARRA333" style="width:100%; text-align:center;"/></td>
  <td width="10%" ><input type="text" id="DADI<%=i%>" name="DADI<%=i%>" value="<%=formatnumber(rs("DADI"),2,,true)%>" class="BARRA333" style="width:100%; text-align:right; padding-right:5px;"maxlength="5" onkeyup="this.value=toInt(this.value)" /></td>
  <td colspan="2" bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle" style="display:none">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="1">Incluye IGV</td>
  <td bgcolor="<%=(Application("BARRA"))%>" ><input type="checkbox" id="CHK3<%=i%>" name="CHK3<%=i%>" value="0" class="BARRA333" style="width:100%; text-align:center;" onkeyup="this.value=toInt(this.value)" /></td>
  <td width="10%" ><input type="text" id="IIGV<%=i%>" name="IIGV<%=i%>" value="<%=forMATNUMBER(rs("Iigv"),2,,TRUE)%>" class="descriptores" style="width:100%; text-align:right; padding-right:5px;" readonly tabindex="-1" /></td>
  <td colspan="2" bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
<tr valign="middle" style="display:none">
  <td bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" colspan="1">Incluye ISC</td>
  <td bgcolor="<%=(Application("BARRA"))%>" ><input type="checkbox" id="CHK4<%=i%>" name="CHK4<%=i%>" value="0" class="BARRA333" style="width:100%; text-align:center;"/></td>
  <td width="10%" ><input type="text" id="IISC<%=i%>" name="IISC<%=i%>" value="<%=forMATNUMBER(rs("IiSC"),2,,TRUE)%>" class="descriptores" style="width:100%; text-align:right; padding-right:5px;" readonly tabindex="-1"/></td>
  <td colspan="2" bgcolor="<%=(Application("BARRA"))%>" class="TITULITOch" style="text-align:left">&nbsp;%</td>
</tr>
<%RS.CLOSE%>
<%next%>
</table>


<script type="text/jscript" language="jscript">
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=yes,left=100,top=20,height=600,width=900";


//alert('<%=request.querystring() %>')
function grabar(op,lin) {
    var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
    opc += "menubar=no,resizable=yes,scrollbars=no,left=100,top=20,height=600,width=900";

    var aOfi = new Array()
    var aCan = new Array()
    maxix = parseInt('<%=ubound(aOfi)%>',10)
    bidi = 0

    for (pix = 1; pix <= maxix; pix++) 
    {   pici = trim(pix.toString())
        pic = Right('00'+ pici,2)
        cc = "d" + lin + 'o'+ pic
        ell = document.getElementById(cc);
        //alert(cc)
        if (ell !== null) 
        {   dato = eval("document.all.CAN" +lin + 'x'+ pic + ".value")
            dete = dato.replace(',','')
            if (parseFloat(dete) > 0 ) 
            {   aCan[bidi] = parseFloat(dete)
                aOfi[bidi++] = trim(eval("document.all.OFI" + lin + 'x'+ pic + ".value"));
            }
        }
    }
    //alert(dete)
    // top.window.derecho.grabalinea()
    kad  = '&cod=' +  trim(eval("document.all.COD"+ op+".value"))
    //alert(kad)
    if (trim('<%=ucase(request.QueryString("cla"))%>')== 'S') 
        kad += '&kod=' +  trim(eval("document.all.KOD"+ op+".value"))
    
    kad += '&lin=' +  trim(eval("document.all.LIN"+ op+".value"))
    kad += '&DES=' + ltrim(eval("document.all.DES"+ op+".value"))
    kad += '&COM=' +  Left(eval("document.all.COME"+op+".value"),800)
    kad += '&UNI=' +  trim(eval("document.all.UNI"+ op+".value"))
    kad += '&PAR=' +  trim(eval("document.all.PAR"+ op+".value"))
    kad += '&ARA=' +  trim(eval("document.all.ARA"+ op+".value"))
    kad += '&ENT=' +  trim(eval("document.all.ENT"+ op+".value"))
    kad += '&PED=' + toInt(eval("document.all.PED" + op + ".value"))
    precio = toInt(eval("document.all.PRE"+ op+".value"))
    if (precio == '')
        prec = 0
    else 
        prec = precio

    kad += '&PRE=' + prec
    kad += '&sol=' +  trim(eval("document.all.SOLI"+op+".value"))
    kad += '&cto=' +  trim(eval("document.all.CCTO"+op+".value"))
    kad += '&FIN=' + toInt(eval("document.all.FINA"+op+".value"))
    kad += '&DCT=' + toInt(eval("document.all.DITE"+op+".value"))
    kad += '&ADI=' + toInt(eval("document.all.DADI"+op+".value"))
    kad += '&IGV=' + toInt(eval("document.all.IIGV"+op+".value"))
    kad += '&ISC=' + toInt(eval("document.all.IISC"+op+".value"))
    kad += '&ch1=' +  trim(eval("document.all.CHK1"+op+".value"))
    kad += '&ch2=' +  trim(eval("document.all.CHK2"+op+".value"))
    kad += '&ch3=' +  trim(eval("document.all.CHK3"+op+".value"))
    kad += '&ch4=' +  trim(eval("document.all.CHK4"+op+".value"))
    kad += '&can=' +  aCan
    kad += '&ofi=' +  aOfi
    kad += '&al2=' +  '<%=request.QueryString("al2")%>'
    kad += '&lt2=' +  '<%=request.QueryString("lt2")%>'
    kad += '&cla=' +  '<%=request.QueryString("cla")%>'
   
    kad += '&hi1=' +  '<%=hi1%>'
    kad += '&hi2=' +  '<%=hi2%>'
    kad += '&hi3=' +  '<%=hi3%>'
    kad += '&hi4=' +  '<%=hi4%>'
    kad += '&hi5=' +  '<%=hi5%>'
    kad += '&hi6=' +  '<%=hi6%>'


    cad = 'comun/inserOCLINnew.asp?OC=' + trim('<%=trim(oc)%>')
/*
    document.all.Iframe1.style.display = 'block'
    document.all.Iframe1.height = "350"
    document.all.Iframe1.width = "100%"
*/
    //alert(kad)  
    document.all.Iframe1.src = cad + kad
   return true;
}
function pasa(obj, lin)
{   maxi='<%=i%>'

    for (o=0 ; o<maxi; o++)
    { DATO = "lin"+o.toString()
      obj = document.getElementById(DATO)
      obj.style.backgroundColor='transparent'
    }

DAT = "lin"+lin.toString()
obj = document.getElementById(DAT)
obj.style.backgroundColor='#f7d975'
 
ALM = '<%=request.QueryString("al2")%>'
COD = '<%=request.QueryString("cod")%>'
CAN = '<%=request.QueryString("CAN")%>'
OFI = '<%=request.QueryString("OFI")%>'
LT2 = '<%=request.QueryString("LT2")%>'
LT1 = '<%=request.QueryString("LT1")%>'
cad = 'ofilinOCnew.asp?OC=' + '<%=OC%>'
cad += '&lin=' + (parseInt(lin,10)+1)
cad += '&cod=' + COD
cad += '&CAN=' + CAN
cad += '&ofi=' + OFI
cad += '&alm=' + ALM
cad += '&lt2=' + LT2
cad += '&lt1=' + LT1
cad += '&hi1=' +  '<%=hi1%>'
cad += '&hi2=' +  '<%=hi2%>'
cad += '&hi3=' +  '<%=hi3%>'
cad += '&hi4=' +  '<%=hi4%>'
cad += '&hi5=' +  '<%=hi5%>'
cad += '&hi6=' +  '<%=hi6%>'
cad += '&ki1=' +  '<%=ki1%>'
cad += '&ki2=' +  '<%=ki2%>'
cad += '&ki3=' +  '<%=ki3%>'
cad += '&ki4=' +  '<%=ki4%>'
cad += '&ki5=' +  '<%=ki5%>'
cad += '&ki6=' +  '<%=ki6%>'
cad += '&cla=' +  '<%=request.QueryString("cla")%>'


//alert(cad)


top.window.derecho.location.replace(cad)
}
window.onbeforeunload = confirmExit;
function confirmExit() {
masi = parseInt('<%=i%>',10)
//alert(masi)
conta = 0
for (p=0; p<masi; p++)
 {  
    if (parseFloat(toInt(eval("document.all.PRE"+ p+".value"))) > 0)
         conta ++
 }
    
    
if (conta == p)
    return window.close()
else
    return "Falta PRECIO de alguna línea...";
}


</script>
<%	
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>