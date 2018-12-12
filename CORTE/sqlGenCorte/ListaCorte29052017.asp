<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../INCLUDES/CnnDBProd.inc"-->
<!--#include file="../../INCLUDES/JSON/QueryToJSON.asp"-->
<%
Response.ContentType = "application/json; charset=utf-8"
numCorte = trim(Request.QueryString("numCorte"))
Dim cmd
Set cmd = Server.CreateObject("ADODB.Command")
'response.write("sp_Lista_Corte '"&numCorte&"' " )
cmd.CommandText = "sp_Lista_Corte '"&numCorte&"' " 
Set cmd.ActiveConnection = Cnn
QueryToJSON(cmd).Flush
Cnn.Close : Set Cnn = Nothing
%>