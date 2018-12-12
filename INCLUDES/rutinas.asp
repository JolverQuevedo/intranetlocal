<%
' Evita el cache del navegador
Response.addHeader "pragma", "no-cache"
Response.CacheControl = "Private"
Response.Expires = 0


' Valida que la session del usuario este activa
' siempre y cuando no este en la ventana ingreso asp

'If Trim(Request.Cookies("Usuario")("USUARIO"))="" And LCase(Right(Request.ServerVariables("URL"),11))<>"ingreso.asp" Then

	'Response.Write(direcionar("ingreso.asp"))
	'Response.End
'End If
'------------------------------------------------------------------------------------
' Prepara valor de una variable para interactuar con sentencias SQL
Function prepara_str_sql(ByVal str)
	If Not IsNull(str) Then
		str = trim(str)
		str = replace(str,"'","''")
		str = replace(str,"--","")
	End If
	prepara_str_sql = str
End Function
'-------------------------------------------------------------------------------------
' Prepara valor de una variable para interactuar con HTML
Function prepara_str_html(ByVal str)
	str = Trim(str)
	If str <>"" Then
		str = Server.HTMLEncode(str)
		'str = replace(str,"Ñ","&Ntilde;")
		'str = replace(str,"ñ","&ntilde;")
	Else
		str = "&nbsp;"
	End If
	prepara_str_html = str
End Function
'------------------------------------------------------------------------------------
' Prepara valor de una variable para interactuar con XML
Function prepara_str_xml(ByVal str)
	If Trim(str)="" or IsNull(str) Then
		str="null"
	Else
		str = Trim(str)
	End If
	prepara_str_xml = str
End Function
'------------------------------------------------------------------------------------
Function direcionar(ByVal url)
	direcionar="<script language='javascript'>location.replace('"&url&"')</script>"
End Function
'------------------------------------------------------------------------------------
Function abrir_ventana(ByVal url, ByVal ancho, ByVal alto)
	Dim propiedades
	propiedades = "'"&url&"','_blank','width="&ancho&",scrollbars=no,status=yes,height="&alto&",top=0,left='+((screen.height -"&alto&")/ 2)+''"
	abrir_ventana="<script language='javascript'>window.open("&propiedades&")</script>"
End Function
'------------------------------------------------------------------------------------
Function cerrar_ventana()
	cerrar_ventana="<script language='javascript'>window.close()</script>"
End Function
'------------------------------------------------------------------------------------
Function verif_nulos(ByVal str)
	If str="" or IsNull(str) Then
		str="null"
	Else
		str="'"&str&"'"
	End If
		verif_nulos=str
End Function
'------------------------------------------------------------------------------------
Function mensaje(ByVal msg)
		mensaje="<script language='javascript'>alert('"&msg&"')</script>"
End Function
'------------------------------------------------------------------------------------
Function linkea(ByVal url)
	linkea="location.replace('"&url&"')"
End Function

'----------------------------------------------------------------------------
' Genera las opciones del select o combobox
Function op_combo(ByVal SQL,rs,cnn)
	Dim output

	rs.Open SQL,cnn
	If rs.RecordCount > 0 Then
		rs.MoveFirst
		Do While Not rs.EOF
			output = output&"<option value="""&Trim(rs(0))&""" >"&prepara_str_html(rs(1))&"</option> "
			rs.MoveNext
		Loop
	End If
	rs.Close
	op_combo=output
	set output=Nothing
End Function
'----------------------------------------------------------------------------
' Genera las opciones del select o combobox con soporte a opciones por defecto
Function opc_combo(ByVal SQL,rs,cnn,ByVal def)
	Dim output
	Dim sele
	rs.Open SQL,cnn
	If rs.RecordCount > 0 Then
		rs.MoveFirst
		Do While Not rs.EOF
			If def= Trim(rs(0)) Then sele="selected" Else sele=""
			output = output&"<option value="""&Trim(rs(0))&""" "&sele&">"&prepara_str_html(rs(1))&"</option> "
			rs.MoveNext
		Loop
	End If
	rs.Close
	opc_combo=output
	set output=Nothing
End Function

'----------------------------------------------------------------------------
' Busca un valor en un Array Unidimensional y devuelve su indice correspondiente
Function busq_array(arr, ByVal val)
	Dim flag
	Dim ix 'Indice
	flag = false
	For ix = 0 To UBound(arr)
		If Trim(arr(ix))= Trim(val) Then
			flag=true
			Exit For
		End If
	Next
	If flag=true Then
		busq_array = ix
	Else
		busq_array = -1
	End If
End Function

'----------------------------------------------------------------------------
' Suma los valores enteros de un array
Function sumval_array(arr)
Dim output
Dim ix
output=0
For Each ix in arr
	output=output + ix
Next
sumval_array = output
End Function

'-----------------------------------------------------------------------------
Function RenombrarArchivo(origen,destino)
	Dim fso
	Set fso = CreateObject("Scripting.FileSystemObject")
	if (fso.FileExists(destino)) then 
		fso.DeleteFile destino,true
	end  if
	if (fso.FileExists(origen)) then 
		fso.MoveFile origen, destino
	else
		Response.Write("Archivo no encontrado! "&origen)
	end if
	set fso = nothing
End function
'-----------------------------------------------------------------------------
Function RecargaVentanaMadre()
RecargaVentanaMadre="<script language='javascript'>window.opener.location.reload()</script>"
End Function 
'-----------------------------------------------------------------------------
Function NavegaHistory(ByVal n)
NavegaHistory="<script language='javascript'>history.go("&n&")</script>"
End Function 

%>
