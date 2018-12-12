<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../comun/funcionescomunes.asp"-->
<%Response.Buffer = TRUE %>
<%Session.LCID = 2057%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%MSS = "select realsoft from usuarios where usuario = '"&usuario&"'"
RS.OPEN MSS, CNN
'RESPONSE.WRITE(MSS)
USUARIO = TRIM(RS("REALSOFT"))
RS.CLOSE
IF TRIM(USUARIO) = "" THEN%>
<script language="jscript" type="text/jscript">
    parent.window.alert("Usuario no registrado para GRABAR en el Real")
</script>
<%RESPONSE.End
END IF

OC =    TRIM(REQUEST.QUERYSTRING("OC"))
tip =    TRIM(REQUEST.QUERYSTRING("tip"))
' Bloqueo la OC para que otro no meta la manotas
CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CUNIORD='1' Where OC_CNUMORD='"&OC&"' ; "

if tip = "S" then 

    ' busca TODOS los PE de los servicios
    ' porque ya estamos seguros que existe y que es de servicios!

     CAD =      " Select a.c5_calma as alm, OC_CCODIGO AS COD ,OC_CDESREF AS DESCRI, OC_CUNIDAD AS UNI, OC_NCANORD AS ORDEN,                    " & _
                " OC_NPREUNI AS UNI_OC, (OC_NCANORD*OC_NPREUNI) AS TOT_OC,                                                                      " & _
                " CANTI = case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID *-1 END,                                      " & _
                " ltrim(rtrim(c6_ctd)) + ' - '+ ltrim(rtrim(c6_cnumdoc)) as DOC, (C6_NPREUNI) AS UNI_PE,                                        " & _
                " (C6_NPREUNI) * case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID *-1 END AS TOT_PE,                     " & _
                " CONVERT(VARCHAR, C5_DFECDOC, 103) AS FECHA,                                                                                   " & _
                " (OC_NCANORD*OC_NPREUNI)-(C6_NPREUNI* case when LTRIM(RTRIM(C5_CTIPMOV)) ='E' THEN C6_NCANTID ELSE C6_NCANTID*-1 END) AS SALDO " & _
                " From RSFACCAR..CO0001MOVD AS CC                                                                                               " & _
                "  inner join  RSFACCAR..al0001movc AS A  on OC_CNUMORD = c5_cnumord                                                            " & _
                " inner join RSFACCAR..al0001movd AS B on c5_cnumdoc = c6_cnumdoc and c5_ctd = c6_ctd and c5_calma = c6_calma                   " & _
                " and OC_CITEM = C6_CITEMOC                                                                                                     " & _
                " Where OC_CNUMORD='"&OC&"' AND OC_NCANORD > 0                                                                                  " & _
                " ORDER BY OC_CCODIGO, C5_DFECDOC desc, OC_CITEM ;                                                                              " 
                rs.close
                'response.write(cad)
                rs.open cad,cnn
    
        if rs.recordcount > 0 then rs.movefirst
            do while not rs.eof
        
                rs.movenext
            loop





   end if

   ' actuaiza el flag de la OC a LIQUIDADO
CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CSITORD='6' Where OC_CNUMORD='"&OC&"' ; "
cnn.execute "Update RSFACCAR..CO0001MOVD Set OC_CESTADO='6' Where OC_CNUMORD='"&oc&"' "

' DESBloqueo la OC 
CNN.EXECUTE "Update RSFACCAR..CO0001MOVC Set OC_CUNIORD='' Where OC_CNUMORD='"&OC&"' ; "




Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	
'regresa a la página de donde fué llamado, para que vea que agregó el registro
%>
<script language="javascript" type="text/jscript">
   alert("OC liquidada")
   cad= '../liquidadas.asp?tip='+ '<%=tip%>'
   //alert(cad)
 //  top.window.opener.location.reload(true);
   top.window.opener.window.location.replace(cad)
   top.window.close()
</script>
</BODY>
</HTML>

