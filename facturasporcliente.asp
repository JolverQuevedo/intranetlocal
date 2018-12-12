<%@ Language=VBScript %>
<% Response.Buffer = true %>
<%	txtUsuario = Request.Cookies("Usuario")("USUARIO")
	if Request.QueryString("PERFIL") <> "" then
		NIVEL = Request.QueryString("PERFIL")
		RESPONSE.COOKIES("usuario")("Perfil") = cint(nivel)
	end if
	txtPerfil = Request.Cookies("Usuario")("Perfil")
	NIVEL = txtPerfil%>

<!--#include file="includes/Cnn.inc"-->
<!DOCTYPE HTML>
<html>
<head>
	<meta charset="UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

	<title>Reporte</title>
	<style>
		*{
			font-family:sans-serif;
			color:#333;
		}
		.table{
			
		}
	</style>
</head>
<body>

<table width="100%">
<tbody><tr>
	<td width="35%" align="left" rowspan="2">
		<img style="cursor: hand;" onclick="javascript: top.window.location.replace('SUBMENU.ASP?TIPO=14');" src="imagenes/ATRAS.gif">
	</td>
	<td align="CENTER">
		<font color="darkblue" face="arial" size="3"><b>FACTURAS POR CLIENTE
		</b></font>
	</td>
	<td width="35%" align="right" rowspan="2"><img src="imagenes/logo.GIF"></td>
</tr>    
<table align="center">
		<tr>
			<td>
				<select id="txtmes">
					<option value="1">Enero</option>
					<option value="2">Febrero</option>
					<option value="3">Marzo</option>
					<option value="4">Abril</option>
					<option value="5">Mayo</option>
					<option value="6">Junio</option>
					<option value="7">Julio</option>
					<option value="8">Agosto</option>
					<option value="9">Septiembre</option>
					<option value="10">Octubre</option>
					<option value="11">Noviembre</option>
					<option value="12">Diciembre</option>
				</select>
			</td>
			<td>
			<select id="txtano">
					<option value="2018">2018</option>
				</select>
				</td>
		</tr>
	</table>
<tr>
	<td align="CENTER">	
		
	</td>
</tr>
<tr><td colspan="3"><hr></td></tr>
</tbody></table>

	
	<table>
		<tr>
			<th>Ruc</th>
			<th>Razón Social</th>
		</tr>
		<tbody id="table"> 
		<tr >
			<td>
				<img src="./imagenes/search.gif" ondblclick="buscar()"/>
				<input type="text" class="txtruc"  onchange="nuevalinea(event)"/>
				
			</td>
			<td><input type="text" class="lblrazon" style="border:none;width:300px;" readonly></input></td>
		</tr>
		</tbody>
		
	</table>
<button onclick="verreporte(false)">Ver Reporte Pantalla</button>
<button onclick="verreporte(true)">Ver Reporte Excel</button>
	<script>
		
		var mytr = document.getElementById('table');
		var rucs=[];
		(function(){
			document.getElementsByClassName("txtruc").length-1
			nuevalinea(13);
		})();
		//var s = 1;
		function buscar(){
			
			var url ="http://localhost/modelador/help/HLPprovREAL_mm.asp";
			var i =document.getElementsByClassName("txtruc").length-1;
			var e =document.getElementsByClassName("txtruc")[i];
			var filtroruc=document.getElementsByClassName("txtruc")[i].value;
			if( filtroruc!= ""){
				url = url +"?cod="+filtroruc+"&des="
			}
			var oo=window.open(url,"Busca Ruc","width:300px;height:600px");
			var timer = setInterval(function() { 
				if(oo.closed) {
					clearInterval(timer);
				if(i == 0){
					document.getElementsByClassName("txtruc")[0].value=localStorage.getItem('ruc');
					document.getElementsByClassName("lblrazon")[0].value=localStorage.getItem('razon');
					console.log(document.getElementsByClassName("txtruc")[0]);
					console.log(document.getElementsByClassName("lblrazon")[0]);
					e.focus();
				}
				else{
					document.getElementsByClassName("txtruc")[i].value=localStorage.getItem('ruc');
					document.getElementsByClassName("lblrazon")[i].value=localStorage.getItem('razon');
					e.focus();
				}
				nuevalinea(13);
			}
			}, 500);
			
			
		}
		function nuevalinea(){
				if(document.getElementsByClassName("lblrazon")[document.getElementsByClassName("txtruc").length-1].value != ""){
					mytr.insertAdjacentHTML('beforeend', '<tr><td><img src="./imagenes/search.gif" ondblclick="buscar()"/><input type="text" class="txtruc"  onchange="nuevalinea()" /></td><td><input type="text" class="lblrazon"  style="border:none;width:600px;" readonly></input></td></tr>');
					var i =document.getElementsByClassName("txtruc").length-2;
					var e =document.getElementsByClassName("txtruc")[i];
					e.focus();
				}
		}
		function verreporte(b){
			nuevalinea(13);
			
			var i =document.getElementsByClassName("txtruc").length-1;
			for(var a = 0;a<i;a++){
				rucs.push("'"+document.getElementsByClassName("txtruc")[a].value+"'");
			}
			console.log(rucs.join());
			var ftsss=rucs.join();
			if(ftsss == ""){
			var c="./reportes/prnftmm.asp?fts=''&excel="+b;
			}else{
				var c="./reportes/prnftmm.asp?fts="+ftsss+"&excel="+b;
			}
			c+="&mes="+document.getElementById("txtmes").value+"&ano="+document.getElementById("txtano").value;
			console.log(c);
			window.location.replace(c);
		}
	</script>
</body>
</html>