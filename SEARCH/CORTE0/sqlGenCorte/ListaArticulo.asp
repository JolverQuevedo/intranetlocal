<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../INCLUDES/CnnDBProd.inc"-->
<!--#include file="../../INCLUDES/JSON/QueryToJSON.asp"-->
<%
Response.ContentType = "application/json; charset=utf-8"
st_ccodcli = trim(Request.QueryString("st_ccodcli"))
st_ccodigo = trim(Request.QueryString("st_ccodigo"))
Dim cmd
Set cmd = Server.CreateObject("ADODB.Command")
cmd.CommandText = "sp_ListaArticulo '"&st_ccodcli&"','"&st_ccodigo&"'" 
Set cmd.ActiveConnection = Cnn
QueryToJSON(cmd).Flush
Cnn.Close : Set Cnn = Nothing
%>