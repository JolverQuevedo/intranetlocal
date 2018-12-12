<!--#include file="../includes/Cnn.inc"-->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="../INCLUDES/jquery.js" type="text/javascript"></script>
    <style>
        *{
            color:#333;
            font-family:  sans-serif;
        }
        #contenido{
            max-width: 960px;
            width: 960px;
            height: 100vh;
            margin:0 auto;
            background: #fafafa;
        }
        .table{width: 100%}
        .table__header{
            background: <%=APPLICATION("head")%>;

        }.table__header>th{color:#fff;}
    </style>
</head>
<body>
    <table style="width:100%" align="center">
        <tr>
            <td>
                <center><img src="../imagenes/atras.gif" alt="Atras"></center>
            </td>
            <td >
                 <center><h1>Generacion de Cortes</h1></center>
            </td>
            <td >
                <center><img src="../imagenes/logo.gif" alt=""></center>
            </td>
        </tr>
    </table>

    <div id="contenido">
        <table class="table" cellpadding="0" cellspacing="0">
            <tr class="table__header">
                <th>OFI</th>
                <th>ESTILO</th>
                <th>PRENDA</th>
                <th>ARTICULO</th>
                <th>NRO CORTE</th>
                <th>FECHA</th>
            </tr>
        </table>
    </div>


    <script src="./js/cortes.js"></script>
    <script src="" language="JavaScript" type="text/"></script>
</body>
</html>