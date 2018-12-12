// JavaScript Document
/*************Funciones*****************/
function pad (str, max) {
	  str = str.toString();
	  return str.length < max ? pad("0" + str, max) : str;
}

function jsFecha(obj, id)
{
	var d = new Date(); 
	var month = d.getMonth()+1; 
	var day = d.getDate(); 
	var _date = (day<10 ? '0' : '') + day+ '/' + (month<10 ? '0' : '') + month + '/' + d.getFullYear() ;
	//return output;
	$('#'+obj+id).val(_date);
}