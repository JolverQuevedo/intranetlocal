// JScript source code
function ajaxObject(url, callbackFunction) {
    var that = this;
    this.updating = false;

    this.update = function (passData, postMethod) {
        if (that.updating == true) { return false; }
        that.updating = true;
        var AJAX = null;
        if (window.XMLHttpRequest) {
            AJAX = new XMLHttpRequest();
        } else {
            AJAX = new ActiveXObject("Microsoft.XMLHTTP");
        }
        if (AJAX == null) {
            return false;
        } else {
            AJAX.onreadystatechange = function () {
                if (AJAX.readyState == 4) {
                    that.updating = false;
                    that.callback(AJAX.responseText, AJAX.status, AJAX.responseXML);
                    delete AJAX;
                }
            }
            var timestamp = new Date();
            if (postMethod == 'POST') {
                var uri = urlCall + '?' + timestamp.getTime();
                AJAX.open("POST", uri, true);
                AJAX.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                AJAX.send(passData);
            } else {
                var uri = urlCall + '?' + passData + '&timestamp=' + (timestamp * 1);
                AJAX.open("GET", uri, true);
                AJAX.send(null);
            }
            return true;
        }
    }
    var urlCall = url;
    this.callback = callbackFunction || function () { };
}
Uso:
// Función que recibe la respuesta del servidor-
function fin(responseTxt, responseStat) {
    alert(responseStat + ' - ' + responseTxt);
}

//Creamos el objeto ajax(test1) y le indicamos la ruta que ha de seguir para obtener los datos
// que se procesarán en la función fin().
var test1 = new ajaxObject('http://someurl.com/server.cgi', fin);
test1.update();

// Pasamos id=user4379 como parametro a la página indicada.
var test2 = new ajaxObject('http://someurl.com/program.php', fin);
test2.update('id=user4379');

// create a new ajaxObject but we'll overwrite the callback function inside
// the object to more tightly bind the object with the response hanlder.
var test3 = new ajaxObject('http://someurl.com/prog.py', fin);
test3.callback = function (responseTxt, responseStat) {
    // we'll do something to process the data here.
    document.getElementById('someDiv').innerHTML = responseTxt;
}
test3.update('coolData=47&userId=user49&log=true');

// create a new ajaxObject and pass the data to the server (in update) as
// a POST method instead of a GET method.
var test4 = new ajaxObject('http://someurl.com/postit.cgi', fin);
test4.update('coolData=47&userId=user49&log=true', 'POST');	

