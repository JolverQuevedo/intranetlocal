<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>
<!--#include file="includes/Cnn.inc"-->
<!--#include file="COMUN/FUNCIONESCOMUNES.ASP"-->
<script type="text/jscript" language="jscript">

function calcHeight()
{
  //find the height of the internal page
  var the_height=
    document.getElementById('body0').contentWindow.
      document.body.scrollHeight+25;

  //change the height of the iframe
  document.getElementById('body0').height=
      the_height;
}

</script>
<%Set RS2 = Server.CreateObject("ADODB.Recordset")
	RS2.CursorLocation   = 3
	RS2.CursorType       = 3    
	RS2.LockType         = 1 
   
 
    PRO	= left(Request.QueryString("PRO"),10)
	VER = right(Request.QueryString("VER"),3)
	cot = Request.QueryString("cot")

	%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" lang="es-pe" />
<title></title>
<link rel="stylesheet" type="text/css" href="ESTILOS1.CSS" />

</head>
<body >
<form id="thisForm" method="post" name="thisForm" action="">


    <table  border="0" cellspacing="0" cellpadding="0" align="left">
  <tr>
   <%DAD = " exec FICHAposdeta '"&cot&"' , '"&VER&"'  " 
  ' RESPONSE.WRITE(DAD)
   RS2.OPEN DAD, CNN 
              IF RS2.RECORDCOUNT > 0 THEN 
                dim atal , ACAN
                atal = array()
                ACAN = ARRAY()
                RS2.MOVEFIRST%>
                    <%DO WHILE NOT RS2.EOF %>
                        <%redim preserve ATAL(ubound(atal)+1)
                        redim preserve acan(ubound(acan )+1)
                        atal(ubound(atal))= rs2("talla")
                        ACAN(ubound(ACAN))= rs2("CANT")
                       RS2.MOVENEXT%>
                   <%LOOP%>    
              <%END IF%>     

   
    <table  border="0" cellspacing="0" cellpadding="0" align="left">
        <tr>
            <td width="10%" class="american2" align="right">TALLAS :&nbsp;&nbsp; </td>
            <%FOR I = 0 TO 9%>
               <td align="center" class="texto" width="8%">
                <%if i <= UBOUND(ATAL) then  %>
               <input id="x<%=i%>" name="x<%=i%>" value="<%=trim(atal(i))%>" class="texto" style="text-align:center" tabindex=-1 readonly/>
               <%end if %>
               </td>    
            <%NEXT%>
            <td width="10%" class="american2" align="center">&nbsp;TOTAL PRENDAS&nbsp;</td>
        
        </tr>   
        <tr>
            <td width="10%" class="american2" align="right">CANTIDADES :&nbsp;&nbsp; </td>
            <%FOR I = 0 TO 9%>
               <td align="center" class="TEXTOblue" width="8%">
                <%if i <= UBOUND(ATAL) then  %>
                    <input id="T<%=i%>" name="T<%=i%>" value="<%=formatnumber(TRIM(acan(i)),0,,true)%>" class="DATOSyellow"  onchange="suma();TOTALIZA()"  style="width:50px">   
                <%end if%>
            </td> 
           <%NEXT%>
           <td width="10%"><input id="CAN" name="CAN" readonly class="TEXTOblue" value= 0 style="text-align:center; padding-right:10px;" tabindex="-1"></td>   
        </tr> 
       
    </table>




<script type="text/jscript" language="jscript">
var opc  = "directories=no,status=no,titlebar=yes,toolbar=no,hotkeys=no,location=no," ;
	opc += "menubar=no,resizable=yes,scrollbars=yes,left=0,top=0,height=600,width=900" ;
	
</script>
<%	RS.Close  
SET RS  = NOTHING
Cnn.Close
SET Cnn = NOTHING %>
</form>
</body>
</html>