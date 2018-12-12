<%@ Language=VBScript%>
<%Session.LCID=2057%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HEAD>
</HEAD><HTML>
<BODY >

<%  pos = Request.QueryString("oc")
  
cad = "select oc_ctipord from rsfaccar..co0001movc where oc_cnumord = '"&pos&"'"
    RESPONSE.WRITE(CAD)
    RS.OPEN CAD, CNN
    ' OC no existe
	if RS.RECORDCOUNT <= 0 then%>
      <script type="text/jscript" language="jscript">
          window.parent.alert("La OC no Existe")
        //  top.window.location.replace('../LIQUIDACION.asp')
       </script>
    <% response.end
    
    end if
rs.close
CAD =	" select almdes,(Select A1_CDESCRI From RSFACCAR..AL0001ALMA where A1_CALMA collate         " & _
        " SQL_Latin1_General_CP1_CI_AI=(select ALMDES from MODELADOR..ordencompra where item =      " & _
        " '0001' and numord = '"&pos&"' and sub_it= '00'  )) AS DD from MODELADOR..ordencompra where item = '0001' and " & _
        " numord = '"&pos&"'  and sub_it= '00'                                           "
      RESPONSE.WRITE(CAD)
		RS.OPEN CAD, CNN

		if RS.RECORDCOUNT > 0 then%>
            <%IF isnull(RS("ALMDES")) THEN%>
            <script type="text/jscript" language="jscript">
                window.parent.alert("La OC no tiene Almacen de Destino, \nFavor corregir")
			    </script>	
            <%response.end
            END IF%>
			<script type="text/jscript" language="jscript">
			    window.parent.document.all.COD.value = '<%=rs("almdes")%>'
			    window.parent.document.all.ALM.value = '<%=rs("DD")%>'
            </script>
		<%else%>
        <%rs.close
            CAD =	" select oc_calmdes,(Select A1_CDESCRI From RSFACCAR..AL0001ALMA where A1_CALMA " & _
                    " =(select oc_calmdes From RSFACCAR..co0001movc where oc_cnumord='"&pos&"'))    " & _
                    " From RSFACCAR..co0001movc where oc_cnumord = '"&pos&"'                        "  
           'RESPONSE.WRITE(CAD)
		    RS.OPEN CAD, CNN
        
           if RS.RECORDCOUNT > 0 then%>
			    <script type="text/jscript" language="jscript">
			        window.parent.document.all.COD.value = '<%=rs("oc_calmdes")%>'
			        window.parent.document.all.ALM.value = '<%=rs.fields.item(1)%>'
                </script>
		    <%else%>
                <script type="text/jscript" language="jscript">
                    window.parent.alert("No existe OC")
                   //alert('<%=cad%>')
			    </script>	
            <%response.End
            end if
        end if  
    rs.close
   
     cad =  " Select OC_CNUMORD,OC_CUNIORD, OC_CSITORD, OC_CCODMON, OC_NTIPCAM,* From RSFACCAR..CO0001MOVC Where OC_CNUMORD= '"&pos&"' "
     RESPONSE.WRITE(CAD)
	 RS.OPEN CAD, CNN

	 if RS.RECORDCOUNT > 0 then msg = ""
     %>
	 	<script type="text/jscript" language="jscript">
            ruc = '<%=trim(rs("oc_ccodpro"))%>' 
	 	    window.parent.document.all.PRO.value = '<%=trim(rs("oc_ccodpro"))%> - <%=rs("OC_crazsoc")%>'
            window.parent.document.all.CAM.value = '<%=rs("OC_NTIPCAM")%>'
            window.parent.document.all.FEC.value = '<%=FORMATDATETIME(rs("OC_DFECDOC"),2)%>'
            window.parent.document.all.MON.value = '<%=rs("OC_CCODMON")%>'
            window.parent.document.all.tip.value = '<%=ucase(rs("OC_Ctipord"))%>'
            window.parent.document.all.sit.value = '<%=ucase(rs("OC_Csitord"))%>'
            //window.parent.document.all.CAM.value = '<%=rs("OC_NTIPCAM")%>'
         </script>
	 <%SIT = RS("OC_CSITORD")    
     rs.close
     
     
     RS.OPEN "select TG_CDESCRI from RSFACCAR.dbo.AL0001TABL WHERE   (TG_CCOD = '31') and tg_Cclave ='"&SIT&"'", CNN 
     RS.MOVEFIRST
     %>
     <script type="text/jscript" language="jscript">

          window.parent.document.all.Dsit.value = '<%=RS("TG_CDESCRI")%>'
	 </script>	

     
     
     
     
     
  
<script language=jscript type="text/jscript">
window.parent.document.all.deta.src ='detaLIQoc.asp?oc='+ '<%=pos%>'+'&ruc=' + ruc

</script>		
</BODY>
</HTML>
