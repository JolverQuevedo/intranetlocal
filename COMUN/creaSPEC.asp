<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<html>
<head>
<meta name="GENERATOR" content="Microsoft Visual Studio 6.0">
</head>
<body>
<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
sp  = request.Cookies("spe")
vr  = right(request.Cookies("ver"),3)
cli = request.Cookies("cli")
tem = request.Cookies("tem")
med = request.Cookies("med")
mmd = request.Cookies("mmd")
est = request.Cookies("est")

if trim(UCASE(sp)) = "AUTO" THEN
    RS.OPEN "SELECT TOP 1 SPEC FROM SPECS_HEAD ORDER BY 1 DESC", CNN
    IF RS.RECORDCOUNT > 0 THEN SPE = RIGHT("0000000000"+ TRIM(CSTR(CDBL(RS("SPEC"))+1)),10) ELSE SPE = "0000000001"
    ' SE CREA CABECERA, GRUPO CON PRENDA TERMINADA, QUE TODOS LOS SPECS TIENEN
    ' Y SPEC_MEDIDAS CON GRUPO 1 Y LINEA 0 PARA QUE TENGA AL MENOS 1 DETALLE EN BLANCO
    MAXIM = SPE
    rs.close
    RS.OPEN "SELECT TOP 1 SPEC FROM specS_grupos where spec > (SELECT TOP 1 SPEC FROM SPECS_HEAD ORDER BY 1 DESC)",CNN
    IF RS.RECORDCOUNT >0 THEN
        RS.MOVEFIRST
        Usuario = Request.Cookies("Usuario")("USUARIO")
        CAD =   " INSERT INTO SPECS_HEAD (SPEC, VER, CLI, CODTEM, ESTILO, USUARIO, FECHA, ESTADO, tipmed, MODELISTA) VALUES     " & _
                " ('"&SPE&"', '001', '"&CLI&"', '"&TEM&"', '"&EST&"', '"&Usuario&"', GETDATE(), 'A' , '"&med&"', '"&MMD&"');    "
    ELSE
        CAD =   " INSERT INTO SPECS_HEAD (SPEC, VER, CLI, CODTEM, ESTILO, USUARIO, FECHA, ESTADO, tipmed, MODELISTA) VALUES     " & _
                " ('"&SPE&"', '001', '"&CLI&"', '"&TEM&"', '"&EST&"', '"&Usuario&"', GETDATE(), 'A' , '"&med&"', '"&MMD&"');    " & _
                " insert into specS_grupos (spec, ver, grupo, orden) VALUES ('"&SPE&"', '001', '001',1) ;                       "
    END IF

    RESPONSE.WRITE(CAD)
    CNN.EXECUTE CAD
    sp= spe
    vr = "001"

    response.cookies("spe")=sp
    response.cookies("ver")=vr
    spe = trim(spe) + "-" + trim(vr)
%>
 
<script language="jscript" type="text/jscript">
   sp = '<%=sp%>'
   vr = '<%=vr %>'
  // alert('<%=USUARIO %>')
    obj = parent.window.document.all.SPE
    obj.options[obj.length] = new Option('<%=spe%>', '<%=spe%>'); 		
    obj.selectedIndex = obj.length-1
    //   alert(parent.window.document.all.SPE.value)
    cad= '../menu_spec.asp?spe='+ sp + '&ver='+ vr
    
    window.location.replace(cad)
</script>   
<%END IF
    
    Cnn.Close	
    set Cnn = Nothing
    SET RS = Nothing	
%>
</BODY>
</HTML>
