
var expireDate = new Date();

function setExpireCookie(name,value,expiredays){
	document.cookie = name+'='+escape(value)+';expires='+expiredays.toGMTString()+';path=/;domain='+window.location.hostname+';';
}

function getExpireCookie(name){
	var tmp=document.cookie.split('; ');
	for (var i=0; i<tmp.length;i++){
		var c_name = tmp[i].split('=');
		if (c_name[0]==name) return c_name[1];
	}
	return false;
}

function saveID(name, login_id) {
	expireDate.setTime(expireDate.getTime() + 1000 * 3600 * 24 * 30); // 30days;
	setExpireCookie(name,login_id,expireDate);
}

function unSaveID(name, login_id) {
	expireDate.setTime(expireDate.getDate() - 1);
	setExpireCookie(name,login_id,expireDate);
}

function saveSSL(name) {
	expireDate.setTime(expireDate.getTime() + 1000 * 3600 * 24 * 365); // 365days;
	setExpireCookie(name,"on",expireDate);
}

function unSaveSSL(name) {
	expireDate.setTime(expireDate.getTime() + 1000 * 3600 * 24 * 365); // 365days;
	setExpireCookie(name,"off",expireDate);
}

function SaveIdCheck(obj, login_id, name) {
	obj.checked=false;
	login_id.value="";
	
	if(getExpireCookie(name)!=""){
		obj.checked=true;
		login_id.className = "box_txt_gra";
		login_id.value=getExpireCookie(name);
	}
}

function sslSaveCheck(obj, name) {
	obj.checked=false;
	
	if(getExpireCookie(name) == "off") {
		obj.checked=false;
	}
	else {
		obj.checked=true;
	}
}

function SaveIdCheck_new(obj, login_id, name) {
	obj.checked=false;
	login_id.value="";
	
	if(getExpireCookie(name)!=""){
		obj.checked=true;
		//login_id.className = "inputon";
		login_id.value=getExpireCookie(name);
	}
}

function sslSaveCheck_new(obj, name) {
	obj.checked=false;
	
	if(getExpireCookie(name) == "off") {
		obj.checked=false;
	}
	else {
		obj.checked=true;
	}
}

function SaveIdCheck_new2(obj, login_id, name1, name2, name3) {
	obj.checked=false;
	login_id.value="";
	
	name3 = name3 || 'save_grade';
	var logtype = getExpireCookie(name3);
	if(logtype!="") {
		setType(logtype);
	}
	
	if(logtype=="1" && getExpireCookie(name1)!=""){
		obj.checked=true;
		//login_id.className = "inputon";
		login_id.value=getExpireCookie(name1);
	}
	if (logtype!="1" && getExpireCookie(name2)!="") {
		obj.checked = true;
		login_id.value = getExpireCookie(name2);
	}
}
