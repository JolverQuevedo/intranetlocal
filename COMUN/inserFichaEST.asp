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
  Dim fCli
    fCli = load.getValue("CLI")
  Dim fEst
    fEst = load.getValue("COD")
  Dim fDes
    fDes = load.getValue("DES")  
  Dim fArt
    fArt = load.getValue("ART")  
  Dim fEcl
    fEcl = load.getValue("ECL")
  Dim  fGen
    fGen = load.getValue("GEN")
  Dim fTip 
    fTip = load.getValue("TIP")
  Dim fObs
    fObs = load.getValue("OBS")
  Dim fUsr
    fUsr = load.getValue("USR")  
  Dim fFec
    fFec = load.getValue("FEC")  
  Dim dMod
    dMod = load.getValue("DMOD")   
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

  <% 
    ' Checking to make sure if file was uploaded
    If fileSize > 0 and trim(fest) = "AUTO" Then
   
      ' Connection string
      cad = "select count(*) as esti from estilos where cliente = '"&fCli&"' " 
      rs.open cad,cnn
      if rs.recordcount>0 then 
        fEst = right("00000"+ cstr(cdbl(rs("esti"))+1),5) 
      else 
        fEst = "00001"
      end if
      rs.close
       rs.Open "estilos", cnn, 2, 2       
       ' Adding data
        rs.AddNew
          ggraba()
          rs("USUCREA") = fUsr
          rs("FECCREA") = fFec
          rs("FOTO").AppendChunk fileData
          rs("CONTENIDO") = contentType
        rs.Update
        rs.Close
        Set rs = Nothing
        %>
     <font color="green">El archivo fué correctamente publicado...</font>
    <%else   
        if trim(fest) = "AUTO" then 
            cad = "select count(*) as esti from estilos where cliente = '"&fCli&"' " 
            rs.open cad,cnn
            if rs.recordcount>0 then 
                fEst = right("00000"+ cstr(cdbl(rs("esti"))+1),5) 
            else 
                fEst = "00001"
            end if
            rs.close
            rs.Open "estilos", cnn, 2, 2       
           ' Adding data
            rs.AddNew
            ggraba()
          rs("USUCREA") = fUsr
          rs("FECCREA") = fFec
          rs("FOTO").AppendChunk fileData
          rs("CONTENIDO") = contentType
        rs.Update
        rs.Close
        response.write("sin foto")
       else

	  kad = "update RSFACCAR.dbo.AL0001ARTI set AR_CDESCRI =left('"&dMod&"',60) where AR_CCODIGO='"&(right(fArt,5)+"00000")&"'"
          response.write(+"<br/>"+kad)
          Cnn.Execute(KAD)

          cad = "select * from estilos where cliente = '"&fCli&"' and codest= '"&fest&"' " 
          response.write(cad)
          rs.open cad,cnn,2,2
          if rs.recordcount>0 then 
            rs.movefirst
               ggraba() 
                If fileSize > 0 then
                    rs("FOTO").AppendChunk fileData
                    rs("CONTENIDO") = contentType
                end if
            rs.update
            rs.close
            set rs= Nothing
          end if
      end if  
     %> 
    <%End If
    If Err.number <> 0 Then%>
      <br><font color="red">El archivo seleccionado es demasiado grande <br />
      No se pudo publicar ...</font>
    <%End If %>
    <script language="jscript" type="text/jscript">
        window.opener.window.location.replace('../detaestilo.asp?pos=' + '<%=fCli%>' + '&gen=1&est=' + '<%=fEst%>')
       window.close()
    </script>
  
  <%sub ggraba()
      rs("CLIENTE") = fCli
      rs("CODEST") = fEst
      rs("ESTCLI") = fEcl
      rs("DESCRIPCION") = fDes
      rs("DESMODELADOR") = dMod
      rs("CODARTICULO") = fArt
      rs("GENERO") = fGen
      rs("TIPOPRENDA") = fTip
      rs("OBSERVACION") = fObs
      rs("USUMOD") = fUsr
      rs("FECMOD") = fFec
  end sub
   %>
  
</body>
</html>
