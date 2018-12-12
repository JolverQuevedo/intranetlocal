<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
PROCESANDO...
<script language="jscript" type="text/jscript">
var    plop = ''
</script>
<%	
pos = Request.QueryString("pos")
TIPO = Request.QueryString("TIP")
cop = Request.QueryString("cop")
CAD =	"Select * From RSFACCAR..AL0001ARTI Where AR_CCODIGO='"&pos&"' " 
RESPONSE.Write(cad)
response.write("<br>")
RESPONSE.Write(pos)
response.write("<br>")

SET RS2 = Server.CreateObject("ADODB.RecordSet")
	        RS2.ActiveConnection	= Cnn
	        rs2.CursorType			= 3
	        rs2.LockType			= 1



RS.OPEN CAD, CNN
	
if RS.RECORDCOUNT <= 0 then     ' IF 1º   --> NO EXISTE EL CODIGO (PRINCIPAL O DE REFERENCIA) %>
	<script type="text/jscript" language="jscript">
    // si no existe el codigo SE BLANQUEA todo EL FORMULARIO
		alert("Articulo no registrado")
		window.parent.thisForm.COD.value = ''
		window.parent.thisForm.KOD.value = ''
		window.parent.thisForm.DES.value = ''
		window.parent.thisForm.COME.value = ''
		window.parent.thisForm.UNI.value = ''
		window.parent.thisForm.PAR.value = ''
		window.parent.thisForm.ARA.value = ''
		window.parent.thisForm.IIGV.value = ''
		window.parent.thisForm.IISC.value = ''
        plop ='yyy'
    </script>
<%else      ' ELSE 1º --> EXISTE EL CODIGO (PRINCIPAL O DE REFERENCIA)
	'*************************************************'
    response.write("<br>")
    response.write("mmmmmmmmmmmmmmmmmmmmmmm")
     
    RS.MoveFirst
    KGS=0
    '*************************************************'
    ' SI LO QUE LLEGO ES RECILINEO SE JALA EL PESO    '
    '*************************************************'
    response.write(pos)
    if left(trim(pos),1) = "9" then  ' IF RECTIL
        tela = left(trim(pos),6)
        rs2.open "select pesouni from modelador..telas where tela = '"&tela&"'", cnn
        if rs2.recordcount > 0 then
            if cdbl(rs2("pesouni")) > 0 then  
                kgs = rs2("pesouni") 
            else 
                kgs = 0
            end if
         end if   
          response.write("<br>")
          response.write(kgs)
          rs2.close
    end if   ' END IF RECTIL
   
   
   
    IF TIPO = "I"  THEN      ' IMPORTACION  %>
     <% ' PARA LO QUE NO ES SERVICIO SOLO SE TRABAJA CON EL COD %>
        <script type="text/jscript" language="jscript">
            // es una COMPRA DE RECITLINEO Y HAY QUE PONER Tallas
                 
            window.parent.thisForm.DES.value = '<%=rs("ar_cdescri")%>'
            window.parent.thisForm.UNI.value = '<%=trim(rs("AR_CUNIDAD"))%>';
            window.parent.thisForm.PAR.value = '<%=LEFT(trim(rs("AR_CPARARA")),3)%>';
            window.parent.thisForm.ARA.value = '<%=trim(rs("AR_CPARARA"))%>';
            window.parent.thisForm.IIGV.value = 0;
            window.parent.thisForm.IISC.value = 0;
               
                 
        </script>
   <%end if
   
    ' **************************'
    ' SI LA OC ES POR SERVICIO  '
    ' **************************'
     
    IF TIPO = "S" and cop ="" THEN      ' IF TIPO  "S"
        
        xxxx = "select * from MATRIZ_COMPRA_TELA where codser = '"&pos&"'"
        response.write(xxxx)
        rs2.open xxxx, cnn
        IF RS2.RECORDCOUNT <= 0 THEN %>
            <script type="text/jscript" language="jscript">
                alert("Codigo no registrado como servicio")
            </script>
        <% plop="1"
        END IF%>      
        <script type="text/jscript" language="jscript">
            // se fija si el codigo primario es un servicio
            if (Left(trim(window.parent.thisForm.COD.value), 2) == 'ST' && trim(window.parent.thisForm.KOD.value)!='') 
            {   if (Left(trim(window.parent.thisForm.KOD.value), 1) == '9') 
                {   window.parent.thisForm.DKOD.value = ''
                    plop = '1'
                    alert("Solo se Aceptan tejidos Circulares...");
                   // alert(plop) 
                }
            }
            else if (Left(trim(window.parent.thisForm.COD.value), 2) == 'SR' && trim(window.parent.thisForm.KOD.value)!='') 
           {    if (Left(trim(window.parent.thisForm.KOD.value), 1) != '9') 
                {   alert("Solo se Aceptan Rectilineos");
                    window.parent.thisForm.DKOD.value = ''
                    plop='1'  
                }
                else 
                {   window.parent.document.all.FICHA.style.display = 'block'    }
            }
           else  if (Left(trim(window.parent.thisForm.COD.value), 1) != 'S' )
           {    alert("Esta OC es por SERVICIO \nEl codigo debe empezar con S")
                plop = '1'
           }  
           // es un servicio por RECITLINEO Y HAY QUE PONER Tallas       
           if (Left(trim(window.parent.thisForm.KOD.value), 1) == '9') 
            {   if (parseFloat('<%=kgs%>') > 0) 
                {   window.parent.thisForm.TOKI.value = '<%=formatnumber(kgs,3,,,true)%>'
                    window.parent.document.all.FICHA.style.display = 'block'
                }
                else 
                {   alert("Rectilineo para SERVICIO NO tiene Peso registrado ")
                    plop ='1'
                }
            }
            // cuando entra por CODIGO de REFERENCIA
            if (plop == '') 
            {   if (trim('<%=request.querystring("opp")%>') == 'X')
                { window.parent.thisForm.DKOD.value = '<%=trim(rs("AR_CDESCRI"))%>'; }
                else {
                    window.parent.thisForm.COD.value = '<%=trim(rs("AR_CCODIGO"))%>';
                    window.parent.thisForm.DES.value = '<%=trim(rs("AR_CDESCRI"))%>';
                    window.parent.thisForm.COME.value = '<%=trim(rs("AR_CDESCR2"))%>';
                    window.parent.thisForm.UNI.value = '<%=trim(rs("AR_CUNIDAD"))%>';
                    window.parent.thisForm.PAR.value = '<%=LEFT(trim(rs("AR_CPARARA")),3)%>';
                    window.parent.thisForm.ARA.value = '<%=trim(rs("AR_CPARARA"))%>';
                    window.parent.thisForm.IIGV.value = '<%=trim(rs("ar_nigvpor"))%>';
                    window.parent.thisForm.IISC.value = '<%=trim(rs("ar_niscpor"))%>';
                }

            }
           
		</script>	
    
    
    
    
    <% ELSE     ' ELSE --> el TIPO no es "S" %>
    <% ' PARA LO QUE NO ES SERVICIO SOLO SE TRABAJA CON EL COD %>
    <script type="text/jscript" language="jscript">
    // es una COMPRA DE RECITLINEO Y HAY QUE PONER Tallas
        if (Left(trim(window.parent.thisForm.COD.value), 1) == '9' || Left(trim(window.parent.thisForm.KOD.value), 1) == '9') {
            if (parseFloat('<%=kgs%>') > 0) {
                window.parent.thisForm.TOKI.value = '<%=formatnumber(kgs,3,,,true)%>'
                window.parent.document.all.FICHA.style.display = 'block'
                window.parent.thisForm.DES.value = '<%=rs("ar_cdescri")%>'
                window.parent.thisForm.UNI.value = '<%=trim(rs("AR_CUNIDAD"))%>';
                window.parent.thisForm.PAR.value = '<%=LEFT(trim(rs("AR_CPARARA")),3)%>';
                window.parent.thisForm.ARA.value = '<%=trim(rs("AR_CPARARA"))%>';
                window.parent.thisForm.IIGV.value = '<%=trim(rs("ar_nigvpor"))%>';
                window.parent.thisForm.IISC.value = '<%=trim(rs("ar_niscpor"))%>';
            }
            else {
                alert("Rectilineo para COMPRA NO tiene Peso registrado ")
                plop = '1'
            }
        }
                 
    </script>

    <%end if    ' END IFTIPO "S" %>
    <script type="text/jscript" language="jscript">
        if ((Left(window.parent.thisForm.COD.value, 1) == 'S') && ('<%=ucase(tipo)%>' != "S")) {
            alert("SOLO las OC de SERVICIOS empiezan su codigo con S")
            plop = '1'
        }
        /*  blanquea los campos si hay alguna inconsistencia  */
       // alert(plop)
        if (plop =='1' || '<%=trim(plop)%>'=='1')
        {   window.parent.thisForm.COD.value = ''
	        window.parent.thisForm.KOD.value = ''
	        window.parent.thisForm.DES.value = ''
	        window.parent.thisForm.DKOD.value =  ''
	        window.parent.thisForm.COME.value = ''
	        window.parent.thisForm.UNI.value = ''
	        window.parent.thisForm.PAR.value = ''
	        window.parent.thisForm.ARA.value = ''
	        window.parent.thisForm.IIGV.value = ''
	        window.parent.thisForm.IISC.value = ''
	        window.parent.document.all.FICHA.style.display = 'none';
	    }
	    TIPO = '<%=UCASE(TRIM(TIPO))%>'
       // alert(TIPO)
        if (TIPO == "I") {
            alert(TIPO)
            window.parent.thisForm.DES.value = '<%=rs("ar_cdescri")%>'
            window.parent.thisForm.DKOD.value = '<%=rs("ar_cdescri")%>'
            window.parent.thisForm.UNI.value = '<%=trim(rs("AR_CUNIDAD"))%>';
            window.parent.thisForm.PAR.value = '<%=LEFT(trim(rs("AR_CPARARA")),3)%>';
            window.parent.thisForm.ARA.value = '<%=trim(rs("AR_CPARARA"))%>';
            window.parent.thisForm.IIGV.value = 0;
            window.parent.thisForm.IISC.value = 0;
        }
    </script>	
<%end if    ' END IF 1%>
	
</BODY>
</HTML>
