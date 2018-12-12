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
		RESPONSE.Write(RS.RECORDCOUNT)
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
		<%RS.MoveFirst%>
            <script type="text/jscript" language="jscript">
                window.parent.thisForm.COD.value = '<%=trim(rs("AR_CCODIGO"))%>';
                window.parent.thisForm.KOD.value = '<%=trim(rs("AR_CCODIG2"))%>'
                window.parent.thisForm.DES.value = '<%=trim(rs("AR_CDESCRI"))%>'
                window.parent.thisForm.COME.value ='<%=trim(rs("AR_CDESCR2"))%>'
                window.parent.thisForm.UNI.value = '<%=trim(rs("AR_CUNIDAD"))%>'
                window.parent.thisForm.PAR.value = '<%=LEFT(trim(rs("AR_CPARARA")),3)%>'
                window.parent.thisForm.ARA.value = '<%=trim(rs("AR_CPARARA"))%>'
                window.parent.thisForm.IIGV.value = '<%=trim(rs("ar_nigvpor"))%>'
                window.parent.thisForm.IISC.value = '<%=trim(rs("ar_niscpor"))%>'
			</script>	
        <%end if%>
		
</BODY>
</HTML>
