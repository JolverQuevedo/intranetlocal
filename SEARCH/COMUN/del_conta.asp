<%@ Language=VBScript %>
<%Usuario = Request.Cookies("Usuario")("USUARIO")%>
<!--#include file="../includes/Cnn.inc"-->

<%Response.Buffer = TRUE %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<%Set   RS2 = Server.CreateObject("ADODB.Recordset")
	    RS2.ActiveConnection = Cnn
	    RS2.CursorType       = 3 'CONST adOpenStatic = 3
	    RS2.LockType         = 1 'CONST adReadOnly = 1
	    RS2.CursorLocation   = 3 'CONST adUseClient = 3



'*********************** OJO **********************
'REVISAR EL LARGO DE LAS COLUMNAS de la tabla
'*********************** OJO **********************
mes = TRIM(Request.QueryString("mes"))
MesES="ENERO,FEBRERO,MARZO,ABRIL,MAYO,JUNIO,JULIO,AGOSTO,SETIEMBRE,OCTUBRE,NOVIEMBRE,DICIEMBRE"  
aMes= split(meses,",")
ANO = TRIM(Request.QueryString("ANO"))

TBL1 = "RSCONCAR..CT0001COMC" + RIGHT(ANO,2)
TBL2 = "RSCONCAR..CT0001COMD" + RIGHT(ANO,2)
TBL3 = "RSCONCAR..CT0001BALH" + RIGHT(ANO,2)
TBL4 = "RSCONCAR..CT0001CTL4" + RIGHT(ANO,2)
TBL5 = "RSCONCAR..CT0001DOCF" + RIGHT(ANO,2)

FECHa = ano + right("00"+mes,2)
response.write("mes = ")
response.write(mes)
RESPONSE.Write("<br>")
RESPONSE.Write("<br>")
response.write("a—O = ")
response.write(ANO)

mes = right("00"+mes,2)+"%"

RESPONSE.Write("<br>")
RESPONSE.Write("<br>")

cad = "set dateformat dmy; Select * From "&TBL1&" Where CSUBDIA='05' AND CCOMPRO like '"&mes&"' order by 2 desc"
'RESPONSE.Write(Cad)
'RESPONSE.Write("<br>")

rs.open cad,cnn
Cnn.BeginTrans	
response.write("DOCUMENTOS ELIMINADOS = ")
 RESPONSE.Write(rs.recordcount)
RESPONSE.Write("<br>")
if rs.recordcount > 0  then     
    rs.movefirst

    ' CAMBIA SITUACIONA TODOS LOS COMPROBANTES DEL SUBDIARIO 05 DEL MES SELECCIONADO
        kad =   " Update "&TBL1&" Set CSITUA='P', CTOTAL=0, CDATE= GETDATE(), CHORA='10:00:', CUSER='inter' " & _
                " Where CSUBDIA='05' And CCOMPRO like '"&MES&"'; "
'RESPONSE.Write(kad)
'RESPONSE.Write("<br>")
'response.end
        
'***************************************************************************

       cnn.execute kad

'***************************************************************************
    ' cabecera de comprobantes
    do while not rs.eof
        compro = rs("ccompro")
        dfec = left(rs("cdate"),10)
        glosa = trim(rs("cglosa"))
        mon = rs("ccodmon")

        ' DETALLE de comprobantes  --> hay que actualizar las cuentas de Balance 
        cad = "SELECT * FROM "&TBL2&" Where DSUBDIA='05' And DCOMPRO='"&COMPRO&"' "
        rs2.open cad, cnn
        if rs2.recordcount > 0 then 
            rs2.movefirst
            MAD = ""
            DO WHILE NOT RS2.EOF
                SOLES= CDBL(rs2("dMNimpor"))*-1
                DOLAR= CDBL(rs2("dUSimpor"))*-1
                cuenta = rs2("dcuenta")
              
                MAD = MAD + "Update "&TBL3&" Set "
                if rs2("ddh") = "D" then
                    MAD = MAD + " BMNDEBE = BMNDEBE + "&SOLES&", BMNHABER = BMNHABER+0,  " & _
                                " BUSDEBE = BUSDEBE + "&DOLAR&", BUSHABER = BUSHABER+0,  " & _
                                " BMNSALI = BMNSALI + 0,         BUSSALI  = BUSSALI+0    " 
                else

                    MAD = MAD + " BMNDEBE = BMNDEBE + 0, BMNHABER = BMNHABER + "&soles&",   " & _
                                " BUSDEBE = BUSDEBE + 0, BUSHABER = BUSHABER + "&dolar&",   " & _
                                " BMNSALI = BMNSALI + 0, BUSSALI  = BUSSALI   + 0           "    
                end if
                mad = mad + " Where BCUENTA='"&cuenta&"' And BFECPRO2='"&fecha&"'; "
                mad = mad + " Delete From "&TBL2&" Where DSUBDIA='05' And DCOMPRO='"&compro&"' And DCODARC='AT' ; "
                MAD = MAD + " Insert Into "&TBL4&" (LG_CSUBDIA,LG_CCOMPRO,LG_CSECUEN,LG_DCOMPRO,LG_CGLOSA,LG_CCODMON,  " & _
                            " LG_DIMPORT,LG_CUSER,LG_CUSUCRE,LG_DFECELI,LG_DFECCRE) Values('05','"&compro&"','0001',                " & _
                            " Convert(datetime,'"&dfec&"',103),'"&glosa&"', '"&mon&"',0,'JCHU','JCHU',GETDATE(),GETDATE())  ;       "
                mad = mad + " Delete From "&TBL1&" Where CSUBDIA='05' And CCOMPRO='"&compro&"' ;  "
                mad = mad + " Delete From "&TBL2&" Where DSUBDIA='05' And DCOMPRO='"&compro&"' ; "
                mad = mad + " DELETE FROM "&TBL5&" WHERE DF_CSUBDIA='05' AND DF_CCOMPRO='"&compro&"' ; "
              '  mad = mad + " DELETE FROM RSIMAGEN..UT0001IMGE13 WHERE UV_CSUBDIA='05' AND UV_CCOMPRO='"&compro&"' ; "
                RS2.MOVENEXT
            LOOP
            ELSE
                MAD = "SELECT 1 "
        end if
        RS2.CLOSE
        RESPONSE.Write(compro)
        RESPONSE.Write("<br>")
        
                
'***************************************************************************

       cnn.execute mad

'***************************************************************************
        'response.End
        rs.movenext
    loop

end if
response.write("<CENTER><B><FONT COLOR='RED' SIZE=2 FACE='ARIAL'>   ")

response.write("PROCESO TERMINADO ......")

if  err.number <> 0 then
	Response.Write ("No se han podido actualizar los datos soliciatados,  Reintente en unos minutos")
	Cnn.RollbackTrans
	Cnn.Abort
else
	Cnn.CommitTrans	
end if

Cnn.Close	
set Cnn = Nothing
SET RS  = Nothing	
SET RS2 = Nothing	
%>

</BODY>
</HTML>
