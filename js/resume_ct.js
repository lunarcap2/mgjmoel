//업종의 1차 data list 를 리턴합니다.
function getCtOptDepth1List() {
	var arrRet = new Array();
	var k = 0;
	for (var i = 0; i < cat_ct1.length; i++) {
		arrRet[k] = new Array();
		arrRet[k][0] = cat_ct1[i][0];
		arrRet[k][1] = cat_ct1[i][1];
		k++;
	}
	return arrRet;
}
//업종의 2차 data list 를 리턴합니다.
function getCtOptDepth2List(depthval1) {
	var arrRet = new Array();
	var k = 0;
	for (var i = 0; i < cat_ct2.length; i++) {
		if (cat_ct2[i][1] == depthval1) {
			arrRet[k] = new Array();
			arrRet[k][0] = cat_ct2[i][0];
			arrRet[k][1] = cat_ct2[i][2];
			k++;
		}
	}
	return arrRet;
}
//업종의 3차 data list 를 리턴합니다.
function getCtOptDepth3List(depthval1) {
	var arrRet = new Array();
	var k = 0;
	for (var i = 0; i < cat_ct3.length; i++) {
		if (cat_ct3[i][1] == depthval1) {
			arrRet[k] = new Array();
			arrRet[k][0] = cat_ct3[i][0];
			arrRet[k][1] = cat_ct3[i][2];
			k++;
		}
	}
	return arrRet;
}

// 업종1차 리스트
function fn_append_ct() {
	var arrCt1 = getCtOptDepth1List();
	var str = '';
	var k = 1;
	var key = 0;

	for (var i = 0; i < arrCt1.length; i++) {
		if(arrCt1[i][0].substring(0,2) == ct1.substring(0,2)) {
			str += '<li class="mmtp"><button class="mmtpBtns on" onclick="fn_append_ct2(this, \'' + arrCt1[i][0] + '\')">' + arrCt1[i][1] + '</button></li>';

			fn_append_ct2(this,arrCt1[i][0]);
		}
		else {
			str += '<li class="mmtp"><button class="mmtpBtns" onclick="fn_append_ct2(this, \'' + arrCt1[i][0] + '\')">' + arrCt1[i][1] + '</button></li>';
		}
	}

	$('#col_ul_ct1').html(str);
}
// 업종2차 리스트
function fn_append_ct2(obj, val) {
	ct1 = val;

	//전체 리스트 class초기화 및 선택요소 class on
	$('#col_ul_ct1').children().children().attr('class', 'mmtpBtns');
	$(obj).attr('class', 'mmtpBtns on');

	var arrCt2 = getCtOptDepth2List(val);
	var str = '';
	var k = 1;
	var key = 0;

	for (var i = 0; i < arrCt2.length; i++) {
		str += '<li class="mmtp">';
		str += '	<input type="checkbox" class="chkrdo" id="CR' + arrCt2[i][0] + '" name="ctKeyWord2" value="' + arrCt2[i][0] + '|' + arrCt2[i][1] + '" onclick="fn_appand_ctkey2(this); fn_append_ct3(this);" />';
		str += '	<label class="lb" for="CR' + arrCt2[i][0] + '">' + arrCt2[i][1] + '</label>';
		str += '</li>';
	}

	$('#col_ul_ct2').html(str);

	//업종2차 체크
	var category_out_ct2_val = "";
	$('[name="category_out_ct2"]').each(function() {
		category_out_ct2_val += "," + this.value;
	});
	if (category_out_ct2_val != "") {
		$('[name="ctKeyWord2"]').each(function() {
			if (category_out_ct2_val.indexOf(this.value.split('|')[0]) > 0) {
				this.checked = true;
			}
		});
	}
}
// 업종3차 리스트
function fn_append_ct3(obj) {
	var ct2_chk,ct2_val, ct2_nm
	ct2_chk = $(obj).is(":checked");
	ct2_val = $(obj).val().split('|')[0];
	ct2_nm = $(obj).val().split('|')[1];

	var arrCt3 = getCtOptDepth3List(ct2_val);
	var str = '';
	var k = 1;
	var key = 0;

	if(ct2_chk) {
		fn_ct3_set(ct2_val, ct2_nm);
	}
	else {
		fn_ctkey2_del(ct2_val);
	}

	//업종3차 체크
	var category_out_ct3_val = "";
	$('[name="category_out_ct3"]').each(function() {
		category_out_ct3_val += "," + this.value;
	});
	if (category_out_ct3_val != "") {
		$('[name="ctKeyWord3"]').each(function() {
			if (category_out_ct3_val.indexOf(this.value) > 0) {
				this.checked = true;
			}
		});
	}
	checkboxFnc();//체크박스.
}

function fn_ct3_set(ct2_val, ct2_nm) {
	var arrCt3 = getCtOptDepth3List(ct2_val);
	var str = '';
	var k = 1;
	var key = 0;

	var str_ct3 = '';

	for (var i = 0; i < arrCt3.length; i++) {
		str_ct3 += '<div class="mmCol4">';
		str_ct3 += '	<input type="checkbox" id="CT' + arrCt3[i][0] + '" name="ctKeyWord3" onclick="fn_appand_ctkey3(this, \'' + ct2_val +'\', \'' + ct2_nm + '\')" value="' + arrCt3[i][0] + '">';
		str_ct3 += '	<label for="CT' + arrCt3[i][0] + '" class="mmGridBox">';
		str_ct3 += '		<span class="mgbInner">' + arrCt3[i][1] + '</span>';
		str_ct3 += '	</label>';
		str_ct3 += '</div>';
	}

	str += '<div class="mmTit borderBottom mmColorBlue2 MT40">' + ct2_nm + '</div>';
	str += '<div class="mmGridBoxWrap isCheckRadio MT20">';
	str += '	<div class="mmRow allPadding">';
	str +=			str_ct3;
	str += '	</div>';
	str += '</div>';

	$('#col_ul_ct3').append(str);
}

// 업종2차코드 클릭
function fn_appand_ctkey2(obj) {
	var ct2_chk, ct2_val, ct2_nm
	ct2_chk = $(obj).is(":checked");
	ct2_val = $(obj).val().split('|')[0];
	ct2_nm = $(obj).val().split('|')[1];

	if (ct2_chk) {
		var ct2_chk_cnt = $('[name="category_out_ct2"]').length;

		if (ct2_chk_cnt >= 4) {
			$(obj).attr("checked", false);
			alert("희망 업종은 최대 4개까지 선택이 가능합니다.");
			return;
		}
		else {
			var up_html = '';

			up_html += '<div class="tt">';
			up_html += '	<span>' + ct2_nm + '</span>';
			up_html += '	<button class="clBtn" name="category_out_ct2" value="' + ct2_val + '" onclick="fn_ctkey2_del(\'' + ct2_val + '\')" title="삭제"/>';
			up_html += '	<span class="mmColorBlue2">></span>';
			up_html += '	<span name="span_set_ct3">';
			up_html += '	</span>';
			up_html += '</div>';

			$('#btm_category_ct').append(up_html);
		}
	}
	else { //선택해제시
		fn_ctkey2_del(ct2_val);
	}
}

// 업종3차코드 클릭
function fn_appand_ctkey3(obj, ct2_val, ct2_nm) {
	var ct3_chk, ct3_val, ct3_nm
	ct3_chk = $(obj).is(":checked");
	ct3_val = $(obj).val();
	ct3_nm = $(obj).next().html();

	if (ct3_chk) {
		var ct3_chk_cnt = $('[name="category_out_ct3"]').length;

		if (ct3_chk_cnt >= 10) {
			$(obj).attr("checked", false);
			alert("희망 업종키워드는 최대 10개까지 선택이 가능합니다.");
			return;
		}
		else {
			var up_html = '';
			var ct2_cnt = 0;
			$('[name="category_out_ct2"]').each(function() {
				if (this.value == ct2_val) {
					ct2_cnt = ct2_cnt + 1;

					up_html += '<div class="tt">';
					up_html +=		ct3_nm;
					up_html += '	<button class="clBtn" name="category_out_ct3" value="' + ct3_val + '" onclick="fn_ctkey3_del(\'' + ct3_val + '\')" title="삭제"/>';
					up_html += '</div>';

					$(this).nextAll('[name="span_set_ct3"]').append(up_html);
				}
			});
		}
	}
	else { //선택해제시
		fn_ctkey3_del(ct3_val);
	}
}

// 업종2차 삭제
function fn_ctkey2_del(_val) {
	// 하단부 선택된 업종표기 삭제
	$('[name="category_out_ct2"]').each(function() {
		if (this.value == _val) {
			$(this).parent().remove();
		}
	});

	// 업종2차 선택된 체크박스 해제
	$('input:checkbox[name="ctKeyWord2"]').each(function() {
		if (this.value.split('|')[0] == _val) {
			this.checked = false;
		}
	});

	// 업종3차 체크박스 해제
	$('input:checkbox[name="ctKeyWord3"]').each(function() {
		if(this.value.substr(0,4) == _val) {
			$(this).parent().parent().parent().prev().remove();
			$(this).parent().parent().parent().remove();
		}
	});
}

// 업종3차 삭제
function fn_ctkey3_del(_val) {
	// 하단부 선택된 업종표기 삭제
	$('[name="category_out_ct3"]').each(function() {
		if (this.value == _val) {
			$(this).parent().remove();
		}
	});

	// 업종3차 선택된 체크박스 해제
	$('input:checkbox[name="ctKeyWord3"]').each(function() {
		if (this.value == _val) {
			this.checked = false;
		}
	});
}

// 저장된 업종값 삭제
function fn_save_ct3_del(_obj, _val) {

	fn_ctkey3_del(_val);

	if ($(_obj).parent().parent().children().length == 1) {
		$(_obj).parents('.c_jobs').parent().remove();
	} else {
		$(_obj).parent().remove();
	}
}
function fn_save_ct2_del(_obj, _val) {
	$(_obj).parent().parent().remove();
	fn_ctkey2_del(_val);
}

// 업종 초기화
function fn_reset_ct() {
	// 하단부 업종표기 초기화
	$("#btm_category_ct").html("");
	// 리스트 초기화
	$("#col_ul_ct2").html("");
	$("#col_ul_ct3").html("");
	fn_append_ct();
}

// 업종값 조건저장
function fn_save_ct() {
	var out_html = '';

	var set_ct2_cnt = $('[name="category_out_ct2"]').length;
	var set_ct3_cnt = $('[name="category_out_ct3"]').length;

	if(set_ct2_cnt > 0) {
		out_html += '<div class="tp">';
		out_html += '	<span class="lb">산업</span>';
		out_html += '	<div class="txts">';
		// out_html += '<input type="text" value="" readonly />';
	}

	for (i=0; i<set_ct2_cnt; i++) {
		out_html += '<div class="tt">';
		var resume_ct2 = $('[name="category_out_ct2"]').eq(i).val();
		var resume_ct2_nm = $('[name="category_out_ct2"]').eq(i).prev().html();
		var resume_ct_txt = '';

		out_html += '<input type="hidden" name="resume_jobtype" value="' + resume_ct2 + '">';

		resume_ct_txt += resume_ct2_nm + '> ';

		for (j=0; j<set_ct3_cnt; j++)  {
			var resume_ct3 = $('[name="category_out_ct3"]').eq(j).val();
			var resume_ct3_nm = $('[name="category_out_ct3"]').eq(j).prev().html();

			if (resume_ct2 == resume_ct3.substring(0, 4)) {
				out_html += '<input type="hidden" name="ct_keyword" value="'+ resume_ct3 +'">';

				resume_ct_txt += resume_ct3_nm;

				if(j < set_ct3_cnt -1) {
					resume_ct_txt += ', ';
				}
			}
		}

		// out_html += '<input type="text" value="' + resume_ct_txt + '" readonly />';
		out_html += resume_ct_txt;
		out_html += '</div>';//tt
	}
	if(set_ct2_cnt > 0) {
		out_html += '	</div>';//txts
		out_html += '</div>';//tp
	}
	$('#div_hope_ctjc').append(out_html);
	if(out_html){
		//$('#div_hope_ctjc').parent().find('.plhmsg').hide();
		//$('#div_hope_ctjc').show();
	}else{
		//$('#div_hope_ctjc').parent().find('.plhmsg').show();
		//$('#div_hope_ctjc').hide();
	}
}
