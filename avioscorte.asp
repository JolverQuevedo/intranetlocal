<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=9">
    <title>Page Title</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css"href="estilos1.css" />
    <!--#include file="./includes/Cnn.inc"-->
    <style>
        *{
            font-family: Arial, Helvetica, sans-serif;
            font-size:12px;
            color:#000 !important;
            text-transform: uppercase
        }
        h1{
            color:#0087d1;
            font-size: 16px;
        }
        body{
            position: relative;
            max-width: 900px;
            margin:0 auto;
        }
		#btnexit{position:absolute;top:0;right:0;width:120px;color:#fff;;background:steelblue;border:none;padding:12px 12px 12px 12px;margin:0px;}
		@media print {
		   #btnexit{display:none}
		}

    </style>
    <script src="./COMUN/jquery.js"></script>
</head>
<body>
    <%
        if request.querystring("corte") = undefined then
    %>
    <table WIDTH=100%>
            <tr>
                <td align= left WIDTH=35% ROWSPAN=2>
                    <img src="imagenes/ATRAS.gif" 
                    style="cursor:hand;"
                    onclick="javascript: top.window.location.replace('SUBMENU.ASP?TIPO=4');">
                </td>
                <td align= CENTER>
                    <font face=arial size= 3 color=DarkBlue><B>Avios por Corte
                    </b></font>
                </td>
                <TD ALIGN=right WIDTH=35% ROWSPAN=2><img src="imagenes/logo.GIF"></TD>
            </TR>    
            <tr>
                <td>
                    <label >Ingre N° de Corte</label>
                    <input type="text" style="width:120px" class="barra3" id="txtbuscar">
                    <button style="width:120px;color:#fff;;background:steelblue;border:none;padding:12px 12px 12px 12px;margin:0px;" onclick="window.location.replace('./avioscorte.asp?corte='+document.getElementById('txtbuscar').value)">Buscar</button>
                </td>
            </tr>
    </table>
    <%
        else
    %>
    <button id="btnexit" style="" onclick="window.location.replace('./avioscorte.asp')">Salir</button>
    <h1 style="text-align:center">Corte <%=request.querystring("corte") %></h1>
    <hr />
    
    <table style="display:block;" align=center id="a" borderColor=white cols=2 border=1 cellSpacing=1 cellPadding=2>
        <tr style="background:#0087d1;color:#ffffff">
            <td >Ofi</td>
            <td >Corte</td>
            <td >Talla</td>
            <td >Total</td>
            <td >Color</td>
        </tr>
            
            <% 
                cad1= "exec datos_tallas_corte '"&request.querystring("corte")&"'" 
                'response.write(cad1)
                DIM MyData(100,1) 
                contador = 0
                rs.open cad1,cnn
                
            %>
            <%do until rs.EOF%>
                <tr>
                <%for each x in rs.Fields%>
                <td><%
                    if x.name ="COLOR" then
                        color = x.value
                    END IF
                    if x.name ="ofi" then
                        ofi = x.value
                    END IF
                    if x.name ="TALLA" then
                        MyData (contador,0) = x.value
                    END IF
                    if x.name ="sumtot" then
                        MyData (contador,1) = x.value
                    END IF
                    Response.Write(x.value)
                %></td>
                <%next
                rs.MoveNext
                contador=contador+1%>
                </tr>
            <%loop
            'rs.close
           %>
    </table>

    <%
    cad3= "SELECT t2.descripcion,t3.po,t6.descripcion as 'tela',PO,t2.ESTCLI,t4.PROTO+'-'+t4.version as protoversion,t2.CODARTICULO, t7.CODIGO as codtempo, t7.DESCRIPCION as destempo,t8.DESCRIPCION as genero,t2.DESCRIPCION as tipoprenda   FROM OFIS AS T1 "
            cad3 = cad3+"INNER JOIN ESTILOS AS T2 ON T1.CLIENTE=T2.CLIENTE AND T1.CODEST=T2.CODEST "
            cad3 = cad3+"INNER JOIN POS AS T3 ON T1.CODIGO=T3.ofi "
            cad3 = cad3+"INNER JOIN cotizacion AS T4 ON T4.COTIZACION=T3.COTIZACION "
            cad3 = cad3+"INNER JOIN protos AS T5 ON T5.PROTO=T4.PROTO and t5.VERSION=t4.VERSION "
            cad3 = cad3+"INNER JOIN TELAS AS T6 ON T5.TELA=T6.TELA INNER JOIN temporadas AS T7 ON T5.TEMPORADA = T7.CODIGO  and t7.CLIENTE=t3.CLIENTE INNER JOIN GENEROS AS T8 ON T8.GENERO = T2.GENERO"
            cad3 = cad3+" wHERE T1.CODIGO='"&ofi&"'  "
    'response.write(cad3)
    Set RS3 = Server.CreateObject("ADODB.Recordset")
    RS3.ActiveConnection = Cnn
    RS3.CursorType       = 3 'CONST adOpenStatic = 3
    RS3.LockType         = 1 'CONST adReadOnly = 1
    RS3.CursorLocation   = 3 'CONST adUseClient = 3
    rs3.open cad3,cnn
    %>
<table id="b">
    <tr>
        <td  style="width:50%;">
            <center>
            
            <table border="0" cellpadding="0" cellspacing="0" >
                <tr>
        <td>Corte</td>
        <td><b><%=request.querystring("corte")%></b></td>
    </tr>
    <tr>
        <td>Articulo </td>
        <td>&nbsp;<b>
            <%if rs3.recordcount > 0 then
                response.write(rs3("descripcion"))
            end if%></b>
        </td>
    </tr>
    <tr>
        <td>Color </td>
        <td>&nbsp;<b><%=color%></b></td>
    </tr>
    <tr>
        <td>OFI </td>
        <td>&nbsp;<b><%=ofi%></b></td>
    </tr>
    <tr>
        <td>PO </td>
        <td>&nbsp;<b><%=rs3("PO")%></b></td>
    </tr>
    <tr>
        <td>TELA </td>
        <td>&nbsp;<b><%=rs3("TELA")%></b></td>
    </tr>
    
            </table></center>
        </td>
        <td  style="width:50%;">
            <center>
            <table border="0" cellpadding="0" cellspacing="0">
            <tr>
        <td>Estilo </td>
        <td>&nbsp;<b><%=rs3("estcli")%></b></td>
    </tr>
    <tr>
        <td>Proto Version </td>
        <td>&nbsp;<b><%=rs3("protoversion")%></b></td>
    </tr>
    <tr>
        <td>Temporada </td>
        <td>&nbsp;<b><%=rs3("codtempo") &"-"&rs3("destempo")%></b></td>
    </tr>
    <tr>
        <td>ARTICULO </td>
        <td>&nbsp;<b><%=rs3("CODARTICULO")%></b></td>
    </tr>
    <tr>
        <td>GENERO </td>
        <td>&nbsp;<b><%=rs3("GENERO")%></b></td>
    </tr>
    <tr>
        <td>Tipo de prenda </td>
        <td>&nbsp;<b><%=rs3("tipoprenda")%></b></td>
    </tr>
    </table>
    </center>
        </td>
    </tr>
    
</table>
<h1>Avios</h1>
    <table  width="900px" align=center id=c borderColor=white bgColor=lightgrey cols=2 border=1 cellSpacing=1 cellPadding=2>
        <tr style="background:#0087d1;color:#ffffff">
            <td>AVIO	</td>
            <td>DESCRIPCION	</td>
            <!-- <td>color	</td> -->
            <!-- <td>ID	</td> -->
            <td>OBSERVACION	</td>
            <td>UNIDAD	</td>
            <td id="col0">T0	</td>
            <td id="col1">T1	</td>
            <td id="col2">T2	</td>
            <td id="col3">T3	</td>
            <td id="col4">T4	</td>
            <td id="col5">T5	</td>
            <td id="col6">T6	</td>
            <td id="col7">T7	</td>
            <td id="col8">T8	</td>
            <td id="col9">T9	</td>
            <td id="colT">TOTAL	</td>
            
        </tr>
            
            <% 
                cad2= "exec DATOS_avios_OFI_2 '"&ofi&"','"&color&"'" 
                'response.write(cad2)
                Set RS2 = Server.CreateObject("ADODB.Recordset")
                RS2.ActiveConnection = Cnn
                RS2.CursorType       = 3 'CONST adOpenStatic = 3
                RS2.LockType         = 1 'CONST adReadOnly = 1
                RS2.CursorLocation   = 3 'CONST adUseClient = 3
                rs2.open cad2,cnn
                vertical = 0
            %>
           <%DO WHILE NOT RS2.EOF %>
                <tr>
                    <td><%=trim(rs2("avio"))%></td>
                    <td><%=trim(rs2("desavi"))%></td>
                    <!-- <td><%=rs2("color")%></td> -->
                    <!-- <td><%=rs2("ID")%></td> -->
                    <td><%=trim(rs2("OBS"))%></td>
                    <td><%=trim(rs2("uni"))%></td>
                    <% for i=0 to 9 %>
                    <td class="col<%=i%> col<%=vertical%>x<%=i%>">
                        <span class="coll<%=i%>" style="display:none"><%=rs2("T"&i)%></span>
                        <%''="Total1: "&(CDbl(rs2("C"&i)))&"<br>"%>
                        
                        <%''="Total2: "&(CDbl(rs2("CN"&i)))&"<br>"%>
                        
                        <p>
                        
                        <%
                            x = (CDbl(rs2("CN"&i)))
                            y = (CDbl(rs2("C"&i)))
                            if(x = 0 or y = 0) then
                                response.write("0")
                            else
                                z = UCase(trim(rs2("T"&i)))
                                'response.write(z)
                                for l = 0 to UBound(MyData)
                                    'response.write(z&"666"&MyData(l,0)&"<br>")
                                    if(MyData(l,0) = z) then
                                        'response.write(x&"/"&y&"*"&MyData(l,1)&"<br>")
                                        yyyy=(x/y*CDbl(MyData(l,1)))
                                        response.write("<span style='color:#111'>"&Int(yyyy)&"</span>")
                                        Exit For
                                    else
                                        response.write(0)
                                    end if
                                next
                            end if 
                            
                        %>
                        </p>
                    </td>
                    <%next
                    
                    %>
                    <td id="tttt<%=vertical%>"></td>
                    <%vertical=vertical+1%>
                </tr>
                <%RS2.MOVENEXT%>
            <%LOOP%>
    </table>
    <script>
        for(i = 0;i<=9;i++){
            document.getElementById("col"+i).innerText=document.getElementsByClassName("coll"+i)[0].innerText;
        }

        function totales(){
            for(x=0;x < <%=vertical%> ;x++){
                var t=0;
                
                for(y=0;y<=9 ;y++){
                    $(".col"+x+"x"+y).find("p").text(parseInt($.trim($(".col"+x+"x"+y).find("p").text())));
                    t+=parseInt($.trim($(".col"+x+"x"+y).find("p").text()))
                }
            document.getElementById("tttt"+x).innerText=t;
            }
        }
        function limpiazeros(){
            for(y=0;y<=9 ;y++){
                if($("#col"+y).text() == ""){
                    document.getElementById("col"+y).style.display="none"
                    for(x=0;x < <%=vertical%> ;x++){
                        $(".col"+x+"x"+y).css("display","none")
                    }
                }
            }
        }
        limpiazeros();
        totales();
         $("#a").before($("#b"));
    </script>
    <%end if%>
</body>
</html>

                        