//직종의 1차 data list 를 리턴합니다.
function getJcOptDepth1List() {
	var arrRet = new Array();
	var k = 0;
	for (var i = 0; i < cat_fld1.length; i++) {
		arrRet[k] = new Array();
		arrRet[k][0] = cat_fld1[i][0];
		arrRet[k][1] = cat_fld1[i][1];
		k++;
	}
	return arrRet;
}
//직종의 2차 data list 를 리턴합니다.
function getJcOptDepth2List(depthval1) {
	var arrRet = new Array();
	var k = 0;
	for (var i = 0; i < cat_fld2.length; i++) {
		if (cat_fld2[i][1] == depthval1) {
			arrRet[k] = new Array();
			arrRet[k][0] = cat_fld2[i][0];
			arrRet[k][1] = cat_fld2[i][2];
			k++;
		}
	}
	return arrRet;
}
//직종의 3차 data list 를 리턴합니다.
function getJcOptDepth3List(depthval1) {
	var arrRet = new Array();
	var k = 0;
	for (var i = 0; i < cat_fld3.length; i++) {
		if (cat_fld3[i][1] == depthval1) {
			arrRet[k] = new Array();
			arrRet[k][0] = cat_fld3[i][0];
			arrRet[k][1] = cat_fld3[i][2];
			k++;
		}
	}
	return arrRet;
}

// 직종1차 리스트
function fn_append_jc() {
	var arrJc1 = getJcOptDepth1List();
	var str = '';
	var k = 1;
	var key = 0;

	for (var i = 0; i < arrJc1.length; i++) {
		if(arrJc1[i][0].substring(0,2) == jc1.substring(0,2)) {
			str += '<li class="mmtp"><button class="mmtpBtns on" onclick="fn_append_jc2(this, \'' + arrJc1[i][0] + '\')">' + arrJc1[i][1] + '</button></li>';

			fn_append_jc2(this, arrJc1[i][0]);
		}
		else {
			str += '<li class="mmtp"><button class="mmtpBtns" onclick="fn_append_jc2(this, \'' + arrJc1[i][0] + '\')">' + arrJc1[i][1] + '</button></li>';
		}
	}

	$('#col_ul_jc1').html(str);

	var category_out_jc_val = "";
	var category_out_ct_val = "";

	$('[name="category_out_jc3"]').each(function() {
		category_out_jc_val += "," + this.value;
	});

	if (category_out_jc_val != "") {
		$('[name="jcKeyWord3"]').each(function() {
			if (category_out_jc_val.indexOf(this.value) > 0) {
				this.checked = true;
			}
		});
	}

	$('[name="category_out_ct3"]').each(function() {
		category_out_ct_val += "," + this.value;
	});

	if (category_out_ct_val != "") {
		$('[name="ctKeyWord3"]').each(function() {
			if (category_out_ct_val.indexOf(this.value) > 0) {
				this.checked = true;
			}
		});
	}
}
// 직종2차 리스트
function fn_append_jc2(obj, val) {
	jc1 = val;

	//전체 리스트 class초기화 및 선택요소 class on
	$('#col_ul_jc1').children().children().attr('class', 'mmtpBtns');
	$(obj).attr('class', 'mmtpBtns on');

	var arrJc2 = getJcOptDepth2List(val);
	var str = '';
	var k = 1;
	var key = 0;

	for (var i = 0; i < arrJc2.length; i++) {
		str += '<li class="mmtp">';
		str += '	<input type="checkbox" class="chkrdo" id="CR' + arrJc2[i][0] + '" name="jcKeyWord2" value="' + arrJc2[i][0] +'|'+ arrJc2[i][1] + '" onclick="fn_appand_jckey2(this); fn_append_jc3(this);" />';
		str += '	<label class="lb" for="CR' + arrJc2[i][0] +'">' + arrJc2[i][1] + '</label>';
		str += '</li>';
	}

	$('#col_ul_jc2').html(str);

	//직종2차 체크
	var category_out_jc2_val = "";
	$('[name="category_out_jc2"]').each(function() {
		category_out_jc2_val += "," + this.value;
	});
	if (category_out_jc2_val != "") {
		$('[name="jcKeyWord2"]').each(function() {
			if (category_out_jc2_val.indexOf(this.value.split('|')[0]) > 0) {
				this.checked = true;
			}
		});

	}
}

function fn_append_jc3(obj) {
	var jc2_chk, jc2_val, jc2_nm
	jc2_chk = $(obj).is(":checked");
	jc2_val = $(obj).val().split('|')[0];
	jc2_nm = $(obj).val().split('|')[1];

	if(jc2_chk) {
		fn_jc3_set(jc2_val, jc2_nm);
	}
	else {
		fn_jckey2_del(jc2_val);
	}

	//직종3차 체크
	var category_out_jc3_val = "";
	$('[name="category_out_jc3"]').each(function() {
		category_out_jc3_val += "," + this.value;
	});

	if (category_out_jc3_val != "") {
		$('[name="jcKeyWord3"]').each(function() {
			if (category_out_jc3_val.indexOf(this.value) > 0) {
				this.checked = true;
			}
		});
	}
}

function fn_jc3_set(jc2_val, jc2_nm) {
	var arrJc3 = getJcOptDepth3List(jc2_val);
	var str = '';
	var k = 1;
	var key = 0;

	var str_jc3 = '';

	for (var i = 0; i < arrJc3.length; i++) {
		str_jc3 += '<div class="mmCol4">';
		str_jc3 += '	<input type="checkbox" id="CT' + arrJc3[i][0] + '" name="jcKeyWord3" onclick="fn_appand_jckey3(this, \'' + jc2_val +'\', \'' + jc2_nm + '\')" value="' + arrJc3[i][0] + '">';
		str_jc3 += '	<label for="CT' + arrJc3[i][0] + '" class="mmGridBox">';
		str_jc3 += '		<span class="mgbInner">' + arrJc3[i][1] + '</span>';
		str_jc3 += '	</label>';
		str_jc3 += '</div>';
	}

	str += '<div class="mmTit borderBottom mmColorBlue2 MT40">' + jc2_nm + '</div>';
	str += '<div class="mmGridBoxWrap isCheckRadio MT20">';
	str += '	<div class="mmRow allPadding">';
	str +=			str_jc3;
	str += '	</div>';
	str += '</div>';

	$('#col_ul_jc3').append(str);
}

// 직종2차코드 클릭
function fn_appand_jckey2(obj) {
	var jc2_chk, jc2_val, jc2_nm
	jc2_chk = $(obj).is(":checked");
	jc2_val = $(obj).val().split('|')[0];
	jc2_nm = $(obj).val().split('|')[1];

	if (jc2_chk) {

		var jc2_chk_cnt = $('[name="category_out_jc2"]').length;

		if (jc2_chk_cnt >= 4) {
			$(obj).attr("checked", false);
			alert("희망 직종은 최대 4개까지 선택이 가능합니다.");
			return;
		}
		else {
			var up_html = '';

			up_html += '<div class="tt">';
			up_html += '	<span>' + jc2_nm +'</span>';
			up_html += '	<button class="clBtn" name="category_out_jc2" value="' + jc2_val + '" onclick="fn_jckey2_del(\'' + jc2_val + '\')" title="삭제"/>';
			up_html += '	<span class="mmColorBlue2">></span>';
			up_html += '	<span name="span_set_jc3">';
			up_html += '	</span>';
			up_html += '</div>';

			$('#btm_category_jc').append(up_html);
		}
	}
	else { //선택해제시
		fn_jckey2_del(jc2_val);
	}
}

// 직종3차코드 클릭
function fn_appand_jckey3(obj, jc2_val, jc2_nm) {
	var jc3_chk, jc3_val, jc3_nm
	jc3_chk = $(obj).is(":checked");
	jc3_val = $(obj).val();
	jc3_nm = $(obj).next().html();

	if (jc3_chk) {
		var jc3_chk_cnt = $('[name="category_out_jc3"]').length;

		if (jc3_chk_cnt >= 10) {
			$(obj).attr("checked", false);
			alert("희망 직종키워드는 최대 10개까지 선택이 가능합니다.");
			return;
		}
		else {
			var up_html = '';
			var jc2_cnt = 0;

			$('[name="category_out_jc2"]').each(function() {
				if (this.value == jc2_val) {
					jc2_cnt = jc2_cnt + 1;

					up_html += '<div class="tt">';
					up_html +=		jc3_nm;
					up_html += '	<button class="clBtn" name="category_out_jc3" value="' + jc3_val + '" onclick="fn_jckey3_del(\'' + jc3_val + '\')" title="삭제"/>';
					up_html += '</div>';

					$(this).nextAll('[name="span_set_jc3"]').append(up_html);
				}
			});
		}
	}
	else { //선택해제시
		fn_jckey3_del(jc3_val);
	}
}

// 직종2차 삭제
function fn_jckey2_del(_val) {
	// 하단부 선택된 직종표기 삭제
	$('[name="category_out_jc2"]').each(function() {
		if (this.value == _val) {
			$(this).parent().remove();
		}
	});

	// 직종2차 선택된 체크박스 해제
	$('input:checkbox[name="jcKeyWord2"]').each(function() {
		if (this.value.split('|')[0] == _val) {
			this.checked = false;
		}
	});

	$('input:checkbox[name="jcKeyWord3"]').each(function() {
		if(this.value.substr(0,4) == _val) {
			$(this).parent().parent().parent().prev().remove();
			$(this).parent().parent().parent().remove();
		}
	});
}

// 직종3차 삭제
function fn_jckey3_del(_val) {
	// 하단부 선택된 직종표기 삭제
	$('[name="category_out_jc3"]').each(function() {
		if (this.value == _val) {
			$(this).parent().remove();
		}
	});

	// 직종3차 선택된 체크박스 해제
	$('input:checkbox[name="jcKeyWord3"]').each(function() {
		if (this.value == _val) {
			this.checked = false;
		}
	});
}

// 저장된 직종값 삭제
function fn_save_jc3_del(_obj, _val) {
	fn_jckey3_del(_val);

	if ($(_obj).parent().parent().children().length == 1) {
		$(_obj).parents('.c_jobs').parent().remove();
	}
	else {
		$(_obj).parent().remove();
	}
}

function fn_save_jc2_del(_obj, _val) {
	$(_obj).parent().parent().remove();
	fn_jckey2_del(_val);
}

// 직종 초기화
function fn_reset_jc() {
	// 하단부 직종표기 초기화
	$("#btm_category_jc").html("");
	// 리스트 초기화
	$("#col_ul_jc2").html("");
	$("#col_ul_jc3").html("");
	fn_append_jc();
}

// 직종값 조건저장
function fn_save_jc() {
	var out_html = '';

	var set_jc2_cnt = $('[name="category_out_jc2"]').length;
	var set_jc3_cnt = $('[name="category_out_jc3"]').length;

	if(set_jc2_cnt > 0) {
		out_html += '<div class="tp">';
		out_html += '	<span class="lb">직무</span>';
		out_html += '	<div class="txts">';
	}

	for (i=0; i<set_jc2_cnt; i++) {
		out_html += '<div class="tt">';
		var resume_jc2 = $('[name="category_out_jc2"]').eq(i).val();
		var resume_jc2_nm = $('[name="category_out_jc2"]').eq(i).prev().html();
		var resume_jc_txt = '';

		out_html += '<input type="hidden" name="resume_jobcode" value="' + resume_jc2 + '">';

		resume_jc_txt += resume_jc2_nm + '> ';

		for (j=0; j<set_jc3_cnt; j++)  {
			var resume_jc3 = $('[name="category_out_jc3"]').eq(j).val();
			var resume_jc3_nm = $('[name="category_out_jc3"]').eq(j).prev().html();

			if (resume_jc2 == resume_jc3.substring(0, 4)) {
				out_html += '<input type="hidden" name="jc_keyword" value="'+ resume_jc3 +'">';

				resume_jc_txt += resume_jc3_nm;

				if(j < set_jc3_cnt -1) {
					resume_jc_txt += ', ';
				}
			}
		}

		out_html += resume_jc_txt;
		out_html += '</div>';//tt
	}
	if(set_jc2_cnt > 0) {
		out_html += '	</div>';//txts
		out_html += '</div>';//tp
	}
	$('#div_hope_ctjc').html(out_html);
	if(out_html){
		//$('#div_hope_ctjc').parent().find('.plhmsg').hide();
		//$('#div_hope_ctjc').show();
	}else{
		//$('#div_hope_ctjc').parent().find('.plhmsg').show();
		//$('#div_hope_ctjc').hide();
	}
}
