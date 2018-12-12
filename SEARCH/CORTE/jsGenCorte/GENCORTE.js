// JavaScript Document
$(document).ready(function(){
	/**********Para TextBox Numericos***************/
	$("#txtnroOFI").numeric();
	$('.clsFecha').mask("00/00/0000", {placeholder: "__/__/____"});
	//$('#txtCorteN1').mask("#######,00", {placeholder: "0.00"});
	/**********Variables**************/
	tabCounter = 1; //Primer Tab

	function GeneraControles(titulo,id)
	{
		
		var _estilo = "background-color:white; color:black; font-size:12px;	font: normal;	font-weight: 200;	opacity: .9;	border:#3B3434 solid 1px;";
		
		var _html = '';
		 _html += '<table width="100%" border="0" id="tbCorte'+id+'" name="tbCorte'+id+'">';
		 _html += '<tbody>';
		 _html += '<tr>';
		 _html += '<td class="fondocelda">Corte N#</td>';
		 _html += '<td><input type="text" name="txtCorteN'+id+'" id="txtCorteN'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '<td>&nbsp;</td>';
		 _html += '<td>&nbsp;</td>';
		 _html += '<td>&nbsp;</td>';
		 _html += '<td>&nbsp;</td>';
		 _html += '</tr>';
		 _html += '<tr>';
		 _html += '<td class="fondocelda">Fecha</td>';
		 _html += '<td><input type="text" name="txtFecha'+id+'" id="txtFecha'+id+'" class="clsFecha" style="'+_estilo+'" size="10"></td>'
		 _html += '     <td class="fondocelda">Peso Paño</td>';
		 _html += '     <td><input type="text" name="txtPano'+id+'" id="txtPano'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '     <td class="fondocelda">Tapeta</td>';
		 _html += '    <td><input type="text" name="txtTapeta'+id+'" id="txtTapeta'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td class="fondocelda">Cons. Estimado</td>';
		 _html += '     <td><input type="text" name="txtEstimado'+id+'" id="txtEstimado'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '     <td class="fondocelda">Pzas x Paño</td>';
		 _html += '     <td><input type="text" name="txtPzaPano'+id+'" id="txtPzaPano'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '     <td class="fondocelda">Retazos</td>';
		 _html += '     <td><input type="text" name="txtRetazos'+id+'" id="txtRetazos'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td class="fondocelda">Cons Real</td>';
		 _html += '     <td><input type="text" name="txtReal'+id+'" id="txtReal'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '     <td class="fondocelda">Paños</td>';
		 _html += '     <td><input type="text" name="txtPan'+id+'" id="txtPan'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '     <td class="fondocelda">Puntas</td>';
		 _html += '    <td><input type="text" name="txtPuntas'+id+'" id="txtPuntas'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td class="fondocelda">Ancho</td>';
		 _html += '     <td><input type="text" name="txtAncho'+id+'" id="txtAncho'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '     <td class="fondocelda">Kg</td>';
		 _html += '     <td><input type="text" name="txtKg'+id+'" id="txtKg'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '     <td class="fondocelda">Fallados</td>';
		 _html += '     <td><input type="text" name="txtFalla'+id+'" id="txtFalla'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td class="fondocelda">Larg Tend</td>';
		 _html += '    <td><input type="text" name="txtLarg'+id+'" id="txtLarg'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '     <td class="fondocelda">Sobrantes</td>';
		 _html += '     <td><input type="text" name="txtSobrantes'+id+'" id="txtSobrantes'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '     <td class="fondocelda">Partida</td>';
		 _html += '     <td><input type="text" name="txtPartida'+id+'" id="txtPartida'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td><p>&nbsp;</p></td>';
		 _html += '     <td>&nbsp;</td>';
		 _html += '     <td>&nbsp;</td>';
		 _html += '     <td>&nbsp;</td>';
		 _html += '     <td class="fondocelda">Metros</td>';
		 _html += '     <td><input type="text" name="txtMetros'+id+'" id="txtMetros'+id+'" style="'+_estilo+'" size="10"></td>';
		 _html += '   </tr>';
		 _html += '   <tr>';
		 _html += '     <td class="fondocelda" colspan="2">Local';
		 _html += '       <input type="radio" name="RadioGroup'+id+'" value="1" id="L'+id+'" class="opt'+id+'" checked="checked">';
		 _html += '     Servicio';
		 _html += '       <input type="radio" name="RadioGroup'+id+'" value="2" id="S'+id+'" class="opt'+id+'"></td>';
		 _html += '     <td colspan="2" name="colTipo'+id+'" id="colTipo'+id+'"><select name="cboModulo'+id+'" id="cboModulo'+id+'" style="font-size:12px;" >';
		 _html += '     </select>';
		 _html += '     </td>';
		 _html += '     <td colspan="2" style="font-size:12px;">Paquete de <input type="text" name="txtPaquete'+id+'" id="txtPaquete'+id+'" size="5" style="'+_estilo+'">Piezas';
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
	
	function GeneraDistribucion(id,fil)
	{
		//alert('#txtCan'+id+fil);

		var _totPza = $('#txtPaquete'+id).val();
		var _cant   = $('#txtCan'+id+fil).val();
		var _gpo	 = Math.round(parseInt(_cant)/parseInt(_totPza));

		$('#ctal'+id+fil+'5').html(_gpo);
		$('#ctal'+id+fil+'6').html(1);
		if(fil==1)
			{
				$('#ctal'+id+fil+'7').html(_gpo);
			}

		var _sumhasta = 0;
		for(i=1;i<=$('#tbTallas'+id+' tr').length-1;i++)
			{
				//alert('#ctal'+id+i+'7');
			/*_fil7 = parseInt($('#ctal'+id+i+'7').html());
			if($('#ctal'+id+i+'7').html()=='' && i==1)
				{
					_fil7=0;
				}
			if(_fil7>0)
				{
					_sumhasta = _fil7;	
				}*/
			}
			/*if(_sumhasta==0)
				 {
					 $('#ctal'+id+fil+'7').html(_gpo);
				 }
				 else{
					 _hasta = _gpo+_sumhasta;
					 _desde = (_hasta-_gpo)+1;
					 $('#ctal'+id+fil+'6').html(_desde);
					 $('#ctal'+id+fil+'7').html(_hasta);
				 }*/
	}
	function GeneraTallas(id)
	{
		var _tallas = "";
		var _talla  = "";
		_tallas = $('#txtTallas').val();
		_talla = _tallas.split(',');
		_art   = $('#cboArticulo').val()
		_art = _art.substr(_art.length-5,5);
		var _filT = 0;
		$.each(_talla, function(key, value){
			var fil = key+1;
			if(value!='')
				{
					$('#tbTallas'+id+' tr:last').after('<tr class="fila" id="ftal'+id+fil+'"><td id="ctal'+id+fil+'1">'+fil+'</td><td id="ctal'+id+fil+'2">'+_art+pad(value, 3)+'</td><td id="ctal'+id+fil+'3">'+pad(value, 3)+'</td><td id="ctal'+id+fil+'4" style="text-align:center;"><input type="text" id="txtCan'+id+fil+'" name="txtCan'+id+fil+'" class="txt" size="5px" /></td><td id="ctal'+id+fil+'5"></td><td id="ctal'+id+fil+'6"></td><td id="ctal'+id+fil+'7"></td></tr>');	
					
					if(fil==4)
						{
							_filT = fil +1
						$('#tbTallas'+id+' tr:last').after('<tr class="filaT" id="ftal'+id+_filT+'"><td id="ctal'+id+_filT+'1"></td><td id="ctal'+id+_filT+'2"></td><td id="ctal'+id+_filT+'3"></td><td id="ctal'+id+_filT+'4" style="text-align:center;">0.00</td><td id="ctal'+id+_filT+'5">0.00</td><td id="ctal'+id+_filT+'6"></td><td id="ctal'+id+_filT+'7"></td></tr>');	
						}
					
					
					$('#txtCan'+id+fil).keypress(function(e){
						
						 if(e.which == 13) {
							 
							 /*if($.trim($('txtPaquete'+id).val())=="")
								 {
									 alert('Debe Ingresar total de paquete de piezas!');
									 $('txtPaquete'+id).focus();
									 return false;
								 }*/
							 
							 for(i=1;i<=$('#tbTallas'+id+' tr').length-1;i++)
								{
									$('#ctal'+id+i+'6').html('');
									$('#ctal'+id+i+'7').html('');
									
								}
							 /*for(i=1;i<=$('#tbTallas'+id+' tr').length-1;i++)
								{
									alert(id+'--'+i);
							 		GeneraDistribucion(id,i);
								}
							 GeneraDistribucion(id,i);*/
							 for(y=1;y<=$('#tbTallas'+id+' tr').length-1;y++)
								{
									//alert('#txtCan'+id+y);
							 var _totPza = $('#txtPaquete'+id).val();
							 var _cant   = $('#txtCan'+id+y).val();
							 
							 var _gpo	 = Math.round(parseInt(_cant)/parseInt(_totPza));
							 $('#ctal'+id+y+'5').html(_gpo);
							 
							if(_gpo>0)		
								{
									$('#ctal'+id+y+'6').html(1);		
								}
							 
							 var _sumhasta = 0;
							 for(i=1;i<=$('#tbTallas'+id+' tr').length-1;i++)
								{
									_fil7 = parseInt($('#ctal'+id+i+'7').html());
									if($('#ctal'+id+i+'7').html()=='' && i==1)
										{
											_fil7=0;
										}
									if(_fil7>0)
										{
											_sumhasta = _fil7;	
										}

								}
							 if(_sumhasta==0)
								 {
									 $('#ctal'+id+y+'7').html(_gpo);
								 }
							 else{
								 _hasta = _gpo+_sumhasta;
								 _desde = (_hasta-_gpo)+1;
								 $('#ctal'+id+y+'6').html(_desde);
								 $('#ctal'+id+y+'7').html(_hasta);
							 }
							}
							 
							 
							 if($('#txtKg'+id).val()>0)
								 {
									 if($(this).val()>0)
										 {
										_real = 0;
										_tot  = 0;
										for(i=1;i<=$('#tbTallas'+id+' tr').length-1;i++)
											{
												if($('#txtCan'+id+i).val()!='')
													{
														
													_real = _real+parseInt($('#txtCan'+id+i).val());
													}
											}
											 
											_tot = (parseFloat($('#txtKg'+id).val())/_real).toFixed(3);  
											 $('#txtReal'+id).val(_tot);
										 }
								 }
				var _sumCantidad = 0;
				var _sumGrupos   = 0;
				var _filT 		 = 1;
				var _f = 1;
							 
				$.each(_talla, function(key, value){
					_f = key+1;
					if($.trim($('#txtCan'+id+_f).val())!="")
					   {
						_sumCantidad = _sumCantidad + parseInt($('#txtCan'+id+_f).val());
						
						_sumGrupos = _sumGrupos + parseInt($('#ctal'+id+_f+'5').html());   
						   //alert(_sumCantidad);
					   }

					//_filT=;
				});
							 //alert('#ctal'+id+_f+'4');
				$('#ctal'+id+_f+'4').html(_sumCantidad.toFixed(2));
				$('#ctal'+id+_f+'5').html(_sumGrupos.toFixed(2));	

				if(parseFloat($('#txtKg'+id).val())>0)
								 {
									 if(parseFloat($(this).val())>0)
										 {
										_real = 0;
										_tot  = 0;
										for(i=1;i<=$('#tbTallas'+id+' tr').length-1;i++)
											{
												//alert($('#txtCan'+id+i).val());
												if($.trim($('#txtCan'+id+i).val())!='')
													{
														
													_real = _real+parseInt($('#txtCan'+id+i).val());
													}
											}
											 
											 //alert($('#txtKg'+id).val());
											 //alert(_real);
											_tot = (parseFloat($('#txtKg'+id).val())/_real).toFixed(3);  
											 $('#txtReal'+id).val(_tot); 
										 }
								 }				
		
						}
					});
					$('#txtCan'+id+fil).blur(function()
											{
						 /*if($(this).val()!="")
							 {
								$('#ctal'+id+fil+'5').html('1');
						 		$('#ctal'+id+fil+'6').html('2');
						 		$('#ctal'+id+fil+'7').html('3');
								 if($('#txtKg'+id).val()>0)
								 {
									 if($(this).val()>0)
										 {
											_real = 0;
										_tot  = 0;
										for(i=1;i<=$('#tbTallas'+id+' tr').length-1;i++)
											{
												if($('#txtCan'+id+i).val()!='')
													{
														
													_real = _real+parseInt($('#txtCan'+id+i).val());
													}
											}
											 
											_tot = (parseFloat($('#txtKg'+id).val())/_real).toFixed(3);  
											 $('#txtReal'+id).val(_tot); 
										 }
								 }
							 }*/
						 
					})
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
	
	function fBuscaCorte(_text,id)
	{
		$.getJSON('../corte/sqlGenCorte/BuscaCorte.asp?numCorte='+_text, function(corte){
			/*$('#txtFecha1').val(corte[0].CT_DFECHA);
			$('#txtReal1').val(corte[0].ct_nconreA);*/
		})
		.done(function(data){
			///$('#txtFecha'+id).val(data[0].CT_DFECHA);
			//$('#txtReal'+id).val(data[0].ct_nconreA);
			if(data[0].CT_CNROCORTE!='')
				{
					alert('El Corte Ingresadp ya existe, Ingrese otro numero');
				}
			else{
				$('#txtFecha'+id).focus();
			}
			/*$.each(data, function(key, value){
			var fil = key+1;
			if(value!='')
				{
					$('#tbTallas'+id+' tr:last').after('<tr class="fila" id="ftal'+id+fil+'"><td id="ctal'+id+fil+'1">'+fil+'</td><td id="ctal'+id+fil+'2">'+value.CT_CARTICULO+'</td><td id="ctal'+id+fil+'3">'+value.CT_CARTICULO+'</td><td id="ctal'+id+fil+'4"></td><td id="ctal'+id+fil+'5"></td><td id="ctal'+id+fil+'6"></td><td id="ctal'+fil+'7"></td></tr>');		
				}
		});*/
			
			//txtEstimado1
		})
		.fail(function( jqxhr, textStatus, error ) {
    		var err = textStatus + ", " + error;
    		alert( "Error: " + err );
		});
		
	}
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
	/******************Boton Aperturar*************************/
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
			jsFecha('txtFecha',ind);
			
			
			//alert($('#tbTallas'+ind).attr('id'));
			/************************/
			//txtCan+ind+
			/************************/
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
			/*****************KeyPress para TextBox***************/
			$('#txtCorteN'+ind).keypress(function(e){
				if(e.which==13)
					{
						_nCorte = $.trim($(this).val());
						if(_nCorte.length<5)
							{
								alert('Debe ingresar 5 digitos!!');
								return;
							}
						
						rid = $(this).attr('id');
						var opt = rid.substring(9,19); 
						_text = pad($(this).val(), 5);
			   			$(this).val(_text);
						fBuscaCorte(_text,opt);
					}
				
			});
			$('#txtFecha'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(8,19); 
						$('#txtEstimado'+opt).focus();
					}
				
			});
			
			$('#txtEstimado'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(11,19); 
						$('#txtAncho'+opt).focus();
					}
				
			});
			
			$('#txtAncho'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(8,19); 
						$('#txtLarg'+opt).focus();
					}
				
			});
			
			$('#txtLarg'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(7,19); 
						$('#txtPano'+opt).focus();
					}
				
			});
			
			$('#txtPano'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(7,19); 
						$('#txtPzaPano'+opt).focus();
					}
				
			});
			
			$('#txtPzaPano'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(10,19); 
						$('#txtPan'+opt).focus();
					}
				
			});
			
			$('#txtPan'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(6,19); 
						$('#txtKg'+opt).focus();
					}
				
			});
			
			$('#txtKg'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(5,19); 
						$('#txtSobrantes'+opt).focus();
					}
				
			});
			
			$('#txtSobrantes'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(12,19); 
						$('#txtTapeta'+opt).focus();
					}
				
			});
			
			$('#txtTapeta'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(9,19); 
						$('#txtRetazos'+opt).focus();
					}
				
			});
			
			$('#txtRetazos'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(10,19); 
						$('#txtPuntas'+opt).focus();
					}
				
			});
			
			$('#txtPuntas'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(9,19); 
						$('#txtFalla'+opt).focus();
					}
				
			});
			
			$('#txtFalla'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(8,19); 
						$('#txtPartida'+opt).focus();
					}
				
			});
			
			$('#txtPartida'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(10,19); 
						$('#txtMetros'+opt).focus();
					}
				
			});
			
			$('#txtMetros'+ind).keypress(function(e){
				if(e.which==13)
					{
						rid = $(this).attr('id');
						var opt = rid.substring(9,19); 
						$('#L'+opt).focus();
					}
				
			});
			/***********************************************/
			ind++;
        });
	});
	
	/************Boton Grabar Corte***********/
	$('#bntGrabar').click(function(){
		
		if($.trim($('#cboTipPrenda').val())=='S')
			{
				alert('Debe seleccionar tipo de prenda!!');
				return;
			}
		_num = 1;
		_grb = 0;
		$("input:checkbox:checked").each(function() {
			if($.trim($('#txtCorteN'+_num).val())=="")
				{
					alert('Debe especificar todos los N° de Corte!!');
					_grb++;
					return false;
				}
			_num++;
		});
		
		if( _grb==0){
		if(confirm('¿Seguro de generar planillas y cortes?'))
			{
				_id = 1;
				$("input:checkbox:checked").each(function() {
					nroOFI		= $('#txtnroOFI').val();
					estilo		= $('#txtEstilo').val();
					prenda		= $('#txtPrenda').val();
					articulo	= $('#cboArticulo').val();
					Tiempo		= $('#txtTiempo').val();
					numCorte	= $('#txtCorteN'+_id).val();
					fecha		= $('#txtFecha'+_id).val();
					cliente		= $('#txtCliente').val();
					CPO			= '427'; 
					costoEst	= $('#txtEstimado'+_id).val();
					costoReal	= $('#txtReal'+_id).val();
					codColor	= $(this).attr('id');
					desColor	= $('#f'+codColor).html();
					kilos		= $('#txtKg'+_id).val();
					sobra		= $('#txtSobrantes'+_id).val();
					tapeta		= $('#txtTapeta'+_id).val();
					ancho		= $('#txtAncho'+_id).val();	
					largo		= $('#txtLarg'+_id).val();
					metro		= $('#txtMetros'+_id).val();
					punta		= $('#txtPuntas'+_id).val();	
					retazo		= $('#txtRetazos'+_id).val();
					falla		= $('#txtFalla'+_id).val();
					pepan		= $('#txtPano'+_id).val();
					pazpano		= $('#txtPzaPano'+_id).val();
					nropano		= $('#txtPan'+_id).val();
					partida		= $('#txtPartida'+_id).val();
					codTela		= $('#txtCodTela').val();
					tela		= $('#txtTela').val();
					codservicio	= $("input[name='RadioGroup1']:checked").val();
					servicio	= $('#cboModulo'+_id).val();
					nropaquete	= $('#txtPaquete'+_id).val();

					//window.open('../corte/sqlGenCorte/GrabaCorte.asp?nroOFI='+nroOFI+'&estilo='+estilo+'&prenda='+prenda+'&articulo='+articulo+'&Tiempo='+Tiempo+'&numCorte='+numCorte+'&fecha='+fecha+'&cliente='+cliente+'&CPO='+CPO+'&costoEst='+costoEst+'&costoReal='+costoReal+'&codColor='+codColor+'&desColor='+desColor+'&kilos='+kilos+'&sobra='+sobra+'&tapeta='+tapeta+'&ancho='+ancho+'&largo='+largo+'&metro='+metro+'&punta='+punta+'&retazo='+retazo+'&falla='+falla+'&pepan='+pepan+'&pazpano='+pazpano+'&nropano='+nropano+'&partida='+partida+'&codTela='+codTela+'&tela='+tela+'&nropaquete='+nropaquete+'&codservicio='+codservicio+'&servicio='+servicio);
					
					$.getJSON('../corte/sqlGenCorte/GrabaCorte.asp?nroOFI='+nroOFI+'&estilo='+estilo+'&prenda='+prenda+'&articulo='+articulo+'&Tiempo='+Tiempo+'&numCorte='+numCorte+'&fecha='+fecha+'&cliente='+cliente+'&CPO='+CPO+'&costoEst='+costoEst+'&costoReal='+costoReal+'&codColor='+codColor+'&desColor='+desColor+'&kilos='+kilos+'&sobra='+sobra+'&tapeta='+tapeta+'&ancho='+ancho+'&largo='+largo+'&metro='+metro+'&punta='+punta+'&retazo='+retazo+'&falla='+falla+'&pepan='+pepan+'&pazpano='+pazpano+'&nropano='+nropano+'&partida='+partida+'&codTela='+codTela+'&tela='+tela+'&nropaquete='+nropaquete+'&codservicio='+codservicio+'&servicio='+servicio,function(data){
						
					})
					.done(function(data){
						//alert(data[0].mensaje);
						alert('Se guardo registro');
					})
					.fail(function( jqxhr, textStatus, error ) {
						var err = textStatus + ", " + error;
						alert( "Error: " + err );
					});
					_id++;
				});
			}}
	});
	/****************************************/
});