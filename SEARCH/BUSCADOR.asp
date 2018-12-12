<%@ Language=VBScript %>
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<HTML>
<HEAD>
</HEAD>
<BODY >
<HTML>
<%	DATO	= Request.QueryString("pos")
    DATO2	= Request.QueryString("pos2")
	col		= Request.QueryString("col")
	col2	= Request.QueryString("col2")
	tbL		= trim(Application("owner"))+"."+trim(Request.QueryString("tbl"))
	url		= Request.QueryString("url")
	msg1    = Request.QueryString("msg1")
	msg2    = Request.QueryString("msg2")
	errr = ""	
CAD =	" SELECT  * from "&tbl&"	    " & _
		" where "&col&" = '"&dato&"'	"
IF TRIM(COL2) <> "" THEN
CAD = CAD + " AND "&COL2&" = '"&DATO2&"'  "
end if		
	RS.Open  CAD, cnn
	IF rs.recordcount <= 0 THEN 
		CAD =	" SELECT  * from "&tbl&"	    " & _
		" where "&col&" like '"&dato&"%'   	"
        IF TRIM(COL2) <> "" THEN
        CAD = CAD + " AND "&COL2&" = '"&DATO2&"'  "
        end if
        response.Write(cad)
        rs.close
        rs.open cad,cnn
	end if	
	IF rs.recordcount <= 0 THEN 
	    errr = "XX" 	
	else 
	    errr = rs.fields.item(0) 
	    IF TRIM(COL2) <> "" THEN  cli = rs(col2)    else cli= ""
	end if
%>
	<script>
		ss =trim('<%=errr%>') 
		cc1 = '<%=trim(cli) %>'
		cc2 = '<%=trim(dato2) %>'
		if (ss=='XX' && trim(cc1)== trim(cc2) )
		{	alert('<%=ucase(msg1) %>')  
		    cad =  '<%=trim(url)%>' + '&pos='
		    window.parent.location.replace(cad)
		}		
		else if (ss=='XX' && trim(cc1)!= trim(cc2) )
		{   alert('<%=ucase(msg2) %>')  
		    cad =  '<%=trim(url)%>' + '&pos=' + ss
	        window.parent.location.replace(cad)
	    }    
	    else
	    {   cad =  '<%=trim(url)%>' + '&pos=' + ss
	        window.parent.location.replace(cad)
	    }
	</script>
</BODY>
</HTML>
