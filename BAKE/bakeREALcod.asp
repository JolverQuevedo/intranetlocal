<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD>
<BODY >
<HTML>
PROCESANDO...

<%	
pos = Request.QueryString("pos")
CAD =	"Select * From RSFACCAR..AL0001ARTI Where AR_CCODIGO='"&pos&"'" 
		RS.OPEN CAD, CNN
	'	RESPONSE.Write(RS.RECORDCOUNT)
		if RS.RECORDCOUNT <= 0 then%>
			<script type="text/jscript" language="jscript">
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
            </script>
		<%else%>
		    <%RS.MoveFirst
             'response.write("<br>")
             'response.write("kgs")
            if left(pos,1) = "9" then
                SET RS2 = Server.CreateObject("ADODB.RecordSet")
	                RS2.ActiveConnection	= Cnn
	                rs2.CursorType			= 3
	                rs2.LockType			= 1
                tela = left(pos,6)
                rs2.open "select pesouni from modelador..telas where tela = '"&tela&"'", cnn
                if rs2.recordcount > 0 and cdbl(rs2("pesouni")) > 0 then  kgs = rs2("pesouni") else kgs = 0
              '  response.write("<br>")
              '  response.write(kgs)
            end if%>           
          <script type="text/jscript" language="jscript">           
                if (trim('<%=request.querystring("opp")%>') == 'X') {
                    window.parent.thisForm.KOD.value = '<%=trim(rs("AR_CCODIGO"))%>';
                    window.parent.thisForm.DKOD.value = '<%=trim(rs("AR_CDESCRI"))%>';

                    if (Left(trim(window.parent.thisForm.KOD.value), 1) == '9') {
                        if (parseInt('<%=kgs%>', 10) > 0) 
                        {   window.parent.thisForm.TOKI.value = '<%=formatnumber(kgs,3,,,true)%>'
                            window.parent.thisForm.FICHA.style.display = 'block'
                        }
                        else {
                            alert("Rectilineo NO tiene Peso registrado")
                        }
                    }
                }
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
                 

      if (Left(trim(window.parent.thisForm.COD.value), 2) == 'SR') 
      {
    
        if (Left(trim(window.parent.thisForm.KOD.value), 1) != '9') 
        {
            alert("Solo se Aceptan Rectilineos")
            window.parent.thisForm.KOD.value = ''
            window.parent.thisForm.DKOD.value = ''
        }
        else       
         { 
             window.parent.thisForm.FICHA.style.display='block'}
    }
    if (Left(trim(window.parent.thisForm.COD.value), 2) == 'ST') 
    {      
        if (Left(trim(window.parent.thisForm.KOD.value), 1) == '9') 
        {
            alert("Solo se Aceptan tejidos Circulares")
            window.parent.thisForm.KOD.value = ''
            window.parent.thisForm.DKOD.value= ''
        }
    }





















		    </script>	
        <%end if%>
		
</BODY>
</HTML>
