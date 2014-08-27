$( document ).ready(function() {
    console.log( "ready!" );

    connectWebViewJavascriptBridge(function(bridge) {
	    bridge.init(function(message, responseCallback) {
	        alert('Received message: ' + message)   
	        if (responseCallback) {
	            responseCallback("Right back atcha")
	        }
	    });

	    $('li.item a').click(function() {
	    	var response = {};
	    	response['action'] = "push";
	    	bridge.send(response);
    		return false; 
    	}); 

	    $('li.item').click(function(){
	    	var response = {};
	    	response['action'] = "push";
	    	bridge.send(response);
    	});	    
	});
});

function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        callback(WebViewJavascriptBridge)
    } else {
        document.addEventListener('WebViewJavascriptBridgeReady', function() {
            callback(WebViewJavascriptBridge)
        }, false)
    }
}
