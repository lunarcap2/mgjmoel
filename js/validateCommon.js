
	function chkNull(obj, msg) {
		if(obj.value.split(" ").join("") == "") {
			alert(msg);
			obj.focus();
			return false;
		} else {
			return true;
		}
	}

	function ischecked(obj,msg) {
		var sObj = eval(obj);
		var i = 0;
		for(i=0;i<sObj.length; i++) {
			if(sObj[i].checked) {
				return true;
			}
		}
		alert(msg);
		return false;
	}

	function isselected(obj,msg) {
		var sObj = eval(obj);
		if(sObj.selectedIndex > 0) {
			return true;
		}
		alert(msg);
		return false;
	}

	function chkLen(obj, minSize, maxSize, msg){
		if(minSize > maxSize){
			alert(obj.name + 'ø° ¥Î«— ±Ê¿Ã √º≈©ø° ¿ﬂ∏¯µ» π¸¿ß∏¶ ªÁøÎ«ﬂΩ¿¥œ¥Ÿ.');
			return false;
		}

		var objval_len = obj.value.length;
		var temp;

		for(i = 0; i < objval_len; i++) {
			temp = obj.value.charAt(i);
			if(escape(temp).length > 4)
			objval_len++;
		}

		if((objval_len < minSize) || (objval_len > maxSize)) {
			alert(msg);
			obj.focus();
			return false;
		} else {
			return true;
		}
	}
	
	//---------------------------------------------------------------------------------------------------
	// µÓ∑œΩ√ ±€¿⁄ºˆ √º≈©
	//---------------------------------------------------------------------------------------------------
	function FC_ChkTextLen(form, maxLen) {
		var f = form;
		var text = f.value;
		
		var i = 0;
		var li_byte = 0;
		var li_len = 0; 
		var ls_one_char = "";
		var text2 = "";
	 
		for (i=0; i< text.length; i++) {
			ls_one_char = text.charAt(i);

			if (escape(ls_one_char).length > 4) {
				li_byte += 2;
			} else {
				li_byte++;
			}

			if(li_byte <= maxLen) {
				li_len = i + 1;
			}
		}

		if (li_byte > maxLen) {
			alert( maxLen + " ±€¿⁄∏¶ √ ∞˙ ¿‘∑¬«“ºˆ æ¯Ω¿¥œ¥Ÿ. \n √ ∞˙µ» ≥ªøÎ¿∫ ¿⁄µø¿∏∑Œ ªË¡¶ µÀ¥œ¥Ÿ. ");
			text2 = text.substr(0, li_len);
			f.value = text2;
		}

		f.focus();
	}
	
	/*
		º˝¿⁄øÕøµπÆ∏∏ ¿‘∑¬πﬁ±‚
		obj = ¿Œ«≤π⁄Ω∫
		return = void
		≈∞ ¿Ã∫•∆Æ ªÁøÎ
	*/
	function NumEngCheck(obj){ 
		temp_value = obj.value.toString(); 
		regexp = /[^0-9a-zA-Z]/g; 
		repexp = ''; 
		temp_value = temp_value.replace(regexp,repexp); 
		obj.value = temp_value; 
	} 


	/*
		º˝¿⁄,øµπÆ,∆ØºˆπÆ¿⁄∏∏ ¿‘∑¬πﬁ±‚
		obj = ¿Œ«≤π⁄Ω∫
		return = void
		≈∞ ¿Ã∫•∆Æ ªÁøÎ
	*/
	function NumEngSpecialCheck(obj){ 
		temp_value = obj.value.toString(); 
		regexp = /[^0-9a-zA-Z~!@\#$%^&*\()\-=+_'\"]/g; 
		repexp = ''; 
		temp_value = temp_value.replace(regexp,repexp); 
		obj.value = temp_value; 
	} 


	/*
		øµæÓ∏∏ ¿‘∑¬πﬁ±‚  (¥Îº“πÆ¿⁄)
		obj = ¿Œ«≤π⁄Ω∫
		type = ¿‘∑¬«¸≈¬
			'small' : º“πÆ¿⁄
			'big' : ¥ÎπÆ¿⁄
			'all' : ¿¸√º
		return = void
		≈∞ ¿Ã∫•∆Æ ªÁøÎ
	*/
	function engCheck(obj, type){ 
		temp_value = obj.value.toString(); 
		regexp = ''; 
		repexp = ''; 
		switch(type){ 
			case 'small':
				regexp = /[^a-z]/g;
				break; 
			case 'big':
				regexp = /[^A-Z]/g;
				break; 
			case 'all':
				regexp = /[^a-z]/i;
				break; 
			default :
				regexp = /[^a-z]/i;
				break;
		}

		temp_value = temp_value.replace(regexp,repexp); 
		obj.value = temp_value; 
	} 


	/*
		º˝¿⁄∏∏ ¿‘∑¬πﬁ±‚
		obj = ¿Œ«≤π⁄Ω∫
		type = ¿‘∑¬«¸≈¬
			'int' : æÁ¿« ¡§ºˆ 
			'float' : æÁ¿« Ω«ºˆ 
			'-int' : ¿Ω¿« ¡§ºˆ ∆˜«‘ 
			'-float' : ¿Ω¿« Ω«ºˆ ∆˜«‘ 
		return = void
		≈∞ ¿Ã∫•∆Æ ªÁøÎ
	*/
	function numCheck(obj, type){ 
		temp_value = obj.value.toString(); 
		regexp = /[^-\.0-9]/g; 
		repexp = ''; 
		temp_value = temp_value.replace(regexp,repexp); 
		regexp = ''; 
		repexp = ''; 
		switch(type){ 
			case 'int':
				regexp = /[^0-9]/g;
				repexp = '';
				break; 
			case 'float':
				regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/;
				repexp = '$2$3$5';
				break;
			case '-int':
				regexp = /^(-?)([0-9]*)([^0-9]*)([0-9]*)([^0-9]*)/;
				repexp = '$1$2$4';
				break;
			case '-float':
				regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/;
				repexp = '$1$2$3$5';
				break; 
			default :
				regexp = /[^0-9]/g;
				repexp = '';
				break; 
		} 

		temp_value = temp_value.replace(regexp,repexp); 
		obj.value = temp_value; 
	}

	function numCheck_alert(obj, type){ 
		temp_value = obj.value.toString(); 

		if(!Validchar(temp_value,num)) {
			alert('º˝¿⁄∏∏ ¿‘∑¬«œΩ« ºˆ ¿÷Ω¿¥œ¥Ÿ');	
		}

		regexp = /[^-\.0-9]/g; 
		repexp = ''; 
		temp_value = temp_value.replace(regexp,repexp); 
		regexp = ''; 
		repexp = ''; 
		switch(type){ 
			case 'int':
				regexp = /[^0-9]/g;
				repexp = '';
				break; 
			case 'float':
				regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/;
				repexp = '$2$3$5';
				break;
			case '-int':
				regexp = /^(-?)([0-9]*)([^0-9]*)([0-9]*)([^0-9]*)/;
				repexp = '$1$2$4';
				break;
			case '-float':
				regexp = /^(-?)([0-9]*)(\.?)([^0-9]*)([0-9]*)([^0-9]*)/;
				repexp = '$1$2$3$5';
				break; 
			default :
				regexp = /[^0-9]/g;
				repexp = '';
				break; 
		} 

		temp_value = temp_value.replace(regexp,repexp); 
		obj.value = temp_value; 
	}

	/* 
		«—±€∏∏ ¿‘∑¬ πﬁ±‚
		obj = ¿Œ«≤π⁄Ω∫
		type = ¿‘∑¬«¸≈¬
			'c' : √ º∫ ∆˜«‘ 
			's' : √ º∫ ∆˜«‘ + ∞¯πÈ ∆˜«‘ 
			'' : √ º∫, ∞¯πÈ π´Ω√ 
		return = void
		«—±€¿∫ ≈∞¿Ã∫•∆Æ∑Œ ªÁøÎ «“ ºˆæ¯±‚ ∂ßπÆø° onBlur, onChange, onFocus¿Ã∫•∆Æ ªÁøÎ «ÿæﬂ«‘
	*/ 
	function korCheck(obj, type) { 
		temp_value = obj.value.toString(); 
		regexp = ''; 
		repexp = ''; 
		switch(type){ 
			case 'c':
				regexp = /[^§°-§æ∞°-∆R]/g;
				break; 
			case 's':
				regexp = /[^§°-§æ∞°-∆R\s]/g;
				break; 
			case '':
				regexp = /[^∞°-∆R]/g;
				break; 
			default :
				regexp = /[^§°-§æ∞°-∆R\s]/g; 
				break; 
		} 

		if(regexp.test(temp_value)) { 
			temp_value = temp_value.replace(regexp,repexp); 
			obj.value = temp_value; 
		} 
	} 

	function korCheck_confirm(obj, type) { 

		temp_value = obj.value.toString(); 
		regexp = ''; 
		repexp = ''; 
		switch(type){ 
			case 'c':
				regexp = /[^§°-§æ∞°-∆R]/g;
				break; 
			case 's':
				regexp = /[^§°-§æ∞°-∆R\s]/g;
				break; 
			case '':
				regexp = /[^∞°-∆R]/g;
				break; 
			default :
				regexp = /[^§°-§æ∞°-∆R\s]/g; 
				break; 
		} 

		if(regexp.test(temp_value)) { 
			return false;
		} else {
			return true;
		}
	} 


	function NumEngCheck_confirm(obj){ 
		temp_value = obj.value.toString(); 
		regexp = /[^0-9a-zA-Z]/g; 
		repexp = ''; 

		if(regexp.test(temp_value)) { 
			return false;
		} else {
			return true;
		}
	} 


	//¡÷πŒπ¯»£ ≈« ¿⁄µø¿Ãµø
	function nextTab(sObj, nObj, eLength) {
		if (sObj.value.length == eLength) {
			nObj.focus();
		}
	}	

	function fieldChk(msg, f) {
		alert(msg);
		f.focus();
	}


	function chkDateType(obj) {
		temp_value = obj.value.toString().length; 
		if (temp_value > 0 && temp_value < 6) {
			alert("¿Ø»ø«œ¡ˆ æ ¿∫ ≥Ø¬•¿‘¥œ¥Ÿ.");
			return;
		}
	}

	//≥Ø¬•∫Ø»Ø yyyymm -> yyyy-mm
	function changeDateType(obj) {
		temp_value = obj.value.toString(); 
		if (temp_value.length == 6) {

			oDate = new Date();
			//oDate.setFullYear(temp_value.substring(0, 4));
			//oDate.setMonth(parseInt(temp_value.substring(4, 6)) - 1);

			var year = temp_value.substring(0, 4);
			var month = parseInt(temp_value.substring(4, 6));

			//if( oDate.getFullYear() != temp_value.substring(0, 4) || oDate.getMonth() + 1 != temp_value.substring(4, 6) ) {
			if (year < oDate.getFullYear() -100 || year > oDate.getFullYear() +100 || month < 1 || month > 12) {
				alert("¿Ø»ø«œ¡ˆ æ ¿∫ ≥Ø¬•¿‘¥œ¥Ÿ.");
				return;
			}

			obj.value = temp_value.substr(0, 4) + "." + temp_value.substr(4, 2);
		}
	}


	//»ﬁ¥Î∆˘π¯»£ ∫Ø»Ø 0101231234 -> 010-123-1234
	function changePhoneType(obj) {
		temp_value = obj.value.toString().replace("-", "");

		if (temp_value.length > 3) {
			obj.value = temp_value.substr(0, 3) + "-" + temp_value.substr(3);
		}
		if (temp_value.length > 6) {
			obj.value = temp_value.substr(0, 3) + "-" + temp_value.substr(3, 3) + "-" + temp_value.substr(6);
		}
		if (temp_value.length == 11) {
			obj.value = temp_value.substr(0, 3) + "-" + temp_value.substr(3, 4) + "-" + temp_value.substr(7, 4);
		}
	}

	//ª˝≥‚ø˘¿œ ∫Ø»Ø 19900312 -> 1990.03.12
	function changeBirthType(obj) {
		temp_value = obj.value.toString().replace(".", "");

		if (temp_value.length > 4) {
			obj.value = temp_value.substr(0, 4) + "." + temp_value.substr(4);
		}
		if (temp_value.length > 6) {
			obj.value = temp_value.substr(0, 4) + "." + temp_value.substr(4, 2) + "." + temp_value.substr(6);
		}
	}


	/*¿Ã∏ﬁ¿œ √º≈© Ω√¿€*/
	function email_check( email ) {    
		var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		return (email != '' && email != 'undefined' && regex.test(email)); 
	}