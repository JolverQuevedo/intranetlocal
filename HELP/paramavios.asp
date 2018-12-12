<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<link rel="stylesheet" type="text/css" href="../ESTILOS1.CSS" />
<!--#include file="../includes/Cnn.inc"-->
<!--#include file="../COMUN/FUNCIONESCOMUNES.ASP"-->
<!--#include file="../COMUN/COMUNhlp.ASP"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
</head>
            
<script type="text/jscript" language="jscript">            
var aDDD = new Array()
var ind = 0
</script>
<%fam = Request.QueryString("fam")
dim aDes 
aDes = Array()
%>
<body topmargin="0" leftmargin="0" rightmargin="0" >
<table	align="center" width="100%" cellpadding="1" cellspacing="0"   border="1" >
    <tr>
       <td width="100%" > 
          <%CAD = "SELECT * FROM PARAMFAMAVIOS WHERE ESTADO = 'A' and familia = '"&fam&"' ORDER BY ID"
	            RS.OPEN CAD, Cnn %>
	            <%if rs.recordcount <=0 then%>
                <center><span class="talasrojo">No hay parámetros definidos para esta familia</span></center>
                <%response.end %>
                <%else%>
				    <%rs.movefirst%>
				    <table width=100% align="center">
                        <%marca = 0%>
                        <%do while not rs.eof%>
                            <tr>                               
                               <td class="TEXTOblue" width="10%"  bgcolor="<%=(Application("barra"))%>"><%=trim(RS("DATO"))%></td>
                                <td width="40%">
                                    <%ReDim preserve aDes(ubound(aDes)+1)
                                    aDes(uBound(aDes)) = trim(RS("DATO"))%>    
                                    <%IF ISNULL(TRIM(RS("VALOR"))) THEN %> 
                                        <input id="F<%=marca%>" name="F<%=marca%>" onchange="llenado('<%=marca%>',this.value)" class="datos" />
                                    <%ELSE%>
                            	        <%=TRIM(RS("VALOR"))%>
                                    <%END IF%>    
                                </td>   
                                <%rs.movenext%>
                                <%marca = marca + 1%>
                                <%if rs.eof then exit do%>
                                <td class="TEXTOblue" width="10%"  bgcolor="<%=(Application("barra"))%>"><%=trim(RS("DATO"))%></td>
                                <td>
                                   <%ReDim preserve aDes(ubound(aDes)+1)
                                   aDes(uBound(aDes)) = trim(RS("DATO"))%>    
                                   <%IF ISNULL(TRIM(RS("VALOR"))) THEN %> 
                                        <input id="F<%=marca%>" name="F<%=marca%>" onchange="llenado('<%=marca%>',this.value)" class="datos" />
                                   <%ELSE%>
                                	    <%=TRIM(RS("VALOR"))%>
                                   <%END IF%>    
                                </td>   
                                <%rs.movenext%>
                                <%marca = marca + 1%>
                            </tr>
                        <%loop%>
                    </table>
              <%end if %>
              <%rs.close%>
        </td>
    </tr>
</table>
<center>
    <img src="../imagenes/done.jpg" style="cursor:hand" onclick="verifica()" alt="Genera Descriptor"/>
</center>

</body>            
<%for i=0 to ubound(ades)
    vari = aDes(i)%>
    <script type="text/jscript" language="jscript">
        aDDD[ind++] = '<%=ltrim(rtrim(vari))%>'
    </script>
<%next%>            
            
            
<script type="text/jscript" language="jscript">
tope = parseInt('<%=marca%>',10)

function llenado(opc,Gcad)
{   window.parent.thisForm.DES.value = window.parent.thisForm.FAM.value + ','
    for (o=0;o<tope; o++)
    {   if (eval("document.all.F"+o)== undefined)
        {   cad = rtrim(eval("document.all.C"+o+".value"))
            window.parent.thisForm.DES.value +=' ' + cad ;
        }
        else    
        {   cad = eval("document.all.F"+o+".value")
            cad = cad.toUpperCase()    
            cad = rtrim(cad)  
            window.parent.thisForm.DES.value +=' ' +  cad ;
        }   
    }
}

function verifica()
{  /*   Yessica solicitó que no sean obligatorios los campos de parámetro
        FECHA 28-04-2011, SEGÚN CORREO
CON = 0
    for (o=0;o<tope; o++)
    {   if ((eval("document.all.F"+o) == undefined && (eval("document.all.C"+o+".value")) ==  '') || ( eval("document.all.C"+o)== undefined  && trim(eval("document.all.F"+o+".value")) ==  ''))
        {   //alert(o)
            CON++;
        }    
    } 
  if (CON > 0)
    {   alert("Los datos están incompletos, por favor REVISE...");
        return false;
    }
*/    
    parent.window.document.all.ACTIV.src='';
    parent.window.calcHeight(); 
    parent.window.document.all.ACTIV.style.visibility = 'hidden';   

}
</script>

</html>
