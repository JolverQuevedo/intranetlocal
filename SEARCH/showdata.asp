<%@ Language=VBScript %>
<%Response.Buffer = true %>
<%Session.LCID=2057%>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->

<script language="jscript" type="text/jscript">

    function autofitIframe(id) {
        if (!window.opera && document.all && document.getElementById) {
            id.style.height = id.contentWindow.document.body.scrollHeight;
        } else if (document.getElementById) {
            id.style.height = id.contentDocument.body.scrollHeight + "px";
        }
    }

</script>

<%
Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 	
ofi = request.QUERYSTRING("ofi")
' revisa si tiene explosion para crear o para mostrary lo redirecciona
cod = request.QueryString("COD")
tip = request.QueryString("tip")
MOV = request.QueryString("MOV")
ORI = request.QueryString("ORI")
DES = request.QueryString("DES")
OLD = request.QueryString("OLD")
SER = request.QueryString("SER")
ENT = request.QueryString("ENT")
REC = request.QueryString("REC")
LT1 = request.QueryString("LT1")
LT2 = request.QueryString("LT2")
cnt = request.QueryString("cnt")
cC2 = request.QueryString("aC2")
cQ2 = request.QueryString("aQ2")
cK2 = request.QueryString("aK2")
cD2 = request.QueryString("aD2")
ac2 = split(cC2,",")
aQ2 = split(cQ2,",")
aK2 = split(cK2,",")
aD2 = split(cD2,",")
cC1 = request.QueryString("aC1")
cQ1 = request.QueryString("aQ1")
cK1 = request.QueryString("aK1")
cD1 = request.QueryString("aD1")
ac1 = split(cC1,",")
aQ1 = split(cQ1,",")
aK1 = split(cK1,",")
aD1 = split(cD1,",")

response.write(cC1)
response.write("<br>")
cSql = request.cookies("cSql")

cSql = right(cSql, len(csql)-10)
dato = ""
grupo = ""
if lcase(lt2) = "c" then ' compra de tela cruda 
    dato = "crudo " 
    grupo =  "sum(kgsteje) as KGS_crudo , case when left(crudo,1) ='9' then sum(qty) else 0 end as qty"
elseif lcase(lt2) = "t" then
    dato = "tela " 
    grupo = "sum(kgs) as kgs_tela, case when left(tela,1) ='9' then sum(qty) else 0 end as qty"
else
    dato = "h1, h2, h3, h4, h5, h6 "
    grupo = "sum(k1) as k1, sum(k2) as k2, sum(k3) as k3, sum(k4) as k4, sum(k5) as k5, sum(k6) as k6, 0 as qty "
end if

kad = "select ofi, po, " + dato+ ", " + grupo + " " + cSql + " group by  ofi, po," + dato + " ORDER BY " + dato


'response.write(kad)

RS.OPEN (KAD),CNN
IF RS.RECORDCOUNT> 0 THEN RS.MOVEFIRST
COLUMNAS = RS.FIELDS.COUNT-1
%>
<body >
<form id="thisForm" method="post" name="thisForm" action="">
<!--*****************************************************************************-->
<!------------- D E T A L L E      A     N I V E L      D E       O F I ----------->
<!--*****************************************************************************-->
<!--------------------------------------------------------------------------------->
<!-------------------- CUANDO ES COMPRA DE PRODUCTO FINAL ------------------------->
<!--------------------------------------------------------------------------------->

<%if ucase(trim(TIP)) = "C" then%>

<table align="center" cellspacing="0" border="1" cellpadding="0" id="detaC" name="detaC" style="display:block">
        <tr><td align="center" colspan="<%=columnas+1 %>"  width="90%" class="tituloGRANDEorange" style="padding-left:10px;padding-right:10px;padding-top:10px;padding-bottom:10px;">Detalle para OC PRODUCTO FINAL</td>
        </tr>
        <tr>
            <%FOR I=0 TO COLUMNAS%>
            <td class="tituloGRANDEgris" style="text-align:center"><%=trim(ucase(rs.fields(i).name))%></td>
            <%NEXT%>
        </tr>
        <%ATOT = Array(null,null, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)%>
        <%DO WHILE NOT RS.EOF%>  
            <tr style="padding-right:10px; padding-left:10px;" >
            <%FOR d=0 TO COLUMNAS%>
                <%  texto = ucase(RS.FIELDS.ITEM(d))%>
                <td <%if d>2 then%> style="text-align:right; padding-right:10px;"<%end if%> class="textogris4" >
                <%IF ISNUMERIC(TEXTO) = true and d> 2 THEN 
                    if  cdbl(texto) > 0 then RESPONSE.WRITE formatnumber(RS.FIELDS.ITEM(d),3,,,true) else response.write("&nbsp;")
                        aTot(d) = aTot(d) + cdbl(RS.FIELDS.ITEM(d))
                    ELSE 
                    RESPONSE.WRITE("&nbsp;"+TEXTO)
                        end if%></td>
            <%NEXT %>
            </tr>
            <%RS.movenext%>
        <%loop%>
        <tr style="padding-right:10px; padding-left:10px;background-color:gainsboro; display:NONE" >
            <%FOR e=0 TO COLUMNAS%>
                <td <%if e>2 then%> style="text-align:right; padding-right:10px;"<%end if%> class="textogris4" >
                <%if aTot(e)<> 0 then response.Write(formatnumber(atot(e),3,,,true))else response.write("&nbsp;")%></td>
            <%NEXT %>
        </tr>
</table>
<!--------------------------------------------------------------------->
<!------------- CUANDO ES UN SERVICIO DE TRANSFORMACION --------------->
<!--------------------------------------------------------------------->        
    <%else%>
   <table align="center" cellspacing="0" border="1" cellpadding="0" id="detaS" name="detaS" style="display:block">
        <tr><td align="center" colspan="<%=columnas+1 %>"  width="90%" class="tituloGRANDEorange" style="padding-left:10px;padding-right:10px;padding-top:10px;padding-bottom:10px;">Detalle para OC PRODUCTO FINAL</td>
        </tr>
        <tr>
            <%FOR I=0 TO COLUMNAS%>
            <td class="tituloGRANDEgris" style="text-align:center"><%=trim(ucase(rs.fields(i).name))%></td>
            <%NEXT%>
        </tr>
        <%ATOT = Array(null,null, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)%>
        <%DO WHILE NOT RS.EOF%>  
            <tr style="padding-right:10px; padding-left:10px;" >
            <%FOR w=0 TO COLUMNAS%>
                <%  texto = ucase(RS.FIELDS.ITEM(w))%>
                <td <%if w>2 then%> style="text-align:right; padding-right:10px;"<%end if%> class="textogris4" >
                <%IF ISNUMERIC(TEXTO) = TRUE and I> 2 THEN 
                    if  cdbl(texto) > 0 then RESPONSE.WRITE formatnumber(RS.FIELDS.ITEM(w),3,,,true) else response.write("&nbsp;")
                        aTot(w) = aTot(w) + cdbl(RS.FIELDS.ITEM(w))
                    ELSE 
                    RESPONSE.WRITE("&nbsp;"+TEXTO)
                        end if%></td>
            <%NEXT %>
            </tr>
            <%RS.movenext%>
        <%loop%>
        <tr style="padding-right:10px; padding-left:10px;background-color:gainsboro; display:none;" >
            <%FOR I=0 TO COLUMNAS%>
                <td <%if i>2 then%> style="text-align:right; padding-right:10px;"<%end if%> class="textogris4" >
                <%if aTot(I)<> 0 then response.Write(formatnumber(atot(i),3,,,true))else response.write("&nbsp;")%></td>
            <%NEXT %>
        </tr>
</table>
<%end if %>
   
 <!--   Hay QUE ver en la tabla de ofis si tiene marca de EXP_TEL para calcular las mermas de hilo y tejido
        sinó todo queda tal cual -->    

<p></p>


<!--------------------------------------------------------------------------------->
<!------------- DATOS RESUMIDOS PARA EMITIR LA ORDEN DE COMPRA -------------------->
<!--------------------------------------------------------------------------------->     

<%if ucase(trim(TIP)) = "C" then%>

            <table align="center" cellspacing="1" border="1" cellpadding="3" id="resumenC" name="resumenC" style="display:block" >
              <tr><td height="60px;" colspan="16" class="tituloMODELADOR">ORDEN DE  <%=mov %>         </td></tr>
           
                <tr style="text-align:center">
                    <td style="text-align:center; background-color:#826f39;color:#fff;FONT-WEIGHT: 700;FONT-SIZE: 12px;FONT-FAMILY: Arial;TEXT-ALIGN: CENTER; " >RSV</td>
                    <td style="text-align:center" class="tituloGRANDEVERDE">CODIGO</td>
                    <td style="text-align:center" class="tituloGRANDEVERDE">DESCRIPCION</td>
                    <td style="text-align:center" class="tituloGRANDEVERDE">KGS</td>
                    <td style="text-align:center" class="tituloGRANDEVERDE">QTY</td>
                    <td style="text-align:center" class="tituloGRANDEROJO">U.M.</td>
                    <td style="text-align:center" class="tituloGRANDEROJO">STK</td>
                    <td style="text-align:center" class="tituloGRANDEROJO">ALM</td>
                    <td style="text-align:center" class="tituloRESUMEN">SUGERIDO</td>
                    <td style="text-align:center;background-color:#826f39; color:#fff;FONT-WEIGHT: 700;FONT-SIZE: 12px;FONT-FAMILY: Arial;TEXT-ALIGN: CENTER; ">OC</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">ULT. O/C</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">CAN</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">US$</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">RUC</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">PROVEEDOR</td>
                    <td style="text-align:center" class="tituloGRANDEgris33">ULT COMPRA</td>
                </tr>
            
                     <%FOR I= 0 TO UBOUND(aC2)%>     
                     <%RS.CLOSE
                           if len(trim(ac2(i))) < 16 and lt2 = "h" then 
                                ac2(i) = left(trim(ac2(i))+"000000000000",12) 
                            else
                                ac2(i) = left(trim(ac2(i))+"000000000000000",16) 
                            end if
                        CAD = " SELECT SK_NSKDIS, SK_CALMA,                                                                                         " & _
                              " OC  = (SELECT TOP 1 OC_CNUMORD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " CAN = (SELECT TOP 1 OC_NCANORD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " PRE = (SELECT TOP 1 OC_NPREUNI FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " UND = (SELECT TOP 1 OC_CUNIDAD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&ac2(i)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " RUC = (SELECT TOP 1 OC_CCODPRO FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&AC2(I)&"' ORDER BY OC_CNUMORD DESC), " & _
                              " PRO = (SELECT top 1 OC_CRAZSOC FROM RSFACCAR..CO0001MOVC AS AA INNER JOIN RSFACCAR..CO0001MOVD AS SS ON             " & _
                              " SS.OC_CNUMORD = AA.OC_CNUMORD AND AA.OC_CCODPRO = SS.OC_CCODPRO where ss.OC_CCODIGO = '"&ac2(i)&"' and              " & _
                              " aa.OC_CNUMORD = (SELECT TOP 1 OC_CNUMORD FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO =  '"&AC2(I)&"'                 " & _
                              " ORDER BY OC_CNUMORD DESC) ),                                                                                        " & _
                              " fec = (SELECT TOP 1 OC_dfecdoc FROM RSFACCAR..CO0001MOVD WHERE OC_CCODIGO = '"&ac2(i)&"' ORDER BY OC_CNUMORD DESC)  " & _
                              " FROM RSFACCAR..AL0001STOC WHERE SK_CALMA IN ('"&DES&"', '"&OLD&"' ) AND SK_CCODIGO = '"&AC2(I)&"'                   " 
                        '*********************************************************
                        '    FALTA RESTAR LA CANTIDAD QUE YA ESTÁ COMPROMETIDA
                        '*********************************************************

                        'response.write(cad)
                        RS.OPEN CAD,CNN%>
                          <tr  class="TEXTO4" id="lin<%=i%>">
                            <td ><input id="ch<%=I%>" type ="checkbox" style="display:block;">&nbsp;</td>
                            <td style="text-align:left;  background-color:#CFFEDD" id="c<%=i%>" ><%=TRIM(ac2(i))%></td>
                            <td style="text-align:left;  background-color:#CFFEDD" id="d<%=i%>"><%=TRIM(aD2(i))%></td>
                            <td style="text-align:right; background-color:#CFFEDD" id="k<%=i%>"><%=FORMATNUMBER(TRIM(ak2(i)),3,,,TRUE)%></td>
                            <td style="text-align:right; background-color:#CFFEDD" id="q<%=i%>">                            
                                <!-- DEPENDE SI HAY CANTIDAD ES PORQUE HAY RECTILINEO POR UNIDADES  -->
                                <%IF aq2(i) <> 0 THEN  response.write(FORMATNUMBER(TRIM(aq2(i)),0,,,TRUE)) ELSE response.write("&nbsp;")%></td>                       
                        <% IF RS.RECORDCOUNT > 0 THEN %>  <!-- ES PORQUE ENCONTRO DATOS EN EL ARCHIVO DE STOCKS.... -->
                            <td style="text-align:right; background-color:#FCE0F9" id="u<%=i%>"><%=TRIM(RS("UND"))%></td>          
                            <td style="text-align:right; background-color:#FCE0F9;cursor:pointer;" ondblclick="partida('a','<%=i%>')" id="s<%=i%>" >
                            <%if UCASE(trim(RS("UND"))) = "UND" THEN response.write(FORMATNUMBER(TRIM(CDBL(RS("SK_NSKDIS"))),0,,,TRUE)) else response.write(FORMATNUMBER(TRIM(CDBL(RS("SK_NSKDIS"))),3,,,TRUE))%>
                            <!-- VERIFICA SI ES EL ALMACEN NUEVO PARA HACER EL SUGERIDO SI ES EL ANTIGUO, LO MUESTRA SOLO COMO AYUDA REFERENCIAL -->
                            <%if ucase(trim(rs("sk_calma"))) = ucase(trim(des)) THEN%>
                                <%IF  aq2(i) <> 0 THEN 
                                        SUGE = CDBL(TRIM(aQ2(i))) - CDBL(RS("SK_NSKDIS")) 
                                       if suge < 0 then suge = "" else suge = FORMATNUMBER(CDBL(SUGE),3,,,TRUE)
                                ELSE 
                                    SUGE = CDBL(TRIM(ak2(i))) - CDBL(RS("SK_NSKDIS"))
                                    if suge < 0 then suge = "" else suge = FORMATNUMBER(CDBL(SUGE),3,,,TRUE)
                                END IF%>
                            <%ELSE%>
                                <%IF  aq2(i) <> 0 THEN 
                                        SUGE = CDBL(TRIM(aQ2(i)))
                                       if suge < 0 then suge = "" else suge = FORMATNUMBER(CDBL(SUGE),3,,,TRUE)
                                ELSE 
                                    SUGE = CDBL(TRIM(ak2(i))) 
                                    if suge < 0 then suge = "" else suge = FORMATNUMBER(CDBL(SUGE),3,,,TRUE)
                                END IF %>
                            <%END IF%>                          
                            </td>
                            <td style="text-align:right; background-color:#FCE0F9" id="a<%=i%>"><%=TRIM((RS("SK_CALMA")))%></td>
                            <td style="text-align:right; background-color:#C1D3FF;">
                            <input type="text" value="<%=suge%>" class="DATOSceleste" id="sug<%=i%>" style="text-align:right; padding-right:20px;" onchange="valida(this,'<%=i%>')"  onfocus="seleccionar(this)" /></td>
                            <td><input id="co<%=i%>" type ="checkbox"></td>
                            <td style="text-align:left ; background-color:#E5E5E5"><%=TRIM(RS("OC"))%></td>
                             <%if isnull(RS("CAN")) then can= 0 else can = CDBL(RS("CAN")) %>
                            <td style="text-align:right; background-color:#E5E5E5"><%=FORMATNUMBER(can,3,,,TRUE)%></td>
                             <%if isnull(RS("pre")) then can= 0 else can = CDBL(RS("pre")) %>
                            <td style="text-align:right; background-color:#E5E5E5"><%=FORMATNUMBER(can,2,,,TRUE)%></td>
                            <td style="text-align:left ; background-color:#E5E5E5"><%=TRIM(RS("RUC"))%></td>
                            <td style="text-align:left ; background-color:#E5E5E5"><%=TRIM(RS("PRO"))%></td>
                             <%if isnull(RS("fec")) then fec= "" else fec =formatdatetime(rs("fec"),2) %>
                            <td style="text-align:left ; background-color:#E5E5E5"><%=fec%></td>
                        <%else %>
                            <td style="text-align:right; background-color:#FCE0F9">&nbsp;</td>
                            <td style="text-align:left ; background-color:#FCE0F9">&nbsp;</td>
                            <td style="text-align:right; background-color:#FCE0F9">&nbsp;</td>
                            <td style="text-align:right; background-color:#C1D3FF;" ondblclick="partida('a','<%=i%>')" id="s<%=i%>"  >
                            <input type="text" value="<%=FORMATNUMBER(TRIM(ak2(i)),3,,,TRUE)%>" class="DATOSceleste" id="sug<%=i%>" style="text-align:right;padding-right:20px;" 
                             onchange="valida(this,'<%=i%>')"  onfocus="seleccionar(this)"/></td>
                            <td><input id="oc<%=i%>" type ="checkbox"></td>
                            <td style="text-align:right; background-color:#E5E5E5">&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5">&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5">&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5">&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5">&nbsp;</td>
                            <td style="text-align:left ; background-color:#E5E5E5">&nbsp;</td>
                        <%END IF %>
                          </tr>
                        <%IF RS.RECORdCOUNT >1 THEN 
                            RS.MOVENEXT %>
                      
                           <tr  class="TEXTO4" id="ln<%=i%>">
                                <td><input id="cc<%=i%>" type ="checkbox">&nbsp;</td>
                                <td style="text-align:left;  background-color:#CFFEDD; color:green;" id="ca<%=i%>">&nbsp;</td>
                                <td style="text-align:left;  background-color:#CFFEDD; color:green;" id="da<%=i%>">&nbsp;</td>
                                <td style="text-align:left;  background-color:#CFFEDD; color:green;" id="ka<%=i%>">&nbsp;</td>
                                <td style="text-align:left;  background-color:#CFFEDD; color:green;" id="qa<%=i%>">&nbsp;</td>
                                <td style="text-align:right; background-color:#FCE0F9" ><%=trim(RS("UND")) %></td>
                         
                                 <%if UCASE(trim(RS("UND"))) = "UND" THEN%>
                                        <%dis =FORMATNUMBER(TRIM(CDBL(RS("SK_NSKDIS"))),0,,,TRUE)%>
                                    <%else%>
                                        <%dis =FORMATNUMBER(TRIM(CDBL(RS("SK_NSKDIS"))),3,,,TRUE)%>
                                    <%end if %>
                          
                                    <!-- VERIFICA SI ES EL ALMACEN NUEVO PARA HACER EL SUGERIDO -->
                                    <!-- SI ES EL ANTIGUO, LO MUESTRA SOLO COMO AYUDA REFERENCIAL -->
                                    <%if ucase(trim(rs("sk_calma"))) = ucase(trim(des)) THEN%>
                                        <%IF  aq2(i) <> 0 THEN 
                                                SUGE = CDBL(TRIM(aQ2(i))) - CDBL(RS("SK_NSKDIS")) 
                                        ELSE 
                                            SUGE = CDBL(TRIM(ak2(i))) - CDBL(RS("SK_NSKDIS"))
                                        END IF%>
                                    <%ELSE%>
                                        <%SUGE = CDBL(TRIM(ak2(i)))%>
                                <%END IF%>
                                <td style="text-align:right; background-color:#FCE0F9; cursor:pointer;" id="st<%=i%>" ondblclick="partida('old','<%=i%>')"><%=dis%></td>
                                <td style="text-align:right; background-color:#FCE0F9;" id="old<%=i%>"><%=TRIM(RS("SK_CALMA"))%></td>
                                <td style="text-align:right; background-color:#C1D3FF" >&nbsp;</td>
                                <td><input id="coo<%=i%>" type ="checkbox">&nbsp;</td>
                                <td style="text-align:right; background-color:#E5E5E5"><%=TRIM(RS("OC"))%></td>
                                <%if isnull(RS("CAN")) then can= 0 else can = CDBL(RS("CAN")) %>
                                <td style="text-align:right; background-color:#E5E5E5"><%=FORMATNUMBER(can,3,,,TRUE)%></td>
                                <td style="text-align:right; background-color:#E5E5E5"><%=FORMATNUMBER(TRIM(CDBL(RS("PRE"))),2,,,TRUE)%></td>
                                <td style="text-align:right; background-color:#E5E5E5"><%=TRIM(RS("RUC"))%></td>
                                <td style="text-align:left;  background-color:#E5E5E5"><%=TRIM(RS("PRO"))%></td>
                                  <%if isnull(RS("fec")) then fec= "" else fec =formatdatetime(rs("fec"),2) %>
                                <td style="text-align:left ; background-color:#E5E5E5"><%=fec%></td>
                            </tr>
                        <%END IF%>
                    <%next %>
               <tr>
                <td><input type="button" class="botonrsv" onclick="reserva()"></td>
                <td colspan="8"></td>
                <td><input type="button" class="botonrsv" onclick="orden()"></td>
               </tr>
            </table>
        
<%ELSE %>



<%END IF%>   

<iframe id="head" name="head" src=""  width="100%" scrolling="no" frameborder="1" height="200"></iframe>
</form>  
<script language="jscript" type="text/jscript">
var maxi = parseInt('<%=i%>',10)
//alert(maxi)

var opc = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no,";
opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900";
var des = trim('<%=des%>')
 for (v=0 ; v< maxi; v++)
 {  if (trim(eval("document.all.s"+v+".innerText")) == '' || trim(eval("document.all.a"+v+".innerText")) != des)
    {   eval("document.all.ch"+v+".style.display='none'")      }
    dd = "st" + v.toString()
    var ele = document.getElementById(dd);
    if(ele !== null)
        { if ( trim(eval("document.all.st"+v+".innerText")) == '' || trim(eval("document.all.ca"+v+".innerText")) == '' )
            {     eval("document.all.cc"+v+".style.display='none'")    }
        }
 }

function partida(data, ff) {   
  
  lt2 = trim('<%=lt2 %>')
  cod = eval("trim(document.all.c"+ff+".innerText)");
  alm = eval("trim(document.all."+data + ff + ".innerText)");
  //alert(alm)
  cad = 'help/HLPpartida.asp?cod=' + cod+ '&alm='+alm
  window.open(cad,'', opc)
}

function valida(obj, ff) 
{   obj.value =  toInt(obj.value)
    var  cod = eval("trim(document.all.c"+ff+".innerText)");
    var  kg  = eval("trim(document.all.k"+ff+".innerText)");
    var  qt  = eval("trim(document.all.q"+ff+".innerText)");
    var  st  = eval("trim(document.all.s"+ff+".innerText)");
    var  ped = parseFloat(obj.value)
    var  qtt = qt.replace(',','') 
    var  kgt = kg.replace(',','')   

    if (isNaN(qtt) != true)
    {   qty = parseFloat(qtt) 
        kgs = parseFloat(kgt)   
    }
    else
    {   qty = 0
        kgs = 0
    }
    stt = st.replace(',','')

    if (isNaN(stt) != true)
        stk = parseFloat(stt)
    else
        stk = 0

    if (qty > 0 )
        {   dif = qty - ped    }
    else
        {   dif = kgs - ped    }

    if(dif<0)
    {   alert("Esta intentando comprar mas de lo que se necesita\nEsto no esta permitido ")
        return false;
    }

}

function reserva()
{   
    rsv = 0
    aCod = new Array()
    aAlm = new Array()
    aCan = new Array()
    lt2 = trim('<%=lt2 %>')
    //alert(lt2)
    for (b=0 ; b< maxi; b++)
    {   cc= "ch" + b.toString()
        ell = document.getElementById(cc);
       
        if ( ell.style.display =='block')
        {   if (ell.checked == true )
            {  cod = eval("trim(document.all.c"+b+".innerText)");        
               ss = "s" + b.toString()
               var vl = document.getElementById(ss);
               if(vl !== null)
                   can = eval("trim(document.all.s"+b+".innerText)");    
               else
                   can = 0;    
               qty = can.replace(',','') 
               // la cantidad que hay en el almacén
               if (trim(qty) != '')
                  can = parseFloat(qty)    
               // si es rectilineo el requerido viene en unidades 
               if (Left(trim(cod),1)== '9')
               {  qq = "q"+b.toString()
                  qt = document.getElementById(qq);
                  if(vl !== null)
                  {  cnt = eval("trim(document.all.q"+b+".innerText)");    
                     qty = cnt.replace(',','') ;
                     cnt = parseInt(qty,10);
                  }  
                  else
                     cnt = 0;  
               }       
               else  // si es tela normal
               {    cnt = eval("trim(document.all.k"+b+".innerText)");    
                    qty =  cnt.replace(',','') ;
                    cnt = parseFloat(qty);
               }
                if (can > cnt)
                    canti = cnt
                else
                    canti = can
                alert(canti)
                alm = eval("trim(document.all.a"+ b + ".innerText)");
                aCod[rsv] = cod;
                aAlm[rsv] = alm;
                aCan[rsv++] = can;       
            }

        } // del display block
    }  // del for
    if (rsv == 0)
    {   alert("Nada que reservar")
       
        }
    else
    {   cad = 'help/hlpRSV.asp?cod='+ aCod + '&alm=' + aAlm + '&can='+aCan + '&lt2=' + '<%=lt2%>'
 
        window.open(cad)
    }
}




function orden()
{   alert("aca abro la ventana de la OC para lo marcado")


}

</script>



</body>
</html>
