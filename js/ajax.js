var net = new Object();
net.READY_STATE_UNINITIALIZED = 0;
net.READY_STATE_LOADING = 1;
net.READY_STATE_LOADED = 2;
net.READY_STATE_INTERACTIVE = 3;
net.READY_STATE_COMPLETE = 4;

net.ContentLoader = function(url, onload, onerror, method, params){
	this.url = url;
	this.onload = onload;
	this.onerror = (onerror) ? onerror : this.defaultError;
	this.method = method;
	this.params = params;
	this.loadXMLDoc(url);
}

net.ContentLoader.prototype={
	loadXMLDoc:function(url){
		if(window.ActiveXObject){
			try {// IE6
				this.req = new ActiveXObject("MSXML2.XMLHTTP");
			} catch (e) {
				try {// IE4, IE5
					 this.req = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e2) {
					this.req = new XMLHttpRequest();
				}
			}
		}else if(window.XMLHttpRequest){
			this.req = new XMLHttpRequest();
		}

		if(this.req){
			try{
				var loader = this;
				this.req.onreadystatechange = function(){
					loader.onReadyState.call(loader);
				}
				this.req.open(this.method, this.url, true);
				this.req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded; charset=euc-kr');
				this.req.send(this.params);
			}catch (err){
				this.onerror.call(this);
			}
		}

	},
	onReadyState:function(){
		var req = this.req;
		var ready = req.readyState;
		if(ready == net.READY_STATE_COMPLETE){
			var httpStatus = req.status;
			if(httpStatus == 200 || httpStatus == 0){
				this.onload.call(this);
			}else{
				this.onerror.call(this);
			}
		}
	},
	defaultError:function(){
		alert('에러발생:\n\nreadState : ' + this.req.readState + '\n\nstatus : ' + this.req.reason + '\n\nheader : ' + this.req.getAllResponseHeaders());
	}


}