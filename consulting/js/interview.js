//면접시간 radio disable
function fn_interview_time_disable() {
	$('input[name="set_interview_time"]').each(function() {
		//$(this).attr('disabled', true);
		$(this).parent().attr('disabled', true);
		$(this).parent().attr('readonly', true);	
		$(this).parent().addClass('disable');
		$(this).parent().removeClass('sel');
	});

	radioboxFnc();//라디오박스
}

//면접시간 disable reset
function fn_interview_time_disable_reset(_val) {
	var time_val = _val.split(",");

	$('input[name="set_interview_time"]').each(function() {
		for (var i=0; i<time_val.length; i++) {
			if (time_val[i] == this.value) {
				$(this).parent().attr('disabled', false);
				$(this).parent().attr('readonly', false);
				$(this).parent().removeClass('disable');
				$(this).parent().removeClass('sel');
			}
		}
		//this.checked = false;
	});

	radioboxFnc();
}

//내가 신청한 면접시간 체크
function fn_chk_user_interview_time() {
	var consultant_id = $('#set_consultant_id').val();
	var consultant_day = $('#set_consultant_day').val();

	if (consultant_id == "" || consultant_day == "") {
		return;
	}

	$.ajax({
		url: "./ajax_get_consulting_apply.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"consultant_id": consultant_id,
			"consultant_day": consultant_day,
		}),
		success: function (data) {
			var time_val = data.split(",");

			$('input[name="set_interview_time"]').each(function() {
				for (var i=0; i<time_val.length; i++) {
					if (time_val[i] == this.value) {
						$(this).parent().attr('disabled', true);
						$(this).parent().attr('readonly', true);
						$(this).parent().removeClass('disable');
						$(this).parent().addClass('sel');
					}
				}
				//this.checked = false;
			});

			radioboxFnc();
		},
		error: function (req, status, err) {
			alert("처리 도중 오류가 발생하였습니다.\n" + err);
		}
	});

}

//면접시간 radio 선택 초기화
function fn_interview_time_reset() {
	$('input[name="set_interview_time"]').each(function() {
		this.checked = false;
	});

	radioboxFnc();//라디오박스
}

//면접시간 선택클릭
function fn_time_set(_obj) {
	var set_day = $('#set_consultant_day').val();
	var set_time = $(_obj).parent().next().html().substring(0, 5);

	if (set_day == "") {
		return;
	} else {
		var today_date = new Date();
		var set_date = new Date(set_day.split("-")[0], set_day.split("-")[1] -1, set_day.split("-")[2], set_time.split(":")[0], set_time.split(":")[1]);

		if (set_date < today_date) {			
			alert("현재시간 이전의 시간은 선택이 불가능합니다.");
			fn_interview_time_reset();
		}
	}
}

/*
----------------------------------------------------------------
채용상담협력사 관련
----------------------------------------------------------------
*/

//채용상담 면접시간 disable 초기화
function fn_consult_time_disable_reset() {
	$('input[name="set_interview_time"]').each(function() {
		//$(this).attr('disabled', true);
		$(this).parent().attr('disabled', false);
		$(this).parent().attr('readonly', false);
		$(this).parent().removeClass('disable');
		$(this).parent().removeClass('sel');
	});
	radioboxFnc();//라디오박스
}

// 내가 신청한 상담 시간 체크
function fn_chk_user_consult_time() {
	var consultant_id = $('#set_interview_id').val();
	var consultant_day = $('#set_interview_day').val();

	if (consultant_id == "" || consultant_id == null || consultant_day == "" || consultant_day == null) {
		return;
	}

	$.ajax({
		url: "./ajax_get_consult_cnt.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"gubun": "U",
			"consultant_id": consultant_id,
			"consultant_day": consultant_day,
		}),
		success: function (data) {
			var time_val = data.split(",");
			$('input[name="set_interview_time"]').each(function() {
				for (var i=0; i<time_val.length; i++) {
					if (time_val[i] == this.value) {
						$(this).parent().removeClass('disable');
						$(this).parent().addClass('sel');
					}
				}
			});
			radioboxFnc();
		},
		error: function (req, status, err) {
			//alert("처리 도중 오류가 발생하였습니다.\n" + err);
		}
	});
}

// 회사 상담 마감 시간 체크
function fn_chk_com_consult_time() {
	var consultant_id = $('#set_interview_id').val();
	var consultant_day = $('#set_interview_day').val();
	
	if (consultant_id == "" || consultant_id == null || consultant_day == "" || consultant_day == null) {
		return;
	}

	$.ajax({
		url: "./ajax_get_consult_cnt.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"gubun": "C",
			"consultant_id": consultant_id,
			"consultant_day": consultant_day,
		}),
		success: function (data) {
			var time_val = data.split(",");

			$('input[name="set_interview_time"]').each(function() {
				for (var i=0; i<time_val.length; i++) {
					if (time_val[i] == this.value) {
						$(this).parent().attr('disabled', true);
						$(this).parent().attr('readonly', true);
						$(this).parent().addClass('disable');
						$(this).parent().removeClass('sel');
					}
				}
			});
			radioboxFnc();
		},
		error: function (req, status, err) {
			alert("처리 도중 오류가 발생하였습니다.\n" + err);
		}
	});
}

//면접시간 선택클릭
function fn_com_time_set(_obj) {
	var set_day = $('#set_interview_day').val();
	var set_time = $(_obj).parent().next().html().substring(0, 5);

	if (set_day == "") {
		return;
	} else {
		var today_date = new Date();
		var set_date = new Date(set_day.split("-")[0], set_day.split("-")[1] -1, set_day.split("-")[2], set_time.split(":")[0], set_time.split(":")[1]);

		if (set_date < today_date) {			
			alert("현재시간 이전의 시간은 선택이 불가능합니다.");
			fn_interview_time_reset();
		}
	}
}