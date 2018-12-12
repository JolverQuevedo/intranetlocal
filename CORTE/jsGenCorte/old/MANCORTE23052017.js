// JavaScript Document
$(document).ready(function(){
	/**********Para TextBox Numericos***************/
	$("#txtnroCORTE").numeric();
	$('.clsFecha').mask("00/00/0000", {placeholder: "__/__/____"});
	//$('#txtCorteN1').mask("#######,00", {placeholder: "0.00"});
	/**********Variables**************/

	function GeneraModulo()
	{
		$.getJSON('../corte/sqlGenCorte/ListaModulos.asp', function(data) {
 			$.each(data, function(k,v){
			 $('#cboModulo').append($('<option>', { 
        		value: v.LI_CLICOD,
        		text : v.LI_CLIDES 	}
				));
	    });
			});	
	}
	
	function GeneraEventRadio(id)
	{
		id=1;
		if(id==1)
			{
				$('#colTipo'+id).html('<select name="cboModulo'+id+'" id="cboModulo'+id+'" style="font-size:12px;" >');
				GeneraModulo();
			}
		if(id==2)
			{
				$('#colTipo'+id).html('<input type="text" name="cboModulo'+id+'" id="cboModulo'+id+'" class="ctrlenable" size="10">');
			}
	}
	
	/***********Evento para los option**************/
			$('.opt1').change(function () {
				rid = $(this).attr('id');
				//var opt = rid.substring(0,5); 
				//alert('L'+opt);
				if(rid=='L1'){
            		$('#celRadio').html('<select name="cboModulo" id="cboModulo" style="font-size:12px;" >');
					GeneraModulo();
        		}
        		else {
            		$('#celRadio').html('<input type="text" name="cboModulo" id="cboModulo" class="ctrlenable" size="10">');
        		}
            });
	/********************************************/		
			
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
			
	}
	function GeneraTallas(data)
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
					
					$('#txtCan'+id+fil).keyup(function(e){
						var _numero = Math.round($('#txtCan'+id+fil).val());
						// if(e.which == 13) {
						 if(_numero>0) {	 
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
							 
							 var _gpo	 = Math.ceil(parseInt(_cant)/parseInt(_totPza));
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
												if($.trim($('#txtCan'+id+i).val())!="")
													{
														
													_real = _real+parseFloat($('#txtCan'+id+i).val());
													}
											}
											 
											_tot = (parseFloat($('#txtKg'+id).val())/_real).toFixed(3);  
											 $('#txtReal'+id).val(_tot);
										 }
								 }
				/*var _sumCantidad = 0;
				var _sumGrupos   = 0;
				var _filT 		 = 1;
				var _f = 1;
							 
				$.each(_talla, function(key, value){
					_f = key+1;
					if($.trim($('#txtCan'+id+_f).val())!="")
					   {
						_sumCantidad = _sumCantidad + parseInt($('#txtCan'+id+_f).val());
						
						_sumGrupos = _sumGrupos + parseInt($('#ctal'+id+_f+'5').html());   
					   }
				});
				$('#ctal'+id+_f+'4').html(_sumCantidad.toFixed(2));
				$('#ctal'+id+_f+'5').html(_sumGrupos.toFixed(2));			 */
				var _sumCantidad = 0;
				var _sumGrupos   = 0;
				var _filT 		 = 1;
				var _f = 1;
							 
				$.each(_talla, function(key, value){
					_f = key+1
					if($.trim($('#txtCan'+id+_f).val())!="")
					   {
						_sumCantidad = _sumCantidad + parseInt($('#txtCan'+id+_f).val());
						
						_sumGrupos = _sumGrupos + parseInt($('#ctal'+id+_f+'5').html());   
					   }
				});
				
				$('#Ttal'+id+'4').html(_sumCantidad.toFixed(2));
				$('#Ttal'+id+'5').html(_sumGrupos.toFixed(2));	
						}
						
				
						
					});
				}
		});

		$('#tbTallas'+id+' tr:last').after('<tr class="filaT" id="Ttal'+id+'"><td id="Ttal'+id+'1"></td><td id="Ttal'+id+'2"></td><td id="Ttal'+id+'3"></td><td id="Ttal'+id+'4" style="text-align:center;">0.00</td><td id="Ttal'+id+'5">0.00</td><td id="Ttal'+id+'6"></td><td id="Ttal'+id+'7"></td></tr>');	
	}
	
	
	//function fBuscaCorte(_text,id)
	function fBuscaCorte(_text)
	{
		//window.open('../corte/sqlGenCorte/ListaCorte.asp?numCorte='+_text);
		$.getJSON('../corte/sqlGenCorte/ListaCorte.asp?numCorte='+_text, function(corte){
		})
		.done(function(data){
			if($.trim(data[0].CT_CNROCORTE)!='')
				{
					//DATOS DE CABECERA
					$('#celOFI').html(data[0].CT_CNROOFI);
					$('#celColor').html(data[0].CT_CCODCOL +' '+ data[0].CT_CDESCOL);
					$('#celEstilo').html(data[0].CT_CCODSTY);
					$('#celPrenda').html(data[0].CT_CPRENDA);
					$('#celTejido').html(data[0].CT_CDESTEL);
					$('#celArticulo').html(data[0].CT_CARTICULO);
					//DATOS DE ESPECIFICACIONES
					
					$('#txtFecha').val(data[0].CT_DFECHA);
					$('#txtPesoPano').val(data[0].CT_NPEPAN.toFixed(2));
					$('#txtTapeta').val(data[0].CT_NTAPETA.toFixed(2));
					$('#txtConsEstimado').val(data[0].CT_NCONEST.toFixed(2));
					$('#txtPzaPano').val(data[0].CT_NPZPAN.toFixed(2));
					$('#txtRetazos').val(data[0].CT_NRETAZOS.toFixed(2));
					$('#txtConsReal').val(data[0].CT_NCONREA.toFixed(2));
					$('#txtPanos').val(data[0].CT_NNRPAN.toFixed(2));
					$('#txtPuntas').val(data[0].CT_NPUNTA.toFixed(2));
					$('#txtAncho').val(data[0].CT_NANCHO.toFixed(2));
					$('#txtKg').val(data[0].CT_NKILOS.toFixed(2));
					$('#txtFallados').val(data[0].CT_NFALLAS.toFixed(2));
					$('#txtLargo').val(data[0].CT_NLARGO.toFixed(2));
					$('#txtSobrantes').val(data[0].CT_NSOBRA.toFixed(2));
					$('#txtPartida').val(data[0].CT_CPARTIDA);
					$('#txtMetros').val(data[0].CT_NMETROS.toFixed(2));
					$('#txtPqte').val(data[0].CT_NPQTE);
					
					$('#tbTallas tr:not(:first-child)').remove();
					
					var fil = 0;
					var _sumCantidad = 0;
					var _sumGrupos   = 0;
					var _gpo	     = 0;
					//var _filT 		 = 1;
					//var _f = 1;
					$.each(data, function(key,value){
						//cboArticulo.append("<option value=\""+v.ST_CCODART+"\">"+v.ST_Cempresa+"</option>");
						fil = key+1;
						if(value!='')
						{
							var _gpo	 = Math.ceil(parseInt(value.CD_NCANT)/parseInt(data[0].CT_NPQTE));
							$('#tbTallas tr:last').after('<tr class="fila" id="fil'+fil+'"><td id="cNum'+fil+'">'+fil+'</td><td id="cArt'+fil+'">'+value.CD_CARTICULO+'</td><td id="cTal'+fil+'">'+value.CD_CTALLA+'</td><td id="cOri'+fil+'" style="text-align:center;">'+value.CD_NCANT+'</td><td id="cEdi'+fil+'"><input type="text" id="txtCan'+fil+'" name="txtCan'+fil+'" class="txt" size="5px" value="'+value.CD_NCANT+'" /></td><td id="cGru'+fil+'">'+_gpo+'</td><td id="cDes'+fil+'">'+value.CD_NINI+'</td><td id="cHas'+fil+'">'+value.CD_NFIN+'</td></tr>');	
							_sumCantidad = _sumCantidad + value.CD_NCANT;
							_sumGrupos   = _sumGrupos   + _gpo;
						}
						//fil++;
						
					
						/**********************************************/
						$('#txtCan'+fil).keyup(function(e){
							
						var _numero = Math.round($(this).val());	
							
						 if(_numero>0) {	 
							 for(i=1;i<=$('#tbTallas tr').length-1;i++)
								{
									$('#cDes'+i).html('');
									$('#cHas'+i).html('');
									
								}
							 
							 for(y=1;y<=$('#tbTallas tr').length-2;y++)
								{
									var _totPza = $('#txtPqte').val();
									var _cant   = $('#txtCan'+y).val();
							 
									var _gpo	 = Math.ceil(parseInt(_cant)/parseInt(_totPza));
									 $('#cGru'+y).html(_gpo);
									if(_gpo>0)		
										{
											//$('#ctal'+id+y+'6').html(1);		
											$('#cDes'+y).html(1);		
										}
							 
							 var _sumhasta = 0;
							 for(i=1;i<=$('#tbTallas tr').length-1;i++)
								{
									_fil7 = parseInt($('#cHas'+i).html());
									if($('#cHas'+i).html()=='' && i==1)
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
									 $('#cHas'+y).html(_gpo);
								 }
							 else{
								 _hasta = _gpo+_sumhasta;
								 _desde = (_hasta-_gpo)+1;
								 $('#cDes'+y).html(_desde);
								 $('#cHas'+y).html(_hasta);
							 }
							}
							 
							 
							 if($('#txtKg').val()>0)
								 {
									 if($(this).val()>0)
										 {
										_real = 0;
										_tot  = 0;
										for(i=1;i<=$('#tbTallas tr').length-1;i++)
											{
												if($.trim($('#txtCan'+i).val())!="")
													{
														
													_real = _real+parseFloat($('#txtCan'+i).val());
													}
											}
											 
											_tot = (parseFloat($('#txtKg').val())/_real).toFixed(3);  
											 $('#txtConsReal').val(_tot);
										 }
								 }
				
				var _sumCan = 0;
				var _sumGru = 0;
				//var _filT 		 = 1;
				var _f = 1;
							 
				$.each(data, function(key, value){
					
					if($.trim($('#txtCan'+_f).val())!="")
					   {
						_sumCan = _sumCan + parseInt($('#txtCan'+_f).val());
						
						_sumGru = _sumGru + parseInt($('#cGru'+_f).html()); 
					   }
					   _f++;
				});
				
				//$('#txtSumEdicion').val(_sumCantidad.toFixed(2));
				//$('#txtSumGrupo').val(_sumGrupos.toFixed(2));	 
				$('#txtSumEdicion').val(_sumCan.toFixed(2));
				$('#txtSumGrupo').val(_sumGru.toFixed(2));	 
				
						}
				});
						fil++;
					/**********************************************/
				
				
					});

					$('#tbTallas tr:last').after('<tr id="fil'+fil+'"><td id="cNum'+fil+'"></td><td id="cArt'+fil+'"></td><td id="cTal'+fil+'"></td><td id="cOri'+fil+'" style="text-align:center;"></td><td id="cEdi'+fil+'"><input type="text" id="txtSumEdicion" name="txtSumEdicion" disabled="disabled" size="5px" value="0.00" /></td><td id="cGru'+fil+'"><input type="text" id="txtSumGrupo" name="txtSumGrupo"  disabled="disabled" size="5px" value="0.00" /></td><td id="cDes'+fil+'"></td><td id="cHas'+fil+'"></td></tr>');	
					
					//******************************
					$('#txtSumEdicion').val(_sumCantidad.toFixed(2));
					$('#txtSumGrupo').val(_sumGrupos.toFixed(2));	 
					//*****************************
				}
			else{
				alert('Numero de Corte no existe, Ingrese otro numero');
			}
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
	$("#txtnroCORTE").keypress(function(e) {
		   if(e.which == 13) {
			  //_text = pad($("#txtnroCORTE").val(), 8);
			   var  _text = $("#txtnroCORTE").val();
			   fBuscaCorte(_text);
			   GeneraModulo();
		   }
		});
	/*************************************/
	$('#bntImprimir').click(function(){
			var _ofi   = $('#celOFI').html();
			var _corte = $('#txtnroCORTE').val();
			window.open('../corte/sqlGenCorte/PlanillaCorte.asp?ofi='+_ofi+'&corte='+_corte);
			
	});
	/************************************/
		
	/************Boton Grabar Corte***********/
	$('#bntGrabar').click(function(){
		if(confirm('¿Seguro de modificar Corte?'))
			{
					numCorte	= $('#txtnroCORTE').val();
					fecha		= $('#txtFecha').val();
					CPO			= '427'; 
					costoEst	= $('#txtConsEstimado').val();
					costoReal	= $('#txtConsReal').val();
					kilos		= $('#txtKg').val();
					sobra		= $('#txtSobrantes').val();
					tapeta		= $('#txtTapeta').val();
					ancho		= $('#txtAncho').val();	
					largo		= $('#txtLargo').val();
					metro		= $('#txtMetros').val();
					punta		= $('#txtPuntas').val();	
					retazo		= $('#txtRetazos').val();
					falla		= $('#txtFallados').val();
					pepan		= $('#txtPesoPano').val();
					pazpano		= $('#txtPzaPano').val();
					nropano		= $('#txtPanos').val();
					partida		= $('#txtPartida').val();
					codTela		= $('#txtCodTela').val();
					codservicio	= $("input[name='RadioGroup1']:checked").val();
					nropaquete	= $('#txtPqte').val();
					servicio	= 1;
					$.getJSON('../corte/sqlGenCorte/GrabaManCorte.asp?numCorte='+numCorte+'&fecha='+fecha+'&CPO='+CPO+'&costoEst='+costoEst+'&costoReal='+costoReal+'&kilos='+kilos+'&sobra='+sobra+'&tapeta='+tapeta+'&ancho='+ancho+'&largo='+largo+'&metro='+metro+'&punta='+punta+'&retazo='+retazo+'&falla='+falla+'&pepan='+pepan+'&pazpano='+pazpano+'&nropano='+nropano+'&partida='+partida+'&codTela='+codTela+'&nropaquete='+nropaquete+'&codservicio='+codservicio+'&servicio='+servicio,function(data){
						
					})
					.done(function(data){
						for(i=1;i<=$('#tbTallas tr').length-2;i++)
									{ 	
										CD_CNROCORTE 	= data.nrocorte;
										CD_CSECUEN 		= $('#cNum'+i).html();
										CD_CARTICULO    = $('#cArt'+i).html();
										CD_CTALLA 		= $('#cTal'+i).html();
										CD_ORIGEN		= $('#cOri'+i).html();
										CD_NCANT		= $('#txtCan'+i).val();
										CD_GRUPO		= $('#cGru'+i).html();
										CD_NINI			= $('#cDes'+i).html();
										CD_NFIN			= $('#cHas'+i).html();
										//window.open('../corte/sqlGenCorte/GrabaCorteManDet.asp?&CD_CNROCORTE='+CD_CNROCORTE+'&CD_CSECUEN='+CD_CSECUEN+'&CD_CARTICULO='+CD_CARTICULO+'&CD_CTALLA='+CD_CTALLA+'&CD_ORIGEN='+CD_ORIGEN+'&CD_NCANT='+CD_NCANT+'&CD_GRUPO='+CD_GRUPO+'&CD_NINI='+CD_NINI+'&CD_NFIN='+CD_NFIN+'&CD_NORDEN='+i+'&item='+i);
										$.getJSON('../corte/sqlGenCorte/GrabaCorteManDet.asp?CD_CNROCORTE='+CD_CNROCORTE+'&CD_CSECUEN='+CD_CSECUEN+'&CD_CARTICULO='+CD_CARTICULO+'&CD_CTALLA='+CD_CTALLA+'&CD_ORIGEN='+CD_ORIGEN+'&CD_NCANT='+CD_NCANT+'&CD_GRUPO='+CD_GRUPO+'&CD_NINI='+CD_NINI+'&CD_NFIN='+CD_NFIN+'&CD_NORDEN='+i+'&item='+i,function(data){
						
										})
										.done(function(data){
										_filas  = $('#tbTallas tr').length-2;

										if(_filas == data.item)	
										{
											
											//window.open('../corte/sqlGenCorte/GrabaTodoManCorte.asp');
											$.getJSON('../corte/sqlGenCorte/GrabaTodoManCorte.asp',function(data){
						
											})
											.done(function(data){
												if(data.status==1)
												{
													alert('Datos Guardados Correctamente');
													window.location.reload(true);
												}
											})
											.fail(function( jqxhr, textStatus, error ){
												var err = textStatus + ", " + error;
												alert( "Error: " + err );
											});
											
										}
										})
										.fail(function( jqxhr, textStatus, error ) {
											var err = textStatus + ", " + error;
											alert( "Error: " + err );
										});
									}

					})
					.fail(function( jqxhr, textStatus, error ) {
						var err = textStatus + ", " + error;
						alert( "Error: " + err );
					});

			}
	});
	/****************************************/
});