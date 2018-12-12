<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->
<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%
'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
CHK = Request.QueryString("chk")
PK = Request.QueryString("pk")
COD = TRIM(Request.QueryString("pos"))
p0	= ucase(trim(Request.QueryString("p0")))
p1	= ucase(trim(Request.QueryString("p1")))
p2	= ucase(trim(Request.QueryString("p2")))
p3	= ucase(trim(Request.QueryString("p3")))
p4	= ucase(trim(Request.QueryString("p4")))
p5	= ucase(trim(Request.QueryString("p5")))
p6	= ucase(trim(Request.QueryString("p6")))
p7	= ucase(trim(Request.QueryString("p7")))
p8	= ucase(trim(Request.QueryString("p8")))
p9	= ucase(trim(Request.QueryString("p9")))
c0	= ucase(trim(Request.QueryString("c0")))
c1	= ucase(trim(Request.QueryString("c1")))
c2	= ucase(trim(Request.QueryString("c2")))
c3	= ucase(trim(Request.QueryString("c3")))
c4	= ucase(trim(Request.QueryString("c4")))
c5	= ucase(trim(Request.QueryString("c5")))
c6	= ucase(trim(Request.QueryString("c6")))
c7	= ucase(trim(Request.QueryString("c7")))
c8	= ucase(trim(Request.QueryString("c8")))
c9	= ucase(trim(Request.QueryString("c9")))
URL = TRIM(Request.QueryString("URL"))
tbL	= trim(application("owner"))+"."+trim(Request.QueryString("tbl"))

FECHA ="{ fn NOW() }"
if COD = "AUTO" then
CAD =	" SELECT  "&pk&"			" & _
		" from "&tbl&"				" & _
		" where "&c0&" = '"&p0&"'	" & _
		" and   "&c1&" = '"&p1&"'	" & _
		" and   "&c2&" = '"&p2&"'	" & _
		" and   "&c3&" = '"&p3&"'	" & _
		" and   "&c4&" = '"&p4&"'	" & _
		" and   "&c5&" = '"&p5&"'	" & _
		" and   "&c6&" = '"&p6&"'	" & _
		" and   "&c7&" = '"&p7&"'	" & _
		" and   "&c8&" = '"&p8&"'	" & _
		" and   "&c9&" = '"&p9&"'	" 
    rs.open cad,cnn		
    ' SOLO si no encuentra proporcion igual con código....
    if rs.recordcount <=0 then
        rs.close
    '	busca el ultimo generado
	    CAD =   " SELECT top 1"&pk&" FROM "&tbl&" " & _
			    " ORDER BY "&pk&" desc"
	    RS.Open CAD, CNN
        IF RS.RecordCount > 0 THEN	
            xx = CINT(RS.FIELDS.ITEM(0)) +1
            xx = CSTR(xx)
            COD = RIGHT("000"+TRIM(xx),3) 
        ELSE 
            COD = "000"
        end if  
        if trim(p0+p1+p2+p3+p4+p5+p6+p7+p8+p9) <> "" then
        CAD =	" insert into "&TBL&"  " & _
		        " ("&PK&","&C0&", "&C1&", "&C2&", "&C3&", "&C4&", "&C5&", " & _
		        " "&C6&", "&C7&", "&C8&", "&C9&", ESTADO, usuario, fecha )" & _
		        " values('"&COD&"','"&P0&"', '" & P1 & "', '" & P2 & "',  " & _
		        " '"&P3&"','"&P4&"','"&P5&"','"&P6&"','"&P7&"','"&P8&"',  " & _
		        " '"&P9&"','A', '"&USUARIO&"', "&fecha&" ) ;              " 
        end if  
    else 
        cod = rs.fields.item(0)    
    end if		
ELSE
'	busca si encuentra EL código 
	CAD =   " SELECT "&pk&" FROM "&tbl&" " & _
			" WHERE  "&pk&"= '"&COD&"' "
	if chk = "0" then
		CAD =	" UPDATE  "&TBL&" set       " & _
				" "&c0&" = '"&p0&"',	    " & _
		        " "&c1&" = '"&p1&"',	    " & _
		        " "&c2&" = '"&p2&"',	    " & _
		        " "&c3&" = '"&p3&"',	    " & _
		        " "&c4&" = '"&p4&"',	    " & _
		        " "&c5&" = '"&p5&"',	    " & _
		        " "&c6&" = '"&p6&"',	    " & _
		        " "&c7&" = '"&p7&"',	    " & _
		        " "&c8&" = '"&p8&"',	    " & _
		        " "&c9&" = '"&p9&"',	    " & _
				" ESTADO = 'A',             " & _
				" USUARIO = '"&USUARIO&"',  " & _
				" FECHA = "&fecha&"         " & _
				" WHERE  "&PK&" = '"&COD&"';"
	else
		CAD =	" UPDATE "&TBL&"                " & _
				" SET  USUARIO = '"&USUARIO&"', " & _
				" FECHA = "&fecha&" ,           " & _
				" ESTADO = 'E'	                " & _ 
				" WHERE "&pk&"= '"&COD&"' ;     "
	end if		

End if
Response.Write(CAD)
' Inicia transacción , para que los datos no queden a medias
Cnn.BeginTrans	
Cnn.Execute(CAD)
if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

Cnn.Close	
set Cnn = Nothing
SET RS = Nothing	

%>
<script>
cad = '<%=trim(url)%>' + '&pos=' + '<%=COD%>'
window.parent.location.replace(cad)
</script>			
</BODY>
</HTML>
