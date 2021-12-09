var pwdMsg = "입력하신 비밀번호가 보안상 매우 취약합니다.\n\n5~10자 까지 영문, 숫자 등의 조합으로\n아이디와 무관한 문자열을 입력해주세요."; 
var blockWord = new Array();
blockWord.push("dfdf");
blockWord.push("asdf");
blockWord.push("123123");
	
PwdChecker = function() {
}

PwdChecker.prototype.mainProgress = function(id, pw) {
	if (pw.length < 5 || pw.length > 10) {
		alert("비밀번호는 5~10자 이상만 허용됩니다.");
		return false;
	}
	if (!this.step1Check(id, pw) 
		|| !this.step2Check(pw) 
		|| !this.step3Check(pw)
		|| !this.step4Check(id, pw)) {
		alert(pwdMsg);
		return false;
	}
	return true;
}

//ID와 일치성 검사
PwdChecker.prototype.step1Check = function(id, pw) {
	if (id.indexOf(pw) != -1) {
		return false;
	}
	if (pw.indexOf(id) != -1) {
		return false;
	}
	return true;
}

//연속성의 문자 및 금지어 검사
PwdChecker.prototype.step2Check = function(pw) {
	if ("01234567890".indexOf(pw) != -1) {
		return false;
	}
	if ("abcdefghijklmnopqrstuvwxyz".indexOf(pw) != -1) {
		return false;
	}
	if ("ABCDEFGHIJKLMNOPQRSTUVWXYZ".indexOf(pw) != -1) {
		return false;
	}
	for (var i = 0; i < blockWord.length; i++) {
		if (pw.indexOf(blockWord[i]) != -1) {
			return false;
		}
	}
	return true;
}

//동일한 앞,뒤 문자가 4개 이상여부 검사
PwdChecker.prototype.step3Check = function(pw) {
	var cnt = 1;
	for (var i = 0; i < pw.length-1; i++) {
		if (this.compare3(pw, i)) {
			++cnt;
		} else {
			cnt = 1;
		}
		if (cnt > 3) {
			return false;
		}
	}
	return true;
}

//패스워드가 아이디에 포함 단어여부 검사
PwdChecker.prototype.step4Check = function(id, pw) {
	return this.compare4(pw, 0, id, 0);
}

PwdChecker.prototype.compare3 = function(pw, i) {
	return pw.charAt(i) == pw.charAt(i+1);
}

PwdChecker.prototype.compare4 = function(pw, i, id, j) {
	if (i >= pw.length) return false;
	var _pw = pw.charAt(i);
	var _id = id.substring(j);
	var k = _id.indexOf(_pw);
	if (k == -1) return true;
	return this.compare4(pw, i+1, id, k+1);
}
