<!--#include file="../includes/cnn.inc"-->
<!--#include file="../INCLUDES/Loader.asp"-->
<%
'****************************************************************************
' ES LA VENTANITA PARA SUBIR EL ARCHIVO A LA BASE DE DATOS....
' ES UN MUST!
'****************************************************************************
  Response.Buffer = True
  
  
  ' load object
  Dim load
    Set load = new Loader
    ' calling initialize method
    load.initialize
  ' File binary data
  Dim fileData
    fileData = load.getFileData("file")
  ' File name
  Dim fileName
    fileName = LCase(load.getFileName("file"))
  ' File path
  Dim filePath
    filePath = load.getFilePath("file")
  ' File path complete
  Dim filePathComplete
    filePathComplete = load.getFilePathComplete("file")
  ' File size
  Dim fileSize
    fileSize = load.getFileSize("file")
  ' File size translated
  Dim fileSizeTranslated
    fileSizeTranslated = load.getFileSizeTranslated("file")
  ' Content Type
  Dim contentType
    contentType = load.getContentType("file")
  ' No. of Form elements
  Dim countElements
    countElements = load.Count
  ' Value of text input field "fname"
  Set load = Nothing
%>

<html>
<head>
  <title></title>
  <style>
    body, input, td { font-family:verdana,arial; font-size:10pt; }
  </style>
</head>
<body>
  <p align="center">
    <b>PUBLICAR IMAGEN DEL ESTILO</b><br>
 </p>
 <table  border="1" align="center">
  
  <%
    ' Checking to make sure if file was uploaded
    If fileSize > 0 Then
      ' Connection string
      ' abrir archivo de estilos para posicionarlo en el registro donde queremops guardar la imagen
      ' primero DEBEN haberse grabado los datos de texto
      cad = ""
       rs.Open "ESTILOS", cnn, 2, 2       
       ' Adding data
        rs.Addnew
          rs("FOTO").AppendChunk fileData
          rs("CONTENIDO") = contentType
        rs.Update
        rs.Close
        Set rs = Nothing%>

     <font color="green">El archivo fué correctamente publicado...</font>
    <%End If
    If Err.number <> 0 Then%>
      <br><font color="red">El archivo seleccionado es demasiado grande <br />
      No se pudo publicar ...</font>
    <%End If%>
  </p>
  
  <br>
<form method="POST" enctype="multipart/form-data" action="Insert.asp">
  <table border="0" align="center">
  <tr>
      <td>Archivo :</td>
      <td><input type="file" name="file" size="40" /></td>
  </tr>
    <td> </td>
    <td><input type="submit" value="Publicar" /></td>
  </tr>
    </form>
</table>

</body>
</html>
