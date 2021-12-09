//아이디 중복 확인
function fn_id_check() {
	var id				= $('#user_id').val();

	var checkNumber		= id.search(/[0-9]/g);	// 숫자 입력 체크
	var checkEnglish	= id.search(/[a-z]/ig);	// 영문 입력 체크

	if (id == "") {
		$('#msgBox_id').text('아이디를 입력해 주시기 바랍니다.');
		$('#user_id').focus();
		return;
	} 
	else if (!Validchar(id, num+alpha)) {
		$('#msgBox_id').text('아이디는 한글 및 특수문자를 지원하지 않습니다.');
		$('#user_id').focus();
		return;
	} 
	else if (id.length < 5) {
		$('#msgBox_id').text('아이디는 최소 5자이상이여야 합니다.');
		$('#user_id').focus();
		return;
	} 
	else if(checkNumber < 0 || checkEnglish < 0){
		$('#msgBox_id').text('영문과 숫자를 혼용하여 입력해 주시기 바랍니다.');
		$('#user_id').focus();
		return;
	} 
	else if (/(\w)\1\1\1/.test(id)){
		$('#msgBox_id').text("동일한 문자 연속 4글자 이상은 사용 금지합니다.");
		$('#user_id').focus();
		return;
	}
	else {
		$.ajax({
			type: "POST"
			, url: "/my/signup/Id_CheckAll.asp"
			, data: { user_id: id }
			, dataType: "text"					
			, async: true
			, success: function (data) {
				// 기존 등록된 아이디가 존재하면 X, 없으면 O
				if (data.trim() == "X") {
					$('#msgBox_id').text("탈퇴한 아이디 또는 이미 사용중인 아이디로, 이용하실 수 없습니다.");
					$('#user_id').focus();
					return;
				} else {
					$('#msgBox_id').text("사용 가능한 아이디입니다.");
					return;
				}
			}
			, error: function (XMLHttpRequest, textStatus, errorThrown) {
				alert(XMLHttpRequest.responseText);
			}

		});
	}
}

//비밀번호 확인
function fn_pw_check() {
	var id			= $('#user_id').val();
	var pw1			= $('#user_pw1').val();
	var pw2			= $('#user_pw2').val();

	var pattern1	= /[0-9]/;					// 숫자 
	var pattern2	= /[a-zA-Z]/;				// 문자 
	var pattern3	= /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자

	if (pw1.length == 0) {
		return;
	}
	else {
		if (pw1.length < 8 || pw1.length > 32) {
			$("#msgBox_pw1").text("비밀번호는 8~32자 까지만 허용됩니다.");
			$('#user_pw1').focus();
			return;
		}
		
		if (id != "" && pw1.search(id) > -1) {
			$("#msgBox_pw1").text("비밀번호에 아이디가 포함되어 있습니다.");
			$('#user_pw1').focus();
			return;
		}	
		
		if(!pattern1.test(pw1) || !pattern2.test(pw1) || !pattern3.test(pw1)) {
			$("#msgBox_pw1").text("비밀번호는 영문, 숫자 및 특수문자의 조합으로 생성해야 합니다");
			$('#user_pw1').focus();
			return;
		}
		else{
			if(pw1.search(id) > -1) {
				$("#msgBox_pw1").text("비밀번호에 아이디가 포함되어 있습니다.");
				$('#user_pw1').focus();
				return;
			}else{
				$("#msgBox_pw1").text("");
			}
		}
	}

	if (pw2.split(" ").join("") == "") {
		$("#msgBox_pw2").text("비밀번호 확인을 입력해 주세요.");
		return;
	} 

	if (pw1 != pw2) {
		$("#msgBox_pw2").text("비밀번호가 일치하지 않습니다.");
		return;
	} 
	else {
		$("#msgBox_pw1").text("");
		$("#msgBox_pw2").text("");
	}
}

//가입하기
function onSubmit() {
	var hArea		= $('[name=hArea]').is(':checked');
	//var id			= $('#user_id').val();
	//var pw1			= $('#user_pw1').val();
	//var pw2			= $('#user_pw2').val();
	var salary		= $('#salary_sel').val();
	
	var agreeCheck = "";
	$('input:radio[name="agreeCheck"]').each(function() {
		if (this.checked) {
			agreeCheck = this.value;
		}
	});

	if (hArea == false){
		alert('취업활동 희망지역을 선택해 주세요.');
		$('[name=hArea]').focus();
		return;
	}
	
	/*
	if (id == '') {
		alert('아이디를 입력해 주세요.');
		$('#user_id').focus();
		return;
	}

	if(pw1 == '') {
		alert('비밀번호를 입력해 주세요.');
		$('#user_pw1').focus();
		return;
	}

	if(pw2 == ''){
		alert('비밀번호 확인을 입력해 주세요.');
		$('#user_pw2').focus();
		return;
	}

	if(pw1 != pw2){
		alert('비밀번호와 비밀번호 확인에 입력한 정보가 일치하지 않습니다.');
		$('#user_pw2').focus();
		return;
	}	
	*/

	if (salary == '') {
		alert('희망연봉을 입력해 주세요.');
		$('#salary_sel').focus();
		return;
	}

	if (agreeCheck != "1"){
		alert('동의하지 않으시면 박람회 사이트 이용이 불가합니다.');
		$('[name=agreeCheck]').focus();
		return;
	}
	
	$('#join_wrap').attr('action', './memberRegProc_moti_school.asp');
	$('#join_wrap').submit();
}