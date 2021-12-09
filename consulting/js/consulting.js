
//컨설팅 분야 선택
function fn_sel_consultant(_val) {

	//날짜 및 시간 초기화
	$('#set_consultant_day').val("");
	$('#sel_consDay').val("");
	$('#set_consDay_txt').text("컨설팅 일자 선택");	
	$("#comp_cmmt").hide();

	fn_interview_time_reset();

	// 컨설팅 신청자 정보 입력 영역 숨김 처리 
	$("#pop_request_consulting").hide();

	$.ajax({
		url: "./ajax_get_schedule.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"consultant_id": _val,
		}),
		success: function (data) {
			$('#set_consultant_id').val(_val);
			fn_interview_time_disable();

			if (data == null || data == "") {
				$('#set_consultant_id').val("");
				alert("해당 컨설팅은 신청 가능한 날짜가 없습니다.");
			}
		},
		error: function (req, status, err) {
			alert("처리 도중 오류가 발생하였습니다.\n" + err);
		}
	});
}


//날짜선택
function day_btn_click(obj) {
	var day_value	= $(obj).val();

	if (day_value <= todayToString) {
		alert("오늘을 포함한 이전 날짜는 선택이 불가능합니다.");
		return false;
	}

	var consultant_id = $('#set_consultant_id').val();
	if (consultant_id == "") {
		alert("상단 탭 중에서 신청하실 컨설팅을 먼저 선택해 주세요.");
		return false;
	}

	//선택 클래스
	$(obj).addClass('on');
	$('.day_btn').not(obj).removeClass('on');

	//선택날짜 값설정
	$('#set_consultant_day').val(day_value);

	//시간 초기화
	fn_interview_time_reset();
	
	//해당 날짜의 시간값 가져오기
	$.ajax({
		url: "./ajax_get_schedule_time.asp",
		type: "POST",
		dataType: "text",
		data: ({
			"consultant_id": consultant_id,
			"consultant_day": day_value,
		}),
		success: function (data) {
			$('#str_set_interview_time').val(data);
			fn_interview_time_disable();
			fn_interview_time_disable_reset(data);
			fn_chk_user_interview_time();
		},
		error: function (req, status, err) {
			alert("처리 도중 오류가 발생하였습니다.\n" + err);
		}
	});
}


//내가 신청한 면접시간 체크
function fn_chk_user_interview_time() {
	var consultant_id	= $('#set_consultant_id').val();
	var consultant_day	= $('#set_consultant_day').val();

	if (consultant_id == "" || consultant_id == null || consultant_day == "" || consultant_day == null) {
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
						$(this).parent().addClass('sel');
						//$(this).parent().next().children("p").text("내꺼");
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


//면접시간 disable reset
function fn_interview_time_disable_reset(_val) {
	var time_val = _val.split(",");
	$('input[name="set_interview_time"]').each(function() {
		for (var i=0; i<time_val.length; i++) {
			if (time_val[i] == this.value) {
				$(this).parent().attr('disabled', false);
				$(this).parent().attr('readonly', false);
				$(this).parent().removeClass('disable');
				$(this).attr('disabled', false);
			}
		}
	});

	radioboxFnc();
}


//면접시간 radio 선택 초기화
function fn_interview_time_reset() {
	$('input[name="set_interview_time"]').each(function() {
		this.checked = false;
		$(".sel_area").children("p").text("일자 및 시간을 선택해 주세요.");
	});
	radioboxFnc();//라디오박스
}


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


//면접시간 선택클릭
function fn_time_set(_obj) {
	var set_day			= $('#set_consultant_day').val();
	var set_time		= $(_obj).parent().next().html().substring(0, 5);
	var set_time_full	= $(_obj).parent().next().html();

	if (set_day == "") {
		return;
	} else {
		var today_date	= new Date();
		var set_date	= new Date(set_day.split("-")[0], set_day.split("-")[1] -1, set_day.split("-")[2], set_time.split(":")[0], set_time.split(":")[1]);

		if (set_date < today_date) {
			alert("현재시간 이전의 시간은 선택이 불가능합니다.");
			fn_interview_time_reset();
			$(".sel_area").children("p").text("일자 및 시간을 선택해 주세요.");
		}else{
			$(".sel_area").children("p").text("신청일 : "+set_day+" / 시간 : "+set_time_full+"");
		}
	}
}
