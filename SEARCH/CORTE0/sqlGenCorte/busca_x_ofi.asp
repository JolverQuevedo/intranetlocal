<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../INCLUDES/CnnDBProd.inc"-->
<!--#include file="../../INCLUDES/JSON/QueryToJSON.asp"-->
<%
Response.ContentType = "application/json; charset=utf-8"
nroOFI = trim(Request.QueryString("nroOFI"))
Dim cmd
Set cmd = Server.CreateObject("ADODB.Command")
cmd.CommandText = "sp_Busca_x_Ofi '"&nroOFI&"'" 
Set cmd.ActiveConnection = Cnn
QueryToJSON(cmd).Flush
Cnn.Close : Set Cnn = Nothing
%>