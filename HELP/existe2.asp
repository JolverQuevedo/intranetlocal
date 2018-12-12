<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
</HEAD>
<BODY >
<HTML>
<%	DATO	= Request.QueryString("pos")
	pk		= Request.QueryString("pk")
	ds		= Request.QueryString("ds")	
	tbL		= trim(Request.QueryString("tbl"))
	DATO2	= Request.QueryString("pos2")
    col2	= Request.QueryString("col2")
	msg1    = Request.QueryString("msg1")
	msg2    = Request.QueryString("msg2")
	errr = ""	
	url		= Request.QueryString("url")
	errr = ""	
' busca por codigo y segundo indice	
CAD =	" SELECT  *			        " & _
		" from "&tbl&"				" & _
		" where "&pk&" = '"&dato&"'	"
Kli= ""		
rs.open cad,cnn
if rs.recordcount > 0 then		
    ' EXISTE!!! y hay que averiguar si es del cliente en edicion o de otro
    RESPONSE.Write(COL2)
    IF TRIM(COL2) <> "" THEN  
        FOR I= 0 TO RS.FIELDS.COUNT -1
             RESPONSE.Write(TRIM(RS.FIELDS(I).NAME))
            IF UCASE(TRIM(RS.FIELDS(I).NAME)) = UCASE(TRIM(COL2)) THEN 
                KLI = RS.FIELDS.ITEM(I)
                EXIT FOR
            END IF     
        NEXT       
        IF UCASE(TRIM(KLI)) = UCASE(TRIM(dato2)) THEN MSG = UCASE(PK) + "  DUPLICADO" ELSE MSG = UCASE(PK) + "  PERTENECE A OTRO " + UCASE(COL2)
    ELSE
        MSG = PK + " YA EXISTE"    
    END IF
ELSE
    MSG = ""
end if 
%>
	<script>
		ss =    ('<%=MSG%>') 
		cc2 = '<%=trim(dato) %>'
		if (ss!='')
		{	alert(ss)  
			cad = '../' + '<%=trim(url)%>'  
			window.parent.location.replace(cad)
		}	
		
	</script>
</BODY>
</HTML>
