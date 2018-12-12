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
<%	oc = Request.QueryString("Oc")
    LIN = Request.QueryString("LIN")
    if trim(oc) = "" then oc  = "AUTO"
    if trim(lin)= "" then lin = "0001"
    cod =  request.QueryString("cod")
    kod =  request.QueryString("kod") 
    can =  request.QueryString("can")
    ofi =  request.QueryString("ofi") 
    alm =  request.QueryString("alm") 
    al2 =  request.QueryString("al2") 
    al1 =  request.QueryString("al1") 
    lt2 =  request.QueryString("lt2") 
    lt1 =  request.QueryString("lt1") 
    ser =  request.QueryString("ser") 
    cla =  request.QueryString("cla")
    hi1 =  request.QueryString("hi1")
    hi2 =  request.QueryString("hi2")
    hi3 =  request.QueryString("hi3")
    hi4 =  request.QueryString("hi4")
    hi5 =  request.QueryString("hi5")
    hi6 =  request.QueryString("hi6")
    ki1 =  request.QueryString("ki1")
    ki2 =  request.QueryString("ki2")
    ki3 =  request.QueryString("ki3")
    ki4 =  request.QueryString("ki4")
    ki5 =  request.QueryString("ki5")
    ki6 =  request.QueryString("ki6")
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

  
	Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
   
    cad = " EXEC OC_LIN_OFI '"&OC&"', '"&LIN&"' "  
	 ' response.Write(cAD)
	rs.open cad, cnn
	IF RS.RecordCount > 0 THEN
		RS.MOVEFIRST
    else
        ofi =  ""       
        cad = "select nom from view_ofis where ofi = '"&aOfi(0)&"'"
        rs2.open cad,cnn
        nom= rs2("nom")
        rs2.close
	END IF
%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title>FICHA O/C</title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />
</head>
<body style="margin-left:0px; margin-top:0px; margin-right:0px;">
<form id="thisForm" method="post" name="thisForm" action="">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr valign="middle" > 
        <td align = "left" class="TALASBLUE" width="60%">
        <table cellpadding="10" cellspacing="1" border="1" bgcolor="#f7d975" width="100%">
		    <tr><td align="left" class="talasblue" width="100%">OFIS <font size="1">Linea <%=LIN%> OC=<%=oc%></font></td></tr>
        </table>
        </td>      
        <td align="center"><img src="imagenes/disk.gif" alt="GRABA" style="cursor:pointer" onclick="graba()" /></td>
        <td width="15%" align="right"><img src="imagenes/LOGO.gif" style="cursor:pointer;" onClick="top.window.close()" /></td>	
    </tr>
</table>  

<table align="center" bordercolor="<%=application("color1")%>" bgcolor="<%=application("color2")%>" cellpadding="1" style="border-style:hidden; width:100%" cellspacing="0" border="1">
   <tr>
       <td colspan="4"> 
        <table cellpadding="5" cellspacing="0" border="0" bgcolor='<%=APPLICATION("FONDITO") %>' bordercolor='<%=APPLICATION("COLOR2") %>' width="100%">
    <tr align="left" class="tituloGRANDEorange" > <td width="10%">Id</td>
    <td width="20%">OFI</td><td width="20%">Cant</td><td width="50%">CLIENTE</td></tr></table>
       </td>
   </tr>
   <%rec=0%>
   <%if rs.recordcount > 0 then%>
       <%DO  WHILE NOT RS.EOF %>
        <!-- ESTO DE CUANDO VIENE PRE-GRABADO -->
            <tr id="LIN<%=rec%>" style="display:block">
                <td width="10%">
                    <input id="LDET<%=rec%>" name="LDET<%=rec%>" class="DESCRIPTORES" style="width:100%; text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(rec+1))),2) %>'/>
                </td>
                <td width="20%">
                    <input id="OFI<%=rec%>" name="OFI<%=rec%>" class="descriptores" style="width:100%;" value="<%=rs("ofi")%>" readonly tabindex="-1""/>
                </td>
                <td width="20%">
                    <input id="CAN<%=rec%>" name="CAN<%=rec%>" class="descriptores"  readonly tabindex="-1"
                    style="width:100%;text-align:right;padding-right:5px;" value="<%=formatnumber(rs("can"),3,,true)%>"/>
                </td>
                <td width="50%">
                    <input id="CLI<%=rec%>" name="CLI<%=rec%>" class="DESCRIPTORES" value="<%=rs("nom") %>" style="width:100%;" readonly tabindex="-1"/>
                </td>
            </tr> 
            <%RS.MOVENEXT%>
            <%rec= rec+1%>
        <%LOOP %>
      <%ELSE%>
      <!-- BARRE EL ARRAY DE OFIS A DONDE HAY QUE REPARTIR LA CANTIDAD TOTAL -->
      <%li=1 %>
      <%if ucase(cla) = "S" then 
        reparto = cdbl(aki1(lin-1))+cdbl(aki2(lin-1))+cdbl(aki3(lin-1))+cdbl(aki4(lin-1))+cdbl(aki5(lin-1))+cdbl(aki6(lin-1))
        cantidad = reparto%>
        <tr id="LIN<%=li%>" style="display:block">
                        <td width="10%"><input id="LDET<%=li%>" name="LDET<%=li%>" class="DESCRIPTORES" style="width:100%; text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(li))),2) %>'/></td>
                        <td width="20%"><input id="OFI<%=li%>"  name="OFI<%=li%>"  class="DESCRIPTORES" style="width:100%;" value="<%=aOfi(i)%>"  readonly tabindex="-1" /></td>
                        <td width="20%"><input id="CAN<%=li%>"  name="CAN<%=li%>"  class="DESCRIPTORES"  readonly tabindex="-1" 
                        style="width:100%;text-align:right;padding-right:5px;" value="<%=formatnumber(CANTIDAD,3,,true)%>"/></td>
                        <td width="50%"><input id="CLI<%=li%>"  name="CLI<%=li%>"  class="DESCRIPTORES" value="<%=nom%>" style="width:100%;" readonly tabindex="-1"/></td>
                    </tr> 

<%li= li + 1%>
      <%else%>

        <%FOR I=0 TO UBOUND(AOFI) %>
            <% Redim preserve texti(X+1)
            cantidad = 0
            REPARTO=aCan(lin-1)
 
            QTY = 0
            if ucase(cla) = "S" then
                if ucase(lt1) = "H" then
                    cad =   " select  ISNULL(sum(k1),0) AS K1, ISNULL(sum(k2),0) AS K2, " & _
                            " ISNULL(sum(k3),0) AS K3, ISNULL(sum(k4),0) AS K4,         " & _
                            " ISNULL(sum(k5),0) AS K5, ISNULL(sum(k6),0) AS K6,         " & _
                            " QTY=0 from EXPLOSION_TELA                                 " & _
                            " where  OFI = '"&aOfi(i)&"' AND crudo=left('"&aCod(LIN-1)&"',6)" & _
                            " group by crudo                                        "          
                end if
            else
                if ucase(lt2)= "H" then 
                    cad = " select ISNULL(sum(k1),0) ,QTY=0 from EXPLOSION_TELA         " & _
                          " where  OFI = '"&aOfi(i)&"' AND '"&aCod(LIN-1)&"' = h1       " & _
                          " group by qty                                                " & _
                          " UNION select ISNULL(sum(k2),0), QTY=0 from EXPLOSION_TELA   " & _
                          " where  OFI = '"&aOfi(i)&"' AND '"&aCod(LIN-1)&"' = h2       " & _
                          " group by qty                                                " & _
                          " UNION select ISNULL(sum(k3),0), QTY=0 from EXPLOSION_TELA   " & _
                          " where  OFI = '"&aOfi(i)&"' AND '"&aCod(LIN-1)&"' = h3       " & _
                          " group by qty                                                " & _
                          " UNION select ISNULL(sum(k4),0), QTY=0 from EXPLOSION_TELA   " & _
                          " where  OFI = '"&aOfi(i)&"' AND '"&aCod(LIN-1)&"' = h4       " & _
                          " group by qty                                                " & _
                          " UNION select ISNULL(sum(k5),0), QTY=0 from EXPLOSION_TELA   " & _
                          " where  OFI = '"&aOfi(i)&"' AND '"&aCod(LIN-1)&"' = h5       " & _
                          " group by qty                                                " & _
                          " UNION select ISNULL(sum(k6),0), QTY=0 from EXPLOSION_TELA   " & _
                          " where  OFI = '"&aOfi(i)&"' AND '"&aCod(LIN-1)&"' = h6       " & _
                          " group by qty                                                " 
                
                elseif ucase(lt2)= "T" then 
                    cad = " select ISNULL(sum(kgs),0), qty= case when left(tela,1) ='9' " & _
                          " then isnull(sum(qty),0) else 0 end  from EXPLOSION_TELA     " & _  
                          " where  OFI = '"&aOfi(i)&"' AND '"&aCod(LIN-1)&"' = tela     " & _
                          " group by tela                                               "
                else
                    cad = " select ISNULL(sum(kgsteje),0), qty= case when left(crudo,1)  " & _
                          " ='9' then isnull(sum(qty),0) else 0 end from EXPLOSION_TELA  " & _  
                          " where OFI = '"&aOfi(i)&"' AND crudo=left('"&aCod(LIN-1)&"',6)" & _
                          " group by crudo                                               "
                end if   
           end if             
           ' RESPONSE.WRITE(CAD)
            RS2.OPEN CAD, CNN
            IF RS2.RECORDCOUNT > 0 THEN RS2.MOVEFIRST
            DO WHILE NOT RS2.EOF
                CANTIDAD = CANTIDAD + CDBL(RS2.FIELDS.ITEM(0))
                QTY = QTY + CDBL(RS2.FIELDS.ITEM(1))
                RS2.MOVENEXT
            LOOP
            RS2.CLOSE
           if cantidad > 0 then
                if ucase(cla) = "S" then
                    cad2 =  " select isnull(sum(kgs),0), isnull(sum(qty),0) from rsv_tela where almdes= '"&alm&"' and   " & _
                            " OFI = '"&aOfi(i)&"' and ( codigo = '"&aHi1(lin-1)&"' or codigo = '"&aHi2(lin-1)&"'        " & _
                            " or codigo = '"&aHi3(lin-1)&"' or codigo = '"&aHi4(lin-1)&"' or codigo = '"&aHi5(lin-1)&"' " & _
                            " or codigo = '"&aHi6(lin-1)&"'  ) and  tipo = '"&lt1&"'      " 
                 else   
                    
                    cad2 =  " select isnull(kgs,0), isnull(qty,0) from rsv_tela where alm= '"&alm&"'  and   " & _
                            " OFI = '"&aOfi(i)&"' and codigo = '"&acod(lin-1)&"' and  tipo = '"&lt2&"'      " 
                 END IF ' del CLA = S    
             
               ' response.write(can2)
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

                if ucase(cla) = "S" then
                    cantidad = cdbl(aki1(lin-1))+cdbl(aki2(lin-1))+cdbl(aki3(lin-1))+cdbl(aki4(lin-1))+cdbl(aki5(lin-1))+cdbl(aki6(lin-1))
               '     cantidad = cantidad - can2
                ELSE
                 ' CANTIDAD = NETO ENTRE LO REQUERIDO MENOS LO RESERVADO
                cantidad = cantidad - can2
                qty = qty - qty2
                ' REPARTO = LO QUE HAY QUE DISTRIBUIR
                       
                if qty > 0 then 
                   cantidad = qty  
                end if
               'response.write(cantidad)
                if reparto <= 0 then 
                   if ucase(cla) = "C" then  
                        cantidad = aCan(lin-1)  
                        aCan(lin-1) = 0
                  end if     
                else
                    aCan(lin-1) = aCan(lin-1)  - cantidad
                end if 
                
                'response.write(cantidad)
                END IF ' DEL CLA = S          
                %>  
                
               
                <!-- hay que restar lo reservado de lo solicitado-->
                <%if cantidad > 0  then %> 
                    <%if cdbl(cantidad) > cdbl(reparto) then 
                        cantidad=reparto
                    end if%>
                  
                   <%if cdbl(cantidad) > 0 then %>
                    <tr id="LIN<%=li%>" style="display:block">
                        <td width="10%"><input id="LDET<%=li%>" name="LDET<%=li%>" class="DESCRIPTORES" style="width:100%; text-align:center" readonly tabindex="-1" value='<%=right("00"+ltrim(rtrim(cstr(li))),2) %>'/></td>
                        <td width="20%"><input id="OFI<%=li%>"  name="OFI<%=li%>"  class="DESCRIPTORES" style="width:100%;" value="<%=aOfi(i)%>"  readonly tabindex="-1" /></td>
                        <td width="20%"><input id="CAN<%=li%>"  name="CAN<%=li%>"  class="DESCRIPTORES"  readonly tabindex="-1" 
                        style="width:100%;text-align:right;padding-right:5px;" value="<%=formatnumber(CANTIDAD,3,,true)%>"/></td>
                        <td width="50%"><input id="CLI<%=li%>"  name="CLI<%=li%>"  class="DESCRIPTORES" value="<%=nom%>" style="width:100%;" readonly tabindex="-1"/></td>
                    </tr> 
                    <%li= li + 1%>
                    <%end if %>
                 <%end if%>
            <%end if%>
        <%NEXT%>

                
      <%end if 'del CLA del inicio %>

        <%REC = I%>
      <%END IF%>

<tr>
    <td width="30%" colspan="2" class="TITULITOCH" align="right">CANTIDAD TOTAL : &nbsp;&nbsp;</td>
        
        <td width="20%"><input id="TOTAL" name="TOTAL" class="descriptores" style="width:100%; text-align:right; padding-right:5px;" value="0.000" readonly tabindex="-1" /></td>
        <td width="50%">&nbsp;</td>
    </tr> 
</table> 
<table cellpadding="0" cellspacing="0" border="1" style="border-color:'<%=APPLICATION("COLOR2") %>'; width:100%" align="center" >
  
</table>

<table width="100%"><tr><td style=" height:1px"></td></tr></table>
<table width="100%">
  <tr><td style=" height:1px"></td></tr></table>
<iframe  width="100%" style="display:none; width:100%;" src="" id="body10" name="body10" scrolling="yes" frameborder="0" ></iframe>
<input id="verif" name="verif" value="0" style="display:none" />

<script type="text/jscript" language="jscript">
var ss = trim('<%=request.querystring("opp")%>')

    suma()


function suma() {
    maxi = parseInt('<%=li-1%>', 10)
//alert(maxi)
    tot = 0
    cla = '<%=ucase(cla)%>'
    if (cla == 'S')
        return true

    pofi = 'Para las Ofis: '
    for (pi = 1; pi <= maxi; pi++) {
        if (eval("document.all.LIN" + pi + ".style.display") == 'block') {
            mini = "CAN" + pi.toString()

            algo = toInt(document.getElementById(mini).value)
            document.getElementById(mini).value = algo
            tt = parseFloat(toInt(algo));
            //alert(algo)
            FF = addCommas(cerea(FormatNumber(toInt(redondea(tt, 3)), 3, false, false, true, true), 3))
            eval("document.all.CAN" + pi + ".value=FF")
            //alert(tt);
            tot += tt;
            bibi = "OFI" + pi.toString()  
            pofi += document.getElementById(bibi).value + ', '
        }
    }
    dd = addCommas(redondea(tot, 3))
    document.all.TOTAL.value = dd
    z = parseInt('<%=lin%>', 10) - 1
   // alert(z)
    kko = eval("trim(top.window.izquierdo.document.all.COD" + z + ".value)")
    ddo = eval("trim(top.window.izquierdo.document.all.DES" + z + ".value)")
    lnn = eval("trim(top.window.izquierdo.document.all.LIN" + z + ".value)")
    obs = Left(pofi,pofi.length-2)
 //   top.window.opener.window.updates(dd, kko, ddo, lnn)
     if (ss.length == 0)
        {  eval("top.window.izquierdo.document.all.PED"+z+".value = dd")
            dito =  Left(kko,1) 
            if (dito != '9')
           {  //  alert()
             eval("top.window.izquierdo.document.all.COME" + z + ".value = obs") }
        }
}


</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>