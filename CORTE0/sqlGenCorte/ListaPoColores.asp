<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../../INCLUDES/CnnDBProd.inc"-->
<!--#include file="../../INCLUDES/JSON/QueryToJSON.asp"-->
<%
Response.ContentType = "application/json; charset=utf-8"
do_ccodigo = trim(Request.QueryString("do_ccodigo"))
do_ctipo   = trim(Request.QueryString("do_ctipo"))
opc		   = trim(Request.QueryString("opc"))	
Dim cmd
Set cmd = Server.CreateObject("ADODB.Command")
cmd.CommandText = "ListaPoColores '"&do_ccodigo&"','"&opc&"'" 
Set cmd.ActiveConnection = Cnn
QueryToJSON(cmd).Flush
Cnn.Close : Set Cnn = Nothing
%>