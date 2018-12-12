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

 <table  border="1" align="center"> 
  <%
    ' Checking to make sure if file was uploaded   
     cad = "select foto, CONTENIDO from TB_CTRL " 
      response.write(cad)
      'response.end
      rs.open cad,cnn,2,2
      if rs.recordcount>0 then 
   
        rs.movefirst
        If fileSize > 0 then
            rs("FOTO").AppendChunk fileData
            rs("CONTENIDO") = contentType
               
        end if
        rs.update
        rs.close
        set rs= Nothing

      end if  %>
   <font color="green">El archivo fué correctamente publicado...</font>   
<%    If Err.number <> 0 Then%>
      <br><font color="red">El archivo seleccionado es demasiado grande <br />
      No se pudo publicar ...</font>
    <%End If %>
      
</body>
</html>
