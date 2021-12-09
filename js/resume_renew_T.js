var _frm1 = null;
$(document).ready(function () {
	_frm1 = document.frm_resume;
});


function fn_regist_date_nullchk(){
	//rsub_regist.asp경로로 왓을때 ==> 이력서등록폼들
	//document의 class="fnDatePicker" 를 찾아서 값이 없으면 false;


	/*
	* 조건값정리
	* pathname이 regist여야하고 && 타겟벨류없어야하고 && 타겟이 활성화상태여야하고 && 타겟이 히든이 아니여야함 -> false
	*/
	var pathname = location.pathname;
	var returnValue = true;
	var $target = $(document).find('.fnDatePicker input');
	if(pathname === '/my/resume/rsub_regist.asp'){
		for (var i = 0; i < $target.length; i++) {
			if(!$target[i].value && !$target[i].disabled && $target.eq(i).is(':visible')){
				returnValue = false;
				break;
			}
		}
	}
	if(!returnValue){
		alert('날짜를 선택해주세요');
	}
	return returnValue;
}

//이력서 등록/저장
function fn_resume_save() {
	//벨리데이션 체크
	if (fn_chk_validate()) {
		fn_resume_save_chkdata();
		_frm1.resumeIsComplete.value = "1";
		_frm1.action = '/my/resume/resume_insert_renew_T.asp';
		_frm1.target = "_self";
		_frm1.submit();
	}
}

function fn_resume_save2() {
	if(!fn_regist_date_nullchk()){
		return false;
	}
	//벨리데이션 체크
	if (fn_chk_validate()) {
		fn_resume_save_chkdata();
		_frm1.resumeIsComplete.value = "4";
		_frm1.action = '/my/resume/resume_insert_renew_T.asp';
		_frm1.target = "_self";
		_frm1.submit();
	}
}

function fn_resume_del() {
	_frm1.resumeIsComplete.value = "5";
	_frm1.action = '/my/resume/resume_insert_renew_T.asp';
	_frm1.target = "_self";
	_frm1.submit();
}

//이력서 임시저장
function fn_resume_save_imsi() {
	if(!fn_regist_date_nullchk()){
		return false;
	}
	//벨리데이션 체크
	if (fn_chk_validate()) {
		fn_resume_save_chkdata();
		_frm1.resumeIsComplete.value = "2";
		_frm1.action = '/my/resume/resume_insert_renew_T.asp';
		_frm1.target = "_self";
		_frm1.submit();
	}
}

function fn_resume_save_preview() {
	//벨리데이션 체크
	if (fn_chk_validate()) {
		fn_resume_save_chkdata();
		_frm1.resumeIsComplete.value = "3";
		_frm1.action = '/my/resume/resume_insert_renew.asp';
		_frm1.target = "procFrame";
		_frm1.submit();
	}
}
function fn_resume_preview() {
	_frm1.action = '/my/resume/resume_preview.asp';
	_frm1.target = "_self";
	_frm1.submit();
}

function fn_del(_rsubItem, _rsub_seq_no, _rsubGubun) {
	if(confirm('삭제하시겠습니까?\n입력한 데이터가 삭제됩니다.')) {
		_frm1.rsubItem.value	= _rsubItem;
		_frm1.rsub_seq_no.value = _rsub_seq_no;
		_frm1.rsubGubun.value	= _rsubGubun;

		fn_resume_del();
	}else{
		try {
			event.target.checked = true;
		} catch (e) { }
	}
}

function fn_resume_update() {
	if(!fn_regist_date_nullchk()){
		return false;
	}
	//벨리데이션 체크
	if (fn_chk_validate()) {
		fn_resume_save_chkdata();
		_frm1.resumeIsComplete.value = "6";
		_frm1.action = '/my/resume/resume_insert_renew_T.asp';
		_frm1.target = "_self";
		_frm1.submit();
	}
}


function fn_validate_chkdate(obj) {
	temp_value = obj.value.toString();
	temp_length = obj.value.replace(".", "").length;

	if (temp_length > 0 && temp_length != 6) {
		alert("유효하지 않은 날짜입니다.");
		obj.focus();
		return false;
	}

	if (temp_length > 0) {
		oDate = new Date();
		//oDate.setFullYear(temp_value.split(".")[0]);
		//oDate.setMonth(parseInt(temp_value.split(".")[1]) - 1);

		var year = temp_value.split(".")[0];
		var month = parseInt(temp_value.split(".")[1]);

		//if( oDate.getFullYear() != temp_value.split(".")[0] || oDate.getMonth() + 1 != temp_value.split(".")[1] ) {
		if (year < oDate.getFullYear() -100 || year > oDate.getFullYear() +100 || month < 1 || month > 12) {
			alert("유효하지 않은 날짜입니다.");
			obj.focus();
			return false;
		}
	}
}

function fn_chk_validate() {
	if(_frm1.rsubGubun.value == '1') {
		if (_frm1.resume_title.value == '') {
			alert('이력서 제목을 입력해주세요.');
			_frm1.resume_title.focus();
			return false;
		}
		if (_frm1.userName.value == '') {
			alert('이름을 입력해주세요.');
			_frm1.userName.focus();
			return false;
		}
		if (_frm1.user_cell1.value == '' || _frm1.user_cell2.value == '' || _frm1.user_cell3.value == '') {
			alert('연락처를 입력해주세요.');
			_frm1.user_cell.focus();
			return false;
		}
		if (_frm1.birthYY.value == '' || _frm1.birthMM.value == '' || _frm1.birthDD.value == '') {
			alert('생년월일을 입력해주세요.');
			_frm1.birth.focus();
			return false;
		}
		else {
			//미성년자 18살 체크 (인재정보 selectbox에 19살부터 시작이라서)
			var date = new Date();
			var birth_year

			birth_year = date.getFullYear() - 18

			if (birth_year < _frm1.birthYY.value) {
				alert("취업 해당 연령에 맞지 않습니다.\n다시 입력해주세요.");
				_frm1.birth.focus();
				return false;
			}
		}

		if (_frm1.email1.value == '' || _frm1.email2.value == '') {
			alert('E-mail을 입력해주세요.');
			_frm1.email.focus();
			return false;
		}
		if (_frm1.address.value == '') {
			alert('주소를 입력해주세요.');
			_frm1.address.focus();
			return false;
		}
	}
	else if(_frm1.rsubGubun.value == '2') {
		//합격년월체크
		if(_frm1.gde_edate != null) {
			if (_frm1.gde_edate.length > 0) {
				for (var i = 0; i < _frm1.gde_edate.length; i++) {
					if (fn_validate_chkdate(_frm1.gde_edate[i]) == false) {
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.gde_edate) == false) {
					return false;
				}
			}
		}
		else {
			//학력 입학년월 체크
			if (_frm1.univ_sdate != null)
			{
				if (_frm1.univ_sdate.length > 0) {
					for (var i = 0; i < _frm1.univ_sdate.length; i++) {
						if (fn_validate_chkdate(_frm1.univ_sdate[i]) == false) {
							return false;
						}
					}
				} else {
					if (fn_validate_chkdate(_frm1.univ_sdate) == false) {
						return false;
					}
				}
			}
			//학력 졸업년월 체크
			if (_frm1.univ_edate != null)
			{
				if (_frm1.univ_edate.length > 0) {
					for (var i = 0; i < _frm1.univ_edate.length; i++) {
						if (fn_validate_chkdate(_frm1.univ_edate[i]) == false) {
							return false;
						}
						if (_frm1.univ_edate[i].value != "" && _frm1.univ_sdate[i].value > _frm1.univ_edate[i].value) {
							alert("학력 졸업일이 입학일보다 빠를 수 없습니다.");
							_frm1.univ_edate[i].focus();
							return false;
						}
					}
				} else {
					if (fn_validate_chkdate(_frm1.univ_edate) == false) {
						return false;
					}
					if (_frm1.univ_edate.value != "" && _frm1.univ_sdate.value > _frm1.univ_edate.value) {
						alert("학력 졸업일이 입학일보다 빠를 수 없습니다.");
						_frm1.univ_edate.focus();
						return false;
					}
				}
			}
		}
	}
	else if(_frm1.rsubGubun.value == '3') {
		//경력 입사년월 체크
		if (_frm1.experience_sdate != null)
		{
			if (_frm1.experience_sdate.length > 0) {
				for (var i = 0; i < _frm1.experience_sdate.length; i++) {
					if (fn_validate_chkdate(_frm1.experience_sdate[i]) == false) {
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.experience_sdate) == false) {
					return false;
				}
			}
		}
		//경력 퇴사년월 체크
		if (_frm1.experience_edate != null)
		{
			if (_frm1.experience_edate.length > 0) {
				for (var i = 0; i < _frm1.experience_edate.length; i++) {
					if (fn_validate_chkdate(_frm1.experience_edate[i]) == false) {
						return false;
					}
					if (_frm1.experience_edate[i].value != "" && _frm1.experience_sdate[i].value > _frm1.experience_edate[i].value) {
						alert("경력 퇴사일이 입사일보다 빠를 수 없습니다.");
						_frm1.experience_edate[i].focus();
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.experience_edate) == false) {
					return false;
				}
				if (_frm1.experience_edate.value != "" && _frm1.experience_sdate.value > _frm1.experience_edate.value) {
					alert("경력 퇴사일이 입사일보다 빠를 수 없습니다.");
					_frm1.experience_edate.focus();
					return false;
				}
			}
		}
	}
	else if(_frm1.rsubGubun.value == '6') {
		//인턴,대외활동 시작일 체크
		if (_frm1.rac_sdate != null)
		{
			if (_frm1.rac_sdate.length > 0) {
				for (var i = 0; i < _frm1.rac_sdate.length; i++) {
					if (fn_validate_chkdate(_frm1.rac_sdate[i]) == false) {
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.rac_sdate) == false) {
					return false;
				}
			}
		}
		//인턴,대외활동 종료일 체크
		if (_frm1.rac_edate != null)
		{
			if (_frm1.rac_edate.length > 0) {
				for (var i = 0; i < _frm1.rac_edate.length; i++) {
					if (fn_validate_chkdate(_frm1.rac_edate[i]) == false) {
						return false;
					}
					if (_frm1.rac_edate[i].value != "" && _frm1.rac_sdate[i].value > _frm1.rac_edate[i].value) {
						alert("인턴,대외활동 시작일이 종료일보다 빠를 수 없습니다.");
						_frm1.rac_edate[i].focus();
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.rac_edate) == false) {
					return false;
				}
				if (_frm1.rac_edate.value != "" && _frm1.rac_sdate.value > _frm1.rac_edate.value) {
					alert("인턴,대외활동 시작일이 종료일보다 빠를 수 없습니다.");
					_frm1.rac_edate.focus();
					return false;
				}
			}
		}
	}
	else if(_frm1.rsubGubun.value == '7') {
		//외국어 인증일자 체크
		if (_frm1.language_date != null)
		{
			if (_frm1.language_date.length > 0) {
				for (var i = 0; i < _frm1.language_date.length; i++) {
					if (fn_validate_chkdate(_frm1.language_date[i]) == false) {
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.language_date) == false) {
					return false;
				}
			}
		}
	}
	else if(_frm1.rsubGubun.value == '8') {
		//자격증 취득일자 체크
		if (_frm1.license_date != null)
		{
			if (_frm1.license_date.length > 0) {
				for (var i = 0; i < _frm1.license_date.length; i++) {
					if (fn_validate_chkdate(_frm1.license_date[i]) == false) {
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.license_date) == false) {
					return false;
				}
			}
		}
	}
	else if(_frm1.rsubGubun.value == '9') {
		//수상 수상일자 체크
		if (_frm1.prize_date != null)
		{
			if (_frm1.prize_date.length > 0) {
				for (var i = 0; i < _frm1.prize_date.length; i++) {
					if (fn_validate_chkdate(_frm1.prize_date[i]) == false) {
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.prize_date) == false) {
					return false;
				}
			}
		}
	}
	else if(_frm1.rsubGubun.value == '10') {
		//교육 시작일 체크
		if (_frm1.academy_sdate != null)
		{
			if (_frm1.academy_sdate.length > 0) {
				for (var i = 0; i < _frm1.academy_sdate.length; i++) {
					if (fn_validate_chkdate(_frm1.academy_sdate[i]) == false) {
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.academy_sdate) == false) {
					return false;
				}
			}
		}
		//교육 종료일 체크
		if (_frm1.academy_edate != null)
		{
			if (_frm1.academy_edate.length > 0) {
				for (var i = 0; i < _frm1.academy_edate.length; i++) {
					if (fn_validate_chkdate(_frm1.academy_edate[i]) == false) {
						return false;
					}
					if (_frm1.academy_edate[i].value != "" && _frm1.academy_sdate[i].value > _frm1.academy_edate[i].value) {
						alert("교육 시작일이 종료일보다 빠를 수 없습니다.");
						_frm1.academy_edate[i].focus();
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.academy_edate) == false) {
					return false;
				}
				if (_frm1.academy_edate.value != "" && _frm1.academy_sdate.value > _frm1.academy_edate.value) {
					alert("교육 시작일이 종료일보다 빠를 수 없습니다.");
					_frm1.academy_edate.focus();
					return false;
				}
			}
		}
	}
	else if(_frm1.rsubGubun.value == '11') {
		//해외경험 시작일 체크
		if (_frm1.abroad_sdate != null)
		{
			if (_frm1.abroad_sdate.length > 0) {
				for (var i = 0; i < _frm1.abroad_sdate.length; i++) {
					if (fn_validate_chkdate(_frm1.abroad_sdate[i]) == false) {
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.abroad_sdate) == false) {
					return false;
				}
			}
		}
		//해외경험 종료일 체크
		if (_frm1.abroad_edate != null)
		{
			if (_frm1.abroad_edate.length > 0) {
				for (var i = 0; i < _frm1.abroad_edate.length; i++) {
					if (fn_validate_chkdate(_frm1.abroad_edate[i]) == false) {
						return false;
					}
					if (_frm1.abroad_edate[i].value != "" && _frm1.abroad_sdate[i].value > _frm1.abroad_edate[i].value) {
						alert("해외경험 시작일이 종료일보다 빠를 수 없습니다.");
						_frm1.abroad_edate[i].focus();
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.abroad_edate) == false) {
					return false;
				}
				if (_frm1.abroad_edate.value != "" && _frm1.abroad_sdate.value > _frm1.abroad_edate.value) {
					alert("해외경험 시작일이 종료일보다 빠를 수 없습니다.");
					_frm1.abroad_edate.focus();
					return false;
				}
			}
		}
	}
	else if(_frm1.rsubGubun.value == '13') {
		//병역 입대일 체크
		if (_frm1.military_sdate != null)
		{
			if (_frm1.military_sdate.length > 0) {
				for (var i = 0; i < _frm1.military_sdate.length; i++) {
					if (fn_validate_chkdate(_frm1.military_sdate[i]) == false) {
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.military_sdate) == false) {
					return false;
				}
			}
		}
		//병역 제대일 체크
		if (_frm1.military_edate != null)
		{
			if (_frm1.military_edate.length > 0) {
				for (var i = 0; i < _frm1.military_edate.length; i++) {
					if (fn_validate_chkdate(_frm1.military_edate[i]) == false) {
						return false;
					}
					if (_frm1.military_edate[i].value != "" && _frm1.military_sdate[i].value > _frm1.military_edate[i].value) {
						alert("병역 입대일이 제대일보다 빠를 수 없습니다.");
						_frm1.military_edate[i].focus();
						return false;
					}
				}
			} else {
				if (fn_validate_chkdate(_frm1.military_edate) == false) {
					return false;
				}
				if (_frm1.military_edate.value != "" && _frm1.military_sdate.value > _frm1.military_edate.value) {
					alert("병역 입대일이 제대일보다 빠를 수 없습니다.");
					_frm1.military_edate.focus();
					return false;
				}
			}
		}
	}

	return true;
}

function fn_resume_save_chkdata() {

	//상세주소 저장
	/*
	if (_frm1.address_dtl.value != "") {
		_frm1.address.value = _frm1.address.value.split(" / ")[0] + " / " + _frm1.address_dtl.value;
	}
	*/

	//최고학력코드 저장(학력사항 학력구분코드 높은것)
	if (_frm1.univ_kind) {
		_frm1.final_scholar.value = _frm1.univ_kind.value;

		var univ_kind = 0;
		for (var i = 0; i < _frm1.univ_kind.length; i++) {
			if (_frm1.univ_kind[i].value > univ_kind) {
				univ_kind = _frm1.univ_kind[i].value;
			}
			_frm1.final_scholar.value = univ_kind;
		}
	}
}

//이력서 (학력_학교명, 경력_회사명, 자격증명) 키워드 검색
function fn_kwSearchItem(obj, _gubun) {
	/*
	이전 형제 노드 찾기
	$("선택자").prev()
	$("선택자").prevAll("선택자");

	다음 형제 노드 찾기
	$("선택자").next()
	$("선택자").nextAll("선택자");
	*/

	var _kw = $(obj).val();
	var _result_obj = $(obj).attr("id");

	if (_kw == "") {
		return;
	}

	$.ajax({
		url: "/my/resume/comm/search_result_school.asp",
		type: "POST",
		dataType: "text",
//		contentType: 'application/x-www-form-urlencoded; charset=euc-kr',
		data: ({
			"kw": escape(_kw),
			"sGubun": _gubun,
			"idx": 0,
			"result_obj_id": _result_obj
		}),
		success: function (data) {
			$(obj).parent().next("#id_result_box").attr('style','display:block;');
			$(obj).parent().next("#id_result_box").html(data).customTags();
		},
		error: function (req, status, err) {
			alert("처리 도중 오류가 발생하였습니다.\n" + err);
		}
	});

	document.charset = "euc-kr";
	/*
	$.get("/my/resume/comm/search_result_school.asp", { "kw": _kw, "sGubun": _gubun, "idx": 0, "result_obj_id": _result_obj }, function (data) {
		$(obj).nextAll("#id_result_box").html(data);
	});
	*/
}

//자동
function textIn(obj, text, result_obj) {
	/*
	바로 위의 부모
	$("선택자").parent()

	모든 부모 찾기
	$("선택자").parents() 모든 부모

	모든 부모 중 선택자에 해당하는 부모 찾기
	$("선택자").parents("선택자")

	특정 자식노드 찾기
	$("선택자").children("선택자")
	*/

	$(obj).parents(".cloneTargetDivision").find("#" + result_obj).val(text);
	$(obj).parents('.result_box').hide();
}

// a태그형태 선택박스 선택값 설정
function fn_sel_value_set(obj, set_name) {
	var _val = $(obj).val();

	$(obj).parents('.cloneTargetDivision').find('#' + set_name).val(_val);
}

function fn_mod_date_update(_rid) {

	$.ajax({
		url: "/my/resume/resume_date_update.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"rid": _rid
		}),
		success: function (data) {
			alert("이력서를 오늘날짜로 업데이트 하였습니다.");
		},
		error: function (req, status, err) {
			alert("처리 도중 오류가 발생하였습니다.\n" + err);
		}
	});

}



function printIframe(id) { //인쇄하기 2015-10-21 skydown@career.co.kr

	var agent = navigator.userAgent.toLowerCase();

	if(agent.indexOf("chrome") != -1 || agent.indexOf("safari") != -1 || agent.indexOf("chrome") != -1 || agent.indexOf("firefox") != -1) {
		var iframe = document.frames ? document.frames[id] : document.getElementById(id);

		var ifWin = iframe.contentWindow || iframe;
		iframe.focus();
		ifWin.printPage();
		return false;
	}

	if(agent.indexOf("msie") != -1 && navigator.appName == "Netscape"){
		window.print();
		return false;
	} else {
		var iframe = document.frames ? document.frames[id] : document.getElementById(id);

		var ifWin = iframe.contentWindow || iframe;
		iframe.focus();
		ifWin.printPage();
		return false;
	}

} //인쇄하기



function printIframe_test(id) {

	var agent = navigator.userAgent.toLowerCase();

	if(agent.indexOf("chrome") != -1 || agent.indexOf("safari") != -1 || agent.indexOf("chrome") != -1 || agent.indexOf("firefox") != -1) {
		var iframe = document.frames ? document.frames[id] : document.getElementById(id);

		var ifWin = iframe.contentWindow || iframe;
		iframe.focus();
		ifWin.leehoPreview();
		return false;
	}

	if(agent.indexOf("msie") != -1 && navigator.appName == "Netscape"){
		window.print();
		return false;
	} else {
		var iframe = document.frames ? document.frames[id] : document.getElementById(id);

		var ifWin = iframe.contentWindow || iframe;
		iframe.focus();
		ifWin.leehoPreview();
		return false;
	}

} //인쇄하기
