// JavaScript Document
$(document).ready(function(){
	
	/**********Variables**************/
	tabCounter = 1;
	/*************Funciones*****************/
	function pad (str, max) {
	  str = str.toString();
	  return str.length < max ? pad("0" + str, max) : str;
	}
	
	function siNumber(numero){
    	if (!/^([0-9])*$/.test(numero))
      		alert("El valor " + numero + " no es un número");
  	}
	
	function GeneraControles(titulo,id)
	{
		
		var _html = '';
		 _html += '<table width="100%" border="0" id="tbCorte'+id+'" name="tbCorte'+id+'">';
		 _html += '<tbody>';
		 _html += '<tr>';
		 _html += '<td class="fondocelda">Corte N#</td>';
		 _html += '<td><input type="text" name="txtCorteN'+id+'" id="txtCorteN'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '<td>&nbsp;</td>';
		 _html += '<td>&nbsp;</td>';
		 _html += '<td>&nbsp;</td>';
		 _html += '<td>&nbsp;</td>';
		 _html += '</tr>';
		 _html += '<tr>';
		 _html += '<td class="fondocelda">Fecha</td>';
		 _html += '<td><input type="text" name="txtFecha'+id+'" id="txtFecha'+id+'" class="ctrlenable" size="10"></td>'
		 _html += '     <td class="fondocelda">Peso Paño</td>';
		 _html += '     <td><input type="text" name="txtPano'+id+'" id="txtPano'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '     <td class="fondocelda">Tapeta</td>';
		 _html += '    <td><input type="text" name="txtTapeta'+id+'" id="txtTapeta'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td class="fondocelda">Cons. Estimado</td>';
		 _html += '     <td><input type="text" name="txtEstimado'+id+'" id="txtEstimado'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '     <td class="fondocelda">Pzas x Paño</td>';
		 _html += '     <td><input type="text" name="txtPzaPano'+id+'" id="txtPzaPano'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '     <td class="fondocelda">Retazos</td>';
		 _html += '     <td><input type="text" name="txtRetazos'+id+'" id="txtRetazos'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td class="fondocelda">Cons Real</td>';
		 _html += '     <td><input type="text" name="txtReal'+id+'" id="txtReal'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '     <td class="fondocelda">Paños</td>';
		 _html += '     <td><input type="text" name="txtPan'+id+'" id="txtPan'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '     <td class="fondocelda">Puntas</td>';
		 _html += '    <td><input type="text" name="txtPuntas'+id+'" id="txtPuntas'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td class="fondocelda">Ancho</td>';
		 _html += '     <td><input type="text" name="txtAncho'+id+'" id="txtAncho'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '     <td class="fondocelda">Kg</td>';
		 _html += '     <td><input type="text" name="txtKg'+id+'" id="txtKg'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '     <td class="fondocelda">Fallados</td>';
		 _html += '     <td><input type="text" name="txtFalla'+id+'" id="txtFalla'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td class="fondocelda">Larg Tend</td>';
		 _html += '    <td><input type="text" name="txtLarg'+id+'" id="txtLarg'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '     <td class="fondocelda">Sobrantes</td>';
		 _html += '     <td><input type="text" name="txtSobrantes'+id+'" id="txtSobrantes'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '     <td class="fondocelda">Partida</td>';
		 _html += '     <td><input type="text" name="txtPartida'+id+'" id="txtPartida'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td><p>&nbsp;</p></td>';
		 _html += '     <td>&nbsp;</td>';
		 _html += '     <td>&nbsp;</td>';
		 _html += '     <td>&nbsp;</td>';
		 _html += '     <td class="fondocelda">Metros</td>';
		 _html += '     <td><input type="text" name="txtMetros'+id+'" id="txtMetros'+id+'" class="ctrlenable" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td class="fondocelda" colspan="2">Local';
		 _html += '       <input type="radio" name="RadioGroup'+id+'" value="1" id="L'+id+'" class="opt'+id+'" checked="checked">';
		 _html += '     Servicio';
		 _html += '       <input type="radio" name="RadioGroup'+id+'" value="2" id="S'+id+'" class="opt'+id+'"></td>';
		 _html += '     <td colspan="2" name="colTipo'+id+'" id="colTipo'+id+'"><select name="cboModulo'+id+'" id="cboModulo'+id+'" style="font-size:12px;" >';
		 _html += '     </select>';
		 _html += '     </td>';
		 _html += '     <td colspan="2" style="font-size:12px;">Paquete de <input type="text" name="txtPaquete'+id+'" id="txtPaquete'+id+'" size="5" class="ctrlenable">Piezas';
		 _html += '     </td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td colspan="7"><table width="100%" border="0" name="tbTallas'+id+'" id="tbTallas'+id+'">';
		 _html += '      <tbody>';
		 _html += '         <tr>';
		 _html += '           <td class="fondosubcelda">#</td>';
		 _html += '           <td class="fondosubcelda">Articulo</td>';
		 _html += '           <td class="fondosubcelda">Talla</td>';
		 _html += '           <td class="fondosubcelda">Cantidad</td>';
		 _html += '           <td class="fondosubcelda">Grupos</td>';
		 _html += '           <td class="fondosubcelda">Desde</td>';
		 _html += '           <td class="fondosubcelda">Hasta</td>';
		 _html += '         </tr>';
		 _html += '       </tbody>';
		 _html += '     </table></td>';
		 _html += '   </tr>';
		 _html += ' </tbody>';
		 _html += '</table>';
		 //_html += '</div>';
		 
		 return _html;
	}	
	
	function GeneraTabs(titulo, id)
	{
		var tabs = $( "#tabs" ).tabs();
		var label = titulo; 
		
		id = "tabs" +tabCounter;
		tabTemplate = "<li><a href='#{href}'>#{label}</a> <span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>",
			
        li = $( tabTemplate.replace( /#\{href\}/g, "#" + id ).replace( /#\{label\}/g, label ) ),
        tabContentHtml = GeneraControles(titulo,tabCounter)
		
		tabs.find( ".ui-tabs-nav" ).append( li );
      	tabs.append( "<div id='" + id + "'><p>" + tabContentHtml + "</p></div>" );
      	tabs.tabs( "refresh" );
		tabCounter++;
	}
	
	function GeneraModulo(id)
	{
		$.getJSON('../corte/sqlGenCorte/ListaModulos.asp', function(data) {
 			$.each(data, function(k,v){
			 $('#cboModulo'+id).append($('<option>', { 
        		value: v.LI_CLICOD,
        		text : v.LI_CLIDES 	}
				));
	    });
			});	
	}
	
	/*$('#bb1').click(function(){
		var opt = $('input:radio[name=RadioGroup1]:checked').val();
		id=1;
		if(opt==1)
			{
				$('#colTipo'+id).html('<select name="cboModulo'+id+'" id="cboModulo'+id+'" style="font-size:12px;" >');
				GeneraModulo(id);
			}
		if(opt==2)
			{
				$('#colTipo'+id).html('<input type="text" name="cboModulo'+id+'" id="cboModulo'+id+'" class="ctrlenable" size="10">');
			}
	});*/
	
	function GeneraEventRadio(id)
	{
		id=1;
		if(id==1)
			{
				$('#colTipo'+id).html('<select name="cboModulo'+id+'" id="cboModulo'+id+'" style="font-size:12px;" >');
				GeneraModulo(id);
			}
		if(id==2)
			{
				$('#colTipo'+id).html('<input type="text" name="cboModulo'+id+'" id="cboModulo'+id+'" class="ctrlenable" size="10">');
			}
	}
	function GeneraTallas(id)
	{
		var _tallas = "";
		var _talla  = "";
		_tallas = $('#txtTallas').val();
		_talla = _tallas.split(',');
		_art   = $('#cboArticulo').val()
		_art = _art.substr(_art.length-5,5);

		$.each(_talla, function(key, value){
			var fil = key+1;
			if(value!='')
				{
					$('#tbTallas'+id+' tr:last').after('<tr class="fila" id="ftal'+id+fil+'"><td id="ctal'+id+fil+'1">'+fil+'</td><td id="ctal'+id+fil+'2">'+_art+pad(value, 3)+'</td><td id="ctal'+id+fil+'3">'+pad(value, 3)+'</td><td id="ctal'+id+fil+'4"></td><td id="ctal'+id+fil+'5"></td><td id="ctal'+id+fil+'6"></td><td id="ctal'+fil+'7"></td></tr>');		
				}
		});
	}
	
	
	
	$('#btnlimpiar').click(function(){
		tabCounter = 1
		$('#tbPo tr:not(:first-child)').remove();
		$('#tbColores tr:not(:first-child)').remove();
		$('#cboTipPrenda').val("S");
		
		$('div#tabs ul li').remove();
		$('div#tabs div').remove();
		$('#cboArticulo').empty();
		$("#lblCodCli").empty();
		$('#lblCodCli').text('');
		$('#txtnroOFI').val('');
		$('#txtCliente').val('');
		$('#txtEstilo').val('');
		$('#txtNroEstilo').val('');
		$('#txtDescripcion').val('');
		$('#txtPrenda').val('');
		$('#txtTela').val('');
		$('#txtTallas').val('');
		$('#txtCodTela').val('');
		$('#txtTiempo').val('');
		
	});
	function fBuscar()
	{
		/******************Limpia Tablas********/
		$('#tbPo tr:not(:first-child)').remove();
		$('#tbColores tr:not(:first-child)').remove();
		$('#cboTipPrenda').val("S");
		
		$('div#tabs ul li').remove();
		$('div#tabs div').remove();
		tabCounter = 1

		/***************************************/
		//window.open('../corte/sqlGenCorte/sqlGenCorte.asp?nroOFI=00000001');
		$.getJSON('../corte/sqlGenCorte/busca_x_ofi.asp?nroOFI=' + $('#txtnroOFI').val(), function(ofi) {
		$("#lblCodCli").empty();
		$('#lblCodCli').text(ofi[0].CO_CCODCLI);
		$('#txtCliente').val(ofi[0].CO_CCLIENTE);
		$('#txtEstilo').val(ofi[0].CO_CCODSTY);
		$('#txtNroEstilo').val(ofi[0].CO_CNROSTY);
		$('#txtDescripcion').val(ofi[0].CO_CDESSTY);
		$('#txtPrenda').val(ofi[0].CO_CPRENDA);
		$('#txtTela').val(ofi[0].CO_CTEJIDO);
		$('#txtTallas').val(ofi[0].CO_CTALLAS);
		$('#txtCodTela').val(ofi[0].CO_CTELA);
		$('#txtTiempo').val(ofi[0].CO_CTIEMPO);	
			
			
		$('#txtCodTela').focus();	
		})
		.done(function(data){ 
			$('#cboArticulo').empty();
			cboArticulo = $('#cboArticulo');
			$.getJSON('../corte/sqlGenCorte/ListaArticulo.asp?st_ccodcli=' + data[0].CO_CCODCLI+'&st_ccodigo='+data[0].CO_CCODSTY, function(data) {
		    		$.each(data, function(k,v){
            		cboArticulo.append("<option value=\""+v.ST_CCODART+"\">"+v.ST_Cempresa+"</option>");
       			});
			});	
			
			//window.open('../corte/sqlGenCorte/ListaPoColores.asp?do_ccodigo=' + data[0].CO_CCODIGO+'&opc=1');
			$.getJSON('../corte/sqlGenCorte/ListaPoColores.asp?do_ccodigo=' + data[0].CO_CCODIGO+'&opc=1', 			function(data) {
					i = 0;
		    		$.each(data, function(k,v){
$('#tbPo tr:last').after('<tr class="fila" id="fil'+i+'"><td>'+v.do_cdescol1+'</td><td>'+v.do_cdescol2+'</td></tr>');	
					$("#fil"+i).on("click",function(){ 
					/****Evento Click de las filas de PO****/
					y=0;
					$("#tbColores tr").each(function () 
        				{
							$('#fila'+y).remove();
							y++;
						});
					$.getJSON('../corte/sqlGenCorte/ListaPoColores.asp?do_ccodigo='+$('#txtnroOFI').val()+'&opc=2', 			function(data) {
						x = 0;
		    		$.each(data, function(n,d){
$('#tbColores tr:last').after('<tr class="fila" id="fila'+x+'"><td><input type="checkbox" id="'+d.do_ccodcol1+'" /></td><td id="f'+$.trim(d.do_ccodcol1)+'">'+$.trim(d.do_cdescol1)+'</td></tr>');	
					$("#"+d.do_ccodcol1).on("click",function(){ 
						
						/*var _div = '';
						_title = d.do_cdescol1+'['+d.do_ccodcol1+']';
						_id    =  d.do_ccodcol1;
						_div   =  $('#tabs').html();
						GeneraTabs(_title,_id);
						var index = $('#tabs a[href="#tabs1"]').parent().index();
						$('#tabs').tabs({ active: index });*/
					});
					x++;
       			});
			});	
				/******************************/ 
					});
					i++;
       			});
			});	
			
		})
		.fail(function( jqxhr, textStatus, error ) {
    		var err = textStatus + ", " + error;
    		alert( "Error: " + err );
		});
	}
	
	/***********************************/
	$("#txtnroOFI").keypress(function(e) {
		   if(e.which == 13) {
			  _text = pad($("#txtnroOFI").val(), 8);
			   $("#txtnroOFI").val(_text);
			   //$('#btnBuscar').click();
			   fBuscar();
		   }
		});
	/*******************************************/
	$('#b1').click(function(){
		var _div = '';
		$('div#tabs ul li').remove();
		$('div#tabs div').remove();
		tabCounter = 1
		ind = 1;
		$("input:checkbox:checked").each(function() {
			_indice = $(this).attr('id');
			_text   = $('#f'+_indice).html();
			//alert($('#f'+_indice).html());
			_title = _text+'['+_indice+']';
			//_id    =  d.do_ccodcol1;
			_div   =  $('#tabs').html();
			GeneraTabs(_title,_indice);
			var index = $('#tabs a[href="#tabs1"]').parent().index();
			$('#tabs').tabs({ active: index });
			GeneraModulo(ind);
			GeneraTallas(ind);
			/***********Evento para los option**************/
			$('.opt'+ind).change(function () {
				rid = $(this).attr('id');
				var opt = rid.substring(1,5); 
				if(rid=='L'+opt){
            		$('#colTipo'+opt).html('<select name="cboModulo'+opt+'" id="cboModulo'+opt+'" style="font-size:12px;" >');
					GeneraModulo(opt);
        		}
        		else {
            		$('#colTipo'+opt).html('<input type="text" name="cboModulo'+opt+'" id="cboModulo'+opt+'" class="ctrlenable" size="10">');
        		}
            });
			/***********************************************/
			ind++;
        });
	});
	
});