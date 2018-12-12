<!--#include file="includes/Cnn.inc"-->
<!--#include file="includes/funcionesVBscript.asp"-->
<%
    set rsclientes = RsNuevo
    rsclientes.open "select codigo,nombre from cliente where stat is null order by 2" , cnn
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Explosion Reporte</title>
    <style type="text/css">
        
        body
        {
            margin: 0;
            padding: 0;
        }
        label
        {
            font-family: Sans-Serif;
        }
        .form-control
        {
            width: 100%;
            display: block;
            color: #232323;
            border: 1px solid #232323;
            padding: 5px 5px;
        }
        .btn
        {
            position: relative;
            width: 80px;
            height: 30px;
            border: 1px solid #f3f3f3;
            background: <%=application("head")%>;
            color: #fff;
            cursor: pointer;
            display: block;
            margin: auto;
            transition: all .2s linear;
        }
        .btn:hover
        {
            background: <%=application("contraste")%>;
        }
    </style>
    <script type="text/javascript" src="COMUN/jquery.js"></script>
</head>
<body>
    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; border-bottom: 1px solid #333">
        <tr>
            <td>
                <center>
                    <img src="imagenes/cerrar.gif" alt="Atras" /></center>
            </td>
            <td style="width:80%;padding:10px">
                <table border="0" style="width: 50%;" cellpadding="0" cellspacing="10" align="center">
                    <tr>
                        <td>
                            <label>
                                Cliente
                            </label>
                            <select class="form-control" id="cliente">
                                <%IF RSclientes.recordcount > 0 THEN%>
                                <%DO WHILE NOT Rsclientes.EOF%>
                                <option value="<%=rsclientes("codigo") %>">
                                    <%=rsclientes("nombre") %></option>
                                <%RSclientes.MOVENEXT%>
                                <%loop %>
                                <% end if %>
                            </select>
                        </td>
                        <td>
                            <label>
                                OFI
                            </label>
                            <input type="text" class="form-control" id="ofi" />
                        </td>
                    </tr>
                    <tr>
                            <td>
                            <label>
                                Excel
                            </label>
                            <input type="checkbox"  id="chkexcel" />
                            </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                        <center>
                                <button class="btn" id="btnbuscar">
                                    Buscar</button>
                            </center></td>
                    </tr>
                </table>
            </td>
            <td>
                <center>
                    <img src="imagenes/cerrar.gif" alt="Logo" /></center>
            </td>
        </tr>
    </table>
    <div style="width: 100%" id="contenido">
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            var cliente = $("#cliente");
            var ofi = $("#ofi");
            var po = $("#po");
            var proto = $("#proto");
            var estilo = $("#estilo");
            $("#btnbuscar").on("click", function () {
                var excel = 0;
                var url = "./explosionreporte_deta.asp";
                if ($("#chkexcel")[0].checked) {
                    url += "?excel=1"
                    window.open(url);
                } else {
                    $.ajax(
                    { url: url, data: {},cache:false, success: function (result) {
                        $("#contenido").html(result);

                    }
                    });
                }
            });
        });
    </script>
</body>
</html>
